module teled.telegram.chat;
import std.json;
import std.typecons;
import std;
import asdf;

enum ChatType : string
{
    @serdeKeys("private", "private") Private = "private",
    @serdeKeys("group",
            "group") Group = "group",
    @serdeKeys("supergroup",
            "supergroup") Supergroup = "supergroup",
    @serdeKeys("channel",
            "channel") Channel = "channel"
}

struct ChatPhoto
{
    string small_file_id;
    string big_file_id;
}

struct Chat
{
    long id;
    ChatType type;
    @serdeOptional Nullable!string title;
    @serdeOptional Nullable!string first_name;
    @serdeOptional Nullable!string last_name;
    @serdeOptional Nullable!string username;
    @serdeOptional Nullable!bool all_members_are_administrators;
    @serdeOptional Nullable!ChatPhoto photo;
    @serdeOptional Nullable!string description;
    @serdeOptional Nullable!string invite_link;
    @serdeOptional Nullable!string sticker_set_name;
    @serdeOptional Nullable!bool can_set_sticker_set;

    @property string chat_id()
    {
        return to!string(id);
    }

    this(JSONValue jsonData)
    {
        id = jsonData["id"].get!long;
        // type = jsonData["type"].get!string;
        if ("first_name" in jsonData)
            first_name = jsonData["first_name"].get!string;
        if ("username" in jsonData)
            username = jsonData["username"].get!string;
    }
}
