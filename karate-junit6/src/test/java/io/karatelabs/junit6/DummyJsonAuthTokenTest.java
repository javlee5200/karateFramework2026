package io.karatelabs.junit6;

import org.junit.jupiter.api.DynamicNode;
import org.junit.jupiter.api.TestFactory;

import java.util.stream.Stream;

class DummyJsonAuthTokenTest {

    @TestFactory
    Stream<DynamicNode> kushkiCardPayments() {
        return Karate.run("dummyjsonAuthToken")
                .relativeTo(getClass())
                .stream();
    }
}

