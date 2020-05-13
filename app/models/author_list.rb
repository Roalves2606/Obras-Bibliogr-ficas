class AuthorList < ApplicationRecord
  ARRAY_TYPE_ERROR_MESSAGE = 'list must be an array'.freeze
  LENGTH_ERROR_MESSAGE = "length doesn't match specified records".freeze
  BLANK_RECORDS_ERROR_MESSAGE = "list can't have blank records".freeze

  validates :records, :original_list, presence: true
  validate :is_array?, :check_blank_records, :check_array_length

  private

  def is_array?
    return if original_list.is_a?(Array)

    errors.add(:original_list, ARRAY_TYPE_ERROR_MESSAGE)
  end

  def check_blank_records
    return unless original_list.try(:any?, &:blank?)

    errors.add(:original_list, BLANK_RECORDS_ERROR_MESSAGE)
  end

  def check_array_length
    return if original_list.try(:length) == records

    errors.add(:original_list, LENGTH_ERROR_MESSAGE)
  end
end
