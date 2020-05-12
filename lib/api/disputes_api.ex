defmodule Square.Disputes do
  @moduledoc """
  Documentation for `Square.Disputes`.
  """
  alias Tesla.Multipart

  @spec list_disputes(Tesla.Client.t(), list) :: {:error, any} | {:ok, Tesla.Env.t()}
  def list_disputes(client, params \\ []), do: Tesla.get(client, "disputes", query: params)

  @spec retrieve_disputes(Tesla.Client.t(), binary) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def retrieve_disputes(client, dispute_id), do: Tesla.get(client, "disputes/#{dispute_id}")

  @spec accept_dispute(Tesla.Client.t(), binary) :: {:error, any} | {:ok, Tesla.Env.t()}
  def accept_dispute(client, dispute_id),
    do: Tesla.post(client, "disputes/#{dispute_id}/accept", %{})

  @spec list_dispute_evidence(Tesla.Client.t(), binary) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def list_dispute_evidence(client, dispute_id), do: Tesla.get(client, "disputes/#{dispute_id}")

  @spec remove_dispute_evidence(binary | Tesla.Client.t(), any, any) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def remove_dispute_evidence(client, dispute_id, evidence_id),
    do: Tesla.delete(client, "disputes/#{dispute_id}/evidence/#{evidence_id}")

  @spec retrieve_dispute_evidence(binary | Tesla.Client.t(), any, any) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def retrieve_dispute_evidence(client, dispute_id, evidence_id),
    do: Tesla.get(client, "disputes/#{dispute_id}/evidence/#{evidence_id}")

  @spec create_dispute_evidence_file(binary | Tesla.Client.t(), any, any) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def create_dispute_evidence_file(client, dispute_id, params \\ []) do
    mp =
      case params do
        [request: request, image_file: image_file] ->
          Multipart.new()
          |> Multipart.add_field("request", request, headers: [{"content-type: application/json"}])
          |> Multipart.add_file(image_file, detect_content_type: true)

        [request: request] ->
          Multipart.new()
          |> Multipart.add_field("request", request, headers: [{"content-type: application/json"}])

        [image_file: image_file] ->
          Multipart.new() |> Multipart.add_file(image_file, detect_content_type: true)

        _ ->
          Multipart.new()
      end

    Tesla.post(client, "disputes/#{dispute_id}/evidence_file", mp)
  end

  @spec create_dispute_evidence_text(binary | Tesla.Client.t(), any, any) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def create_dispute_evidence_text(client, dispute_id, body \\ %{}),
    do: Tesla.post(client, "disputes/#{dispute_id}/evidence_text", body)
end
