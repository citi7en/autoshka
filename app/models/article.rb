class Article < ActiveRecord::Base
#attr_accessible :title, :rubric, :autor, :content, :release, :date

validates_presence_of :title, :rubric, :autor, :content, :release, :date
validates_length_of :title, :rubric, :autor, :maximum => 100
validates_numericality_of :release, :less_than => 5001, :only_integer => true

end
