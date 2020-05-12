defmodule Square.Terminal do
  def create_terminal_checkout(client, body \\ %{}),
    do: Tesla.post(client, "terminals/checkouts", body)

  def search_terminal_checkouts(client, body \\ %{}),
    do: Tesla.post(client, "terminals/checkouts/search", body)

  def get_terminal_checkout(client, checkout_id),
    do: Tesla.get(client, "terminals/checkouts/#{checkout_id}")

  def cancel_terminal_checkout(client, checkout_id, body \\ %{}),
    do: Tesla.post(client, "terminals/checkouts/#{checkout_id}/cancel", body)
end
