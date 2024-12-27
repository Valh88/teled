# teled
смал либ для тг ботов чисто для себя

```D
import std.stdio;
import teled.packade;

void main()
{
    auto listenerBot = new TelegramClient("token");

    listenerBot.onMessage((TelegramClient bot, Update update, Message message) {
        if (message.text == "Слава РУСИ")
            bot.sendMessage(message.chat.chat_id, "1488");
    });

    listenerBot.onCallBackQuery((TelegramClient bot, Update up, CallbackQuery query) {
        
        ///logic
    });


    listenerBot.startPooling();
}
```