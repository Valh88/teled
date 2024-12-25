module teled.core.bot;
import std;
import teled.core.drivers.rawapi : ATelegramBotClient;
import teled.core.options : Options;
import teled.core.drivers.vibeclient : VibeClient;
import teled.core.drivers.http : HttpClient;
import teled.telegram.user : User;
import teled.core.metods;

public class TelegramClient : ATelegramBotClient
{
    this(string token, HttpClient client = new VibeClient())
    {
        this(Options(token), client);
    }

    this(Options options, HttpClient client = new VibeClient())
    {
        super.options = options;
        super.client = client;
    }

    T makeRequest(T)(string method)
    {
        auto data = client.getRequest(super.options.url ~ method,);
        auto user = T(data);
        return user;
    }

    string makeRequest(T)(string method, string bodyJson)
    {
        auto data = client.postRequest(super.options.url ~ method, bodyJson);
        return data;
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
    auto bot = new TelegramClient("7997355907:AAEFFgXtW4l4J5C7wbcE7wxWZcyOq2IWWao");
    // auto str = bot.getMe();
    // auto data = bot.getUpdate();
    // writeln(data);
    // bot.sendMessage("610864528", "dasdasd");
    bot.start();
}
