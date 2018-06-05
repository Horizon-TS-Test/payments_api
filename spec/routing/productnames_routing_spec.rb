require "rails_helper"

RSpec.describe ProductnamesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/productnames").to route_to("productnames#index")
    end

    it "routes to #new" do
      expect(:get => "/productnames/new").to route_to("productnames#new")
    end

    it "routes to #show" do
      expect(:get => "/productnames/1").to route_to("productnames#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/productnames/1/edit").to route_to("productnames#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/productnames").to route_to("productnames#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/productnames/1").to route_to("productnames#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/productnames/1").to route_to("productnames#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/productnames/1").to route_to("productnames#destroy", :id => "1")
    end

  end
end
