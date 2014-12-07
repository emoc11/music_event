require "rails_helper"

RSpec.describe User, :type => :model do

  it "can save a user" do
    user = User.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyonrails")
    user.save!

    found = User.last
    expect(found.login).to eq("emoc11")
    expect(found.email).to eq("emoc11@free.fr")
    expect(found.password).to eq("rubyonrails")
  end

  it "requires login, email and password" do
    user = User.new
    expect(user.valid?).to eq(false)

    user.login = "emoc11"
    expect(user.valid?).to eq(false)

    user.email = "emoc11@free.fr"
    expect(user.valid?).to eq(false)

    user.password = "rubyonrails"
    expect(user.valid?).to eq(true)
  end

  it "requires a valid email format" do
    user = User.new(login: "emoc11", password: "rubyonrails")
    expect(user.valid?).to eq(false)

    user.email = "emoc11"
    expect(user.valid?).to eq(false)

    user.email = "emoc11@free."
    expect(user.valid?).to eq(false)

    user.email = "emoc11@.fr"
    expect(user.valid?).to eq(false)

    user.email = "@free.fr"
    expect(user.valid?).to eq(false)

    user.email = "emoc11@free.fr"
    expect(user.valid?).to eq(true)
  end

  it "is impossible to add the same email/login twice" do
    user = User.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyonrails")
    expect(user.valid?).to eq(true)

    other_user = User.create(login: "emoc", email: "emoc11@free.fr", password: "rubyonrails")
    expect(other_user.valid?).to eq(false)

    other_user = User.create(login: "emoc11", email: "emoc11@hotmail.fr", password: "rubyonrails")
    expect(other_user.valid?).to eq(false)

    other_user = User.create(login: "emoc11", email: "emoc11@free.fr", password: "rubyonrails")
    expect(other_user.valid?).to eq(false)

    other_user = User.create(login: "emoc", email: "emoc11@hotmail.fr", password: "rubyonrails")
    expect(other_user.valid?).to eq(true)
  end
end