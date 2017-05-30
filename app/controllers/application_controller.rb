class ApplicationController < ActionController::API
  rescue_from StandardError, with: :server_error
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_found(error=nil)
    logger.error(error || 'Not found')
    render json: { message: 'Not found' }, status: :not_found
  end

  def server_error(error)
    logger.error error
    render json: { message: I18n.t('errors.messages.server_error') }, status: :internal_server_error
  end
end
