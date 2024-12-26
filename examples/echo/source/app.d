import std.stdio;
import teled.packade;

void main()
{
    auto listenerBot = new TelegramClient("token");

    listenerBot.onMessage((TelegramClient bot, Update update, Message message) {
        if (message.text == "Слава РУСИ")
            bot.sendMessage(message.chat.chat_id, "1488");
    });

    listenerBot.startPooling();
}
