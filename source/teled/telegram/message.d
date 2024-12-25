module teled.telegram.message;
import std.json;
import std.typecons;
import std;
import teled.telegram.user : User;
import teled.telegram.chat : Chat;
import teled.telegram.stiker : Sticker;
import teled.telegram.content;
import teled.telegram.pay;

struct Message
{
    uint message_id;
    uint date;
    Chat chat;
    Nullable!User from;
    Nullable!User forward_from;
    Nullable!Chat forward_from_chat;
    Nullable!uint forward_from_message_id;
    Nullable!string forward_signature;
    Nullable!string forward_sender_name;
    Nullable!uint forward_date;
    Nullable!uint edit_date;
    Nullable!string media_group_id;
    Nullable!string author_signature;
    Nullable!string text;
    Nullable!(MessageEntity[]) entities;
    Nullable!(MessageEntity[]) caption_entities;
    Nullable!Audio audio;
    Nullable!Document document;
    Nullable!Animation animation;
    Nullable!Game game;
    Nullable!Poll poll;
    Nullable!(PhotoSize[]) photo;
    Nullable!Sticker sticker;
    Nullable!Video video;
    Nullable!Voice voice;
    Nullable!VideoNote video_note;
    Nullable!string caption;
    Nullable!Contact contact;
    Nullable!Location location;
    Nullable!Venue venue;
    Nullable!(User[]) new_chat_members;
    Nullable!User left_chat_member;
    Nullable!string new_chat_title;
    Nullable!(PhotoSize[]) new_chat_photo;
    Nullable!bool delete_chat_photo;
    Nullable!bool group_chat_created;
    Nullable!bool supergroup_chat_created;
    Nullable!bool channel_chat_created;
    Nullable!long migrate_to_chat_id;
    Nullable!long migrate_from_chat_id;
    Nullable!Invoice invoice;
    Nullable!SuccessfulPayment successful_payment;
    Nullable!string connected_website;

    this(JSONValue jsonData)
    {
        message_id = jsonData["message_id"].get!uint;
        date = jsonData["date"].get!uint;
        chat = Chat(jsonData["chat"]);
        if ("text" in jsonData)
            text = jsonData["text"].get!string;
        if ("from" in jsonData)
            from = User(jsonData["from"]);
    }
}

struct MessageEntity
{
    MessageEntityType type;
    uint offset;
    uint length;
    Nullable!string url;
    Nullable!User user;
}

enum MessageEntityType : string
{
    Mention = "mention",
    Hashtag = "hashtag",
    Cashtag = "cashtag",
    BotCommand = "bot_command",
    Url = "url",
    Email = "email",
    PhoneNumber = "phone_number",
    Bold = "bold",
    Italic = "italic",
    Underline = "underline",
    Strikethrough = "strikethrough",
    Code = "code",
    Pre = "pre",
    TextLink = "text_link",
    TextMension = "text_mention"
}

struct Audio
{
    string file_id;
    uint duration;
    Nullable!string performer;
    Nullable!string title;
    Nullable!string mime_type;
    Nullable!uint file_size;
    Nullable!PhotoSize thumb;
}

struct PhotoSize
{
    string file_id;
    int width;
    int height;

    Nullable!uint file_size;
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
    Nullable!uint correct_option_id;
    Nullable!string explanation;
    Nullable!(MessageEntity[]) explanation_entities;
    Nullable!uint open_period;
    Nullable!uint close_date;
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
    Nullable!string last_name;
    Nullable!uint user_id;
    Nullable!string vcard;
}

struct ChosenInlineResult
{
    string result_id;
    User from;
    Nullable!Location location;
    Nullable!string inline_message_id;
    string query;
}

struct CallbackQuery
{
    string id;
    User from;
    Nullable!Message message;
    string inline_message_id;
    string chat_instance;
    string data;
    string game_short_name;
}

struct InlineQuery
{
    string id;
    User from;
    Nullable!Location location;
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
    Nullable!OrderInfo order_info;
}

struct PollAnswer
{
    string poll_id;
    User user;
    uint[] option_ids;
}
