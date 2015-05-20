require "rails_helper"

RSpec.describe HomesController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #search_result" do
    it "responds successfully with an HTTP 200 status code" do
      get :search_result, latitude: 10.21345, longitude: 106.658642, distance: 1000
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the search_result template" do
      get :search_result
      expect(response).to render_template("search_result")
    end
  end
end
