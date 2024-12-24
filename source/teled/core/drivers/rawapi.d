module teled.core.drivers.rawapi;
import teled.core.options: Options;
import teled.core.drivers.http: HttpClient;

abstract class ATelegramBotClient
{   
    HttpClient client;
    Options _options;
    long botId;
    
    @property
    void options(Options value) {_options = value; }
    
    @property
    Options options() {return _options; }

    T makeRequest(T)();

    string getMe();
}