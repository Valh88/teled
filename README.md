# teled

```
import std.stdio;
import teled.packade;

void main()
{
    auto listenerBot = new TelegramClient("7997355907:AAEFFgXtW4l4J5C7wbcE7wxWZcyOq2IWWao");

    listenerBot.onMessage((TelegramClient bot, Update update, Message message) {
        if (message.text == "Слава РУСИ")
            bot.sendMessage(message.chat.chat_id, "1488");
    });

    listenerBot.startPooling();
}


```