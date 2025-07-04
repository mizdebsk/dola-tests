package greeter;

import static org.junit.jupiter.api.Assertions.fail;
import org.junit.jupiter.api.Test;

class FailingTest {
    @Test
    void boom() {
	fail("Boom!");
    }
}
