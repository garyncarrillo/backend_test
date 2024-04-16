require 'rails_helper'

RSpec.describe Product, type: :model do
  it "has a valid factory" do
    product = build(:product)
    expect(product).to be_valid
  end

  it "belongs to a user" do
    user = create(:user)
    product = create(:product, user: user)
    expect(product.user).to eq(user)
  end
end
