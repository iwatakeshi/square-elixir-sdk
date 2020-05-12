defmodule Square.BankAccounts do
  @moduledoc """
  Documentation for `Square.BankAccounts`.
  """

  @doc """
  Returns a list of `BankAccount` maps linked to a Square account.
  For more information, see
  [Bank Accounts API](https://developer.squareup.com/docs/docs/bank-accounts-api).

  ```
  def list_bank_accounts(client, [
    cursor: nil,
    limit: nil,
    location_id: nil
  ])
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `cursor` | `String` | Query, Optional | The pagination cursor returned by a previous call to this endpoint.<br>Use it in the next `ListBankAccounts` request to retrieve the next set <br>of results.<br><br>See the [Pagination](https://developer.squareup.com/docs/docs/working-with-apis/pagination) guide for more information. |
  | `limit` | `Integer` | Query, Optional | Upper limit on the number of bank accounts to return in the response. <br>Currently, 1000 is the largest supported limit. You can specify a limit <br>of up to 1000 bank accounts. This is also the default limit. |
  | `location_id` | `String` | Query, Optional | Location ID. You can specify this optional filter <br>to retrieve only the linked bank accounts belonging to a specific location. |

  ### Response Type

  [`List Bank Accounts Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/list-bank-accounts-response.md)

  ### Example Usage

      iex> Square.client |> Square.BankAccounts.list_bank_accounts()

  """
  @spec list_bank_accounts(Tesla.Client.t(), list) :: {:error, any} | {:ok, Tesla.Env.t()}
  def list_bank_accounts(client, params \\ []),
    do: Tesla.get(client, "bank-accounts", query: params)

  @doc """
  Returns details of a [BankAccount](#type-bankaccount) identified by V1 bank account ID.
  For more information, see
  [Retrieve a bank account by using an ID issued by V1 Bank Accounts API](https://developer.squareup.com/docs/docs/bank-accounts-api#retrieve-a-bank-account-by-using-an-id-issued-by-the-v1-bank-accounts-api).

  ```
  def get_bank_account_by_v1_id(client, v1_bank_account_id)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `v1_bank_account_id` | `String` | Template, Required | Connect V1 ID of the desired `BankAccount`. For more information, see <br>[Retrieve a bank account by using an ID issued by V1 Bank Accounts API](https://developer.squareup.com/docs/docs/bank-accounts-api#retrieve-a-bank-account-by-using-an-id-issued-by-v1-bank-accounts-api). |

  ### Response Type

  [`Get Bank Account by V1 Id Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/get-bank-account-by-v1-id-response.md)

  ### Example Usage

      iex> v1_bank_account_id = "v1_bank_account_id8"
      iex> Square.client |> Square.BankAccounts.get_bank_account_by_v1_id(v1_bank_account_id)

  """
  @spec get_bank_account_by_v1_id(Tesla.Client.t(), binary) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def get_bank_account_by_v1_id(client, v1_bank_account_id),
    do: Tesla.get(client, "bank-accounts/by-v1-id/#{v1_bank_account_id}")

  @doc """
  Returns details of a [BankAccount](#type-bankaccount)
  linked to a Square account. For more information, see
  [Bank Accounts API](https://developer.squareup.com/docs/docs/bank-accounts-api).

  ```
  def get_bank_account(client, bank_account_id)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `bank_account_id` | `String` | Template, Required | Square-issued ID of the desired `BankAccount`. |

  ### Response Type

  [`Get Bank Account Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/get-bank-account-response.md)

  ### Example Usage

      iex> bank_account_id = "bank_account_id0"
      iex> Square.client |> Square.BankdAccounts.get_bank_account(bank_account_id)

  """
  @spec get_bank_accounts(binary | Tesla.Client.t(), binary) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def get_bank_accounts(client, bank_account_id),
    do: Tesla.get(client, "bank-accounts/#{bank_account_id}")
end
