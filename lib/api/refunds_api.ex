defmodule Square.Refunds do
  def list_payment_refunds(client, params \\ []), do: Tesla.get(client, "refunds", query: params)

  def refund_payment(client, body \\ %{}), do: Tesla.post(client, "refunds", body)

  def get_payment_refund(client, refund_id), do: Tesla.get(client, "refunds/#{refund_id}")
end
