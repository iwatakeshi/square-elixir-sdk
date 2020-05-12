defmodule Square.LocationsTest do
  use ExUnit.Case
  import Square
  import Square.Locations

  test "list all locations" do
    response =
      client()
      |> list_locations()

    assert {:ok, res} = response
    assert res.status == 200
  end

  test "create a location" do
    body = %{
      location: %{
        name: "New location name",
        description: "My new location",
        address: %{
          address_line_1: "1234 Peachtree St. NE",
          administrative_district_level_1: "GA",
          locality: "Atlanta",
          postal_code: "30309"
        }
      }
    }

    response = client() |> create_location(body)
    assert {:ok, res} = response
    assert res.status == 200
  end

  test "retrieve a location" do
    location_id = "X60RNSW7Y4JF1"

    response = client() |> retrieve_location(location_id)
    assert {:ok, res} = response
    assert res.status == 200
  end

  test "update a location" do
    location_id = "X60RNSW7Y4JF1"

    body = %{
      location: %{
        name: "New location name",
        description: "Updated location",
        address: %{
          address_line_1: "1234 Peachtree St. NE",
          administrative_district_level_1: "GA",
          locality: "Atlanta",
          postal_code: "30309"
        },
        business_hours: %{
          periods: [%{day_of_week: "MON", start_local_time: "09:00", end_local_time: "17:00"}]
        },
        twitter_username: "twitter",
        instagram_username: "instagram"
      }
    }

    response = client() |> update_location(location_id, body)
    assert {:ok, res} = response
    assert res.status == 200
  end
end
