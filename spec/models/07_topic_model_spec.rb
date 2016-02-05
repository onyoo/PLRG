require 'spec_helper'

describe "Make and Associate a Topic" do

  it "can alphabetize topics" do
    @topic = Topic.create(name: "Geometry")

    @algebra = Topic.create(name: "Algebra")
    expect(Topic.in_alphabetical_order).to eq([@algebra,@topic])
  end

end