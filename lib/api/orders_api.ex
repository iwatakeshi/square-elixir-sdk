defmodule Square.Orders do
  def create_order(client, location_id, body \\ %{}),
    do: Tesla.post(client, "locations/#{location_id}/orders", body)

  def batch_retrieve_order(client, location_id, body \\ %{}),
    do: Tesla.post(client, "locations/#{location_id}/orders/batch-retrieve", body)

  def update_order(client, location_id, order_id, body \\ %{}),
    do: Tesla.post(client, "locations/#{location_id}/orders/#{order_id}", body)

  def search_orders(client, body \\ %{}), do: Tesla.post(client, "orders/search", body)

  def pay_order(client, orders_id, body \\ %{}),
    do: Tesla.post(client, "orders/#{orders_id}/pay", body)
end
