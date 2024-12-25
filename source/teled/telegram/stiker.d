module teled.telegram.stiker;
import teled.telegram.message : PhotoSize;

struct Sticker
{
    string file_id;
    uint width;
    uint height;
    PhotoSize thumb;
    string emoji;
    string set_name;
    MaskPosition mask_position;
    uint file_size;
}

struct MaskPosition
{
    string point;
    float x_shift;
    float y_shift;
    float scale;
}
