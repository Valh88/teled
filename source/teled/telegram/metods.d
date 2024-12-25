module teled.telegram.metods;
import std.typecons;
import std.json;
import std;
import teled.telegram.update;
import teled.core.bot;

struct GetUpdatesMethod
{

    Nullable!int offset;
    Nullable!ubyte limit;
    Nullable!uint timeout;
    Nullable!(UpdateType[]) allowed_updates;
    public static url = "/getUpdates";

    this(int offset, ubyte limit, uint timeout, UpdateType[] allowed_updates = [
    ])
    {
        this.offset = offset;
        this.limit = limit;
        this.timeout = timeout;
        this.allowed_updates = allowed_updates;
    }

    @property string stringJson()
    {
        JSONValue data;
        if (!offset.isNull)
            data["offset"] = offset.toString();
        if (!limit.isNull)
            data["limit"] = limit.toString();
        if (!timeout.isNull)
            data["timeout"] = timeout.toString();
        if (!allowed_updates.isNull)
            data["allowed_updates"] = allowed_updates.toString();
        return data.toString();
    }
}

// unittest
// {
//     auto bot = TelegramClient();
// }
