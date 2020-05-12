defmodule Square.Merchants do
  @moduledoc """
  Documentation for `Square.Merchants`.
  """

  def list_merchants(client, params \\ []), do: Tesla.get(client, "merchants", query: params)

  def retrieve_merchants(client, merchant_id), do: Tesla.get(client, "merchants/#{merchant_id}")
end
