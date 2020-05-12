defmodule Square.Inventory do
  @moduledoc """
  Docuemntation for `Square.Inventory`.
  """

  def retrieve_inventory_adjustment(client, adjustment_id),
    do: Tesla.get(client, "inventory/adjustment/#{adjustment_id}")

  def batch_range_inventory(client, body \\ %{}),
    do: Tesla.post(client, "inventory/batch-change", body)

  def batch_retrieve_inventory_changes(client, body \\ %{}),
    do: Tesla.post(client, "inventory/batch-retrieve-changes", body)

  def batch_retrieve_inventory_counts(client, body \\ %{}),
    do: Tesla.post(client, "inventory/batch-retrieve-inventory-counts", body)

  def retrieve_inventory_physical_counts(client, physical_count_id),
    do: Tesla.get(client, "inventory/physical-count/#{physical_count_id}")

  def retrieve_inventory_changes(client, catalog_object_id, params \\ []),
    do: Tesla.get(client, "inventory/#{catalog_object_id}/changes", query: params)
end
