class Article < ActiveRecord::Base
	state_machine :state, :initial => :new do
	  event :tested do
	    transition [:new, :pending_publication, :rejected, :archive] => :published
	  end

	  event :rejected do
	    transition [:new, :pending_publication, :published, :archive] => :rejected
	  end
	end
end