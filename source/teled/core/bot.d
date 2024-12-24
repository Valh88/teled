module teled.core.bot;
import std;
import teled.core.drivers.rawapi: ATelegramBotClient;
import teled.core.options: Options;
import teled.core.drivers.vibeclient: VibeClient;
import teled.core.drivers.http: HttpClient;
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

    T makeRequest(T)() {
        writeln(T);
    }

    override string getMe() 
    {
        writeln(super.options.url ~ "/getMe");

        auto data = client.getRequest(super.options.url ~ "/getMe");
        return data;
    }

}
import std.typecons : Nullable;
import asdf;

struct Simple
{
    string name;
    ulong level;
    Nullable!string her;
}
unittest
{
    // auto bot = new TelegramClient("6622260946:AAErrswzp6RxwYXxulFzhCLP028Hw608tJs");
    // auto str = bot.getMe();
    // writeln(str);


    auto o = Simple("asdf", 42, "her");
    // string data = `{"name":"asdf","level":42,"her":"null"}`;
    auto d = o.serializeToJson();
    // auto c = data.deserialize!Simple;
    writeln(d);
    // writeln(c);
}