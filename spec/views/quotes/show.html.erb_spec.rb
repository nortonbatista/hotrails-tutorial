require 'rails_helper'

RSpec.describe 'quotes/show' do
  let(:quote_name) { Faker::Quote.famous_last_words }

  before do
    assign(:quote, create(:quote, name: quote_name))
  end

  it 'renders attributes in <p>' do
    render
    assert_select 'p', text: Regexp.new(quote_name)
  end
end
