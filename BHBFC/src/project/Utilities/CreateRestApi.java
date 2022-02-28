package project.Utilities;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import com.sun.net.httpserver.HttpServer;
public class CreateRestApi {
    public static void CallAPI() throws IOException {

        HttpServer server = HttpServer.create(new InetSocketAddress(9090), 0);
        server.createContext("/api/greeting", (exchange -> {
            if ("GET".equals(exchange.getRequestMethod())) {
                String responseText = "Hello World! from our framework-less REST createRestApi\n";
                exchange.sendResponseHeaders(200, responseText.getBytes().length);
                OutputStream output = exchange.getResponseBody();
                output.write(responseText.getBytes());
                output.flush();
            } else {
                exchange.sendResponseHeaders(405, -1);// 405 Method Not Allowed
            }
            exchange.close();
        }));
        server.setExecutor(null); // creates a default executor
        server.start();

    }
}
