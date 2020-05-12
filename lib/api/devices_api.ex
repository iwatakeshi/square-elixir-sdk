defmodule Square.Devices do
  @moduledoc """
  Documentation for `Square.Devices`.
  """

  @doc """
  Lists all DeviceCodes associated with the merchant.

  ```
  def list_device_codes(client, [
    cursor: nil,
    location_id: nil,
    product_type: nil
  ])
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `cursor` | `String` | Query, Optional | A pagination cursor returned by a previous call to this endpoint.<br>Provide this to retrieve the next set of results for your original query.<br><br>See [Paginating results](#paginatingresults) for more information. |
  | `location_id` | `String` | Query, Optional | If specified, only returns DeviceCodes of the specified location.<br>Returns DeviceCodes of all locations if empty. |
  | `product_type` | [`String (Product Type)`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/product-type.md) | Query, Optional | If specified, only returns DeviceCodes targeting the specified product type.<br>Returns DeviceCodes of all product types if empty. |

  ### Response Type

  [`List Device Codes Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/list-device-codes-response.md)

  ### Example Usage

      iex> Square.client |> Square.Devices.list_device_codes()

  """
  @spec list_device_codes(Tesla.Client.t(), list) :: {:error, any} | {:ok, Tesla.Env.t()}
  def list_device_codes(client, params \\ []),
    do: Tesla.get(client, "devices/codes", query: params)

  @doc """
  Creates a DeviceCode that can be used to login to a Square Terminal device to enter the connected
  terminal mode.

  ```
  def create_device_code(client, body)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `body` | [`Create Device Code Request Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/create-device-code-request.md) | Body, Required | An object containing the fields to POST for the request.<br><br>See the corresponding object definition for field details. |

  ### Response Type

  [`Create Device Code Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/create-device-code-response.md)

  ### Example Usage

      iex> body = %{
        idempotency_key: "01bb00a6-0c86-4770-94ed-f5fca973cd56",
        device_code: %{
          name: "Counter 1",
          product_type: "TERMINAL_API",
          location_id: "B5E4484SHHNYH"
        }
      }
      iex> Square.client |> Square.Devices.create_device_code(body)
  """
  @spec create_device_code(Tesla.Client.t(), map) :: {:error, any} | {:ok, Tesla.Env.t()}
  def create_device_code(client, body \\ %{}), do: Tesla.post(client, "devices/codes", body)

  @doc """
  Retrieves DeviceCode with the associated ID.

  ```
  def get_device_code(client, id)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `id` | `String` | Template, Required | The unique identifier for the device code. |

  ### Response Type

  [`Get Device Code Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/get-device-code-response.md)

  ### Example Usage

      iex> Square.client |> Square.Devices.get_device_code(id)

  """
  @spec get_device_code(Tesla.Client.t(), binary) :: {:error, any} | {:ok, Tesla.Env.t()}
  def get_device_code(client, id), do: Tesla.get(client, "devices/codes/#{id}")
end
