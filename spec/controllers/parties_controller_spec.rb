require 'rails_helper'

RSpec.describe PartiesController, :type => :controller do

  render_views

  describe "GET index" do
    it "displays a list of posts with some author details" do
      eileen = User.create(name: "Eileen #{rand(1000)}", email: "Eileen@rs.com")
      benson = User.create(name: "Benson #{rand(1000)}", email: "benson@rs.com")

      a_post = Post.create(user: eileen, message: "Hello")
      an_unpublished_post = Post.create(user: eileen, message: "Not published!", published: false)
      a_post_again = Post.create(user: eileen, message: "Hello all!")
      benson_post = Post.create(user: benson, message: "And another one #{rand 1000}")

      get :index
      expect(response).to have_http_status(:success)

      expect(response.body).to include("#{eileen.name} wrote #{a_post.message}")
      expect(response.body).to include("#{eileen.name} wrote #{a_post_again.message}")
      expect(response.body).to include("#{benson.name} wrote #{benson_post.message}")
      expect(response.body).to_not include("Not published")
    end

    it "only display published posts" do
      eileen = User.create(name: "Eileen #{rand(1000)}", email: "Eileen@rs.com")
      a_post = Post.create(user: eileen, message: "Hello")
      an_unpublished_post = Post.create(user: eileen, message: "Not published!", published: false)

      get :index
      expect(response).to have_http_status(:success)

      expect(response.body).to include("#{eileen.name} wrote #{a_post.message}")
      expect(response.body).to_not include("Not published")
    end
  end

  describe "GET new" do
    # Basic new form: http://cl.ly/image/1a1p3l2X0A1E
    it "displays a form to create a new post" do
      User.create(name: "Eileen", email: "Eileen@rs.com")
      User.create(name: "Benson", email: "benson@rs.com")

      get :new

      expect(response).to have_http_status(:success)
      expect(response.body).to include("Create a new post!")
      expect(response.body).to include("Eileen")
      expect(response.body).to include("Benson")
    end
  end

  describe "GET show" do
    it "displays a post" do
      user = User.create(name: "Eileen #{rand 1000}", email: "Eileen@rs.com")
      my_post = Post.create(user: user, message: "Showing the post #{rand 1000}")

      get "show", id: my_post.id

      expect(response.body).to include("Post by #{user.name}")
      expect(response.body).to include(my_post.message)
    end

    it "returns a 404 if the post has been unpublished" do
      user = User.create(name: "Eileen #{rand 1000}", email: "Eileen@rs.com")
      my_post = Post.create(user: user, message: "Lorem", published: false)

      get "show", id: my_post.id

      expect(response).to have_http_status(404)
    end
  end

  describe "POST create" do
    it "creates a new post" do
      user = User.create(name: "Eileen", email: "Eileen@rs.com")

      post :create, post: { user_id: user.id, message: "Hello yall!" }
      expect(response).to redirect_to(posts_path)

      last_post_created = Post.last
      expect(last_post_created.message).to eq("Hello yall!")
      expect(last_post_created.user.id).to eq(user.id)
    end

    it "fails gracefuly if there is a validation error" do
      user = User.create(name: "Eileen", email: "Eileen@rs.com")

      post :create, post: { user_id: nil, message: "Hello yall!" }

      expect(response.body).to include("User can&#39;t be blank")
      expect(Post.count).to eq(0)
    end
  end
end
