class ApplicationController < ActionController::API
    # applies the rescue to every method in the application
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

    private

    def not_found(e)
        render json: { errors: e.message }, status: :not_found
    end

    def not_destroyed(e)
        render json: { errors: e.record.errors }, status: :unprocessible_entity
    end
end
