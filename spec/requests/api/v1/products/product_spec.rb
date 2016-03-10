require 'spec_helper'

describe 'GET /v1/products/:id' do
  it 'returns a product by :id' do
    product = create(:product)

    get "/v1/products/#{product.id}"

    expect(response_json).to eq(
      {
        'brand' => product.brand,
        'name' => product.name,
        'id' => product.id,
        'upc' => product.upc,
        'description' => product.description,
        'units' => product.units,
        'measurement' => product.measurement,
        'category' => product.category
      }
    )
  end
end

describe "POST /v1/products" do
  it "saves the brand, name, upc, description, units, measurment and category" do
    device_token = "123abcd456xyz"

    post "/v1/products", {
      brand: "Kirkland Signature",
      name: "Organic Tomato Sauce",
      upc: "96619937301",
      description: "Tomato sauce from Costco",
      units: 15.0,
      measurement: "ounce",
      category: "vegetables"
    }.to_json,
    set_headers(device_token)

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

  it 'returns an error message when invalid' do
    auth_token = '123abcd456xyz'

    post '/v1/products',
      {}.to_json,
      set_headers(auth_token)

    expect(response_json).to eq({
      'message' => 'Validation Failed',
      'errors' => [
        "Name can't be blank"
      ]
    })
    expect(response.code.to_i).to eq 422
  end
end
