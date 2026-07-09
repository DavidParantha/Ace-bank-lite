package com.acebank.lite.util;

import lombok.extern.java.Log;

import java.security.SecureRandom;
import java.sql.*;

/**
 * OTP Service – Handles generation, storage, validation, and cleanup of OTPs.
 * OTPs are 6-digit codes stored in the OTP_TOKENS table with:
 * - 5-minute expiry window
 * - Maximum 3 verification attempts per OTP
 */
@Log
public class OtpService {

    private static final int OTP_VALIDITY_MINUTES = 5;
    private static final SecureRandom random = new SecureRandom();

    /** Result codes returned by the verify method */
    public enum OtpResult {
        SUCCESS, // OTP is correct and within time/attempt limits
        WRONG_CODE, // OTP code doesn't match
        EXPIRED, // OTP has passed its expiry time
        MAX_ATTEMPTS, // Too many wrong attempts for this OTP
        NOT_FOUND // No OTP exists for this email
    }

    /**
     * Generates a 6-digit OTP, stores it in the DB, and emails it to the user.
     * Any previous OTPs for this email are deleted first.
     *
     * @param email the user's registered email
     * @return true if OTP was generated and emailed successfully
     */
    public static boolean generateAndSend(String email) {
        String otp = String.format("%06d", random.nextInt(999999));

        try (Connection conn = ConnectionManager.getConnection()) {
            // Clean up old OTPs for this email
            try (PreparedStatement del = conn.prepareStatement(QueryLoader.get("otp.delete_by_email"))) {
                del.setString(1, email);
                del.executeUpdate();
            }

            // Insert new OTP with expiry timestamp
            try (PreparedStatement ps = conn.prepareStatement(QueryLoader.get("otp.insert"))) {
                ps.setString(1, email);
                ps.setString(2, otp);
                ps.setTimestamp(3, new Timestamp(
                        System.currentTimeMillis() + (OTP_VALIDITY_MINUTES * 60 * 1000L)));
                ps.executeUpdate();
            }

            // Send OTP via email
            String subject = "AceBank - Password Reset OTP";
            String body = String.format(
                    """
                            Dear User,

                            Your One-Time Password (OTP) for password reset is:

                                %s

                            This OTP is valid for %d minutes. Do not share it with anyone.
                            You have a maximum of 3 attempts to enter the correct OTP.

                            If you did not request this, please ignore this email.

                            Regards,
                            AceBank Security Team""",
                    otp, OTP_VALIDITY_MINUTES);

            MailUtil.sendMailAsync(email, subject, body);
            log.info("OTP email queued successfully to: " + email);
            return true;

        } catch (Exception e) {
            log.severe("Failed to generate/send OTP for " + email + ": " + e.getMessage());
            return false;
        }
    }

    /**
     * Verifies the OTP entered by the user.
     * Checks: existence → expiry → attempt count → code match.
     * Increments attempt count on every call (even on success).
     *
     * @param email   the user's email
     * @param otpCode the 6-digit OTP entered by the user
     * @return OtpResult indicating the outcome
     */
    public static OtpResult verify(String email, String otpCode) {
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement ps = conn.prepareStatement(QueryLoader.get("otp.get_latest"))) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return OtpResult.NOT_FOUND;
                }

                int id = rs.getInt("ID");
                String storedOtp = rs.getString("OTP_CODE");
                int attempts = rs.getInt("ATTEMPTS");
                int maxAttempts = rs.getInt("MAX_ATTEMPTS");
                Timestamp expiresAt = rs.getTimestamp("EXPIRES_AT");

                // Check expiry
                if (expiresAt.before(new Timestamp(System.currentTimeMillis()))) {
                    return OtpResult.EXPIRED;
                }

                // Check attempts
                if (attempts >= maxAttempts) {
                    return OtpResult.MAX_ATTEMPTS;
                }

                // Increment attempt count regardless of outcome
                incrementAttempts(id);

                // Check code
                if (storedOtp.equals(otpCode)) {
                    return OtpResult.SUCCESS;
                } else {
                    // Check if this was the last attempt
                    if (attempts + 1 >= maxAttempts) {
                        return OtpResult.MAX_ATTEMPTS;
                    }
                    return OtpResult.WRONG_CODE;
                }
            }

        } catch (Exception e) {
            log.severe("OTP verification error for " + email + ": " + e.getMessage());
            return OtpResult.NOT_FOUND;
        }
    }

    /**
     * Removes all OTP records for the given email.
     * Called after a successful password reset.
     */
    public static void cleanup(String email) {
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement ps = conn.prepareStatement(QueryLoader.get("otp.delete_by_email"))) {
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (Exception e) {
            log.warning("OTP cleanup failed for " + email + ": " + e.getMessage());
        }
    }

    /** Increments the attempt counter for a specific OTP record */
    private static void incrementAttempts(int otpId) {
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement ps = conn.prepareStatement(QueryLoader.get("otp.increment_attempts"))) {
            ps.setInt(1, otpId);
            ps.executeUpdate();
        } catch (Exception e) {
            log.warning("Failed to increment OTP attempts: " + e.getMessage());
        }
    }
}
