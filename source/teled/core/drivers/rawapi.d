module teled.core.drivers.rawapi;
import teled.core.options : Options;
import teled.core.drivers.http : HttpClient;
import teled.telegram.user : User;
import teled.telegram.message : Message;
import teled.telegram.update : Update;

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

    // void onMessage(void delegate(Message message, Update update));

    //void onError() Todo
    //void onCalbackQuery() Todo
    //void onCommand() Todo
}
