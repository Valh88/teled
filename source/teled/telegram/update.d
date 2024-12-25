module teled.telegram.update;
import std : writeln;
import std.typecons;
import std.json;
import teled.telegram.message;
import teled.telegram.pay;
import teled.telegram.user;

struct Update
{
    uint update_id;
    Nullable!Message message;

    Nullable!Message edited_message;
    Nullable!Message channel_post;
    Nullable!Message edited_channel_post;
    Nullable!InlineQuery inline_query;
    Nullable!ChosenInlineResult chosen_inline_result;
    Nullable!CallbackQuery callback_query;
    Nullable!ShippingQuery shipping_query;
    Nullable!PreCheckoutQuery pre_checkout_query;
    Nullable!Poll poll;
    Nullable!PollAnswer poll_answer;

    static Update[] stringJsonToList(string data)
    {
        Update[] updates;
        JSONValue jsonData = parseJSON(data)["result"];
        writeln(jsonData.toPrettyString());
        foreach (dataJsonUpdate; jsonData.array())
        {
            updates ~= Update(dataJsonUpdate);
        }
        return updates;
    }

    this(JSONValue jsonData)
    {
        update_id = jsonData["update_id"].get!uint;
        if ("message" in jsonData)
            message = Message(jsonData["message"]);
    }
}

enum UpdateType : string
{
    Message = "message",
    EditedMessage = "edited_message",
    ChannelPost = "channel_post",
    EditedChannelPost = "edited_channel_post",
    InlineQuery = "inline_query",
    ChosenInlineResult = "chosen_inline_result",
    CallbackQuery = "callback_query",
    ShippingQuery = "shipping_query",
    PreCheckoutQuery = "pre_checkout_query",
    Poll = "poll",
    PollAnswer = "poll_answer"
}
