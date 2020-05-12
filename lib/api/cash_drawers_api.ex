defmodule Square.CashDrawers do
  @moduledoc """
  Documentation for `Square.CashDrawers`.
  """

  @doc """
  Provides the details for all of the cash drawer shifts for a location
  in a date range.

  ```
  def list_cash_drawer_shifts(client, [
    location_id: "", # required
    sort_order: nil,
    begin_time: nil,
    end_time: nil,
    limit: nil,
    cursor: nil
  ])
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `location_id` | `String` | Query, Required | The ID of the location to query for a list of cash drawer shifts. |
  | `sort_order` | [`String (Sort Order)`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/sort-order.md) | Query, Optional | The order in which cash drawer shifts are listed in the response,<br>based on their opened_at field. Default value: ASC |
  | `begin_time` | `String` | Query, Optional | The inclusive start time of the query on opened_at, in ISO 8601 format. |
  | `end_time` | `String` | Query, Optional | The exclusive end date of the query on opened_at, in ISO 8601 format. |
  | `limit` | `Integer` | Query, Optional | Number of cash drawer shift events in a page of results (200 by<br>default, 1000 max). |
  | `cursor` | `String` | Query, Optional | Opaque cursor for fetching the next page of results. |

  ### Response Type

  [`List Cash Drawer Shifts Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/list-cash-drawer-shifts-response.md)

  ### Example Usage

      iex> location_id = "location_id"
      iex> Square.client |> Square.CashDrawers.list_cash_drawer_shifts([location_id: "..."])
  """
  @spec list_cash_drawers_shifts(Tesla.Client.t(), list) :: {:error, any} | {:ok, Tesla.Env.t()}
  def list_cash_drawers_shifts(client, params \\ []),
    do: Tesla.get(client, "cash-drawers/shifts", query: params)

  @doc """
    Provides the summary details for a single cash drawer shift. See
  RetrieveCashDrawerShiftEvents for a list of cash drawer shift events.

  ```
  def retrieve_cash_drawer_shift(client, shift_id, [
    location_id: "" # required
  ])
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `location_id` | `String` | Query, Required | The ID of the location to retrieve cash drawer shifts from. |
  | `shift_id` | `String` | Template, Required | The shift ID. |

  ### Response Type

  [`Retrieve Cash Drawer Shift Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/doc/models/retrieve-cash-drawer-shift-response.md)

  ### Example Usage

      iex> location_id = "location_id4"
      iex> shift_id = "shift_id0"
      iex> Square.client |> Square.CashDrawers.retrieve_cash_drawer_shift(shift_id, [location_id: "..."])

  """
  @spec retreive_cash_drawer_shift(Tesla.Client.t(), binary, list) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def retreive_cash_drawer_shift(client, shift_id, params \\ []),
    do: Tesla.get(client, "cash-drawers/shifts/#{shift_id}", query: params)

  @doc """
  Provides a paginated list of events for a single cash drawer shift.

  ```
  def list_cash_drawer_shift_events(shift_id, [
    location_id: "", # required
    limit: nil,
    cursor: nil
  ])
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `location_id` | `String` | Query, Required | The ID of the location to list cash drawer shifts for. |
  | `shift_id` | `String` | Template, Required | The shift ID. |
  | `limit` | `Integer` | Query, Optional | Number of resources to be returned in a page of results (200 by<br>default, 1000 max). |
  | `cursor` | `String` | Query, Optional | Opaque cursor for fetching the next page of results. |

  ### Response Type

  [`List Cash Drawer Shift Events Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/list-cash-drawer-shift-events-response.md)

  ### Example Usage

      iex> location_id = "location_id4"
      iex> shift_id = "shift_id0"
      iex> Square.client |> Square.CashDrawers.list_cash_drawer_shift_events(client, shift_id, [location_id: ""])
  """
  @spec list_cash_drawers_shift_events(Tesla.Client.t(), binary, list) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def list_cash_drawers_shift_events(client, shift_id, params \\ []),
    do: Tesla.get(client, "cash-drawers/shifts/#{shift_id}/events", query: params)
end
