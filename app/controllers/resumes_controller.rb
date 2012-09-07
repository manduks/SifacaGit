class ResumesController < ApplicationController
  include ActionView::Helpers::NumberHelper

  # GET /resumes
  # GET /resumes.json
  def index
    @clients = current_user.clients.search(params[:search])
    @resumes = []
    logger.debug(@resumes)
    @withoutClients = false
    @rfc_user = validateRfc(User.find(current_user.id).rfc)

    if (@clients.nil? || @clients.empty?) && params[:search]
      @withoutClients = true
      @clients = current_user.clients
    end

    @clients.each do |client|
      if @withoutClients
        @resumes = @resumes + Resume.search_by_invoice_id(Invoice.find_all_by_client_id(client.id), params[:search])
      else
        @resumes = @resumes + Resume.find_all_by_invoice_id(Invoice.find_all_by_client_id(client.id))
      end
    end

    @resumes = @resumes.paginate(:per_page => 10, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @resumes }
      format.js
    end
  end

  # GET /resumes/1
  # GET /resumes/1.json
  def show
    @resume = Resume.find(params[:id])
    @user = current_user
    @flag = User.find(current_user.id).tax_regime
    @folio = FolioDetail.find(Invoice.find(@resume.invoice_id).folio_detail_id).folio_detail_id
    @client = Client.find(Invoice.find(@resume.invoice_id).client_id)
    @dir = after_create(@user)
    @rfc_user = User.find(current_user.id).rfc
    #attachments["Folio_#{@folio}.pdf}"] = File.read("#{Rails.root}/public/uploads/pdfs/"+"#{user.id}"+"Folio_#{@folio}.pdf}")


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resume }
      format.pdf do
        if @flag == 0
          #if validateRfc(@rfc_user)
            pdf = ResumePdf.new(@resume, @user, view_context)
            @name = "General"
          #else
           # pdf = InvoicefisPdf.new(@resume, @user, view_context)
            #@name = "General"
          #end
        end
        if @flag == 1
          pdf = InvoicePdf.new(@resume, @user, view_context)
          @name = "Honorarios"
        end
        if @flag == 2
          pdf = SchoolPdf.new(@resume, @user, view_context)
          @name = "Escuela"
        end

        send_data pdf.render, :filename => "Folio-#{@folio}.pdf", :type => 'application/pdf', :disposition => 'inline'
        pdf.render_file File.join(Rails.root, "public/uploads/pdfs/"+"#{@user.id}", "Folio_#{@folio}.pdf")

      end

    end
    # ClientMailer.pdf_delivery(@client, @folio, @user).deliver
  end

  # GET /resumes/new
  # GET /resumes/new.json

  def new
    @resume = Resume.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resume }
    end
  end

  # GET /resumes/1/edit
  def edit
    @resume = Resume.find(params[:id])
  end

  # POST /resumes
  # POST /resumes.json
  def create
    @resume = Resume.new(params[:resume])

    respond_to do |format|
      if @resume.save
        format.html { redirect_to @resume, notice: 'Resume was successfully created.' }
        format.json { render json: @resume, status: :created, location: @resume }
      else
        format.html { render action: "new" }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /resumes/1
  # PUT /resumes/1.json
  def update
    @resume = Resume.find(params[:id])

    respond_to do |format|
      if @resume.update_attributes(params[:resume])
        format.html { redirect_to @resume, notice: 'Resume was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resumes/1
  # DELETE /resumes/1.json
  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy

    respond_to do |format|
      format.html { redirect_to resumes_url }
      format.json { head :no_content }
    end
  end

  def after_create(user)
    if !File.exist?("#{Rails.root}/public/uploads/pdfs/"+"#{user.id}")
      Dir.mkdir("#{Rails.root}/public/uploads/pdfs/"+"#{@user.id}")
    end
  end

  def send_email
    @user = current_user
    @resume = Resume.find(params[:id])
    @folio = FolioDetail.find(Invoice.find(@resume.invoice_id).folio_detail_id).folio_detail_id
    @client = Client.find(Invoice.find(@resume.invoice_id).client_id)
    ClientMailer.pdf_delivery(@client, @folio, @user).deliver
    respond_to do |format|
      format.html { redirect_to resumes_url }
      #format.json { head :no_content }
    end
  end

  def validateRfc(rfc)
    r = rfc[3]
    b = (/[0-9]/ === r)
    return b
  end

end
