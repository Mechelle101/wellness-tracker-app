class NutritionLog < ApplicationRecord
  belongs_to :user
  belongs_to :entry
end
