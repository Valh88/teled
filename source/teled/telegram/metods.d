module teled.telegram.metods;
import std.typecons;
import std.json;
import std;
import std.sumtype;
import teled.telegram.update;
import teled.core.bot;
import teled.telegram.markup;

struct GetUpdatesMethod
{

    Nullable!int offset;
    Nullable!ubyte limit;
    Nullable!uint timeout;
    Nullable!(UpdateType[]) allowed_updates;
    public static url = "/getUpdates";

    this(int offset, ubyte limit, uint timeout, UpdateType[] allowed_updates = [
    ])
    {
        this.offset = offset;
        this.limit = limit;
        this.timeout = timeout;
        this.allowed_updates = allowed_updates;
    }

    @property string stringJson()
    {
        JSONValue data;
        if (!offset.isNull)
            data["offset"] = offset.toString();
        if (!limit.isNull)
            data["limit"] = limit.toString();
        if (!timeout.isNull)
            data["timeout"] = timeout.toString();
        if (!allowed_updates.isNull)
            data["allowed_updates"] = allowed_updates.toString();
        return data.toString();
    }
}

alias ChatId = SumType!(int, string);

alias ReplyMarkup = SumType!(ReplyKeyboardMarkup, ReplyKeyboardRemove,
        InlineKeyboardMarkup, ForceReply);

struct SendMessageMethod
{
    public static url = "/sendMessage";

    ChatId chat_id;
    string text;
    Nullable!ParseMode parse_mode;
    Nullable!bool disable_web_page_preview;
    Nullable!bool disable_notification;
    Nullable!uint reply_to_message_id;

    Nullable!ReplyMarkup reply_markup;

    @property string stringJson()
    {
        JSONValue data;
        data["chat_id"] = chat_id.toString();
        data["text"] = text;
        return data.toString();
    }
}

enum ParseMode : string
{
    Markdown = "Markdown",
    HTML = "HTML",
    None = "",
}
