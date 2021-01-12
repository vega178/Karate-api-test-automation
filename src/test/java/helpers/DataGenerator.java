package helpers;

import com.github.javafaker.Faker;

public class DataGenerator {
    private static final Faker randomData = new Faker();

    public static String getRandomEmail() {
        return randomData.name().firstName().toLowerCase() + randomData.random().nextInt(0, 100) + "@gmai.com";
    }

    public static String getRandomUserName() {
        return randomData.name().username();
    }

    public String getRandomName() {
        return randomData.name().name();
    }
}
