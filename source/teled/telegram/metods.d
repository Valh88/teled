module teled.telegram.metods;
import std.typecons;
import std.json;
import std : writeln;
import std.sumtype;
import mir.algebraic : Variant, isVariant;
import asdf;
import mir.deser.json : deserializeJson;
import mir.ser.json : serializeJson;
import mir.deser.json : deserializeJson;
import mir.ser.json : serializeJson;
import teled.telegram.update;
import teled.bot;
import teled.telegram.markup;
import teled.telegram.metods;
import teled.telegram.command;

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
}

alias ChatId = Variant!(int, string);

alias ReplyMarkup = Variant!(ReplyKeyboardMarkup, ReplyKeyboardRemove,
        InlineKeyboardMarkup, ForceReply);

@serdeRealOrderedIn static struct SendMessageMethod
{
    public static url = "/sendMessage";

    ChatId chat_id;
    string text;
    @serdeIgnoreOutIfAggregate!((ref a) => !(a.parse_mode.isNull == false)) @serdeOptional Nullable!ParseMode parse_mode;

    @serdeIgnoreOutIfAggregate!((ref a) => !(a.disable_web_page_preview.isNull == false)) @serdeOptional Nullable!bool disable_web_page_preview;

    @serdeIgnoreOutIfAggregate!((ref a) => !(a.disable_notification.isNull == false)) @serdeOptional Nullable!bool disable_notification;

    @serdeIgnoreOutIfAggregate!((ref a) => !(a.reply_to_message_id.isNull == false)) @serdeOptional Nullable!uint reply_to_message_id;

    // @serdeIgnoreOutIfAggregate!((ref a) => !(a.reply_markup.isNull == false))
    @serdeOptional ReplyMarkup reply_markup;

    unittest
    {
        auto data = SendMessageMethod();
        data.chat_id = "123";
        data.text = "dsad";
        auto mk = InlineKeyboardButton();
        mk.text = "3213";
        mk.callback_data = "dasd";

        auto imk = InlineKeyboardMarkup();
        imk.inline_keyboard = [[mk]];
        data.reply_markup = imk;
        // writeln(serializeJson!SendMessageMethod(data));
    }
}

enum ParseMode : string
{
    @serdeKeys("Markdown", "Markdown") Markdown = "Markdown",
    @serdeKeys("HTML", "HTML") HTML = "HTML",
    @serdeKeys("", "") None = "",
}

struct SetMyCommandsMetod
{
    static url = "/setMyCommands";

    BotCommand[] commands;
    // scope_//TODO
    @serdeIgnoreOutIfAggregate!((ref a) => !(a.language_code.isNull == false)) @serdeOptional Nullable!string language_code;

    unittest
    {
        auto botCommands = [BotCommand("text", "command text")];
        auto c = SetMyCommandsMetod();
        c.commands = botCommands;
        writeln(c);
    }
}

struct AnswerCallbackQuery
{
    static string url_ =  "/answerCallbackQuery";

    string callback_query_id;
    
    @serdeIgnoreOutIfAggregate!((ref a) => !(a.text.isNull == false))
    @serdeOptional
    Nullable!string text;
    
    @serdeIgnoreOutIfAggregate!((ref a) => !(a.show_alert.isNull == false))
    @serdeOptional 
    Nullable!bool show_alert;

    @serdeIgnoreOutIfAggregate!((ref a) => !(a.url.isNull == false))
    @serdeOptional
    Nullable!string url;

    @serdeIgnoreOutIfAggregate!((ref a) => !(a.cache_time.isNull == false))
    @serdeOptional
    Nullable!int cache_time;
}
