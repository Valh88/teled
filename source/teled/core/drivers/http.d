module teled.core.drivers.http;

interface HttpClient
{
    string getRequest(string url);

    string postRequest(string url, string bodyJson);
}