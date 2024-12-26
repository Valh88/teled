module teled.telegram.message;
import std.json;
import std.typecons;
import std;
import asdf;
import teled.telegram.user : User;
import teled.telegram.chat : Chat;
import teled.telegram.stiker : Sticker;
import teled.telegram.content;
import teled.telegram.pay;

struct Message
{
    uint message_id;
    uint date;
    @serdeOptional Chat chat;
    @serdeOptional Nullable!User from;
    @serdeOptional Nullable!User forward_from;
    @serdeOptional Nullable!Chat forward_from_chat;
    @serdeOptional Nullable!uint forward_from_message_id;
    @serdeOptional Nullable!string forward_signature;
    @serdeOptional Nullable!string forward_sender_name;
    @serdeOptional Nullable!uint forward_date;
    @serdeOptional Nullable!uint edit_date;
    @serdeOptional Nullable!string media_group_id;
    @serdeOptional Nullable!string author_signature;
    @serdeOptional Nullable!string text;
    @serdeOptional Nullable!(MessageEntity[]) entities;
    @serdeOptional Nullable!(MessageEntity[]) caption_entities;
    @serdeOptional Nullable!Audio audio;
    @serdeOptional Nullable!Document document;
    @serdeOptional Nullable!Animation animation;
    @serdeOptional Nullable!Game game;
    @serdeOptional Nullable!Poll poll;
    @serdeOptional Nullable!(PhotoSize[]) photo;
    @serdeOptional Nullable!Sticker sticker;
    @serdeOptional @serdeOptional Nullable!Video video;
    @serdeOptional Nullable!Voice voice;
    @serdeOptional Nullable!VideoNote video_note;
    @serdeOptional Nullable!string caption;
    @serdeOptional Nullable!Contact contact;
    @serdeOptional Nullable!Location location;
    @serdeOptional Nullable!Venue venue;
    @serdeOptional Nullable!(User[]) new_chat_members;
    @serdeOptional Nullable!User left_chat_member;
    @serdeOptional Nullable!string new_chat_title;
    @serdeOptional Nullable!(PhotoSize[]) new_chat_photo;
    @serdeOptional Nullable!bool delete_chat_photo;
    @serdeOptional Nullable!bool group_chat_created;
    @serdeOptional Nullable!bool supergroup_chat_created;
    @serdeOptional Nullable!bool channel_chat_created;
    @serdeOptional Nullable!long migrate_to_chat_id;
    @serdeOptional Nullable!long migrate_from_chat_id;
    @serdeOptional Nullable!Invoice invoice;
    @serdeOptional Nullable!SuccessfulPayment successful_payment;
    @serdeOptional Nullable!string connected_website;
}

struct MessageEntity
{
    MessageEntityType type;
    uint offset;
    uint length;
    @serdeOptional Nullable!string url;
    @serdeOptional Nullable!User user;
}

enum MessageEntityType : string
{
    @serdeKeys("mention", "mention") Mention = "mention",

    @serdeKeys("hashtag", "hashtag") Hashtag = "hashtag",

    @serdeKeys(
            "cashtag", "cashtag") Cashtag = "cashtag",

    @serdeKeys("bot_command",
            "bot_command") BotCommand = "bot_command",

    @serdeKeys("url", "url") Url = "url",

    @serdeKeys("email", "email") Email = "email",

    @serdeKeys("phone_number",
            "phone_number") PhoneNumber = "phone_number",

    @serdeKeys("bolt",
            "bolt") Bold = "bold",

    @serdeKeys("italic",
            "italic") Italic = "italic",

    @serdeKeys("underline",
            "underline") Underline = "underline",

    @serdeKeys("strikethrough",
            "strikethrough") Strikethrough = "strikethrough",

    @serdeKeys("code", "code") Code = "code",

    @serdeKeys("pre",
            "pre") Pre = "pre",

    @serdeKeys("text_link", "text_link") TextLink = "text_link",

    @serdeKeys("text_mention", "text_mention") TextMension = "text_mention"
}

struct Audio
{
    string file_id;
    uint duration;
    @serdeOptional Nullable!string performer;
    @serdeOptional Nullable!string title;
    @serdeOptional Nullable!string mime_type;
    @serdeOptional Nullable!uint file_size;
    @serdeOptional Nullable!PhotoSize thumb;
}

struct PhotoSize
{
    string file_id;
    int width;
    int height;

    @serdeOptional Nullable!uint file_size;
}

struct Document
{
    string file_id;
    PhotoSize thumb;
    string file_name;
    string mime_type;
    uint file_size;
}

struct Animation
{
    string file_id;
    PhotoSize thumb;
    string file_name;
    string mime_type;
    uint file_size;
}

struct Game
{
    string title;
    string description;
    PhotoSize[] photo;
    string text;
    MessageEntity text_entities;
    Animation animation;
}

struct Poll
{
    string id;
    string question;
    PollOption[] options;
    uint total_voter_count;
    bool is_closed;
    bool is_anonymous;
    string type;
    bool allows_multiple_answers;
    @serdeOptional Nullable!uint correct_option_id;
    @serdeOptional Nullable!string explanation;
    @serdeOptional Nullable!(MessageEntity[]) explanation_entities;
    @serdeOptional Nullable!uint open_period;
    @serdeOptional Nullable!uint close_date;
}

struct PollOption
{
    string text;
    uint voter_count;
}

struct Contact
{
    string phone_number;
    string first_name;
    @serdeOptional Nullable!string last_name;
    @serdeOptional Nullable!uint user_id;
    @serdeOptional Nullable!string vcard;
}

struct ChosenInlineResult
{
    string result_id;
    User from;
    @serdeOptional Nullable!Location location;
    @serdeOptional Nullable!string inline_message_id;
    string query;
}

struct CallbackQuery
{
    string id;
    User from;
    @serdeOptional Nullable!Message message;
    string inline_message_id;
    string chat_instance;
    string data;
    string game_short_name;
}

struct InlineQuery
{
    string id;
    User from;
    @serdeOptional Nullable!Location location;
    string query;
    string offset;
}

struct PreCheckoutQuery
{
    string id;
    User from;
    string currency;
    uint total_amount;
    string invoice_payload;
    string shipping_option_id;
    @serdeOptional Nullable!OrderInfo order_info;
}

struct PollAnswer
{
    string poll_id;
    User user;
    uint[] option_ids;
}
