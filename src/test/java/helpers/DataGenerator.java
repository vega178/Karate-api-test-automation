package helpers;

import com.github.javafaker.Faker;
import net.minidev.json.JSONObject;

public class DataGenerator {
    private static final Faker randomData = new Faker();
    private static final JSONObject jsonBody = new JSONObject();

    public static String getRandomEmail() {
        return randomData.name().firstName().toLowerCase() + randomData.random().nextInt(0, 100) + "@gmai.com";
    }

    public static String getRandomUserName() {
        return randomData.name().username();
    }

    public String getRandomName() {
        return randomData.name().name();
    }

    public static JSONObject getRandomArticleValues() {
        String title = randomData.gameOfThrones().character();
        String description = randomData.gameOfThrones().city();
        String body = randomData.gameOfThrones().quote();
        jsonBody.put("title", title);
        jsonBody.put("description", description);
        jsonBody.put("body", body);
        return jsonBody;
    }

    public static String getRandomComment () {
        return randomData.rockBand().name();
    }
}
