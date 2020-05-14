require 'rails_helper'

RSpec.describe Api::V1::AuthorListController do
  describe '#create' do
    context 'with valid params' do
      let(:author_list) { create(:author_list) }

      let(:params) do
        {
          records: 2,
          original_list: ['Rodrigo Nunes', 'Mariana Almeida']
        }
      end

      let(:expected_response) do
        { 'formatted_list' => ['NUNES, Rodrigo', 'ALMEIDA, Mariana'] }
      end

      before do
        post :create, params: { author_list: params }
      end

      it 'returns ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns formatted list response' do
        json_response = JSON.parse(response.body)

        expect(json_response).to eq(expected_response)
      end
    end

    context 'with invalid params' do
      let(:empty_error) { "can't be blank" }
      let(:array_type_error) { 'list must be an array' }
      let(:blank_records_error) { "list can't have blank records" }
      let(:lenght_error) { "length doesn't match specified records" }

      context 'when original list is not an array' do
        let(:invalid_params) do
          {
            records: 1,
            original_list: 'a'
          }
        end

        let(:error_response) { [empty_error, array_type_error, lenght_error] }

        before do
          post :create, params: { author_list: invalid_params }
        end

        it 'returns correct error response' do
          errors = JSON.parse(response.body)['error']['original_list']

          expect(errors).to match_array(error_response)
        end
      end

      context 'when original list is empty' do
        let(:invalid_params) do
          {
            records: 1,
            original_list: []
          }
        end

        let(:error_response) { [empty_error, lenght_error, array_type_error] }

        before do
          post :create, params: { author_list: invalid_params }
        end

        it 'returns correct error response' do
          errors = JSON.parse(response.body)['error']['original_list']

          expect(errors).to match_array(error_response)
        end
      end

      context 'when original list has blank records' do
        let(:invalid_params) do
          {
            records: 1,
            original_list: ['']
          }
        end

        let(:error_response) { [blank_records_error] }

        before do
          post :create, params: { author_list: invalid_params }
        end

        it 'returns correct error response' do
          errors = JSON.parse(response.body)['error']['original_list']

          expect(errors).to match_array(error_response)
        end
      end

      context "when records doesn't match original list length" do
        let(:invalid_params) do
          {
            records: 3,
            original_list: ['A']
          }
        end

        let(:error_response) { [lenght_error] }

        before do
          post :create, params: { author_list: invalid_params }
        end

        it 'returns correct error response' do
          errors = JSON.parse(response.body)['error']['original_list']

          expect(errors).to match_array(error_response)
        end
      end
    end
  end
end
