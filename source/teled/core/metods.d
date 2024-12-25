module teled.core.metods;
import std;
import std.json;
import teled.core.bot;
import teled.telegram.update;
import teled.core.bot : TelegramClient;
import teled.telegram.metods;
import teled.telegram.update;

Update[] getUpdate(TelegramClient bot)
{
    GetUpdatesMethod getUpdates = GetUpdatesMethod(0, 1, 30);
    auto str = bot.makeRequest!Update(getUpdates.url, getUpdates.stringJson);
    return Update.stringJsonToList(str);
}
