class Article < ActiveRecord::Base
	state_machine :state, :initial => :new do
	  event :select_state_published do
	    transition [:new, :pending_publication, :rejected, :archive] => :published
	  end

	  event :select_state_rejected do
	    transition [:new, :pending_publication, :published, :archive] => :rejected
	  end
	end

	state_machine :category, :initial => :default do
	  event :select_category_sale do
	    transition [:default, :purchase, :currency, :service, :rent] => :sale
	  end

	  event :select_category_purchase do
	    transition [:default, :sale, :currency, :service, :rent] => :purchase
	  end

	  event :select_category_currency do
	    transition [:default, :sale, :purchase, :service, :rent] => :currency
	  end

	  event :select_category_service do
	    transition [:default, :sale, :purchase, :currency, :rent] => :service
	  end

	  event :select_category_rent do
	    transition [:default, :sale, :purchase, :currency, :service] => :rent
	  end

	end
end