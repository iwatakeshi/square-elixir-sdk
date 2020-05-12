defmodule Square.PaymentsTest do
  use ExUnit.Case
  import Square
  import Square.Payments

  test "list all payments" do
    response =
      client()
      |> list_payments()

    assert {:ok, res} = response
    assert res.status == 200
  end

  test "create a payment (nonce)" do
    body = %{
      amount_money: %{
        amount: 10,
        currency: "USD"
      },
      idempotency_key: UUID.uuid4(),
      source_id: "cnon:card-nonce-ok"
    }

    response = client() |> create_payment(body)
    assert {:ok, res} = response
    assert res.body["payment"]["status"] == "COMPLETED"
    assert res.body["payment"]["card_details"]["status"] == "CAPTURED"
  end
end
