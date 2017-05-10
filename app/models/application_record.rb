class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  WAREHOUSE = 1
end
