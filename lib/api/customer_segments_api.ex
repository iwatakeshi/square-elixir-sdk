defmodule Square.CustomerSegments do
  @moduledoc """
  Documentation for `Square.Segments`.
  """

  @doc """
  Retrieves the list of customer segments of a business.

  ```
  def list_customer_segments(client, [cursor: nil])
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `cursor` | `String` | Query, Optional | A pagination cursor returned by previous calls to __ListCustomerSegments__.<br>Used to retrieve the next set of query results.<br><br>See the [Pagination guide](https://developer.squareup.com/docs/docs/working-with-apis/pagination) for more information. |

  ### Response Type

  [`List Customer Segments Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/list-customer-segments-response.md)

  ### Example Usage

      iex> Square.client |> Square.CustomerSegments.list_customer_segments()
  """
  @spec list_customer_segments(Tesla.Client.t(), list) :: {:error, any} | {:ok, Tesla.Env.t()}
  def list_customer_segments(client, params \\ []),
    do: Tesla.get(client, "customers/segments", query: params)

  @doc """
  Retrieves a specific customer segment as identified by the `segment_id` value.

  ```
  def retrieve_customer_segment(segment_id:)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `segment_id` | `String` | Template, Required | The Square-issued ID of the customer segment. |

  ### Response Type

  [`Retrieve Customer Segment Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/retrieve-customer-segment-response.md)

  ### Example Usage

      iex> segment_id = "segment_id4"
      iex> Square.client |> Square.CustomerSegments.retrieve_customer_segment(segment_id)

  """
  @spec retrieve_customer_segment(Tesla.Client.t(), binary) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def retrieve_customer_segment(client, segment_id),
    do: Tesla.get(client, "customers/segments/#{segment_id}")
end
