defmodule Square.Checkout do
  @doc """
  Links a `checkoutId` to a `checkout_page_url` that customers will
  be directed to in order to provide their payment information using a
  payment processing workflow hosted on connect.squareup.com.

  ```ruby
  def create_checkout(client, location_id, body)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `location_id` | `String` | Template, Required | The ID of the business location to associate the checkout with. |
  | `body` | [`Create Checkout Request Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/create-checkout-request.md) | Body, Required | An object containing the fields to POST for the request.<br><br>See the corresponding object definition for field details. |

  ### Response Type

  [`Create Checkout Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/create-checkout-response.md)

  ### Example Usage

      iex> location_id = "location_id4"
      iex> body = %{
        idempotency_key: "86ae1696-b1e3-4328-af6d-f1e04d947ad6",
        order: %{
          order: %{
            location_id: "location_id",
            reference_id: "reference_id",
            customer_id: "customer_id",
            line_items: [
              %{
                name: "Printed T Shirt",
                quantity: "2",
                applied_taxes: [%{ tax_uid: "38ze1696-z1e3-5628-af6d-f1e04d947fg3" }],
                applied_discounts: [%{
                  discount_uid: "56ae1696-z1e3-9328-af6d-f1e04d947gd4"
                }],
                base_price_money = %{
                  amount: 1500,
                  currency: "USD"
              }
             %{
                name: "Slim Jeans",
                quantity: "1",
                base_price_money = %{
                  amount: 2500,
                  currency: "USD"
              }
             %{
                name: "Woven Sweater",
                quantity: "3",
                base_price_money = %{
                  amount: 3500,
                  currency: "USD"
              }
            ],
            taxes: [%{
              uid: "38ze1696-z1e3-5628-af6d-f1e04d947fg3",
              type: "INCLUSIVE",
              percentage: "7.75",
              scope: "LINE_ITEM"
            }],
            discounts: [%{
              uid: "56ae1696-z1e3-9328-af6d-f1e04d947gd4",
              type: "FIXED_AMOUNT",
              amount_money: %{
                amount: 100,
                currency: "USD"
              },
              scope: "LINE_ITEM"
            }]
          },
          idempotency_key: "12ae1696-z1e3-4328-af6d-f1e04d947gd4",
        },
        ask_for_shipping_address: true,
        merchant_support_email: 'merchant+support@website.com',
        pre_populate_buyer_email: 'example@email.com',
        pre_populate_shipping_address: %{
          address_line_1: "1455 Market St.",
          address_line_2: "Suite 600",
          locality: "San Francisco",
          administrative_district_level_1: "CA",
          postal_code: "94103",
          country: "US",
          first_name: "Jane",
          last_name: "Doe"
        },
        redirect_url: "https://merchant.website.com/order-confirm",
        additional_recipients: [
          %{
            location_id: "057P5VYJ4A5X1",
            description: "Application fees"
          }
        ]
      }
      iex> Square.client |> Square.Checkout.create_checkout(location_id, body)
  """
  @spec create_checkout(Tesla.Client.t(), binary, map) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def create_checkout(client, location_id, body \\ %{}),
    do: Tesla.post(client, "locations/#{location_id}/checkouts", body)
end
