defmodule Square.Employees do
  @moduledoc """
  Documentation for `Square.Employees`.
  """

  def list_employees(client, params \\ []), do: Tesla.get(client, "employees", query: params)

  def retrieve_employee(client, id), do: Tesla.get(client, "employees/#{id}")
end
