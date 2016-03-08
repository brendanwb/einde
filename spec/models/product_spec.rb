require 'rails_helper'

RSpec.describe Product, "Validations" do
  it { should validate_presence_of(:name) }
end

#describe Product, "Associations" do
  #it { should belong_to(:user) }
#end
