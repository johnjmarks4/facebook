class StaticPagesController < DeviseController
  skip_before_action :authenticate_user!
  skip_before_action :signed_in?
  skip_before_action :refresh_notifications

  def about
    # Devise code so navbar can include a sign-in
    build_resource
    yield resource if block_given?
    respond_with resource
  end

  protected

  def build_resource(hash=nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
  end
end