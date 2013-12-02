class Film < ActiveRecord::Base
    has_many :seances, dependent: :destroy
end
