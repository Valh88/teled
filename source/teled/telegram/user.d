module teled.telegram.user;
import std.json;
import std.typecons;
import std;

struct User
{
    ulong id;
    bool is_bot;
    string first_name;

    Nullable!string last_name;
    Nullable!string username;
    Nullable!string language_code;

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
}
