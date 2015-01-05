module Record_history
    def record_history_create
        if @article.save
          History.create(user_name: current_user.name, action: "created", object: @article.title, time: Time.now)
        end
    end

    def record_history_destroy
        if @article.destroy
          History.create(user_name: current_user.name, action: "deleted", object: @article.title, time: Time.now)
        end
    end

    def record_history_show
          History.create(user_name: current_user.name, action: "viewed", object: @article.title, time: Time.now)
    end

    def record_history_edit
          History.create(user_name: current_user.name, action: "edited", object: @article.title, time: Time.now)
    end
end