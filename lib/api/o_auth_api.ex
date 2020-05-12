defmodule Square.OAuth do
  alias Square.Config
  @spec renew_token(binary, binary, map) :: {:error, any} | {:ok, Tesla.Env.t()}
  def renew_token(client_id, authorization, body \\ %{}) do
    middleware = [
      {Tesla.Middleware.BaseUrl, Config.base_url("")},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers,
       [
         {"Authorization", authorization},
         {"Square-Version", Config.api_version()}
       ]}
    ]

    Tesla.client(middleware)
    |> Tesla.post("oauth2/clients/#{client_id}/access-token/renew", body)
  end

  def revoke_token(authorization, body \\ %{}) do
    middleware = [
      {Tesla.Middleware.BaseUrl, Config.base_url("")},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers,
       [
         {"Authorization", authorization},
         {"Square-Version", Config.api_version()}
       ]}
    ]

    Tesla.client(middleware)
    |> Tesla.post("oauth2/revoke", body)
  end

  def obtain_token(body \\ %{}) do
    middleware = [
      {Tesla.Middleware.BaseUrl, Config.base_url("")},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers,
       [
         {"Authorization", "Bearer " <> Config.access_token()},
         {"Square-Version", Config.api_version()}
       ]}
    ]

    Tesla.client(middleware)
    |> Tesla.post("oauth2/token", body)
  end
end
