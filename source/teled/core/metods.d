module teled.core.metods;
import std : writeln;
import std.conv;
import std.json;
import std.logger;
import core.time;
import std.datetime.systime;
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

void answerCallbackQuery(TelegramClient bot, AnswerCallbackQuery query)
{
    bot.makeRequest(AnswerCallbackQuery.url_, serializeJson(query));
}

void startPooling(TelegramClient bot)
{
    //TODO add async tasks maybe
    log("start polling");
    SysTime previousTime = Clock.currTime();
    auto tick = 3.seconds;
    while (true)
    {
        SysTime currentTime = Clock.currTime();
        Duration deltaTime = currentTime - previousTime;

        if (deltaTime > tick)
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
            previousTime = currentTime;
        }

        // import core.thread.osthread;
        // import core.time;
        // Thread.sleep(dur!("seconds")(3));
    }
}
