module teled.core.bot;
import std;
import teled.core.drivers.rawapi: ATelegramBotClient;
import teled.core.options: Options;
import teled.core.drivers.vibeclient: VibeClient;
import teled.core.drivers.http: HttpClient;
import teled.telegram.user :User;

public class TelegramClient : ATelegramBotClient
{
    this(string token, HttpClient client = new VibeClient()) {
        this(Options(token), client);
    }

    this(Options options, HttpClient client = new VibeClient()) 
    {
        super.options = options;
        super.client = client;
    }

    T makeRequest(T)(string method) {
        auto data = client.getRequest(super.options.url ~ method,);
        writeln(data);
        auto user = User(data);
        return user;
    }

    T makeRequest(T)(string method, string bodyJson) {
        auto data = client.postRequest(super.options.url ~ method, bodyJson);
        auto user = User(data);
        return user;
    }

    override User getMe() 
    {
        User user = makeRequest!User("/getMe");

        return user;
    }

}

import std.json;

unittest
{
    auto bot = new TelegramClient("6622260946:AAErrswzp6RxwYXxulFzhCLP028Hw608tJs");
    auto str = bot.getMe();
    writeln(str);
    // JSONValue j = parseJSON(str);
    // if ("ok" in j) writeln(j);



}