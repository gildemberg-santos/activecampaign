# frozen_string_literal: true

require 'spec_helper'

describe Activecampaign do
  let!(:url) { 'https://leadster1656523378.api-us1.com/' }
  let!(:token) { '0d575fe3de57ac0733061e1495c72a0cfc6d32d1140213d0bbb97c7157fd76f67ce8b7a9' }

  describe '#validade_uri' do
    context 'quando a URL é válida' do
      it 'retorna uma instância de URI::HTTPS' do
        expect(described_class.validade_uri(url)).to be_an_instance_of(URI::HTTPS)
      end
    end

    context 'quando a URL é inválida' do
      it 'levanta um erro para URL nula' do
        expect do
          described_class.validade_uri(nil)
        end.to raise_error(Activecampaign::InvalidURIError,
                           "Url is must be a String 'NilClass'")
      end

      it 'levanta um erro para URL mal formatada' do
        expect do
          described_class.validade_uri('testando_a_url')
        end.to raise_error(Activecampaign::InvalidURIError,
                           "Url is invalid 'testando_a_url'")
      end

      it 'levanta um erro para URL com espaços' do
        expect do
          described_class.validade_uri('testando a url')
        end.to raise_error(Activecampaign::InvalidURIError,
                           'bad URI(is not URI?): "testando a url"')
      end
    end
  end

  describe '#validade_token' do
    context 'quando o token é inválido' do
      it 'levanta um erro para token nulo' do
        expect do
          described_class.validade_token(nil)
        end.to raise_error(Activecampaign::InvalidTokenError,
                           "Token must be a String 'NilClass'")
      end
    end
  end
end
