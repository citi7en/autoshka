class Article < ActiveRecord::Base
#attr_accessible :title, :rubric, :autor, :content, :release, :date

validates_presence_of :title, :rubric, :autor, :content, :release, :date
validates_length_of :title, :rubric, :autor, :maximum => 100
validates_numericality_of :release, :less_than => 5001, :only_integer => true

def self.find_by_year_month(year, month)

  requested_date = Date.new(year.to_i, month.to_i, 1)
  from = requested_date -1
  to = requested_date >> 1
  Article.find(:all, :conditions => ["date BETWEEN ? and ?", from, to])
end

end
