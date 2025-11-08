
package com.example.gclab;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;

import java.time.Duration;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

@RestController
public class DemoController {

    // Intentional static collection to demonstrate Old Gen growth if not cleared
    private static final List<byte[]> staticBag = new CopyOnWriteArrayList<>();

    // lightweight endpoint for keep-alive tests
    @GetMapping("/ping")
    public String ping() {
        return "pong";
    }

    // SSE-like stream for chunked transfer demonstration
    @GetMapping(value = "/stream", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public Flux<String> stream() {
        return Flux.interval(Duration.ofMillis(500))
                .map(i -> "data: tick-" + i + "\n\n");
    }

    // Allocate and optionally hold memory (to trigger promotion if abused)
    // Example: /alloc?sizeMb=5&hold=true
    @GetMapping("/alloc")
    public String alloc(int sizeMb, boolean hold) {
        byte[] block = new byte[sizeMb * 1024 * 1024];
        // touch to ensure materialization
        for (int i = 0; i < block.length; i += 4096) {
            block[i] = (byte) (i % 128);
        }
        if (hold) {
            staticBag.add(block);
            return "allocated and held " + sizeMb + "MB, bagSize=" + staticBag.size();
        } else {
            return "allocated " + sizeMb + "MB (not held)";
        }
    }

    // Clear held objects
    @GetMapping("/clear")
    public String clear() {
        int before = staticBag.size();
        staticBag.clear();
        return "cleared bag (before=" + before + ", after=" + staticBag.size() + ")";
    }
}
