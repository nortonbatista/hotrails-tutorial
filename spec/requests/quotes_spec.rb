require 'rails_helper'

RSpec.describe '/quotes' do
  let(:valid_attributes) do
    { name: Faker::Quote.famous_last_words }
  end

  let(:invalid_attributes) do
    { name: nil }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Quote.create! valid_attributes
      get quotes_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      quote = Quote.create! valid_attributes
      get quote_url(quote)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_quote_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      quote = Quote.create! valid_attributes
      get edit_quote_url(quote)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Quote' do
        expect do
          post quotes_url, params: { quote: valid_attributes }
        end.to change(Quote, :count).by(1)
      end

      it 'redirects to the created quote' do
        post quotes_url, params: { quote: valid_attributes }
        expect(response).to redirect_to(quote_url(Quote.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Quote' do
        expect do
          post quotes_url, params: { quote: invalid_attributes }
        end.not_to change(Quote, :count)
      end

      it 'renders a response with 422 status' do
        post quotes_url, params: { quote: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_quote_name) { Faker::Quote.famous_last_words }
      let(:new_attributes) do
        { name: new_quote_name }
      end

      it 'updates the requested quote' do
        quote = Quote.create! valid_attributes
        patch quote_url(quote), params: { quote: new_attributes }
        expect do
          quote.reload
        end.to change(quote, :name).to(new_quote_name)
      end

      it 'redirects to the quote' do
        quote = Quote.create! valid_attributes
        patch quote_url(quote), params: { quote: new_attributes }
        quote.reload
        expect(response).to redirect_to(quote_url(quote))
      end
    end

    context 'with invalid parameters' do
      it 'renders a response with 422 status' do
        quote = Quote.create! valid_attributes
        patch quote_url(quote), params: { quote: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested quote' do
      quote = Quote.create! valid_attributes
      expect do
        delete quote_url(quote)
      end.to change(Quote, :count).by(-1)
    end

    it 'redirects to the quotes list' do
      quote = Quote.create! valid_attributes
      delete quote_url(quote)
      expect(response).to redirect_to(quotes_url)
    end
  end
end
