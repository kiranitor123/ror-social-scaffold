require "rails_helper"

RSpec.describe User, :type => :model do
  context "Associations" do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end
end