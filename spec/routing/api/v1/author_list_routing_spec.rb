require 'rails_helper'

RSpec.describe Api::V1::AuthorListController, type: :routing do
  it { is_expected.to route(:post, '/api/v1/author_list').to(action: :create) }
end
