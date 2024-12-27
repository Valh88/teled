module teled.telegram.user;
import std.json;
import std.typecons;
import std;
import asdf;

struct User
{
    public static url = "/getMe";

    ulong id;
    bool is_bot;
    string first_name;

    @serdeOptional Nullable!string last_name;
    @serdeOptional Nullable!string username;
    @serdeOptional Nullable!string language_code;

    this(string data)
    {
        JSONValue dataJson = parseJSON(data)["result"];
        _setUser(dataJson);
    }

    this(JSONValue jsonData)
    {
        _setUser(jsonData);
    }

    private void _setUser(JSONValue dataJson)
    {
        this.id = dataJson["id"].get!ulong;
        this.is_bot = dataJson["is_bot"].get!bool;
        this.first_name = dataJson["first_name"].get!string();
        this.username = dataJson["username"].get!string();
    }

    @serdeIgnore @property string user_id()
    {
        return id.to!string;
    }
}
