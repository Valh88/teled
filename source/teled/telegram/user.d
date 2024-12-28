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

    @serdeIgnore @property string user_id()
    {
        return id.to!string;
    }
}
