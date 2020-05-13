class Api::V1::AuthorListController < ApplicationController
  def create
    author_list = CreateAuthorListService.call(author_params)

    render json: author_list

  rescue StandardError => e
    errors = { errors: e, backtrace: e.backtrace }
    render json: errors, status: 500
  end

  private

  def author_params
    params.require(:author_list).permit(
      :records,
      original_list: []
    )
  end
end
