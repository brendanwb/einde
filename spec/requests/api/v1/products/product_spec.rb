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
