require 'spec_helper'

describe "Creates all objects in database." do
  before do

    @category = Category.create(name: "Math")
    @user = User.create(first_name: "Roberto")
    @topic = Topic.create(name: "Geometry")
    @resource = Resource.create(name: "textbook")
  end

end