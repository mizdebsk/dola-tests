package greeter;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;

class GreeterTest {
    @Test void test() {
	Greeter greeter = new Greeter();
	String greeting = greeter.hello();
	assertEquals("Hello!", greeting);
    }
}
