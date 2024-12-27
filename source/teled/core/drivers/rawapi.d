module teled.core.drivers.rawapi;
import teled.core.options : Options;
import teled.core.drivers.http : HttpClient;
import teled.telegram.user : User;
import teled.telegram.message : Message, CallbackQuery;
import teled.telegram.update : Update;
import teled.bot;

abstract class ATelegramBotClient
{
    HttpClient client;
    Options _options;
    long botId;

    @property void options(Options value)
    {
        _options = value;
    }

    @property Options options()
    {
        return _options;
    }

    T makeRequest(T)(string method);

    User getMe();

    // void onMessage(void function(TelegramClient bot, Message message, Update update));
    // void onCallbackQuery(void function(TelegramClient bot, CallbackQuery callbackQuery, Message message));
    //void onError() //TODO
    //void onCalbackQuery() //Todo
    //void onCommand() //Todo
}
