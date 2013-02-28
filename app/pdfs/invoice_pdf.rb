class InvoicePdf < Prawn::Document
  include ActionView::Helpers::NumberHelper

  def initialize (invoice, user, view)
    super()
    @invoice = invoice
    @user = user
    @view = view
    @invoice = Invoice.find(@invoice.invoice_id)
    move_down 20
    head
    title
    rfc
    address
    folio
    clients
    total
    money
    qr
    signature
    message
    if @invoice.status == 0
      cancel
    end
  end

  def head
    stroke_horizontal_rule
    move_down 3
    pad(7) { text_box "Recibo de Honorarios", :kerning => true, :at => [0, y - 31], :style => :bold
    text_box "FOLIO", :kerning => false, :at => [500, y - 31], :style => :bold }
    stroke_horizontal_rule
  end

  def title
    font("Courier") do
      string = "#{@user.name}"

      y_position = cursor - 25
      excess_text = text_box string,
                             :width => 350,
                             :height => 50,
                             :overflow => :truncate,
                             :at => [150, y_position],
                             :size => 16,
                             :style => :bold


      text_box excess_text,
               :width => 300,
               :at => [100, y_position - 50]
      move_down 7
    end
  end

  def rfc
    string = " RFC. #{@user.rfc}"

    y_position = cursor - 35
    excess_text = text_box string,
                           :width => 229,
                           :height => 50,
                           :overflow => :truncate,
                           :at => [150, y_position],
                           :size => 11

    text_box excess_text,
             :width => 300,
             :at => [100, y_position - 50]

  end

  def address

    string = "CALLE #{@user.street}"+" No.#{@user.num_ext}"+" #{@user.num_int}"+" Col. #{@user.suburb},"+
        " C.P. #{@user.cp}"+" Del. #{@user.township},"+" #{@user.state}"

    y_position = cursor - 50
    excess_text = text_box string,
                           :width => 230,
                           :height => 50,
                           :overflow => :truncate,
                           :at => [150, y_position],
                           :size => 9

    text_box excess_text,
             :width => 300,
             :at => [100, y_position - 50]
  end

  def folio
    bounding_box([480, cursor - 10], :width => 400, :height => 130, :align => :center) do
      text "No.  #{FolioDetail.find(@invoice.folio_detail_id).folio_detail_id}", :color => "FF0000", :style => :bold, :size => 15
    end
  end

  def clients
    bounding_box([10, cursor - -60], :width => 430, :height => 130, :align => :center) do
      text "<b>Recibi de:</b> #{Client.find(@invoice.client_id).name}", :inline_format => true
      text "<b>R.F.C.:</b> #{Client.find(@invoice.client_id).rfc}", :inline_format => true
      text "<b>Domicilio:</b> #{Client.find(@invoice.client_id).street} # #{Client.find(@invoice.client_id).num_ext} #{Client.find(@invoice.client_id).num_int} Col. #{Client.find(@invoice.client_id).suburb} C.P. #{Client.find(@invoice.client_id).cp}, Del. #{Client.find(@invoice.client_id).township}, #{Client.find(@invoice.client_id).state}", :inline_format => true
      text "<b>Concepto:</b> #{Resume.find_by_invoice_id(@invoice.id).concept}", :inline_format => true
      text "<b>Lugar y Fecha:</b> #{Resume.find_by_invoice_id(@invoice.id).places}   #{@invoice.date.strftime("%d/%m/%Y")}", :inline_format => true
    end
  end

  def total
    bounding_box([270, cursor - -61], :width => 430, :height => 130, :align => :center) do
      text "<b>CANTIDAD: </b>", :inline_format => true
      text "<b>I.V.A.: </b>", :inline_format => true
      text "<b>SUBTOTAL: </b>", :inline_format => true
      text "<b>RET. I.S.R.: </b>", :inline_format => true
      text "<b>RET. I.V.A.: </b>", :inline_format => true
      text "<b>TOTAL: </b>", :inline_format => true
    end
  end

  def money
    bounding_box([340, cursor - -130], :width => 430, :height => 130) do
      text "#{number_to_currency(Resume.find_by_invoice_id(@invoice.id).quantity, :unit => "$ ", :align => :right)}"
      text "#{number_to_currency(Resume.find_by_invoice_id(@invoice.id).iva, :unit => "$ ")}"
      text "#{number_to_currency(Resume.find_by_invoice_id(@invoice.id).subtotal, :unit => "$ ")}"
      text "#{number_to_currency(Resume.find_by_invoice_id(@invoice.id).ret_isr, :unit => "$ ")}"
      text "#{number_to_currency(Resume.find_by_invoice_id(@invoice.id).ret_iva, :unit => "$ ")}"
      text "#{number_to_currency(Resume.find_by_invoice_id(@invoice.id).total, :unit => "$ ")}"
    end
  end

  def qr
    bounding_box([420, cursor - -150], :width => 430, :height => 130, :align => :center) do
      @qr = "#{Folio.find_by_user_id(@user.id).qr}"
      qrpath = "#{Rails.root}/public"+@qr+""
      image qrpath, :width => 115, :height => 115
    end
  end

  def signature
    bounding_box([10, cursor - -80], :width => 210, :height => 130, :align => :center) do
      text "<b>Total con Letra:</b> #{Resume.find_by_invoice_id(@invoice.id).letter_number}", :inline_format => true
      move_down 30
      stroke_horizontal_rule
      move_down 4
      text "<b>FIRMA</b>", :align => :center, :inline_format => true
    end
  end

  def message
    file = "#{Rails.root}/bundle/ruby/1.9.1/gems/prawn-0.12.0/data/fonts/Chalkboard.ttf"
    font_families["Action Man"] = {
        :normal => {:file => file, :font => "ActionMan"},
    }
    bounding_box([15, cursor - -50], :width => 510, :height => 130, :align => :center) do
      font("Action Man") do
        text "Efectos fiscales al pago", :size => 10, :align => :center
        text "NUMERO DE APROBACION DEL FOLIO ASIGNADO POR SICOFI : #{Folio.find_by_user_id(@user).approval}", :size => 10, :align => :center
        text "La reproduccion apocrifa de este comprobante constituye un delito en los terminos de las disposiciones fiscales.", :size => 10, :align => :center
        text "Este comprobante tendra una vigencia de dos anos contados a partir de la fecha de aprobacion de la asignacion de folios, la cual es: #{Folio.find_by_user_id(@user).date_initiation.strftime("%d/%m/%Y")}", :size => 10, :align => :center
      end
    end

  end

  def cancel
    bounding_box([10, cursor - -80], :width => 550, :height => 250) do
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
