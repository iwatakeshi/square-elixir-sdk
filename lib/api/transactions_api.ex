defmodule Square.Transactions do
  @deprecated "Endpoint 'list_refunds' in Transactions is deprecated"
  def list_refunds(client, location_id, params \\ []),
    do: Tesla.get(client, "locations/#{location_id}/refunds", query: params)

  @deprecated "Endpoint 'list_transactions' in Transactions is deprecated"
  def list_transactions(client, location_id, params \\ []),
    do: Tesla.get(client, "locations/#{location_id}/transactions", query: params)

  @deprecated "Endpoint 'charge' in Transactions is deprecated"
  def charge(client, location_id, body \\ %{}),
    do: Tesla.post(client, "locations/#{location_id}/transactions", body)

  @deprecated "Endpoint 'capture_transaction' in Transactions is deprecated"
  def capture_transaction(client, location_id, transaction_id),
    do: Tesla.post(client, "locations/#{location_id}/transactions/#{transaction_id}/capture", %{})

  @deprecated "Endpoint 'create_refund' in Transactions is deprecated"
  def create_refund(client, location_id, transaction_id, body \\ %{}),
    do: Tesla.post(client, "locations/#{location_id}/transactions/#{transaction_id}/refund", body)

  @deprecated "Endpoint 'void_transaction' in Transactions is deprecated"
  @spec void_transaction(binary | Tesla.Client.t(), any, any) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def void_transaction(client, location_id, transaction_id),
    do: Tesla.post(client, "locations/#{location_id}/transactions/#{transaction_id}/void", %{})
end
