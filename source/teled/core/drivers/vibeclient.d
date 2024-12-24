module teled.core.drivers.vibeclient;
import std;

import vibe.d;
import teled.core.drivers.http : HttpClient;

public class VibeClient : HttpClient
{
    string getRequest(string url) 
    {
        HTTPClientResponse response = requestHTTP(url);
        return response.bodyReader.readAllUTF8(true);
    }

    string postRequest(string url, string bodyJson)
    {
        string data;
        requestHTTP(url,
            (scope HTTPClientRequest request) {
                request.method = HTTPMethod.POST;
                request.headers["Content-Type"] = "application/json";
                request.writeBody( cast(const(ubyte[])) bodyJson);
            },
            (scope HTTPClientResponse response) {
                data = response.bodyReader.readAllUTF8(true);
                logDebug("Response headers:\n  %s\n  %s", response, response.headers);
                logDiagnostic("Response body:\n  %s", data);
            }
        );

        return data;
    }
}

// unittest
// {
//     auto client = new VibeClient();
//     auto bodyJson = client.getRequest("https://reqres.in/api/users?page=2");
//     // writeln(bodyJson);

//     auto postBody = client.postRequest("https://reqres.in/api/users", "{\"name\": \"morpheus\", \"job\": \"leader\"}");
//     writeln(postBody);
// }