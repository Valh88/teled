module teled.telegram.markup;
import std.typecons;
import std : writeln;
import std.algorithm;
import std.json;
import std.conv;
import asdf;
import mir.deser.json : deserializeJson;
import mir.ser.json : serializeJson;
import teled.telegram.metods;

struct ReplyKeyboardMarkup
{
    KeyboardButton[][] keyboard;

    @serdeIgnoreOutIfAggregate!((ref a) => !(a.resize_keyboard.isNull == false)) @serdeOptional Nullable!bool resize_keyboard;

    @serdeIgnoreOutIfAggregate!((ref a) => !(a.one_time_keyboard.isNull == false)) @serdeOptional Nullable!bool one_time_keyboard;

    @serdeIgnoreOutIfAggregate!((ref a) => !(a.selective.isNull == false)) @serdeOptional Nullable!bool selective;

    unittest
    {
        auto a = KeyboardButton();
        a.text = "dsadsa";
        auto rk = ReplyKeyboardMarkup();
        rk.keyboard = [[a]];
        writeln(serializeJson(rk));
    }
}

struct ReplyKeyboardRemove
{
    bool remove_keyboard = true;

    @serdeIgnoreOutIfAggregate!((ref a) => !(a.selective.isNull == false)) @serdeOptional Nullable!bool selective;
}

struct InlineKeyboardMarkup
{
    InlineKeyboardButton[][] inline_keyboard;

    unittest
    {
        auto sm = SendMessageMethod();
        sm.chat_id = "1234";
        sm.text = "1";
        sm.text = "qwewqedasdsad";
        auto keyboard1 = InlineKeyboardButton("1234");
        keyboard1.callback_data = "dasd";
        keyboard1.url = "dsadsadsa";
        auto keyboard2 = InlineKeyboardButton("213");
        auto keyboard3 = InlineKeyboardButton("6546");
        auto keyboard4 = InlineKeyboardButton("99898");
        auto mark = InlineKeyboardMarkup([[keyboard1], [keyboard3]]);
        sm.reply_markup = mark;
        writeln(mark);
    }
}

struct ForceReply
{
    bool force_reply = true;

    @serdeIgnoreOutIfAggregate!((ref a) => !(a.selective.isNull == false)) @serdeOptional Nullable!bool selective;
}

struct InlineKeyboardButton
{
    string text;
    @serdeIgnoreOutIfAggregate!((ref a) => !(a.url.isNull == false)) @serdeOptional Nullable!string url;

    @serdeIgnoreOutIfAggregate!((ref a) => !(a.callback_data.isNull == false)) @serdeOptional Nullable!string callback_data;

    @serdeIgnoreOutIfAggregate!((ref a) => !(a.switch_inline_query.isNull == false)) @serdeOptional Nullable!string switch_inline_query;

    @serdeIgnoreOutIfAggregate!((ref a) => !(a.switch_inline_query_current_chat.isNull == false)) @serdeOptional Nullable!string switch_inline_query_current_chat;
    // @serdeOptional Nullable!CallbackGame callback_game;

    @serdeIgnoreOutIfAggregate!((ref a) => !(a.pay.isNull == false)) @serdeOptional Nullable!bool pay;
}

struct KeyboardButton
{
    string text;
    @serdeIgnoreOutIfAggregate!((ref a) => !(a.request_contact.isNull == false)) @serdeOptional Nullable!bool request_contact;

    @serdeIgnoreOutIfAggregate!((ref a) => !(a.request_location.isNull == false)) @serdeOptional Nullable!bool request_location;
}
