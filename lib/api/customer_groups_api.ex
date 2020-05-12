defmodule Square.CustomerGroups do
  @moduledoc """
  Documentation for `Square.CustomerGroups`.
  """

  @doc """
  Retrieves the list of customer groups of a business.

  ```
  def list_customer_groups(client, [
    cursor: nil
  ])
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `cursor` | `String` | Query, Optional | A pagination cursor returned by a previous call to this endpoint.<br>Provide this to retrieve the next set of results for your original query.<br><br>See the [Pagination guide](https://developer.squareup.com/docs/working-with-apis/pagination) for more information. |

  ### Response Type

  [`List Customer Groups Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/list-customer-groups-response.md)

  ### Example Usage

      iex> Square.client |> Square.CustomerGroups.list_customer_groups()

  """
  @spec list_customer_groups(Tesla.Client.t(), list) :: {:error, any} | {:ok, Tesla.Env.t()}
  def list_customer_groups(client, params \\ []),
    do: Tesla.get(client, "customers/groups", query: params)

  @doc """
  Creates a new customer group for a business.

  The request must include the `name` value of the group.

  ```
  def create_customer_group(client, body)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `body` | [`Create Customer Group Request Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/create-customer-group-request.md) | Body, Required | An object containing the fields to POST for the request.<br><br>See the corresponding object definition for field details. |

  ### Response Type

  [`Create Customer Group Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/create-customer-group-response.md)

  ### Example Usage

      iex> body = %{
        group: {
          name: "Loyal Customers"
        }
      }
      iex> Square.client |> Square.CustomerGroups.create_customer_group(body)
  """
  @spec create_customer_group(Tesla.Client.t(), map) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def create_customer_group(client, body \\ %{}), do: Tesla.post(client, "customers/groups", body)

  @doc """
  Deletes a customer group as identified by the `group_id` value.

  ```
  def delete_customer_group(client, group_id)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `group_id` | `String` | Template, Required | The ID of the customer group to delete. |

  ### Response Type

  [`Delete Customer Group Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/delete-customer-group-response.md)

  ### Example Usage

      iex> group_id = "group_id0"

      iex> Square.client |> Square.CustomerGroups.delete_customer_group(group_id)

  """
  @spec delete_customer_group(Tesla.Client.t(), binary) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def delete_customer_group(client, group_id),
    do: Tesla.delete(client, "customers/groups/#{group_id}")

  @doc """
  Retrieves a specific customer group as identified by the `group_id` value.

  ```
  def retrieve_customer_group(client, group_id)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `group_id` | `String` | Template, Required | The ID of the customer group to retrieve. |

  ### Response Type

  [`Retrieve Customer Group Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/retrieve-customer-group-response.md)

  ### Example Usage

      iex> group_id = "group_id0"

      iex> Square.client |> Square.CustomerGroups.retrieve_customer_group(group_id)
  """
  @spec retrieve_customer_group(Tesla.Client.t(), binary) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def retrieve_customer_group(client, group_id),
    do: Tesla.get(client, "customers/groups/#{group_id}")

  @doc """
  Updates a customer group as identified by the `group_id` value.

  ```
  def update_customer_group(client, group_id, body)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `group_id` | `String` | Template, Required | The ID of the customer group to update. |
  | `body` | [`Update Customer Group Request Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/update-customer-group-request.md) | Body, Required | An object containing the fields to POST for the request.<br><br>See the corresponding object definition for field details. |

  ### Response Type

  [`Update Customer Group Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/update-customer-group-response.md)

  ### Example Usage


      iex> group_id = "group_id0"
      iex> body = %{
        group: {
          name: "Loyal Customers 2"
        }
      }
      iex> Square.client |> Square.CustomerGroups.update_customer_group(group_id, body)

  """
  @spec update_customer_group(Tesla.Client.t(), binary, map) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def update_customer_group(client, group_id, body \\ %{}),
    do: Tesla.put(client, "customers/groups/#{group_id}", body)
end
