require 'rails_helper'

RSpec.describe 'quotes/edit' do
  let(:quote) { create(:quote) }

  before do
    assign(:quote, quote)
  end

  it 'renders the edit quote form' do
    render

    assert_select 'form[action=?][method=?]', quote_path(quote), 'post' do
      assert_select 'input[name=?]', 'quote[name]'
    end
  end
end
