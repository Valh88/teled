module teled.core.metods;
import std : writeln;
import std.conv;
import std.json;
import std.algorithm;
import teled.core.bot;
import teled.telegram.update;
import teled.core.bot : TelegramClient;
import teled.telegram.metods;
import teled.telegram.markup;
import teled.telegram.update;
import teled.telegram.message;

Update[] getUpdate(TelegramClient bot, ref GetUpdatesMethod getU)
{
    auto str = bot.makeRequest!Update(GetUpdatesMethod.url, getU.stringJson);
    return Update.stringJsonToList(str);
}

Message sendMessage(TelegramClient bot, string chatId, string text)
{
    auto sm = SendMessageMethod();
    sm.chat_id = chatId;
    sm.text = text;
    auto data = bot.makeRequest!Message(SendMessageMethod.url, sm.stringJson);
    return Message(data);
}

void start(TelegramClient bot)
{
    GetUpdatesMethod getU = GetUpdatesMethod(0, 100, 400);
    while (true)
    {
        foreach (Update update; bot.getUpdate(getU))
        {
            if (!update.message.isNull)
            {
                writeln(update.message.get.text);
                if (update.message.get.text == "/start")
                {
                    //test
                    Message mess = update.message.get;
                    bot.sendMessage(mess.chat.chat_id, "huy");
                }
            }
            getU.offset = update.update_id + 1;
        }

    }
}
