defmodule Square.Config do
  @moduledoc """
  Stores configuration variables used to communicate with Square's Connect API

  All settings also accept `{:system, "VAR" }` to read their
  values from environment variables at runtime.
  """

  @doc """
  Determines whether the API should run in sandbox or production. This will default to sandbox,
  but can be overridden in `mix.exs`:

      config :square_elixir_sdk, sandbox: false
  """
  @spec sandbox() :: boolean
  def sandbox, do: from_env(:square_elixir_sdk, :sandbox, true)

  @doc """
  Returns the protocol used for the Square API. The default is `"https"` for
  interacting with the Square API, but when testing with Bypass, you may want
  this to be `"http"`.
  """
  @spec protocol :: binary
  def protocol, do: Application.get_env(:square_elixir_sdk, :protocol) || "https"

  @doc """
  Returns the domain of the Square API. This will default to `connect.squareupsandbox.com`,
  but can be overridden using the `sandbox` setting.
  """
  @spec api_domain :: binary
  def api_domain,
    do: if(sandbox(), do: "connect.squareupsandbox.com", else: "connect.squareup.com")

  @doc """
  Returns the version of the API that the Square SDK is going to request for. Set it in
  `mix.exs`:
      config :square_elixir_sdk, api_version: "2020-04-22"
  """
  @spec api_version :: binary
  def api_version, do: Application.get_env(:square_elixir_sdk, :api_version) || "2020-04-22"

  @doc """
  Returns the combined base URL of the Square API, using the configuration
  settings given.

  You can also specify the api version to use. This will default to `v2`
  """
  @spec base_url(binary) :: binary
  def base_url(version \\ "v2"),
    do:
      if(version == "",
        do: "#{protocol()}://#{api_domain()}/",
        else: "#{protocol()}://#{api_domain()}/#{version}/"
      )

  @doc """
  Returns the Square Access Token for your account. Set it in `mix.exs`:

      config :square_elixir_sdk, access_token: "Your auth token"
  """
  @spec access_token :: binary
  def access_token, do: from_env(:square_elixir_sdk, :access_token)

  @doc """
  A light wrapper around `Application.get_env/2`, providing automatic support for `{:system, "VAR" }` tuples.
  """
  @spec from_env(atom, atom, any) :: any
  def from_env(otp_app, key, default \\ nil)

  def from_env(otp_app, key, default) do
    otp_app
    |> Application.get_env(key, default)
    |> read_from_system(default)
  end

  defp read_from_system({:system, env}, default), do: System.get_env(env) || default
  defp read_from_system(value, _default), do: value
end
