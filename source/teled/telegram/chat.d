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
    int id;
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

    @serdeIgnore
    @property string chat_id()
    {
        return to!string(id);
    }
}
