class OrderQuery

    def initalize(scope = order.all)
        @scope = scope
    end


    def call(params)
        @scope = @scope.by_status(params[:status])
        @scope = @scope.by_date_range(params[:start_date], params[:end_date])
        @scope.recent
    end
    
end