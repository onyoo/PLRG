require 'spec_helper'

describe "Associate a User" do
  before do

    @category = Category.create(username: "Math")
    @user = User.create(first_name: "Roberto")
    @topic = Topic.create(name: "Geometry", category: @category.id, user_id: @user.id)
  end

  it "has properties" do
    expect(@user.name).to eq("Roberto")
    (@user.id.class).should be_a_kind_of(Integer)
  end

end