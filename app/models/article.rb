class Article < ActiveRecord::Base
	has_one :comment, dependent: :destroy
	
	state_machine :state, :initial => :pending_publication do
	  event :select_state_published do
	    transition [:pending_publication, :rejected, :archive] => :published
	  end

	  event :select_state_rejected do
	    transition [:pending_publication, :published, :archive] => :rejected
	  end

	  event :select_state_archive do
	    transition [:pending_publication, :published, :rejected] => :archive
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

	def translation_status_if_the_time_is_greater_than_1_day
		Article.all.where(state: 'published').each do |article|
			if ((Time.now - article.updated_at)/60).round >= 4
				article.select_state_archive
			end
		end
	end
end