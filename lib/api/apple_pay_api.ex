defmodule Square.ApplePay do
  @moduledoc """
  Documentation for `Square.ApplePay`.
  """

  @doc """
  Activates a domain for use with Web Apple Pay and Square. A validation
  will be performed on this domain by Apple to ensure is it properly set up as
  an Apple Pay enabled domain.

  This endpoint provides an easy way for platform developers to bulk activate
  Web Apple Pay with Square for merchants using their platform.

  To learn more about Apple Pay on Web see the Apple Pay section in the
  [Square Payment Form Walkthrough](https://developer.squareup.com/docs/docs/payment-form/payment-form-walkthrough).

  ```
  def register_domain(body)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `body` | [`Register Domain Request Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/register-domain-request.md) | Body, Required | An object containing the fields to POST for the request.<br><br>See the corresponding object definition for field details. |

  ### Response Type

  [`Register Domain Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/register-domain-response.md)

  ### Example Usage

      iex> body = %{
        domain_name: "example.com"
      }
      iex> Square.client |> Square.ApplePay.register_domain(body)
  """
  @spec register_domain(Tesla.Client.t(), map) :: {:error, any} | {:ok, Tesla.Env.t()}
  def register_domain(client, body \\ %{}), do: Tesla.post(client, "apple-pay/domains", body)
end
