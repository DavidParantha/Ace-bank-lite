package com.acebank.lite.util;

import lombok.extern.java.Log;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.concurrent.CompletableFuture;

@Log
public class MailUtil {

    // Default sender address
    private static final String DEFAULT_SENDER = "parantha1902@gmail.com";

    public static void sendMailAsync(String recipient, String subject, String body) {
        log.info("Scheduling background email (via Brevo HTTP API) to: " + recipient);
        CompletableFuture.runAsync(() -> {
            try {
                sendMail(recipient, subject, body);
            } catch (Exception e) {
                log.warning("Background email failed for " + recipient + ": " + e.getMessage());
                e.printStackTrace();
            }
        });
    }

    public static boolean sendMail(final String recipient, String subject, String body) {
        log.info("Attempting to send email via Brevo HTTP API to: " + recipient);

        // Fetch Brevo API Key from ConfigLoader
        String apiKey = ConfigLoader.getProperty("BREVO_API_KEY");
        String senderEmail = ConfigLoader.getProperty(ConfigKeys.MAIL_ADDR);

        if (apiKey == null || apiKey.isEmpty()) {
            log.severe("BREVO_API_KEY environment variable is missing!");
            return false;
        }
        if (senderEmail == null || senderEmail.isEmpty()) {
            senderEmail = DEFAULT_SENDER;
        }

        try {
            URL url = new URL("https://api.brevo.com/v3/smtp/email");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("accept", "application/json");
            conn.setRequestProperty("api-key", apiKey);
            conn.setRequestProperty("content-type", "application/json");
            conn.setDoOutput(true);
            conn.setConnectTimeout(10000);
            conn.setReadTimeout(10000);

            // Escape quotes and newlines in body
            String escapedBody = body.replace("\\", "\\\\")
                                     .replace("\"", "\\\"")
                                     .replace("\n", "\\n")
                                     .replace("\r", "");

            // Construct JSON request body
            String jsonPayload = String.format(
                "{" +
                "  \"sender\": {\"name\": \"AceBank Support\", \"email\": \"%s\"}," +
                "  \"to\": [{\"email\": \"%s\"}]," +
                "  \"subject\": \"%s\"," +
                "  \"textContent\": \"%s\"" +
                "}",
                senderEmail, recipient, subject, escapedBody
            );

            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = jsonPayload.getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            int responseCode = conn.getResponseCode();
            if (responseCode >= 200 && responseCode < 300) {
                log.info("Email sent successfully via Brevo HTTP API to " + recipient);
                return true;
            } else {
                log.severe("Failed to send email via Brevo. HTTP Response Code: " + responseCode);
                // Read error stream if any
                try (java.util.Scanner s = new java.util.Scanner(conn.getErrorStream(), StandardCharsets.UTF_8).useDelimiter("\\A")) {
                    String errorResponse = s.hasNext() ? s.next() : "";
                    log.severe("Error Response: " + errorResponse);
                }
                return false;
            }

        } catch (Exception e) {
            log.severe("Failed to send email to " + recipient + " via Brevo API. Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}