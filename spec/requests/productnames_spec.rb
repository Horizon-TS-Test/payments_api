require 'rails_helper'

RSpec.describe "Productnames", type: :request do
  describe "GET /productnames" do
    it "works! (now write some real specs)" do
      get productnames_path
      expect(response).to have_http_status(200)
    end
  end
end
