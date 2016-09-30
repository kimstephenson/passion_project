require 'spec_helper'

describe User do
  let(:user) {User.new(first_name:"Bob", last_name:"Smith", email:"bob@smith.com", zip_code:"90007", password:"password")}
  let(:user2) {User.new(first_name:"Jim", last_name:"Smith", email:"bob@smith.com", password:"password")}

  it "must have a unique email" do
    user.save
    user2.save
    expect(user2.errors.full_messages).to include("Email has already been taken")
  end

  it "authenticates user" do
    user.save
    expect(User.authenticate("bob@smith.com", "password")).to be_truthy
  end

  it "validates email format" do
    user3 = User.create(first_name: "Bob", last_name: "Smith", zip_code: "90007", email: "a", password: "password")
    expect(user3.errors.full_messages).to include("Email must be a valid email address")
  end

  it "fills in city and state based on zip code" do
    user.save
    user.city_state
    expect(user.city).to eq("Los Angeles")
    expect(user.state).to eq("CA")
  end

  it "encrypts password" do
    user.save
    expect(user.password == "password").to be true
  end
end
