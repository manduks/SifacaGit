class UsersController < Devise::RegistrationsController
  def edit
    @user = current_user

  end

  def update
    @user = User.find(current_user.id)
    params[:user][:active] = validateUserInformation(@user, params[:user]) ? 1 : 0
    if @user.update_without_password(params[:user])
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to dashboard_path
    else
      render "edit"
    end
  end

  private

  def validateUserInformation(user, params)
    @valid = true
    @tax_regime = (params[:tax_regime].nil? || params[:tax_regime].empty?) ? user.tax_regime : params[:tax_regime]
    @tax_regime = Integer(@tax_regime)
    if @tax_regime == 0 || @tax_regime == 2
      #if (user.logo_emp.nil? && (params[:logo_emp].nil? || params[:logo_emp].empty?))
      # @valid = false
      #end

    elsif @tax_regime == 1
      if params[:curp].nil? || params[:curp].empty?
        @valid = false
      end
    end

    if params[:name].nil? || params[:name].empty? ||
        params[:rfc].nil? || params[:rfc].empty? ||
        params[:street].nil? || params[:street].empty? ||
        params[:num_ext].nil? || params[:num_ext].empty? ||
        params[:suburb].nil? || params[:suburb].empty? ||
        params[:cp].nil? || params[:cp].empty? ||
        params[:township].nil? || params[:township].empty? ||
        params[:state].nil? || params[:state].empty?
      @valid = false
    end

    return @valid
  end

end
