class ReportPdf < Prawn::Document
  include ActionView::Helpers::NumberHelper

  def initialize(receipt, supplier)
    super(top_margin: 40, :page_layout => :portrait)
    @receipt = receipt
    @receipt.producer = supplier
    logo = "#{Rails.root}/app/assets/images/large/logo.png" 
    image logo, :position => :left, :width => 100  #:at => [50,450], :width => 450

    header
    move_down 50 # cursor set down
    type_of_receipt # partial
    move_down 20
    receipt_description # partial
    move_down 20
    horizontal_rule
    move_down 20
    customer_file
    move_down 20
    text "Bestell- / Lieferinformationen"
    shipping_info

  end

  def header
        bounding_box [bounds.left - 0, bounds.top], :width  => bounds.width do
        font "Helvetica"
        text "terracamp GmbH Münster \n Stadtfiliale Aegidimarkt 4, 48143 Münster \n", :align => :center, :size => 15
        text "terracamp.aegidiimarkt@terracamp.de \n fon 0251 - 45777      fax 0251 - 57438", :align => :center, :size => 12
      end
        bounding_box [bounds.left + 220, bounds.top], :width => bounds.width do
        font "Helvetica"
        text "Vorgangs-Nr \n ", :align => :center, :size => 15
		if @receipt.receipt_type == "Bestellung"
			text @receipt.receipt_number, :align => :center, :size => 15
		else
			text "AEG " + @receipt.receipt_number, :align => :center, :size => 15
		end 
      end
  end 

  def type_of_receipt
    #image "#{Rails.root}/app/assets/images/logo.png", :position => :right
    content = [  [ {:content => @receipt.receipt_type, :colspan => 2, :size => 15, :font_style => :bold} ],
            [ @receipt.receipt_date.strftime("%d.%m.%Y"), {:content => "Ansprechpartner: " + @receipt.receipt_person, :colspan => 1} ]
          ]

    table content, :cell_style => {:width => 270}
  end

  def receipt_description

    if @receipt.purchase_date == nil
      purchase_date = ''
    else
      purchase_date = @receipt.purchase_date.strftime("%d.%m.%Y")
    end

	if @receipt.receipt_type == "Bestellung"
	
	    content = [   [{:content => "Hersteller", :font_style => :bold},  {:content => @receipt.producer, :colspan => 3}],
                  [{:content => "Artikel-Bez.", :font_style => :bold},{:content => @receipt.article, :colspan => 3}],
                  [{:content => "Farbe", :font_style => :bold}, {:content => @receipt.article_color}, {:content => "Größe", :font_style => :bold}, {:content => @receipt.article_size}],
                  [{:content => "Bemerkungen: \n \n" + @receipt.receipt_notes + " \n \n", :colspan => 4}]
                  
          ]
	else	  
		content = [   [{:content => "Hersteller", :font_style => :bold},  {:content => @receipt.producer, :colspan => 3}],
					  [{:content => "Artikel-Bez.", :font_style => :bold},{:content => @receipt.article, :colspan => 3}],
					  [{:content => "Farbe", :font_style => :bold}, {:content => @receipt.article_color}, {:content => "Größe", :font_style => :bold}, {:content => @receipt.article_size}],
					  [{:content => "Bemerkungen: \n \n" + @receipt.receipt_notes + " \n \n", :colspan => 4}],
					  [{:content => "Kaufbeleg: " + @receipt.receipt_true}, {:content => "Kaufdatum " + purchase_date, :colspan => 2},{:content => "Mangel markiert: " + @receipt.article_flaw}]

			  ]
	end

    table content, :cell_style => {:width => 135}


    
  end

  def customer_file
    text "Kundendaten"
    # [{:content => "Kundendaten", :border_width => 0}, {:content => "", :border_width => 0}, {:content => "", :border_width => 0}, {:content => "", :border_width => 0}],
    content = [   
                  [{:content => "Name: "}, {:content => @receipt.customer.customer_name + " " + @receipt.customer.customer_surname}],
                  [{:content => "Straße: "}, {:content => @receipt.customer.customer_street}],
                  [{:content => "PLZ, Wohnort: "}, {:content => @receipt.customer.customer_town}],
                  [{:content => "Telefon: "},{:content => @receipt.customer.customer_phone}],
                  [{:content => "Email: "}, {:content => @receipt.customer.customer_email}]
    ]

    table content, :cell_style => {:width => 270}
  end

  def shipping_info
  
    if @receipt.order_date == nil
      order_date = ''
    else
      order_date = @receipt.order_date.strftime("%d.%m.%Y")
    end

    if @receipt.order_receiving == nil
      order_receiving = ''
    else
      order_receiving = @receipt.order_receiving.strftime("%d.%m.%Y")
    end

    if @receipt.customer_notice == nil
      customer_notice = ''
    else
      customer_notice = @receipt.customer_notice.strftime("%d.%m.%Y")
    end

    content = [
                  [{:content => "Bestellt am: "}, {:content => order_date}],
                  [{:content => "Wareneingang am: "}, {:content => order_receiving}],
                  [{:content => "Kundeninfo am: "}, {:content => customer_notice}]
    ]

    table content, :cell_style => {:width => 270}

  end




end

