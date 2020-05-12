defmodule Square.Locations do
  @moduledoc """
  Documentation for `Square.Locations`.
  """

  @doc """
  Provides information of all locations of a business.

  Most other Connect API endpoints have a required `location_id` path parameter.
  The `id` field of the `Location` map returned by this endpoint correspond to that `location_id` parameter.

  ```
  def list_locations(client)
  ```

  ### Response Type

  [`List Locations Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/list-locations-response.md)

  ### Example Usage

      iex> Square.client |> Square.Locations.list_locations()
  """
  @spec list_locations(Tesla.Client.t()) :: {:error, any} | {:ok, Tesla.Env.t()}
  def list_locations(client), do: Tesla.get(client, "locations")

  @doc """
  Creates a location.
  For more information about locations, see [Locations API Overview](https://developer.squareup.com/docs/locations-api).

  ```
  def create_location(client, body)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `body` | [`Create Location Request Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/create-location-request.md) | Body, Required | A map containing the fields to POST for the request.<br><br>See the corresponding map definition for field details. |

  ### Response Type

  [`Create Location Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/create-location-response.md)

  ### Example Usage

      iex> body =%{
            location: %{
              name: "New location name",
              description: "My new location",
              address: %{
                address_line_1: "1234 Peachtree St. NE",
                administrative_district_level_1: "GA",
                locality: "Atlanta",
                postal_code: "30309"
              }
            }
          }
      iex> Square.client |> Square.Locations.create_location(body)
  """
  @spec create_location(Tesla.Client.t(), map) :: {:error, any} | {:ok, Tesla.Env.t()}
  def create_location(client, body \\ %{}), do: Tesla.post(client, "locations", body)

  @doc """
  Retrieves details of a location.

  ```
  def retrieve_location(client, location_id)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `location_id` | `String` | Template, Required | The ID of the location to retrieve. |

  ### Response Type

  [`Retrieve Location Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/retrieve-location-response.md)

  ### Example Usage


      iex> location_id = "location_id4"
      iex> Square.client |> Square.Locations.retrieve_location(location_id)

  """
  @spec retrieve_location(Tesla.Client.t(), binary) :: {:error, any} | {:ok, Tesla.Env.t()}
  def retrieve_location(client, location_id), do: Tesla.get(client, "locations/#{location_id}")

  @doc """
  Updates a location.

  ```
  def update_location(client, location_id, body)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `location_id` | `String` | Template, Required | The ID of the location to update. |
  | `body` | [`Update Location Request Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/update-location-request.md) | Body, Required | A map containing the fields to POST for the request.<br><br>See the corresponding map definition for field details. |

  ### Response Type

  [`Update Location Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/update-location-response.md)

  ### Example Usage

  ```
      iex> location_id = "location_id4"
      iex> body = %{
            location: %{
                name: "New location name",
                description: "Updated location",
                address: %{
                  address_line_1: "1234 Peachtree St. NE",
                  administrative_district_level_1: "GA",
                  locality: "Atlanta",
                  postal_code: "30309"
                },
                business_hours: {
                  periods: [
                    %{ day_of_week: "MON", start_local_time: "09:00", end_local_time: "17:00" }
                  ]
                },
                twitter_username: "twitter",
                instagram_username: "instagram"
              }
            }
      iex> Square.client |> Square.Locations.update_location(location_id, body)
  """
  @spec update_location(Tesla.Client.t(), binary, map) :: {:error, any} | {:ok, Tesla.Env.t()}
  def update_location(client, location_id, body \\ %{}),
    do: Tesla.put(client, "locations/#{location_id}", body)
end
