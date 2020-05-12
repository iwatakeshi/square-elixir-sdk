defmodule Square.Labor do
  @moduledoc """
  Documentation for `Square.Labor`
  """

  def list_break_types(client, params \\ []), do: Tesla.get(client, "labor/break-types", params)

  def create_break_types(client, body \\ %{}), do: Tesla.post(client, "labor/break-types", body)

  def delete_break_type(client, id), do: Tesla.delete(client, "labor/break-types/#{id}")

  def get_break_type(client, id), do: Tesla.get(client, "labor/break-types/#{id}")

  def update_break_type(client, id, body \\ %{}),
    do: Tesla.put(client, "labor/break-types/#{id}", body)

  def list_employee_wages(client, params \\ []),
    do: Tesla.get(client, "labor/employee-wages", query: params)

  def get_employee_wage(client, id), do: Tesla.get(client, "labor/employee-wages/#{id}")

  def create_shift(client, body \\ %{}), do: Tesla.post(client, "labor/shifts", body)

  def search_shifts(client, body \\ %{}), do: Tesla.post(client, "labor/shifts/search", body)

  def delete_shift(client, id), do: Tesla.delete(client, "labor/shifts/#{id}")

  def get_shift(client, id), do: Tesla.get(client, "labor/shifts/#{id}")

  def update_shift(client, id, body \\ %{}), do: Tesla.put(client, "labor/shifts/#{id}", body)

  def list_workweek_configs(client, params \\ []),
    do: Tesla.get(client, "labor/workweek-configs", query: params)
end
