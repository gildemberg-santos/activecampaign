# frozen_string_literal: true

require "spec_helper"

describe Activecampaign::Request do
  let!(:url) { "https://api.activecampaign.com/" }
  let!(:token) { "0d575fe3de57ac0733061e1495c72a0cfc6d32d1140213d0bbb97c7157fd76f67ce8b7a9" }

  it "URL e Token Válida" do
    expect(described_class.new(url: url, token: token)).to(be_an_instance_of(Activecampaign::Request))
  end
end
