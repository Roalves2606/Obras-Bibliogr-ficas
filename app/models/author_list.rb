class AuthorList < ApplicationRecord
  LENGTH_ERROR_MESSAGE = "length doesn't match specified records".freeze

  validates :records, :original_list, presence: true
  validate :original_list_length

  private

  def original_list_length
    return if original_list.try(:length) == records

    errors.add(:original_list, LENGTH_ERROR_MESSAGE)
  end
end
