module teled.core.metods;
import std : writeln;
import std.conv;
import std.json;
import asdf;
import mir.deser.json : deserializeJson;
import mir.ser.json : serializeJson;
import std.algorithm;
import teled.telegram.update;
import teled.bot : TelegramClient;
import teled.telegram.metods;
import teled.telegram.markup;
import teled.telegram.update;
import teled.telegram.message;

Update[] getUpdate(TelegramClient bot, ref GetUpdatesMethod getU)
{
    auto str = bot.makeRequest(GetUpdatesMethod.url, serializeToJson(getU));
    //TODO callbackQuery
    return deserialize!(Update[])(parseJson(str)["result"]);
}

Message sendMessage(TelegramClient bot, string chatId, string text)
{
    auto sm = SendMessageMethod();
    sm.chat_id = chatId;
    sm.text = text;
    return bot.makeRequest!Message(SendMessageMethod.url, serializeJson(sm));
}

Message sendMessage(TelegramClient bot, SendMessageMethod sm)
{
    return bot.makeRequest!Message(SendMessageMethod.url, serializeJson(sm));
}

void setMyCommand(TelegramClient bot, SetMyCommandsMetod sm)
{
    bot.makeRequest(SetMyCommandsMetod.url, serializeJson(sm));
}

void startPooling(TelegramClient bot)
{
    while (true)
    {
        foreach (Update update; bot.getUpdate(bot.getU))
        {
            if (!update.callback_query.isNull)
            {
                bot.callbackQuery(update, update.callback_query.get);
            }
            else
            {
                if (!update.message.isNull)
                {
                    bot.onMessageCallback(update, update.message.get);
                }
                else
                {
                    bot.defaultCallbackMessage(update);
                }
            }
            bot.getU.offset = update.update_id + 1;
        }

        import core.thread.osthread;
        import core.time;

        Thread.sleep(dur!("seconds")(3));
    }
}
