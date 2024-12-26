module teled.bot;
import std : writeln;
import std.stdio;
import asdf;
import teled.core.drivers.rawapi : ATelegramBotClient;
import teled.core.options : Options;
import teled.core.drivers.vibeclient : VibeClient;
import teled.core.drivers.http : HttpClient;
import teled.telegram.user : User;
import teled.telegram.message : Message;
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
            TelegramClient bot, Update up) { writeln(up); };

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
}

unittest
{
    auto listenerBot = new TelegramClient("7997355907:AAEFFgXtW4l4J5C7wbcE7wxWZcyOq2IWWao");

    listenerBot.onMessage((TelegramClient bot, Update update, Message message) {
        writeln(update);
        auto mess =  SendMessageMethod();
        mess.chat_id = message.chat.chat_id;
        mess.text = message.text.get;
        bot.sendMessage(mess);



        // auto sm = SendMessageMethod();
        // sm.chat_id = message.chat.chat_id;
        // sm.text = message.text.get;
        // auto keyboard1 = InlineKeyboardButton("1234");
        // keyboard1.callback_data = "dasd";
        // // keyboard1.url = "dsadsadsa";
        // auto keyboard2 = InlineKeyboardButton("213");
        // auto keyboard3 = InlineKeyboardButton("6546");
        // auto keyboard4 = InlineKeyboardButton("99898");
        // auto mark = InlineKeyboardMarkup([
        //     [keyboard1, keyboard2],
        //     [keyboard3, keyboard4]
        //     ]);
        // sm.reply_markup = mark;

        // writeln(sm.stringJson);
        // bot.sendMessage(sm);
    });

    listenerBot.startPooling();
}
