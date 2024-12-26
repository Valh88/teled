module teled.telegram.content;
import std.typecons;
import asdf;
import teled.telegram.message : PhotoSize;

struct Video
{
    string file_id;
    uint width;
    uint height;
    uint duration;
    PhotoSize thumb;
    string mime_type;
    uint file_size;
}

struct Voice
{
    string file_id;
    uint duration;
    string mime_type;
    uint file_size;
}

struct VideoNote
{
    string file_id;
    uint length;
    uint duration;
    PhotoSize thumb;
    uint file_size;
}

struct Location
{
    float longitude;
    float latitude;
}

struct Venue
{
    Location location;
    string title;
    string address;
    @serdeOptional Nullable!string foursquare_id;
    @serdeOptional Nullable!string foursquare_type;
}
