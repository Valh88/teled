module teled.telegram.update;
import std : writeln;
import std.typecons;
import std.json;
import asdf;
import teled.telegram.message;
import teled.telegram.pay;
import teled.telegram.user;

struct Update
{
    uint update_id;
    @serdeOptional Nullable!Message message;
    @serdeOptional Nullable!Message edited_message;
    @serdeOptional Nullable!Message channel_post;
    @serdeOptional Nullable!Message edited_channel_post;
    @serdeOptional Nullable!InlineQuery inline_query;
    @serdeOptional Nullable!ChosenInlineResult chosen_inline_result;
    @serdeOptional Nullable!CallbackQuery callback_query;
    @serdeOptional Nullable!ShippingQuery shipping_query;
    @serdeOptional Nullable!PreCheckoutQuery pre_checkout_query;
    @serdeOptional Nullable!Poll poll;
    @serdeOptional Nullable!PollAnswer poll_answer;
}

enum UpdateType : string
{
    @serdeKeys("message", "message") Message = "message",
    @serdeKeys("edited_message",
            "edited_message") EditedMessage = "edited_message",
    @serdeKeys("channel_post",
            "channel_post") ChannelPost = "channel_post",
    @serdeKeys("edited_channel_post", "edited_channel_post") EditedChannelPost = "edited_channel_post",
    @serdeKeys("inline_query",
            "inline_query") InlineQuery = "inline_query",
    @serdeKeys("chosen_inline_result",
            "chosen_inline_result") ChosenInlineResult = "chosen_inline_result",
    @serdeKeys("callback_query", "callback_query") CallbackQuery = "callback_query",
    @serdeKeys("shipping_query", "shipping_query") ShippingQuery = "shipping_query",
    @serdeKeys("pre_checkout_query", "pre_checkout_query") PreCheckoutQuery
        = "pre_checkout_query", @serdeKeys("poll", "poll") Poll = "poll",
    @serdeKeys("poll_answer", "poll_answer") PollAnswer = "poll_answer"
}
