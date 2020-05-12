defmodule Square.Reporting do
  def list_additional_recipient_receivables_refunds(client, location_id, params \\ []),
    do:
      Tesla.get(client, "locations/#{location_id}/additional-recipient-receivable-refunds",
        query: params
      )

  def list_additional_recipient_receivables(client, location_id, params \\ []),
    do:
      Tesla.get(client, "locations/#{location_id}/additional-recipient-receivables", query: params)
end
