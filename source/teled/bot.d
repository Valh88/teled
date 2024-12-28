module teled.bot;
import std : writeln;
import std.stdio;
import std.logger;
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
            TelegramClient bot, Update up) { writeln(up);  writeln("default callback update");};

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
        auto typeT = deserialize!T(parseJson(data)["result"]);
        return typeT;
    }

    string makeRequest(string method)
    {
        auto data = client.getRequest(super.options.url ~ method,);
        return data;
    }

    string makeRequest(string method, string bodyJson)
    {
        auto data = client.postRequest(super.options.url ~ method, bodyJson);
        return data;
    }

    T makeRequest(T)(string method, string bodyJson)
    {
        auto data = client.postRequest(super.options.url ~ method, bodyJson);
        return deserialize!(T)(parseJson(data)["result"]);
    }

    override User getMe()
    {
        User user = makeRequest!User(User.url);
        return user;
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
    auto getU = GetUpdatesMethod();
    getU.timeout = 2000;
    auto listenerBot = new TelegramClient("7997355907:AAEFFgXtW4l4J5C7wbcE7wxWZcyOq2IWWao");
    listenerBot.getU = getU;
    listenerBot.onMessage((TelegramClient bot, Update update, Message message) {
        writeln(message.entities);
        auto sm = SendMessageMethod();
        sm.chat_id = message.chat.chat_id;
        sm.text = message.text.get;
        auto b = InlineKeyboardButton();
        b.text = "sdasdsadasd";
        b.callback_data = "123";

        auto c = InlineKeyboardMarkup([
            [b]
        ]);
        sm.reply_markup = c; 

        bot.sendMessage(sm);
    });

    listenerBot.onCallBackQuery((TelegramClient bot, Update up, CallbackQuery query) {
        AnswerCallbackQuery answer;
        answer.callback_query_id = query.id;
        // bot.answerCallbackQuery(answer);
    });

    listenerBot.startPooling();
}
