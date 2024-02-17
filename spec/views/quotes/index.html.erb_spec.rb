require 'rails_helper'

RSpec.describe 'quotes/index' do
  let(:quote_name) { Faker::Quote.famous_last_words }

  before do
    assign(:quotes, create_list(:quote, 2, name: quote_name))
  end

  it 'renders a list of quotes' do
    render
    assert_select 'div>p', text: Regexp.new(quote_name), count: 2
  end
end
