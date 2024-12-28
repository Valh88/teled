module teled.bot;
import std : writeln;
import std.stdio;
import std.logger;
import std.conv;
import asdf;
import mir.deser.json : deserializeJson;
import mir.ser.json : serializeJson;
import teled.core.drivers.rawapi : ATelegramBotClient;
import teled.core.options : Options;
import teled.core.drivers.vibeclient : VibeClient;
import teled.core.drivers.http : HttpClient;
import teled.telegram.user : User;
import teled.telegram.message : Message, CallbackQuery;
import teled.core.metods;
import teled.telegram.metods;
import teled.telegram.update : Update;
import teled.telegram.markup;

public class TelegramClient : ATelegramBotClient
{
    private void function(TelegramClient bot, Update update, Message message) _onMessageCallback;
    //on calback query toto
    //on calback inlinequery todo
    private void function(TelegramClient bot, Update update) _defaultCallbackMessage = function(
            TelegramClient bot, Update up) {
        writeln(up);
        writeln("default callback update");
    };

    private void function(string error) _errorCallback = (string error) {
        writeln(error);
    };

    private void function(TelegramClient bot, Update update, CallbackQuery callbackQuery) _callBackQuery;

    GetUpdatesMethod getU;

    this(string token, HttpClient client = new VibeClient())
    {
        this(Options(token), client);
    }

    this(Options options, HttpClient client = new VibeClient())
    {
        this.getU = GetUpdatesMethod(0, 100, 400);
        super.options = options;
        super.client = client;
    }

    T makeRequest(T)(string method)
    {
        auto data = client.getRequest(super.options.url ~ method,);
        return _serealizeData!T(parseJson(data));
    }

    string makeRequest(string method, string bodyJson)
    {
        auto data = client.postRequest(super.options.url ~ method, bodyJson);
        return data;
    }

    T makeRequest(T)(string method, string bodyJson)
    {
        auto data = client.postRequest(super.options.url ~ method, bodyJson);
        return _serealizeData!T(parseJson(data));
    }

    override User getMe()
    {
        User user = makeRequest!User(User.url);
        return user;
    }

    private T _serealizeData(T)(Asdf data)
    {
        if (data["ok"].to!bool) 
        {
            return deserialize!(T)(data["result"]);
        }
        else
        {
            _errorCallback(data.to!string);
        }
        return T();
    }

    void onMessage(void function(TelegramClient bot, Update update, Message message) func)
    {
        _onMessageCallback = func;
    }

    void onMessageCallback(Update update, Message message)
    {
        _onMessageCallback(this, update, message);
    }

    void defaultCallbackMessage(Update update)
    {
        _defaultCallbackMessage(this, update);
    }

    void onCallBackQuery(void function(TelegramClient bot, Update up, CallbackQuery cb) func)
    {
        _callBackQuery = func;
    }

    void callbackQuery(Update up, CallbackQuery qb)
    {
        _callBackQuery(this, up, qb);
    }

}

unittest
{
    auto listenerBot = new TelegramClient("7997355907:AAEFFgXtW4l4J5C7wbcE7wxWZcyOq2IWWao");
    // writeln(listenerBot.getMe());
    listenerBot.onMessage((TelegramClient bot, Update update, Message message) {
        if (message.text == "Слава РУСИ")
            bot.sendMessage(message.chat.chat_id, "1488");
    });

    listenerBot.onCallBackQuery((TelegramClient bot, Update up, CallbackQuery query) {
        writeln(query);
        auto a = AnswerCallbackQuery();
        a.callback_query_id = query.id;
        bot.answerCallbackQuery(a);
    });

    listenerBot.startPooling();
}
