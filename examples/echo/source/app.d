import std.stdio;
import teled.packade;

void main()
{
    auto listenerBot = new TelegramClient("7997355907:AAEFFgXtW4l4J5C7wbcE7wxWZcyOq2IWWao");

    listenerBot.onMessage((Update update, Message message) {
        if (message.text == "Слава РУСИ")
            listenerBot.sendMessage(message.chat.chat_id, "1488");
    });

    listenerBot.onCallBackQuery((Update up, CallbackQuery query) {

        ///logic
    });

    listenerBot.startPooling();
}
