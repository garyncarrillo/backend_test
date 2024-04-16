require 'rails_helper'

RSpec.describe User, type: :model do
  it "should have many products" do
    user = create(:user)
    product1 = create(:product, user: user)
    product2 = create(:product, user: user)
    
    expect(user.products.count).to eq(2) # Verifica que el usuario tenga dos productos asociados
  end

  it "has a valid factory" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "is invalid without an email" do
    user = build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it "is invalid with a duplicate email" do
    create(:user, email: "test@example.com")
    user = build(:user, email: "test@example.com")
    expect(user).to_not be_valid
  end
end