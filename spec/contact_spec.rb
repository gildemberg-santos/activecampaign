# frozen_string_literal: true

require "spec_helper"

describe Activecampaign::Contact do
  let!(:url) { "https://api.activecampaign.com/" }
  let!(:token) { "0d575fe3de57ac0733061e1495c72a0cfc6d32d1140213d0bbb97c7157fd76f67ce8b7a9" }
  let!(:contact) do
    {
      "contact" => {
        "email" => "johndoe@example.com",
        "firstName" => "John",
        "lastName" => "Doe",
        "phone" => "7223224241",
        "fieldValues" => [
          {
            "field" => "1",
            "value" => "The Value for First Field",
          },
          {
            "field" => "6",
            "value" => "2008-01-20",
          },
        ],
      },
    }
  end

  it "Criar Instancia de Contato" do
    expect(described_class.new(url: url, token: token)).to(be_an_instance_of(Activecampaign::Contact))
  end

  # it "Criar Contato" do
  #   expect(described_class.new(url, token).create(contact)).to(be_an_instance_of(Hash))
  # end
end
