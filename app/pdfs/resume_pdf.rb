class ResumePdf < Prawn::Document
  include ActionView::Helpers::NumberHelper

  def initialize (resume, user, view)
    super()
    @resume = resume
    @view = view
    @user = user
    @invoice = Invoice.find(@resume.invoice_id)
    @articles = Article.find_all_by_invoice_id(@resume.invoice_id)
    move_down 20
    title
    users
    logo
    folio
    client
    arts
    article
    receipt
    qr
    message
    if @invoice.status == 0
      cancel
    end
  end


  def logo
    bounding_box([0, cursor - 0], :width => 200, :height => 100) do
      if !@user.logo_emp.url.nil?
        @logo_emp = "#{@user.logo_emp}"
        image "#{Rails.root}/public"+@logo_emp+"", :width => 140, :height => 100
      end
    end
  end

  def title
    string = "#{@user.name}"
    y_position = cursor - -10
    excess_text = text_box string,
                           :width => 350,
                           :height => 50,
                           :overflow => :truncate,
                           :at => [150, y_position],
                           :size => 15,
                           :style => :bold

    text_box excess_text,
             :width => 300,
             :at => [100, y_position - 50]

  end

  def users

    string = " #{@user.street}"+" N.#{@user.num_ext}"+" #{@user.num_int}"+" COL. #{@user.suburb}"+
        " Del. #{@user.township}"+" C.P.#{@user.cp}"+" #{@user.state}"+" RFC. #{@user.rfc}"

    y_position = cursor - 30
    excess_text = text_box string,
                           :width => 229,
                           :height => 50,
                           :overflow => :truncate,
                           :at => [160, y_position],
                           :size => 11

    text_box excess_text,
             :width => 300,
             :at => [100, y_position - 50]
  end

  def folio
    cell_1 = make_cell(:content => "Factura ", :align => :center, :size => 10, :background_color => "D3D3D3")
    cell_2 = make_cell(:content => "No. de Folio:", :size => 10)
    cell_3 = make_cell(:content => "Fecha", :align => :center, :size => 10, :background_color => "D3D3D3")
    cell_4 = make_cell(:content => "#{FolioDetail.find(@invoice.folio_detail_id).folio_detail_id}", :align => :center, :text_color => "B22222", :width => 40, :size => 13)
    cell_5 = make_cell(:content => "#{@invoice.date.strftime("%d/%m/%Y")}", :align => :center, :width => 107)

    data = [[cell_1],
            [[[cell_2, cell_4]]]]

    data2 = [[cell_3], [cell_5]]
    bounding_box([425, cursor - -109], :width => 200, :height => 100) do
      table(data)
      move_down 4
      table(data2)
    end
  end

  def client
    cell_1 = make_cell(:content => "Datos del Cliente", :align => :center, :background_color => "D3D3D3")
    cell_2 = make_cell(:content => "Nombre del Cliente:", :width => 120)
    cell_3 = make_cell(:content => "RFC del Cliente:", :width => 120)
    cell_4 = make_cell(:content => "Domicilio:", :width => 120)
    cell_5 = make_cell(:content => "#{Client.find(Invoice.find(@resume.invoice_id).client_id).name}", :width => 410)
    cell_6 = make_cell(:content => "#{Client.find(Invoice.find(@resume.invoice_id).client_id).rfc}", :width => 410)
    cell_7 = make_cell(:content => "#{Client.find(Invoice.find(@resume.invoice_id).client_id).street} #{Client.find(Invoice.find(@resume.invoice_id).client_id).num_int} #{Client.find(Invoice.find(@resume.invoice_id).client_id).num_ext} #{Client.find(Invoice.find(@resume.invoice_id).client_id).suburb} #{Client.find(Invoice.find(@resume.invoice_id).client_id).cp} #{Client.find(Invoice.find(@resume.invoice_id).client_id).township} #{Client.find(Invoice.find(@resume.invoice_id).client_id).state}", :width => 410)


    data = [[cell_2, cell_5],
            [cell_3, cell_6],
            [cell_4, cell_7]
    ]

    move_down 20
    table([[cell_1], [data]])
  end

  def article
    cell_1 = make_cell(:content => "", :borders => [:top, :right, :left], :width => 80)
    cell_2 = make_cell(:content => "", :width => 260)
    cell_3 = make_cell(:content => "Subtotal", :background_color => "D3D3D3", :width => 100)
    cell_4 = make_cell(:content => "#{number_to_currency(@resume.subtotal, :unit => "$")}", :align => :right, :width => 90)
    cell_5 = make_cell(:content => "I.V.A Tasa 16 %", :background_color => "D3D3D3")
    cell_6 = make_cell(:content => "#{number_to_currency(@resume.total - @resume.subtotal, :unit => "$")}", :align => :right)
    cell_7 = make_cell(:content => "Total a Pagar", :background_color => "D3D3D3")
    cell_8 = make_cell(:content => "#{number_to_currency(@resume.total, :unit => "$")}", :align => :right)


    data = [[cell_1, cell_2, cell_3, cell_4],
            ["", "", cell_5, cell_6],
            ["", "", cell_7, cell_8],
    ]

    table([[data]])

  end

  def receipt
    cell_1 = make_cell(:content => "Cantidad con Letra", :background_color => "D3D3D3")
    cell_2 = make_cell(:content => "Condiciones de pago", :background_color => "D3D3D3")
    cell_3 = make_cell(:content => "Recibi de Conformidad", :background_color => "D3D3D3")
    cell_4 = make_cell(:content => "#{@resume.letter_number}", :align => :center, :width => 398)
    cell_5 = make_cell(:content => "#{@resume.payment_condition}", :align => :center, :width => 398)
    cell_6 = make_cell(:content => "#{@resume.receipt}", :align => :center, :width => 398)

    data = [[cell_1, cell_4], [cell_2, cell_5], [cell_3, cell_6]]

    table([[data]])
  end

  def qr
    @qr = "#{Folio.find_by_user_id(@user.id).qr}"
    move_down 20
    qrpath = "#{Rails.root}/public"+@qr+""
    image qrpath, :width => 115, :height => 115
  end

  def message
    file = "#{Rails.root}/bundle/ruby/1.9.1/gems/prawn-0.12.0/data/fonts/Chalkboard.ttf"
    font_families["Action Man"] = {
        :normal => {:file => file, :font => "ActionMan"},
    }
    bounding_box([130, cursor - -90], :width => 400, :height => 130, :align => :center) do
      font("Action Man") do
        text "Efectos fiscales al pago", :size => 10, :align => :center
        text "NUMERO DE APROBACION DEL FOLIO ASIGNADO POR SICOFI : #{Folio.find_by_user_id(@user).approval}", :size => 10, :align => :center
        text "La reproduccion apocrifa de este comprobante constituye un delito en los terminos de las disposiciones fiscales", :size => 10, :align => :center
        text "Este comprobante tendra una vigencia de dos anos contados a partir de la fecha de aprobacion de la asignacion de folios, la cual es: #{Folio.find_by_user_id(@user).date_initiation.strftime("%d/%m/%Y")}", :size => 10, :align => :center
      end
    end

  end

  def arts
    cell_1 = make_cell(:content => "Cantidad", :align => :center, :width => 80, :background_color => "D3D3D3")
    cell_2 = make_cell(:content => "Clase de Mercancias o Descripcion", :align => :center, :width => 260, :background_color => "D3D3D3")
    cell_3 = make_cell(:content => "Valor por Unidad", :align => :center, :width => 100, :background_color => "D3D3D3")
    cell_4 = make_cell(:content => "Total", :align => :center, :width => 90, :background_color => "D3D3D3")

    data = [[cell_1, cell_2, cell_3, cell_4]]


    @articles.each do |article|
      @iva = (article.unit_cost * article.quantity) * ((article.iva.nil? || article.iva == 0) ? 0 : (article.iva.to_f / 100))
      cell_5 = make_cell(:content => "#{article.quantity}", :align => :center)
      cell_6 = make_cell(:content => "#{article.description}", :align => :center)
      cell_7 = make_cell(:content => "#{number_to_currency(article.unit_cost, :unit => "$")}", :align => :center)
      cell_8 = make_cell(:content => "#{number_to_currency((article.quantity * article.unit_cost) + @iva, :unit => "$")}", :align => :right)

      data << [cell_5, cell_6, cell_7, cell_8]
    end
    table([[data], [""]])
  end

  def cancel
    bounding_box([0, cursor - -250], :width => 550, :height => 250) do
      angle = 30
      font "#{Rails::root}/bundle/ruby/1.9.1/gems/prawn-0.12.0/data/fonts/Action Man.dfont" do
        text "Cancelada",
             :color => "FF0000",
             :rotate => angle,
             :rotate_around => 50,
             :size => 60,
             :align => :center
      end
    end
  end

end