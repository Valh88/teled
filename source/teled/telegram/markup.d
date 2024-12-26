module teled.telegram.markup;
import std.typecons;
import std: writeln;
import std.algorithm;
import std.json;
import std.conv;
import asdf;
import teled.telegram.metods;


struct ReplyKeyboardMarkup
{
    KeyboardButton[][] keyboard;
    @serdeOptional Nullable!bool resize_keyboard;
    @serdeOptional Nullable!bool one_time_keyboard;
    @serdeOptional Nullable!bool selective;
}

struct ReplyKeyboardRemove
{
    bool remove_keyboard = true;
    @serdeOptional Nullable!bool selective;
}

struct InlineKeyboardMarkup
{
    InlineKeyboardButton[][] inline_keyboard;

    string serialise()
    {
        JSONValue[] reply;
        foreach (InlineKeyboardButton[] str; inline_keyboard)
        {
            JSONValue[] strData;
            foreach (InlineKeyboardButton button; str)
            {
                JSONValue butt;
                butt["text"] = button.text;
                if (!button.url.isNull)
                    butt["url"] = button.url.get;
                if (!button.callback_data.isNull)
                    butt["callback_data"] = button.callback_data.get;
                if (!button.switch_inline_query.isNull)
                    butt["switch_inline_query"] = button.switch_inline_query.get;
                if (!button.switch_inline_query_current_chat.isNull)
                    butt["switch_inline_query_current_chat"] = button
                        .switch_inline_query_current_chat.get;
                if (!button.pay.isNull)
                    butt["url"] = button.pay.get.to!string;
                strData ~= butt;
            }
            reply ~= JSONValue(strData);
        }
        auto data = JSONValue(reply);
        // writeln(data);
        return data.toString();
    }
}

unittest
{
    auto sm = SendMessageMethod();
    sm.chat_id = "1234";
    sm.text = "qwewqedasdsad";
    auto keyboard1 = InlineKeyboardButton("1234");
    keyboard1.callback_data = "dasd";
    keyboard1.url = "dsadsadsa";
    auto keyboard2 = InlineKeyboardButton("213");
    auto keyboard3 = InlineKeyboardButton("6546");
    auto keyboard4 = InlineKeyboardButton("99898");
    auto mark = InlineKeyboardMarkup([
        [keyboard1, keyboard2],
        [keyboard3, keyboard4]
        ]);
    sm.reply_markup = mark;
  
    // writeln(sm.reply_markup.get!ReplyKeyboardMarkup);
    writeln(sm.stringJson);
}

struct ForceReply
{
    bool force_reply = true;
    @serdeOptional Nullable!bool selective;
}

struct InlineKeyboardButton
{
    string text;
    @serdeOptional Nullable!string url;
    @serdeOptional Nullable!string callback_data;
    @serdeOptional Nullable!string switch_inline_query;
    @serdeOptional Nullable!string switch_inline_query_current_chat;
    // @serdeOptional Nullable!CallbackGame callback_game;
    @serdeOptional Nullable!bool pay;
}

struct KeyboardButton
{
    string text;

    @serdeOptional Nullable!bool request_contact;
    @serdeOptional Nullable!bool request_location;
}
