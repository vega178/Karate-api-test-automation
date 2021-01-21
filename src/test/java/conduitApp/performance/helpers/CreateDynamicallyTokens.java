package conduitApp.performance.helpers;

import com.intuit.karate.Runner;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

public class CreateDynamicallyTokens {
    private static final ArrayList<String> tokens = new ArrayList<>();
    private static final AtomicInteger counter  = new AtomicInteger();

    private static final String[] emails  = {
        "estebanvegapatio@gmail.com",
        "estebanvegapatio_qa@gmail.com",
        "karate_stg@prueba.com"
    };

    public static String getNextToken() {
        return tokens.get( counter.getAndIncrement() % tokens.size());
    }

    public static void createAccessTokens() {
        for (String email: emails){
            Map<String, Object> account = new HashMap<>();
            account.put("userEmail", email);
            account.put("userPassword", "Ab1234567!");
            Map<String, Object> result = Runner.runFeature("classpath:helpers/Login.feature", account, true);
            tokens.add(result.get("sessionToken").toString());
        }
    }

}
