package conduitApp;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

@KarateOptions( tags = {"@regression,@debug"} )
class ConduitTest {
    
    // this will run all *.feature files that exist in sub-directories
    // see https://github.com/intuit/karate#naming-conventions   
    @Test
    void testParallel() {
        Results results = Runner.parallel(getClass(),5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
    
}
