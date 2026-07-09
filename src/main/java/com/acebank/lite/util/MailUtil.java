package com.acebank.lite.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import lombok.extern.java.Log;

import java.util.Properties;
import java.util.concurrent.CompletableFuture;

@Log
public class MailUtil {

    public static void sendMailAsync(String recipient, String subject, String body) {
        log.info("Scheduling background email to: " + recipient);
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
        log.info("Attempting to send email to: " + recipient);

        String mailAddr = ConfigLoader.getProperty(ConfigKeys.MAIL_ADDR);
        String mailPwd = ConfigLoader.getProperty(ConfigKeys.MAIL_PWD);

        if (mailAddr == null || mailPwd == null || mailAddr.isEmpty() || mailPwd.isEmpty()) {
            log.severe("Email credentials are not configured! MAIL_ADDR: " + mailAddr + ", PWD provided: "
                    + (mailPwd != null && !mailPwd.isEmpty()));
            return false;
        }

        try {
            Properties props = getSmtpConfig();
            log.info("SMTP Config: " + props.toString());

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(mailAddr, mailPwd);
                }
            });

            // Enable debugging if needed
// session.setDebug(true);

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(mailAddr, "AceBank Support"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
            message.setSubject(subject);
            message.setText(body);

            log.info("Handing off to Transport.send...");
            Transport.send(message);
            log.info("Email sent successfully to " + recipient);
            return true;

        } catch (Exception e) {
            log.severe("Failed to send email to " + recipient + ". Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    private static Properties getSmtpConfig() {
        Properties props = new Properties();

        // Safely load each SMTP property with null-safe fallback defaults.
        // Use port 465 with SSL/TLS as port 587 (STARTTLS) is often blocked by cloud providers like Render.
        putSafe(props, "mail.smtp.host",
                ConfigLoader.getProperty(ConfigKeys.MAIL_SMTP_HOST), "smtp.gmail.com");
        putSafe(props, "mail.smtp.port",
                ConfigLoader.getProperty(ConfigKeys.MAIL_SMTP_PORT), "465");
        putSafe(props, "mail.smtp.auth",
                ConfigLoader.getProperty(ConfigKeys.MAIL_SMTP_AUTH), "true");
        
        // Use SSL/TLS socket factory configuration for port 465
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.socketFactory.fallback", "false");

        putSafe(props, "mail.smtp.connectiontimeout",
                ConfigLoader.getProperty(ConfigKeys.MAIL_SMTP_CONN_TIMEOUT), "10000");
        putSafe(props, "mail.smtp.timeout",
                ConfigLoader.getProperty(ConfigKeys.MAIL_SMTP_TIMEOUT), "10000");

        // SSL trust — critical for Docker/cloud environments where the JVM
        // may not have smtp.gmail.com's CA certificate pre-trusted.
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        return props;
    }

    /**
     * Null-safe property setter. Uses fallback if value is null or blank.
     * Prevents the NullPointerException that Properties.put() throws on null values.
     */
    private static void putSafe(Properties props, String key, String value, String fallback) {
        if (value != null && !value.isBlank()) {
            props.put(key, value);
        } else {
            props.put(key, fallback);
            log.warning("SMTP config '" + key + "' was null/blank — using fallback: " + fallback);
        }
    }
}