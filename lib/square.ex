defmodule Square do
  alias Square.Config

  @moduledoc """
  Documentation for `Square`.
  """

  @doc """
  Returns a client that makes requests to Square's API.

  You may also specify the API version to use. This defaults to `v2`.
  """
  @spec client(binary) :: Tesla.Client.t()
  def client(version \\ "v2"), do: client(Config.access_token(), version)

  @doc """
  Returns a client that makes requests to Square's API.

  You may also specify an access token and an API version to use.
  """
  @spec client(binary, binary) :: Tesla.Client.t()
  def client(token, version) do
    middleware = [
      {Tesla.Middleware.BaseUrl, Config.base_url(version)},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers,
       [
         {"Authorization", "Bearer " <> token},
         {"Square-Version", Config.api_version()}
       ]}
    ]

    Tesla.client(middleware)
  end
end
