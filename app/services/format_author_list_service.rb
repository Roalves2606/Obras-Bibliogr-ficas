class FormatAuthorListService < ServiceBase
  attr_reader :original_list

  def initialize(original_list)
    @original_list = original_list
  end

  CONJUNCTIONS = %w[da de do das dos].freeze
  LAST_NAME_EXECPTION = %w[
    junior
    filho
    filha
    sobrinho
    sobrinha
    neto
    neta
  ].freeze

  def call
    return if original_list.try(:any?, &:blank?)

    original_list.try(:map) do |name|
      name_array = name.split.map(&:downcase)

      format_name(name_array)
    end
  end

  private

  def format_name(name_array)
    case
    when name_array.one?
      name_array.first.upcase

    when (name_array.first(2) & CONJUNCTIONS).any? \
      && LAST_NAME_EXECPTION.include?(name_array.last)

      all_exceptions_format(name_array)

    when (name_array.first(2) & CONJUNCTIONS).any?
      conjunction_format(name_array)

    when LAST_NAME_EXECPTION.include?(name_array.last)
      last_name_exception_format(name_array)

    else
      simple_format(name_array)
    end
  end

  def simple_format(name_array)
    first_name = name_array.first
    last_name = name_array.last

    "#{last_name.upcase}, #{first_name.capitalize}"
  end

  def conjunction_format(name_array)
    first_name = generate_first_name_with_conjunction(name_array)
    last_name = name_array.last

    "#{last_name.upcase}, #{first_name.capitalize}"
  end

  def last_name_exception_format(name_array)
    first_name = name_array.first
    last_name =  generate_last_name_with_exception(name_array)

    "#{last_name.upcase}, #{first_name.capitalize}"
  end

  def all_exceptions_format(name_array)
    conjunction_index = find_conjunction_index(name_array)

    first_name = generate_first_name_with_conjunction(name_array)
    last_name = generate_last_name_with_exception(name_array, conjunction_index)

    "#{last_name.upcase}, #{first_name.capitalize}"
  end

  def generate_first_name_with_conjunction(name_array)
    conjunction_index = find_conjunction_index(name_array)

    name_array.take(conjunction_index + 1).join(' ')
  end

  def generate_last_name_with_exception(name_array, conjunction_index = nil)
    exception_index = find_last_name_exception_index(name_array)

    previous_index_is_first_name =
      previous_index_is_first_name?(exception_index)

    previous_index_is_exception =
      previous_index_is_exception?(exception_index, conjunction_index)

    previous_index_is_invalid =
      previous_index_is_first_name || previous_index_is_exception

    return name_array.last if previous_index_is_invalid

    name_array.last(2).join(' ')
  end

  def previous_index_is_first_name?(exception_index)
    (exception_index - 1).zero?
  end

  def previous_index_is_exception?(exception_index, conjunction_index)
    (exception_index - 1) == conjunction_index
  end

  def find_last_name_exception_index(name_array)
    last_name_exception = (LAST_NAME_EXECPTION & name_array).first

    name_array.index(last_name_exception)
  end

  def find_conjunction_index(name_array)
    conjunction = (CONJUNCTIONS & name_array).first

    name_array.index(conjunction)
  end
end
