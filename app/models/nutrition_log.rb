class NutritionLog < ApplicationRecord
  belongs_to :user
  # this allows logs to exist without a linked entry
  # so the user can have free nutrition logging
  belongs_to :entry, optional: true
end
