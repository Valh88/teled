module teled.telegram.metods;
import std.typecons;
import std.json;
import std : writeln;
import std.sumtype;
import mir.algebraic : Variant, isVariant;
import asdf;
import teled.telegram.update;
import teled.bot;
import teled.telegram.markup;

struct GetUpdatesMethod
{
    public static url = "/getUpdates";

    Nullable!int offset;
    Nullable!ubyte limit;
    Nullable!uint timeout;
    Nullable!(UpdateType[]) allowed_updates;

    this(int offset, ubyte limit, uint timeout, UpdateType[] allowed_updates = [
    ])
    {
        this.offset = offset;
        this.limit = limit;
        this.timeout = timeout;
        this.allowed_updates = allowed_updates;
    }

    string stringJson()
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

alias ChatId = Variant!(int, string);

alias ReplyMarkup = Variant!(ReplyKeyboardMarkup, ReplyKeyboardRemove,
        InlineKeyboardMarkup, ForceReply);

struct SendMessageMethod
{
    public static url = "/sendMessage";

    ChatId chat_id;
    string text;
    @serdeOptional Nullable!ParseMode parse_mode;
    @serdeOptional Nullable!bool disable_web_page_preview;
    @serdeOptional Nullable!bool disable_notification;
    @serdeOptional Nullable!uint reply_to_message_id;
    @serdeOptional ReplyMarkup reply_markup;

    @serdeIgnore
    @property string stringJson()
    {
        JSONValue data;
        data["chat_id"] = chat_id.toString();
        data["text"] = text;
        try {
            InlineKeyboardMarkup d = reply_markup.get!InlineKeyboardMarkup;
            data["reply_parkup"] = d.serialise();
        } catch (Exception e) {
            writeln("error");
        }
        return data.toString();
    }

    @serdeIgnore
    @property void reply(ReplyMarkup markup)
    {
        reply_markup = markup;
    }
}

enum ParseMode : string
{   
    @serdeKeys("Markdown", "Markdown")
    Markdown = "Markdown",
    @serdeKeys("HTML", "HTML")
    HTML = "HTML",
    @serdeKeys("", "")
    None = "",
}
