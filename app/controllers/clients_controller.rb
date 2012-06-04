class ClientsController < ApplicationController
  helper_method :sort_column, :sort_direction
  # GET /clients
  # GET /clients.json
  def index
    @clients = current_user.clients.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 6, :page => params[:page])
    @client = Client.new
    @user = current_user


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clients }
      format.js
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.json
  def new
    @client = Client.new
    @student = Student.new
    @user = current_user
    @user = User.find(@user.id)
    @list_students = []
    # @list_students = Student.all


    # 1.times { @client.students.build }

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client }
      format.js
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
    @user = current_user
    @user = User.find(@user.id)

    respond_to do |format|
      format.html { redirect_to clients_path }
      format.js
    end
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(params[:client])
    @student = Student.new(params[:student])
    @client.user = current_user
    @user = current_user
    @clients = current_user.clients.paginate(:per_page => 6, :page => params[:page])

    respond_to do |format|
      if @client.save
        format.html { redirect_to clients_path, notice: 'El cliente fue agregado satisfactoriamente.' }
        format.json { render json: @client, status: :created, location: @client }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.json
  def update
    @client = Client.find(params[:id])
    @clients = current_user.clients.paginate(:per_page => 6, :page => params[:page])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to clients_path, notice: 'El cliente fue actualizado satisfactoriamente' }
        format.json { head :no_content }
        format.js
      else
        format.html { redirect_to }
        format.json { render json: @client.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
    end
  end


  def sort_column
    Client.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end


end
