defmodule Square.Customers do
  @moduledoc """
  Documentation for `Square.Customers`.
  """

  @doc """
  Lists a business's customers.

  ```
  def list_customers(client, [cursor: nil, sort_field: nil, sort_order: nil])
  ```
  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `cursor` | `String` | Query, Optional | A pagination cursor returned by a previous call to this endpoint.<br>Provide this to retrieve the next set of results for your original query.<br><br>See the [Pagination guide](https://developer.squareup.com/docs/working-with-apis/pagination) for more information. |
  | `sort_field` | [`String (Customer Sort Field)`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/customer-sort-field.md) | Query, Optional | Indicates how Customers should be sorted.<br><br>Default: `DEFAULT`. |
  | `sort_order` | [`String (Sort Order)`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/sort-order.md) | Query, Optional | Indicates whether Customers should be sorted in ascending (`ASC`) or<br>descending (`DESC`) order.<br><br>Default: `ASC`. |

  ### Response Type

  [`List Customers Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/list-customers-response.md)

  ### Example Usage

      iex> Square.client |> Square.Customers.list_customers()
  """
  @spec list_customers(Tesla.Client.t(), list) :: {:error, any} | {:ok, Tesla.Env.t()}
  def list_customers(client, params \\ []), do: Tesla.get(client, "customers", query: params)

  @doc """
  Creates a new customer for a business, which can have associated cards on file.

  You must provide __at least one__ of the following values in your request to this
  endpoint:

  - `given_name`
  - `family_name`
  - `company_name`
  - `email_address`
  - `phone_number`

  ```
  def create_customer(client, body)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `body` | [`Create Customer Request Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/create-customer-request.md) | Body, Required | A map containing the fields to POST for the request.<br><br>See the corresponding map definition for field details. |

  ### Response Type

  [`Create Customer Response Map`](/doc/models/create-customer-response.md)

  ### Example Usage

      iex> body = %{
        given_name: "Amelia",
        family_name: "Earhart",
        email_address: "Amelia.Earhart@example.com",
        address: %{
          address_line_1: "500 Electric Ave.",
          address_line_2: "Suite 600",
          locality: "New York",
          administrative_district_level_1: "NY",
          postal_code: "10003",
          country: "US"
        },
        phone_number: "1-212-555-4240",
        reference_id: "Your reference ID",
        note: "a customers"
      }
      iex> Square.client |> Square.Customer.create_customer(body)
  """
  @spec create_customer(Tesla.Client.t(), map) :: {:error, any} | {:ok, Tesla.Env.t()}
  def create_customer(client, body \\ %{}), do: Tesla.post(client, "customers", body)

  @doc """
  Searches the customer profiles associated with a Square account.
  Calling SearchCustomers without an explicit query parameter returns all
  customer profiles ordered alphabetically based on `given_name` and `family_name`.

  ```
  def search_customers(client, body)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `body` | [`Search Customers Request Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/search-customers-request.md) | Body, Required | An object containing the fields to POST for the request.<br><br>See the corresponding object definition for field details. |

  ### Response Type

  [`Search Customers Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/search-customers-response.md)

  ### Example Usage

      iex> body = %{
            limit: 2,
            query: %{
              filter: %{
                creation_source: %{
                  values: ["THIRD_PARTY"],
                  rule: "INCLUDE"
                },
                created_at: %{
                  start_at: "2018-01-01T00:00:00-00:00",
                  end_at: "2018-02-01T00:00:00-00:00"
                },
                group_ids: %{
                  all: ["545AXB44B4XXWMVQ4W8SBT3HHF"]
                },
              }
            },
            sort: %{
              field: "CREATED_AT",
              order: "ASC"
            }
          }
      iex> Square.client |> Square.Customers.search_customers(client, body)
  """
  @spec search_customers(Tesla.Client.t(), map) :: {:error, any} | {:ok, Tesla.Env.t()}
  def search_customers(client, body \\ %{}), do: Tesla.post(client, "customers/search", body)

  @doc """
  Deletes a customer from a business, along with any linked cards on file. When two profiles
  are merged into a single profile, that profile is assigned a new `customer_id`. You must use the
  new `customer_id` to delete merged profiles.

  ```
  def delete_customer(client, customer_id)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `customer_id` | `String` | Template, Required | The ID of the customer to delete. |

  ### Response Type

  [`Delete Customer Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/delete-customer-response.md)

  ### Example Usage

      iex> customer_id = "customer_id8"
      iex> Square.client |> Square.Customers.delete_customer(customer_id)

  """
  @spec delete_customer(Tesla.Client.t(), binary) :: {:error, any} | {:ok, Tesla.Env.t()}
  def delete_customer(client, customer_id), do: Tesla.delete(client, "customers/#{customer_id}")

  @doc """
  Returns details for a single customer.

  ```
  def retrieve_customer(client, customer_id)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `customer_id` | `String` | Template, Required | The ID of the customer to retrieve. |

  ### Response Type

  [`Retrieve Customer Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/retrieve-customer-response.md)

  ### Example Usage

      iex> customer_id = "customer_id8"

      iex> Square.client |> Square.Customers.retrieve_customer(customer_id)
  """
  @spec retrieve_customer(Tesla.Client.t(), binary) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def retrieve_customer(client, customer_id), do: Tesla.get(client, "customers/#{customer_id}")

  @doc """
  Updates the details of an existing customer. When two profiles are merged
  into a single profile, that profile is assigned a new `customer_id`. You must use
  the new `customer_id` to update merged profiles.

  You cannot edit a customer's cards on file with this endpoint. To make changes
  to a card on file, you must delete the existing card on file with the
  [DeleteCustomerCard](#endpoint-deletecustomercard) endpoint, then create a new one with the
  [CreateCustomerCard](#endpoint-createcustomercard) endpoint.

  ```
  def update_customer(client, customer_id, body)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `customer_id` | `String` | Template, Required | The ID of the customer to update. |
  | `body` | [`Update Customer Request Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/update-customer-request.md) | Body, Required | An object containing the fields to POST for the request.<br><br>See the corresponding object definition for field details. |

  ### Response Type

  [`Update Customer Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/update-customer-response.md)

  ### Example Usage

      iex> customer_id = "customer_id8"
      iex> body = %{
        email_address: "New.Amelia.Earhart@example.com",
        phone_number: "",
        note: "updated customer note"
      }
      iex> Square.client |> Square.Customers.update_customer(customer_id, body)
  """
  @spec update_customer(Tesla.Client.t(), binary, map) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def update_customer(client, customer_id, body),
    do: Tesla.put(client, "customers/#{customer_id}", body)

  @doc """
  Adds a card on file to an existing customer.

  As with charges, calls to `CreateCustomerCard` are idempotent. Multiple
  calls with the same card nonce return the same card record that was created
  with the provided nonce during the _first_ call.

  ```
  def create_customer_card(client, customer_id, body)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `customer_id` | `String` | Template, Required | The Square ID of the customer profile the card is linked to. |
  | `body` | [`Create Customer Card Request Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/create-customer-card-request.md) | Body, Required | An object containing the fields to POST for the request.<br><br>See the corresponding object definition for field details. |

  ### Response Type

  [`Create Customer Card Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/create-customer-card-response.md)

  ### Example Usage

      iex> customer_id = "customer_id8"
      iex> body = %{
        card_nonce: "Your card nonce",
        billing_address: %{
          address_line_1: "500 Electric Ave",
          address_line_2: "Suite 600",
          locality: "New York",
          administrative_district_level_1: "NY",
          postal_code: "10003",
          country: "US",
          cardholder_name: "Amelia Earhart"
        }
      }
      iex> Square.client |> Square.Customers.create_customer_card(customer_id, body)
  """
  @spec create_customer_card(Tesla.Client.t(), binary, map) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def create_customer_card(client, customer_id, body),
    do: Tesla.post(client, "customers/#{customer_id}/cards", body)

  @doc """
  Removes a card on file from a customer.

  ```
  def delete_customer_card(client, customer_id, card_id)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `customer_id` | `String` | Template, Required | The ID of the customer that the card on file belongs to. |
  | `card_id` | `String` | Template, Required | The ID of the card on file to delete. |

  ### Response Type

  [`Delete Customer Card Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/delete-customer-card-response.md)

  ### Example Usage

      iex> customer_id = "customer_id8"
      iex> card_id = "card_id4"
      iex> Square.client |> Square.Customers.delete_customer_card(customer_id, card_id)
  """
  @spec delete_customer_card(Tesla.Client.t(), binary, binary) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def delete_customer_card(client, customer_id, card_id),
    do: Tesla.delete(client, "customers/#{customer_id}/cards/#{card_id}")

  @doc """
  Adds a group membership to a customer.

  The customer is identified by the `customer_id` value
  and the customer group is identified by the `group_id` value.

  ```
  def add_group_to_customer(client, customer_id, group_id)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `customer_id` | `String` | Template, Required | The ID of the customer to add to a group. |
  | `group_id` | `String` | Template, Required | The ID of the customer group to add the customer to. |

  ### Response Type

  [`Add Group to Customer Response Map`](https://github.com/square/square-ruby-sdk/blob/maste/doc/models/add-group-to-customer-response.md)

  ### Example Usage

      iex> customer_id = "customer_id8"
      iex> group_id = "group_id0"

      iex> Square.client |> Square.Customers.add_group_to_customer(customer_id, group_id)

  """
  @spec add_group_to_customer(Tesla.Client.t(), binary, binary) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def add_group_to_customer(client, customer_id, group_id),
    do: Tesla.put(client, "customers/#{customer_id}/groups/#{group_id}", %{})

  @doc """
  Removes a group membership from a customer.

  The customer is identified by the `customer_id` value
  and the customer group is identified by the `group_id` value.

  ```
  def remove_group_from_customer(client, customer_id, group_id)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `customer_id` | `String` | Template, Required | The ID of the customer to remove from the group. |
  | `group_id` | `String` | Template, Required | The ID of the customer group to remove the customer from. |

  ### Response Type

  [`Remove Group From Customer Response Map`](https://github.com/square/square-ruby-sdk/blob/maste/doc/models/remove-group-from-customer-response.md)

  ### Example Usage

      iex> customer_id = "customer_id8"
      iex> group_id = "group_id0"

      iex> Square.client |> Square.Customers.remove_group_from_customer(customer_id, group_id)
  """
  @spec remove_group_from_customer(Tesla.Client.t(), binary, binary) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def remove_group_from_customer(client, customer_id, group_id),
    do: Tesla.delete(client, "customers/#{customer_id}/groups/#{group_id}")
end
