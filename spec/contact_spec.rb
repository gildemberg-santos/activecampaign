# frozen_string_literal: true

require "spec_helper"

describe Activecampaign::Contact do
  let!(:url) { "https://leadster1656523378.api-us1.com/" }
  let!(:token) { "0d575fe3de57ac0733061e1495c72a0cfc6d32d1140213d0bbb97c7157fd76f67ce8b7a9" }
  let!(:contact) do
    {
      "contact" => {
        "email" => "johndoe2@example.com",
        "firstName" => "John 2",
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
  #   expect(described_class.new(url: url, token: token).create(contact)).to(be_an_instance_of(Hash))
  # end

  # it "Atualizar Contato" do
  #   expect(described_class.new(url: url, token: token).update(contact, 229)).to(be_an_instance_of(Hash))
  # end

  it "Buscar Contato" do
    expect(described_class.new(url: url, token: token).find("johndoe@example.com")).to(be_an_instance_of(Hash))
  end

  it "Verificar se Contato Existe" do
    expect(described_class.new(url: url, token: token).contact?("johndoe@example.com")).to(be_an_instance_of(TrueClass))
  end

  it "Criar ou Atualizar Contato" do
    expect(described_class.new(url: url, token: token).upset(contact)).to(be_an_instance_of(Hash))
  end
end
