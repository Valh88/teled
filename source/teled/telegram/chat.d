module teled.telegram.chat;
import std.json;
import std.typecons;
import std;

enum ChatType : string
{
    Private = "private",
    Group = "group",
    Supergroup = "supergroup",
    Channel = "channel"
}

struct ChatPhoto
{
    string small_file_id;
    string big_file_id;
}

struct Chat
{
    long id;
    ChatType _type;
    Nullable!string title;
    Nullable!string first_name;
    Nullable!string last_name;
    Nullable!string username;
    Nullable!bool all_members_are_administrators;
    Nullable!ChatPhoto photo;
    Nullable!string description;
    Nullable!string invite_link;
    Nullable!string sticker_set_name;
    Nullable!bool can_set_sticker_set;

    @property void type(string data)
    {
        switch (data)
        {
        case "private":
            _type = ChatType.Private;
            break;
        case "group":
            _type = ChatType.Group;
            break;
        case "supergroup":
            _type = ChatType.Supergroup;
            break;
        case "channel":
            _type = ChatType.Channel;
            break;
        default:
            _type = ChatType.Private;
            break;
        }
    }

    @property ChatType type()
    {
        return _type;
    }

    this(JSONValue jsonData)
    {
        id = jsonData["id"].get!long;
        type = jsonData["type"].get!string;
        if ("first_name" in jsonData)
            first_name = jsonData["first_name"].get!string;
        if ("username" in jsonData)
            username = jsonData["username"].get!string;
    }
}
