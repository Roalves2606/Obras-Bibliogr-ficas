class CreateAuthorListService < ServiceBase
  attr_accessor :author_params, :original_list, :records

  def initialize(author_params)
    @author_params = author_params
    @original_list = author_params[:original_list]
    @records = author_params[:records].to_i
  end

  def call
    author_list = AuthorList.new(author_params)

    if author_list.save
      { formatted_list: author_list.formatted_list }
    else
      { error: author_list.errors.messages }
    end
  end
end
