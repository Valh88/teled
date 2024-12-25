module teled.telegram.pay;
import std.typecons;
import teled.telegram.user : User;

struct Invoice
{
    string title;
    string description;
    string start_parameter;
    string currency;
    uint total_amount;
}

struct SuccessfulPayment
{
    string currency;
    uint total_amount;
    string invoice_payload;
    string shipping_option_id;
    Nullable!OrderInfo order_info;
    string telegram_payment_charge_id;
    string provider_payment_charge_id;
}

struct OrderInfo
{
    string name;
    string phone_number;
    string email;
    Nullable!ShippingAddress shipping_address;
}

struct ShippingAddress
{
    string country_code;
    string state;
    string city;
    string street_line1;
    string street_line2;
    string post_code;
}

struct ShippingQuery
{
    string id;
    User from;
    string invoice_payload;
    ShippingAddress shipping_address;
}
