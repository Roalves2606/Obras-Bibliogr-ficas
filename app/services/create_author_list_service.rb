class CreateAuthorListService < ServiceBase
  attr_accessor :author_params, :original_list, :records

  def initialize(author_params)
    @author_params = author_params
    @original_list = author_params[:original_list]
    @records = author_params[:records].to_i
  end

  def call
    author_list = AuthorList.new(params_with_formatted_list)

    if author_list.save
      { formatted_list: author_list.formatted_list }
    else
      { error: author_list.errors.messages }
    end
  end

  private

  def params_with_formatted_list
    formatted_list = FormatAuthorListService.call(original_list)
    new_params = { formatted_list: formatted_list }

    author_params.merge(new_params)
  end
end
