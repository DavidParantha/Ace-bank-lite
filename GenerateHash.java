import org.mindrot.jbcrypt.BCrypt;

public class GenerateHash {
    public static void main(String[] args) {
        String password = "Demo@1234";
        String hash = BCrypt.hashpw(password, "$2a$12$KIXnS5K8UjxYMPUDg1F0.O");
        System.out.println("Hash: " + hash);
        System.out.println("Matches: " + BCrypt.checkpw(password, hash));
    }
}
