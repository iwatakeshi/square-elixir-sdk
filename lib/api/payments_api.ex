defmodule Square.Payments do
  @moduledoc """
  Documentation for `Square.Payments`.
  """

  @doc """
  Retrieves a list of payments taken by the account making the request.

  ```
  def list_payments(client,
  [
    begin_time: nil,
    end_time: nil,
    sort_order: nil,
    cursor: nil,
    location_id: nil,
    total: nil,
    last_4: nil,
    card_brand: nil
  ])
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `begin_time` | `String` | Query, Optional | Timestamp for the beginning of the reporting period, in RFC 3339 format.<br>Inclusive. Default: The current time minus one year. |
  | `end_time` | `String` | Query, Optional | Timestamp for the end of the requested reporting period, in RFC 3339 format.<br><br>Default: The current time. |
  | `sort_order` | `String` | Query, Optional | The order in which results are listed.<br>- `ASC` - oldest to newest<br>- `DESC` - newest to oldest (default). |
  | `cursor` | `String` | Query, Optional | A pagination cursor returned by a previous call to this endpoint.<br>Provide this to retrieve the next set of results for the original query.<br><br>See [Pagination](https://developer.squareup.com/docs/basics/api101/pagination) for more information. |
  | `location_id` | `String` | Query, Optional | Limit results to the location supplied. By default, results are returned<br>for all locations associated with the merchant. |
  | `total` | `Float` | Query, Optional | The exact amount in the total_money for a `Payment`. |
  | `last_4` | `String` | Query, Optional | The last 4 digits of `Payment` card. |
  | `card_brand` | `String` | Query, Optional | The brand of `Payment` card. For example, `VISA` |


  ### Response Type

  [`List Payments Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/list-payments-response.md)

  ### Example Usage

      iex> Square.client |> Square.Payments.list_payments()
  """

  @spec list_payments(Tesla.Client.t(), list) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def list_payments(client, params \\ []),
    do: Tesla.get(client, "payments", query: params)

  @doc """
  Retrieves details for a specific Payment.

  ```
  def get_payment(payment_id)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `payment_id` | `String` | Template, Required | Unique ID for the desired `Payment`. |

  ### Response Type

  [`Get Payment Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/get-payment-response.md)

  ### Example Usage

      iex> payment_id = "payment_id0"
      iex> Square.client |> Square.Payments.get_payment(payment_id)
  """
  @spec get_payment(Tesla.Client.t(), binary) :: {:error, any} | {:ok, Tesla.Env.t()}
  def get_payment(client, payment_id), do: Tesla.get(client, "payments/#{payment_id}")

  @doc """

  Charges a payment source, for example, a card
  represented by customer's card on file or a card nonce. In addition
  to the payment source, the request must also include the
  amount to accept for the payment.

  There are several optional parameters that you can include in the request.
  For example, tip money, whether to autocomplete the payment, or a reference ID
  to correlate this payment with another system.
  For more information about these
  payment options, see [Take Payments](https://developer.squareup.com/docs/payments-api/take-payments).

  The `PAYMENTS_WRITE_ADDITIONAL_RECIPIENTS` OAuth permission is required
  to enable application fees.

  ```
  def create_payment(client, body)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `body` | [`Create Payment Request Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/create-payment-request.md) | Body,Required | A map containing the fields to POST for the request.<br><br>See the corresponding map definition for field details. |

  ### Response Type

  [`Create Payment Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/create-payment-response.md)

  ### Example Usage

        iex> body %{
          source_id: "ccof:uIbfJXhXETSP197M3GB",
          idempotency_key: "4935a656-a929-4792-b97c-8848be85c27c",
          amount_money: %{
            amount: 200,
            currency: "USD"
          },
          app_fee_money: {
            amount: 10,
            currency: "USD",
          },
          autocomplete: true,
          customer_id: "VDKXEEKPJN48QDG3BGGFAK05P8",
          location_id: "XK3DBG77NJBFX",
          reference_id: "123456",
          note: "Brief description",
        }
        iex> Square.client |> Square.Payments.create_payment(body)
  """
  @spec create_payment(Tesla.Client.t(), map) :: {:error, any} | {:ok, Tesla.Env.t()}
  def create_payment(client, body \\ %{}), do: Tesla.post(client, "payments", body)

  @doc """
  Cancels (voids) a payment. If you set `autocomplete` to false when creating a payment,
  you can cancel the payment using this endpoint. For more information, see
  [Delayed Payments](https://developer.squareup.com/docs/payments-api/take-payments#delayed-payments).

  ```
  def cancel_payment(client, payment_id)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `payment_id` | `String` | Template, Required | `payment_id` identifying the payment to be canceled. |

  ### Response Type

  [`Cancel Payment Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/cancel-payment-response.md)

  ### Example Usage

      iex> payment_id = "payment_id0"
      iex> Square.client |> Square.Payments.cancel_payment(payment_id)
  """
  @spec cancel_payment(Tesla.Client.t(), binary) :: {:error, any} | {:ok, Tesla.Env.t()}
  def cancel_payment(client, payment_id),
    do: Tesla.post(client, "payments/#{payment_id}/cancel", %{})

  @doc """
  Cancels (voids) a payment identified by the idempotency key that is specified in the
  request.

  Use this method when status of a CreatePayment request is unknown. For example, after you send a
  CreatePayment request a network error occurs and you don't get a response. In this case, you can
  direct Square to cancel the payment using this endpoint. In the request, you provide the same
  idempotency key that you provided in your CreatePayment request you want  to cancel. After
  cancelling the payment, you can submit your CreatePayment request again.

  Note that if no payment with the specified idempotency key is found, no action is taken, the end
  point returns successfully.

  ```
  def cancel_payment_by_idempotency_key(client, body)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `body` | [`Cancel Payment by Idempotency Key Request Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/cancel-payment-by-idempotency-key-request.md) | Body, Required | A map containing the fields to POST for the request.<br><br>See the corresponding map definition for field details. |

  ### Response Type

  [`Cancel Payment by Idempotency Key Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/cancel-payment-by-idempotency-key-response.md)

  ### Example Usage

      iex> body = %{}
      iex> body[:idempotency_key] = "a7e36d40-d24b-11e8-b568-0800200c9a66"
      iex> Square.client |> Square.Pyaments.cancel_payment_by_idempotency_key(body)

  """
  def cancel_payment_by_idempotency_key(client, body \\ %{}),
    do: Tesla.post(client, "payments/cancel", body)

  @doc """
  Completes (captures) a payment.

  By default, payments are set to complete immediately after they are created.
  If you set autocomplete to false when creating a payment, you can complete (capture)
  the payment using this endpoint. For more information, see
  [Delayed Payments](https://developer.squareup.com/docs/payments-api/take-payments#delayed-payments).

  ```
  def complete_payment(payment_id, body)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `payment_id` | `String` | Template, Required | Unique ID identifying the payment to be completed. |
  | `body` | `Map` | Body, Required | A map containing the fields to POST for the request.<br><br>See the corresponding map definition for field details. |

  ### Response Type

  [`Complete Payment Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/complete-payment-response.md)

  ### Example Usage

      iex> payment_id = "payment_id0"
      iex> body = %{ key1: "val1", key2: "val2" }
      iex> Square.client |> Square.Payments.complete_payment(payment_id, body)

  """
  def complete_payment(client, payment_id, body \\ %{}),
    do: Tesla.post(client, "payments/#{payment_id}/complete", body)
end
