module teled.core.options;

enum TypeDispatcher
{
    hook,
    pooling
}

public struct Options
{
    private string _baseTelegramUrl = "https://api.telegram.org/bot";
    private string _token;
    private string _url;

    this(string token)
    {
        this._token = token;
        this._url = _baseTelegramUrl ~ _token;
    }

    @property string url()
    {
        return _url;
    }

    @property string baseTelegramUrl()
    {
        return _baseTelegramUrl;
    }

    @property string token()
    {
        return _token;
    }
}
