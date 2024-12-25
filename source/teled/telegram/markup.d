module teled.telegram.markup;
import std.typecons;
import std.algorithm;

struct ReplyKeyboardMarkup
{
    KeyboardButton[][] keyboard;

    Nullable!bool resize_keyboard;
    Nullable!bool one_time_keyboard;
    Nullable!bool selective;
}

struct ReplyKeyboardRemove
{
    bool remove_keyboard = true;
    Nullable!bool selective;
}

struct InlineKeyboardMarkup
{
    InlineKeyboardButton[][] inline_keyboard;
}

struct ForceReply
{
    bool force_reply = true;
    Nullable!bool selective;
}

struct InlineKeyboardButton
{
    string text;
    Nullable!string url;
    Nullable!string callback_data;
    Nullable!string switch_inline_query;
    Nullable!string switch_inline_query_current_chat;
    // Nullable!CallbackGame callback_game;
    Nullable!bool pay;
}

struct KeyboardButton
{
    string text;

    Nullable!bool request_contact;
    Nullable!bool request_location;
}
