defmodule Square.Catalog do
  alias Tesla.Multipart

  @moduledoc """
  Documentation for `Square.Catalog`.
  """

  @doc """
  Deletes a set of [CatalogItem](#type-catalogitem)s based on the
  provided list of target IDs and returns a set of successfully deleted IDs in
  the response. Deletion is a cascading event such that all children of the
  targeted object are also deleted. For example, deleting a CatalogItem will
  also delete all of its [CatalogItemVariation](#type-catalogitemvariation)
  children.

  `BatchDeleteCatalogObjects` succeeds even if only a portion of the targeted
  IDs can be deleted. The response will only include IDs that were
  actually deleted.

  ```
  def batch_delete_catalog_objects(client, body)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `body` | [`Batch Delete Catalog Objects Request Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/batch-delete-catalog-objects-request.md) | Body, Required | An object containing the fields to POST for the request.<br><br>See the corresponding object definition for field details. |

  ### Response Type

  [`Batch Delete Catalog Objects Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/batch-delete-catalog-objects-response.md)

  ### Example Usage

      iex> body = %{
        object_ids: ["W62UWFY35CWMYGVWK6TWJDNI", "AA27W3M2GGTF3H6AVPNB77CK"]
      }
      iex> Square.client |> Square.Catalog.batch_delete_catalog_objects(body)
  """
  @spec batch_delete_catalog_objects(Tesla.Client.t(), map) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def batch_delete_catalog_objects(client, body \\ %{}),
    do: Tesla.post(client, "catalog/batch-delete", body)

  @doc """
  Returns a set of objects based on the provided ID.
  Each [CatalogItem](#type-catalogitem) returned in the set includes all of its
  child information including: all of its
  [CatalogItemVariation](#type-catalogitemvariation) objects, references to
  its [CatalogModifierList](#type-catalogmodifierlist) objects, and the ids of
  any [CatalogTax](#type-catalogtax) objects that apply to it.

  ```
  def batch_retrieve_catalog_objects(body)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `body` | [`Batch Retrieve Catalog Objects Request Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/batch-retrieve-catalog-objects-request.md) | Body, Required | An object containing the fields to POST for the request.<br><br>See the corresponding object definition for field details. |

  ### Response Type

  [`Batch Retrieve Catalog Objects Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/batch-retrieve-catalog-objects-response.md)

  ### Example Usage

      iex> body = %{
        object_ids: ["W62UWFY35CWMYGVWK6TWJDNI", "AA27W3M2GGTF3H6AVPNB77CK"],
        include_releted_objects: true
      }
      iex> Square.client |> Square.Catalog.batch_retrieve_catalog_objects(body)
  """
  @spec batch_retrieve_catalog_objects(Tesla.Client.t(), map) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def batch_retrieve_catalog_objects(client, body \\ %{}),
    do: Tesla.post(client, "catalog/batch-retrieve", body)

  @doc """
  Creates or updates up to 10,000 target objects based on the provided
  list of objects. The target objects are grouped into batches and each batch is
  inserted/updated in an all-or-nothing manner.

  If an object within a batch is malformed in some way, or violates a database constraint, the entire batch
  containing that item will be disregarded. However, other batches in the same
  request may still succeed. Each batch may contain up to 1,000 objects, and
  batches will be processed in order as long as the total object count for the
  request (items, variations, modifier lists, discounts, and taxes) is no more
  than 10,000.

  ```
  def batch_upsert_catalog_objects(body:)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `body` | [`Batch Upsert Catalog Objects Request Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/batch-upsert-catalog-objects-request.md) | Body, Required | An object containing the fields to POST for the request.<br><br>See the corresponding object definition for field details. |

  ### Response Type

  [`Batch Upsert Catalog Objects Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/batch-upsert-catalog-objects-response.md)

  ### Example Usage

      iex> body = %{
          idempotency_key: "789ff020-f723-43a9-b4b5-43b5dc1fa3dc",
          batches: [%{
            objects: [
              %{
                type: "ITEM",
                id: "#Tea",
                present_at_all_locations: true,
                item_data: %{
                  name: "Tea",
                  description: "Hot Leaf Juice",
                  category_id: "#Beverages",
                  tax_ids: ["#SalesTax"],
                  variations: [%{
                    type: "ITEM_VARIATION",
                    id: "#Tea_Mug",
                    present_at_all_locations: true,
                    item_variation_data: %{
                      item_id: "#Tea",
                        name: "Mug",
                        pricing_type: "FIXED_PRICING",
                        price_money: %{
                          amount: 150,
                          currency: "USD"
                        }
                    }
                  }]
                }
              },
              %{
                type: "ITEM",
                id: "#Coffee",
                present_at_all_location: true,
                item_data: %{
                  name: "Coffee",
                  description: "Hot Bean Juice",
                  category_id: "#Beverage",
                  tax_id: "#SalesTax",
                  variations: [
                    %{
                    type: "ITEM_VARIATION",
                    id: "#Coffee_Regular",
                    present_at_all_locations: true,
                    item_variation_data: %{
                      item_id: "#Coffee",
                      name: "Regular",
                      pricing_type: "FIXED_PRICING",
                      price_money: %{
                        amount: 250,
                        currency: "USD"
                      }
                    }
                  }, %{
                    type: "ITEM_VARIATION",
                    id: "#Coffee_Large",
                    present_at_all_locations: true,
                    item_variation_data: %{
                      item_id: "#Coffee",
                      name: "Large",
                      pricing_type: "FIXED_PRICING",
                      price_money: %{
                        amount: 350,
                        currency: "USD"
                      }
                    }
                  }]
                }
              },
              %{
                type: "CATEGORY",
                id: "#Beverages",
                present_at_all_locations: true,
                category_data: %{
                  name: "Beverages",
                }
              },
              %{
                type: "TAX",
                id: "#SalesTax",
                present_at_all_locations: true,
                tax_data: %{
                  name: "Sales Tax",
                  calculation_phase: "TAX_SUBTOTAL_PHASE",
                  inclusion_type: "ADDITIVE",
                  percentage: "5.0",
                  applies_to_custom_amounts: true,
                  enabled: true
                }
              }
            ],
          }]
        }
      iex> Square.client |> Square.Catalog.batch_upsert_catalog_objects(body)
  """
  @spec batch_upsert_catalog_objects(Tesla.Client.t(), map) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def batch_upsert_catalog_objects(client, body \\ %{}),
    do: Tesla.post(client, "catalog/batch-upsert", body)

  @doc """
  Upload an image file to create a new [CatalogImage](#type-catalogimage) for an existing
  [CatalogObject](#type-catalogobject). Images can be uploaded and linked in this request or created independently
  (without an object assignment) and linked to a [CatalogObject](#type-catalogobject) at a later time.

  CreateCatalogImage accepts HTTP multipart/form-data requests with a JSON part and an image file part in
  JPEG, PJPEG, PNG, or GIF format. The maximum file size is 15MB. The following is an example of such an HTTP request:

  ```
  POST /v2/catalog/images
  Accept: application/json
  Content-Type: multipart/form-data;boundary="boundary"
  Square-Version: XXXX-XX-XX
  Authorization: Bearer {ACCESS_TOKEN}

  --boundary
  Content-Disposition: form-data; name="request"
  Content-Type: application/json

  {
  "idempotency_key":"528dea59-7bfb-43c1-bd48-4a6bba7dd61f86",
  "object_id": "ND6EA5AAJEO5WL3JNNIAQA32",
  "image":{
  "id":"#TEMP_ID",
  "type":"IMAGE",
  "image_data":{
  "caption":"A picture of a cup of coffee"
  }
  }
  }
  --boundary
  Content-Disposition: form-data; name="image"; filename="Coffee.jpg"
  Content-Type: image/jpeg

  {ACTUAL_IMAGE_BYTES}
  --boundary
  ```

  Additional information and an example cURL request can be found in the [Create a Catalog Image recipe](https://developer.squareup.com/docs/more-apis/catalog/cookbook/create-catalog-images).

  ```
  def create_catalog_image(client, [request: nil, image_file: nil])
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `request` | [`Create Catalog Image Request Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/create-catalog-image-request.md) | Form, Optional | - |
  | `image_file` | `File | UploadIO` | Form, Optional | - |

  ### Response Type

  [`Create Catalog Image Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/create-catalog-image-response.md)

  ### Example Usage

      iex> request = %{
        idempotency_key: "528dea59-7bfb-43c1-bd48-4a6bba7dd61f86",
        image: {
          type: "IMAGE",
          id: "#TEMP_ID"
        }
      }
      iex> Square.client |> Square.Catalog.create_catalog_image(request: request)
  """
  @spec create_catalog_image(Tesla.Client.t(), list) :: {:error, any} | {:ok, Tesla.Env.t()}
  def create_catalog_image(client, params \\ []) do
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

    Tesla.post(client, "catalog/images", mp)
  end

  @doc """
  Returns information about the Square Catalog API, such as batch size
  limits for `BatchUpsertCatalogObjects`.

  ```
  def catalog_info(client)
  ```

  ### Response Type

  [`Catalog Info Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/catalog-info-response.md)

  ### Example Usage

      iex> Square.client |> Square.Catalog.catalog_info()
  """
  @spec catalog_info(Tesla.Client.t()) :: {:error, any} | {:ok, Tesla.Env.t()}
  def catalog_info(client), do: Tesla.get(client, "catalog/info")

  @doc """
  Returns a list of [CatalogObject](#type-catalogobject)s that includes
  all objects of a set of desired types (for example, all [CatalogItem](#type-catalogitem)
  and [CatalogTax](#type-catalogtax) objects) in the catalog. The `types` parameter
  is specified as a comma-separated list of valid [CatalogObject](#type-catalogobject) types:
  `ITEM`, `ITEM_VARIATION`, `MODIFIER`, `MODIFIER_LIST`, `CATEGORY`, `DISCOUNT`, `TAX`, `IMAGE`.

  __Important:__ ListCatalog does not return deleted catalog items. To retrieve
  deleted catalog items, use SearchCatalogObjects and set `include_deleted_objects`
  to `true`.

  ```
  def list_catalog(client, [
    cursor: nil,
    types: nil
  ])
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `cursor` | `String` | Query, Optional | The pagination cursor returned in the previous response. Leave unset for an initial request.<br>See [Pagination](https://developer.squareup.com/docs/basics/api101/pagination) for more information. |
  | `types` | `String` | Query, Optional | An optional case-insensitive, comma-separated list of object types to retrieve, for example<br>`ITEM,ITEM_VARIATION,CATEGORY,IMAGE`.<br><br>The legal values are taken from the CatalogObjectType enum:<br>`ITEM`, `ITEM_VARIATION`, `CATEGORY`, `DISCOUNT`, `TAX`,<br>`MODIFIER`, `MODIFIER_LIST`, or `IMAGE`. |

  ### Response Type

  [`List Catalog Response Map`](/doc/models/list-catalog-response.md)

  ### Example Usage

      iex> Square.Catalog |> Square.Catalog.list_catalog()
  """
  @spec list_catalog(Tesla.Client.t(), list) :: {:error, any} | {:ok, Tesla.Env.t()}
  def list_catalog(client, params \\ []), do: Tesla.get(client, "catalog/list", query: params)

  @doc """
  Creates or updates the target [CatalogObject](#type-catalogobject).

  ```
  def upsert_catalog_object(client, body)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `body` | [`Upsert Catalog Object Request Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/upsert-catalog-object-request.md) | Body, Required | An object containing the fields to POST for the request.<br><br>See the corresponding object definition for field details. |

  ### Response Type

  [`Upsert Catalog Object Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/upsert-catalog-object-response.md)

  ### Example Usage

      iex> body = %{
        idempotency_key: "af3d1afc-7212-4300-b463-0bfc5314a5ae",
        type: "ITEM",
        id: "#Cocoa",
        item_data: %{
          name: "Cocoa",
          description: "Hot chocolate",
          abbreviation: "Ch"
        }
      }
      iex> Square.client |> Square.Catalog.upsert_catalog_object(body)
  """
  @spec upsert_catalog_object(Tesla.Client.t(), map) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def upsert_catalog_object(client, body \\ %{}), do: Tesla.post(client, "catalog/object", body)

  @doc """
  Deletes a single [CatalogObject](#type-catalogobject) based on the
  provided ID and returns the set of successfully deleted IDs in the response.
  Deletion is a cascading event such that all children of the targeted object
  are also deleted. For example, deleting a [CatalogItem](#type-catalogitem)
  will also delete all of its [CatalogItemVariation](#type-catalogitemvariation) children.

  ```
  def delete_catalog_object(client, object_id)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `object_id` | `String` | Template, Required | The ID of the catalog object to be deleted. When an object is deleted, other<br>objects in the graph that depend on that object will be deleted as well (for example, deleting a<br>catalog item will delete its catalog item variations). |

  ### Response Type

  [`Delete Catalog Object Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/delete-catalog-object-response.md)

  ### Example Usage

      iex> object_id = "object_id8"

      iex> Square.client |> Square.Category.delete_catalog_object(object_id)

  """
  @spec delete_catalog_object(Tesla.Client.t(), binary) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def delete_catalog_object(client, object_id),
    do: Tesla.delete(client, "catalog/object/#{object_id}")

  @doc """
  Returns a single [CatalogItem](#type-catalogitem) as a
  [CatalogObject](#type-catalogobject) based on the provided ID. The returned
  object includes all of the relevant [CatalogItem](#type-catalogitem)
  information including: [CatalogItemVariation](#type-catalogitemvariation)
  children, references to its
  [CatalogModifierList](#type-catalogmodifierlist) objects, and the ids of
  any [CatalogTax](#type-catalogtax) objects that apply to it.

  ```
  def retrieve_catalog_object(client, object_id:, [
    include_related_objects: nil
  ])
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `object_id` | `String` | Template, Required | The object ID of any type of catalog objects to be retrieved. |
  | `include_related_objects` | `Boolean` | Query, Optional | If `true`, the response will include additional objects that are related to the<br>requested object, as follows:<br><br>If the `object` field of the response contains a CatalogItem,<br>its associated CatalogCategory, CatalogTax objects,<br>CatalogImages and CatalogModifierLists<br>will be returned in the `related_objects` field of the response. If the `object`<br>field of the response contains a CatalogItemVariation,<br>its parent CatalogItem will be returned in the `related_objects` field of<br>the response.<br><br>Default value: `false` |

  ### Response Type

  [`Retrieve Catalog Object Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/retrieve-catalog-object-response.md)

  ### Example Usage

      iex> object_id = "object_id8"

      iex> Square.client |> Square.Catalog.retrieve_catalog_object(object_id)
  """
  @spec retrieve_catalog_object(Tesla.Client.t(), binary, list) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def retrieve_catalog_object(client, object_id, params \\ []),
    do: Tesla.get(client, "catalog/object/#{object_id}", query: params)

  @doc """
  Queries the targeted catalog using a variety of query types:

  `CatalogQuerySortedAttribute`,
  `CatalogQueryExact`,
  `CatalogQueryRange`,
  `CatalogQueryText` ,
  `CatalogQueryItemsForTax`,
  `CatalogQueryItemsForModifierList` ,

  Future end of the above comment:

  `CatalogQueryItemsForTax`,
  `CatalogQueryItemsForModifierList`,
  `CatalogQueryItemsForItemOptions`,
  `CatalogQueryItemVariationsForItemOptionValues`,

  ```
  def search_catalog_objects(body:)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `body` | [`Search Catalog Objects Request Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/search-catalog-objects-request.md) | Body, Required | An object containing the fields to POST for the request.<br><br>See the corresponding object definition for field details. |

  ### Response Type

  [`Search Catalog Objects Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/search-catalog-objects-response.md)

  ### Example Usage

      iex> body = %{
        object_types: "ITEM",
        prefix_query: %{
          attribute_name: "name",
          attribute_prefix: "tea"
        },
        limit: 100
      }
      iex> Square.client |> Square.Catalog.search_catalog_objects(body)
  """
  @spec search_catalog_objects(Tesla.Client.t(), any) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def search_catalog_objects(client, body \\ %{}), do: Tesla.post(client, "catalog/search", body)

  @doc """
  Updates the [CatalogModifierList](#type-catalogmodifierlist) objects
  that apply to the targeted [CatalogItem](#type-catalogitem) without having
  to perform an upsert on the entire item.

  ```
  def update_item_modifier_lists(body:)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `body` | [`Update Item Modifier Lists Request Map`](/doc/models/update-item-modifier-lists-request.md) | Body, Required | An object containing the fields to POST for the request.<br><br>See the corresponding object definition for field details. |

  ### Response Type

  [`Update Item Modifier Lists Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/update-item-modifier-lists-response.md)

  ### Example Usage

      iex> body = %{
        item_ids: ["H42BRLUJ5KTZTTMPVSLFAACQ", "2JXOBJIHCWBQ4NZ3RIXQGJA6"],
        modifier_lists_to_enable: ["H42BRLUJ5KTZTTMPVSLFAACQ", "2JXOBJIHCWBQ4NZ3RIXQGJA6"],
        modifier_lists_to_disable: ["7WRC16CJZDVLSNDQ35PP6YAD"]
      }
      iex> Square.client |> Square.Catalog.update_item_modifier_lists(body)

  """
  @spec update_modifier_lists(Tesla.Client.t(), any) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  def update_modifier_lists(client, body \\ %{}),
    do: Tesla.post(client, "catalog/update-item-modifiers-lists", body)

  @doc """
  Updates the [CatalogTax](#type-catalogtax) objects that apply to the
  targeted [CatalogItem](#type-catalogitem) without having to perform an
  upsert on the entire item.

  ```
  def update_item_taxes(body:)
  ```

  ### Parameters

  | Parameter | Type | Tags | Description |
  |  --- | --- | --- | --- |
  | `body` | [`Update Item Taxes Request Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/update-item-taxes-request.md) | Body, Required | An object containing the fields to POST for the request.<br><br>See the corresponding object definition for field details. |

  ### Response Type

  [`Update Item Taxes Response Map`](https://github.com/square/square-ruby-sdk/blob/master/doc/models/update-item-taxes-response.md)

  ### Example Usage

        iex> body = %{
          item_ids: ["H42BRLUJ5KTZTTMPVSLFAACQ", "2JXOBJIHCWBQ4NZ3RIXQGJA6"],
          taxes_to_enable: ["4WRCNHCJZDVLSNDQ35PP6YAD"],
          taxes_to_disable: ["AQCEGCEBBQONINDOHRGZISEX]
        }
        iex> Square.client |> Square.Catalog.update_item_taxes(body)
  """
  @spec update_item_taxes(Tesla.Client.t(), any) :: {:error, any} | {:ok, Tesla.Env.t()}
  def update_item_taxes(client, body \\ %{}),
    do: Tesla.post(client, "catalog/update-item-taxes", body)
end
