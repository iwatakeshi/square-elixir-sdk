defmodule Square.MobileAuthorization do
  def create_mobile_authorization_code(client, body \\ %{}),
    do: Tesla.post(client, "mobile/authorization-code", body)
end
