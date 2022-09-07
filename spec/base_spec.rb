# frozen_string_literal: true

require "spec_helper"

describe Activecampaign do
  let!(:url) { "https://api.activecampaign.com/" }
  let!(:token) { "0d575fe3de57ac0733061e1495c72a0cfc6d32d1140213d0bbb97c7157fd76f67ce8b7a9" }

  it "Url Válida" do
    expect(described_class.validade_uri(url)).to(be_an_instance_of(URI::HTTPS))
  end

  it "Url Inválida" do
    expect do
      described_class.validade_uri(nil)
    end.to(raise_error(an_instance_of(Activecampaign::InvalidURIError).and(having_attributes(message: "Url is must be a String 'NilClass'"))))

    expect do
      described_class.validade_uri("testando_a_url")
    end.to(raise_error(an_instance_of(Activecampaign::InvalidURIError).and(having_attributes(message: "Url is invalid 'testando_a_url'"))))

    expect do
      described_class.validade_uri("testando a url")
    end.to(raise_error(an_instance_of(Activecampaign::InvalidURIError).and(having_attributes(message: "bad URI(is not URI?): testando a url"))))
  end

  it "Token Inválida" do
    expect do
      described_class.validade_token(nil)
    end.to(raise_error(an_instance_of(Activecampaign::InvalidTokenError).and(having_attributes(message: "Token must be a String 'NilClass'"))))

    expect do
      described_class.validade_token("")
    end.to(raise_error(an_instance_of(Activecampaign::InvalidTokenError).and(having_attributes(message: "Token is required"))))

    expect do
      described_class.validade_token("testando_o_token")
    end.to(raise_error(an_instance_of(Activecampaign::InvalidTokenError).and(having_attributes(message: "Token is invalid 'testando_o_token'"))))
  end

  it "Payload Inválida" do
    expect do
      described_class.validate_payload("")
    end.to(raise_error(an_instance_of(Activecampaign::InvalidPayloadError).and(having_attributes(message: "Payload must be a Hash 'String'"))))
    expect do
      described_class.validate_payload({})
    end.to(raise_error(an_instance_of(Activecampaign::InvalidPayloadError).and(having_attributes(message: "Payload is required"))))
  end
end
