module teled.core.drivers.vibeclient;
import std;

import vibe.d;
import teled.core.drivers.http : HttpClient;

public class VibeClient : HttpClient
{
    string getRequest(string url)
    {
        string data;
        HTTPClientResponse response = requestHTTP(url);
    
        data = response.bodyReader.readAllUTF8(true);
        return data;
    }

    string postRequest(string url, string bodyJson)
    {
        string data;
        requestHTTP(url, (scope HTTPClientRequest request) {
            request.method = HTTPMethod.POST;
            request.headers["Content-Type"] = "application/json";
            request.writeBody(cast(const(ubyte[])) bodyJson);
        }, (scope HTTPClientResponse response) {
            logDebug("Response headers:\n  %s\n  %s", response, response.headers);
            logDiagnostic("Response body:\n  %s", data);
            data = response.bodyReader.readAllUTF8(true);
            // if (response.statusCode == 200)
            // {
            //     data = response.bodyReader.readAllUTF8(true);
            // }
            // else
            // {
            //     //TODO callback error
            //     writeln(response.bodyReader.readAllUTF8(true));
            //     // throw new Exception("Server Error");
            // }
        });
        logDiagnostic("Response headers:\n  %s\n  %s", response);
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
