class FoliosController < ApplicationController
  before_filter :authenticate_user!
  # GET /folios
  # GET /folios.json
  def index
    @folios = current_user.folios.paginate(:per_page => 4, :page =>params[:page])
    @folio = Folio.new
    #@clients = current_user.clients

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @folios }
      format.js
    end
  end

  # GET /folios/1
  # GET /folios/1.json
  def show
    @folio = Folio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @folio }
    end
  end

  # GET /folios/new
  # GET /folios/new.json
  def new
    @folio = Folio.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @folio }
      format.js
    end
  end

  # GET /folios/1/edit
  def edit
    @folio = Folio.find(params[:id])
  end

  # POST /folios
  # POST /folios.json
  def create
    ## Variables utilizadas para listar y crear folios despues de un error en el create
    @folios = current_user.folios.paginate(:per_page => 10, :page =>params[:page])
    # Activamos el nuevo folio
    params[:folio][:user_id] = current_user.id
    params[:folio][:activo] = 1
    @folio = Folio.new(params[:folio])
    #Se hacen las validaciones correspondientes para folios
    @folio = validateFolios(@folio, params[:folio], 'create')

    # Desactivamos todos los folios anteriores
    if @folio.errors.empty?
      deactivatePreviousFolios
    end

    respond_to do |format|
      if @folio.errors.empty? && @folio.save
        #Agregamos todos los folios details que correspondan a este folio
        addFolioDetails(@folio.id, params[:folio])

        format.html { redirect_to folios_path, notice: 'Folio was successfully created.' }
        format.json { render json: @folio, status: :created, location: @folio }
        format.js
      else
        format.html { render action: "index" }
        format.json { render json: @folio.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /folios/1
  # PUT /folios/1.json
  def update
    @folios = current_user.folios.paginate(:per_page => 3, :page =>params[:page])
    @folio = Folio.find(params[:id])

    @folio = validateFolios(@folio, params[:folio], 'update')

    respond_to do |format|
      if @folio.errors.empty? && @folio.update_attributes(params[:folio])
        format.html { redirect_to folios_path, notice: 'Folio was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @folio.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /folios/1
  # DELETE /folios/1.json
  def destroy
    @folio = Folio.find(params[:id])
    @folio.destroy

    respond_to do |format|
      format.html { redirect_to folios_url }
      format.json { head :no_content }
    end
  end

  private

  def addFolioDetails(folio_id, params)
    (Integer(params[:initiation])..Integer(params[:finish])).each do |i|
      @folioDetail = FolioDetail.new
      @folioDetail.folio_id = folio_id
      @folioDetail.folio_detail_id = i
      @folioDetail.status = 1
      @folioDetail.save
    end
  end

  def deactivatePreviousFolios
    current_user.folios.each do |folio|
      folio.activo = 0
      @fol = Folio.find(folio.id)
      folio = folio.as_json
      @fol.update_attributes(folio)
    end
  end

  def validateFolios(folio, params, action)
    if action == 'create'
      #Validamos el qr
      if params[:qr].nil?
        folio.errors.add 'qr', 'No puede estar vacio'
      end
    end
    #Validamos el folio initiation que sea consecutivo con los que ya tiene.
    if params[:initiation].empty?
      folio.errors.add 'initiation', 'No puede estar vacio'
    else
      if Integer(params[:initiation]) <= (Folio.find_max_by_user_id(current_user.id, nil) || 0) #Folio.maximum("finish", :conditions => ['user_id = ?', current_user.id])
        folio.errors.add 'initiation', 'Debe ser mayor que '+(Folio.find_max_by_user_id(current_user.id, nil) || 0).to_s
      end
    end
    #Validamos que el finish sea mayor que el initiation
    if params[:finish].empty?
      folio.errors.add 'finish', 'No puede estar vacio'
    else
      if Integer(params[:initiation]) >= Integer(params[:finish])
        folio.errors.add 'finish', 'Debe ser un rango valido'
      end
    end

    if params[:date_initiation].empty?
      folio.errors.add 'date_initiation', 'No puede estar vacio'
    end

    if params[:date_finish].empty?
      folio.errors.add 'date_finish', 'No puede estar vacio'
    end

    if params[:approval].empty?
      folio.errors.add 'approval', 'No puede estar vacio'
    end

    return folio
  end
end
