package io.karatelabs.junit6;

import org.junit.jupiter.api.DynamicNode;
import org.junit.jupiter.api.TestFactory;

import java.util.stream.Stream;

class HelloKarateTest {

    @TestFactory
    Stream<DynamicNode> helloKarate() {
        //return Karate.run("hello-karate")
        return Karate.run("apiTest")
                .relativeTo(getClass())
                .stream();
    }
}
