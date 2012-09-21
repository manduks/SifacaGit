class InvoicesController < ApplicationController
  include ActionView::Helpers::NumberHelper
  # GET /invoices
  # GET /invoices.json

  def index
    @invoices = Invoice.all
    @invoice = Invoice.new


    #@clients = Client.all.collect { |u| [u.name,u.id] }


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invoices }
      format.js
    end
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @invoice = Invoice.find(params[:id])
    @user = current_user

    respond_to do |format|
      format.html { redirect_to '/resumes', notice: 'Invoice was successfully created.' } # show.html.erb
      format.json { render json: @invoice }
      format.pdf do
        pdf = InvoicePdf.new(@invoice, @user, view_context)
        send_data pdf.render, :filename => 'invoice.pdf', :type => 'application/pdf', :disposition => 'inline'
      end
    end
  end

  # GET /invoices/new
  # GET /invoices/new.json
  def new
    @invoice = Invoice.new
    @client = Client.new
    @article = Article.new
    @resume = Resume.new
    @user = current_user
    @user = User.find(@user.id)
    @students = Student.find(:all)

    1.times { @invoice.articles.build }

    @folio = Folio.find_activo_by_user_id(current_user.id)
    @availableFolios = FolioDetail.find_by_folio_id_and_status(@folio, 1)


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invoice }
    end
  end

  # GET /invoices/1/edit
  def edit
    @folioDetail = FolioDetail.find(Invoice.find(params[:id]).folio_detail_id)
    @folioDetail.status = 1
    @folioDetail.save
    @invoice = Invoice.find(params[:id])
    @folio = Folio.find_activo_by_user_id(current_user.id)
    @availableFolios = FolioDetail.find_by_folio_id_and_status(@folio, 1)
  end

  # POST /invoices
  # POST /invoices.json
  def create
    params[:invoice][:status] = 1
    @invoice = Invoice.new(params[:invoice])
    @article = Article.new(params[:article])
    @resume = Resume.new(params[:resume])


    @regime = User.find(current_user.id).tax_regime
    @rfc_user = User.find(current_user.id).rfc

    if params[:invoice][:date].nil? || params[:invoice][:date].empty?
      @invoice.errors.add 'date', 'Ingresa una Fecha'
    end

    if params[:invoice][:folio_detail_id].nil? || params[:invoice][:folio_detail_id].empty?
      @invoice.errors.add 'folio_detail_id', 'Debes de seleccionar un folio'
    end

    if params[:invoice][:client_id].nil? || params[:invoice][:client_id].empty?
      @invoice.errors.add 'client_id', 'Debes de seleccionar un cliente'
    end


    if @regime == 0
      if !params[:invoice][:articles_attributes]["0"].nil? &&
          (params[:invoice][:articles_attributes]["0"][:quantity].nil? ||
              params[:invoice][:articles_attributes]["0"][:quantity].empty?)
        @invoice.errors.add 'articles', 'Debes agregar al menos un articulo'
      end
      #!params[:invoice][:articles_attributes]["0"].nil? &&
      #if (params[:invoice][:articles_attributes][""][:quantity].nil? || params[:invoice][:articles_attributes][""][:quantity].empty?)
      # @invoice.errors.add 'articles', 'No pueden estar vacios los campos'
      #end
      if params[:resume][:receipt].nil? || params[:resume][:receipt].empty?
        @invoice.errors.add 'receipt', 'No puede estar vacio el campo'
      end
    end

    if @regime == 1
      if params[:resume][:places].nil? || params[:resume][:places].empty?
        @invoice.errors.add 'places', 'No puede estar vacio el campo'
      end

      if params[:resume][:concept].nil? || params[:resume][:concept].empty?
        @invoice.errors.add 'concept', 'No puede estar vacio el campo'
      end

      if params[:resume][:total].nil? || params[:resume][:total].empty?
        @invoice.errors.add 'concept', 'No puede estar vacio el campo'
      end
    end

    #params[:invoice][:articules_attributes][0][:description]]
    respond_to do |format|
      if @invoice.errors.empty? && @invoice.save
        @rfc = Client.find(params[:invoice][:client_id]).rfc.to_s
        @folioDetail = FolioDetail.find(params[:invoice][:folio_detail_id])
        @folioDetail.status = 0
        @folioDetail.save
        @article.invoice_id = Invoice.maximum("id")
        @resume.invoice_id = Invoice.maximum("id")
        if @regime == 0 || @regime == 2
          @articles = Article.find_all_by_invoice_id(@article.invoice_id)
          @subtotal = 0
          @total = 0
          @articles.each do |article|
            @subtotal = @subtotal + Article.subtotal_multiplication(article.unit_cost, article.quantity)
            @total = @total + Article.total_multiplication(article.unit_cost, article.quantity, article.iva)
          end
          @resume.subtotal = @subtotal
          @resume.total = @subtotal + @total
          #if validateRfc(@rfc_user)
            #@resume.iva = number_with_precision(@resume.total - @resume.subtotal, :precision => 2)
            #@totals = number_with_precision(@resume.total, :precision => 2)
          #else
            @resume.iva = number_with_precision(@resume.subtotal * 0.16, :precision => 2)
            @resume.ret_iva = number_with_precision(((@resume.total - @resume.subtotal)/3)*2, :precision => 2)
            @totals = number_with_precision(@resume.total-@resume.ret_iva, :precision => 2)
            @resume.total = @totals
          #end
          @resume.letter_number = @totals.to_f.to_words.capitalize << " pesos " << (@totals.to_f.to_s.split(".")[1] || 0).rjust(2, '0')<< "/100 M.N."
          @resume.save
          #@resume.letter_number = @totals.to_f.to_words.capitalize << " pesos " << (@totals.to_f.to_s.split(".")[1] || 0).rjust(2, '0')<< "/100 M.N."
        end
        if @regime == 1
          @quantity = @resume.total * 1.04895104895105
          @resume.quantity = number_with_precision(@quantity, :precision => 2)
          @resume.iva = number_with_precision(@resume.quantity * 0.16, :precision => 2)
          @resume.subtotal = number_with_precision(@resume.iva + @resume.quantity, :precision => 2)
          @resume.letter_number = @resume.total.to_words.capitalize << " pesos " << (@resume.total.to_s.split(".")[1] || 0).rjust(2, '0')<< "/100 M.N."
          if validateRfc(@rfc)
            @resume.ret_isr = number_with_precision(@resume.quantity * 0.10, :precision => 2)
            @resume.ret_iva = number_with_precision(@resume.quantity * (0.16/3*2), :precision => 2)
          end
          @resume.save
        end


        format.html { redirect_to '/resumes', notice: 'La factura fue creada satisfactoriamente' }
        format.json { render json: @invoice, status: :created, location: @invoice }
        format.js
      else
        logger.debug("else entro")
        @folio = Folio.find_activo_by_user_id(current_user.id)
        @availableFolios = FolioDetail.find_by_folio_id_and_status(@folio, 1)

        format.html { render action: "new" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /invoices/1
  # PUT /invoices/1.json
  def update
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      if @invoice.update_attributes(params[:invoice])
        @folioDetail = FolioDetail.find(@invoice.folio_detail_id)
        @folioDetail.status = 0
        @folioDetail.save
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.status = 0
    @invoice.save

    respond_to do |format|
      format.html { redirect_to '/resumes', notice: 'La factura fue cancelada satisfactoriamente.' }
      format.json { head :no_content }
    end
  end

  def add
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def dynamic_students
    @students = Student.find_all_by_client_id(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def validateRfc(rfc)
    r = rfc[3]
    b = (/[0-9]/ === r)
    return b
  end
end
