require "spec_helper"

describe "GET /v1/products/:id" do
  it "returns a product by :id" do
    product = create(:product)

    get "/v1/products/#{product.id}"

    expect(response_json).to eq(
      {
        "brand" => product.brand,
        "name" => product.name,
        "id" => product.id,
        "upc" => product.upc,
        "description" => product.description,
        "units" => product.units,
        "measurement" => product.measurement,
        "category" => product.category
      }
    )
  end
end

describe "POST /v1/products" do
  it "saves the brand, name, upc, description, units, measurment and category" do
    auth_token = "123abcd456xyz"

    post "/v1/products", {
      brand: "Kirkland Signature",
      name: "Organic Tomato Sauce",
      upc: "96619937301",
      description: "Tomato sauce from Costco",
      units: 15.0,
      measurement: "ounce",
      category: "vegetables"
    }.to_json,
    set_headers(auth_token)

    product = Product.last
    expect(response_json).to eq({ "id" => product.id })
    expect(product.brand).to eq "Kirkland Signature"
    expect(product.name).to eq "Organic Tomato Sauce"
    expect(product.upc).to eq "96619937301"
    expect(product.description).to eq "Tomato sauce from Costco"
    expect(product.units).to eq 15.0
    expect(product.measurement).to eq "ounce"
    expect(product.category).to eq "vegetables"
  end

  it "returns an error message when invalid" do
    auth_token = "123abcd456xyz"

    post "/v1/products",
      {}.to_json,
      set_headers(auth_token)

    expect(response_json).to eq({
      "message" => "Validation Failed",
      "errors" => [
        "Name can't be blank"
      ]
    })
    expect(response.code.to_i).to eq 422
  end
end


describe "PATCH /v1/products/:id" do
  it "updates the product attributes" do
    auth_token = "123abcd456xyz"
    product = create(:product, name: "Old name")
    new_name = "New name"

    patch "/v1/products/#{product.id}", {
      brand: product.brand,
        name: new_name,
        upc: product.upc,
        description: product.description,
        units: product.units,
        measurement: product.measurement,
        category: product.category
    }.to_json,
    set_headers(auth_token)

    product = product.reload
    expect(product.name).to eq new_name
    expect(response_json).to eq({ "id" => product.id })
  end


  it "returns an error message when invalid" do
    auth_token = "123abcd456xyz"
    product = create(:product)

    patch "/v1/products/#{product.id}", {
      brand: product.brand,
        name: nil,
        upc: product.upc,
        description: product.description,
        units: product.units,
        measurement: product.measurement,
        category: product.category
    }.to_json,
    set_headers(auth_token)

    product = product.reload
    expect(product.name).to_not be nil
    expect(response_json).to eq({
      "message" => "Validation Failed",
      "errors" => [
        "Name can't be blank"
      ]
    })
    expect(response.code.to_i).to eq 422
  end
end
