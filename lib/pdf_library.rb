
module PDF
  class Generator

    MARGIN = 5.mm

    def initialize(story_list)
      @filename = Tempfile.new(["Test", ".pdf"])
      @stories = story_list
    end

    def write_to

      Prawn::Document.new(:page_layout => :landscape,
                          :page_size => "A4",
                          :left_margin => 5.mm) do |pdf|

        pdf.font "#{Prawn::BASEDIR}/data/fonts/DejaVuSans.ttf"

        index = 0

        @stories.each do |story|

          bb = get_bounding_box(index %4)

          # --- Write content
          pdf.bounding_box [bb[:left], bb[:top]], :width => bb[:width], :height => bb[:height] do

            pdf.stroke_color = story.story_color
            pdf.line_width=6
            pdf.stroke_bounds

            # We want to inset the text from the border which has been painted
            pdf.bounding_box [MARGIN, pdf.bounds.top-MARGIN], :width => 120.mm, :height => bb[:height] - MARGIN*2 do

              pdf.text story.name.force_encoding("UTF-8"), :size => 14
              pdf.fill_color "52D017"
              pdf.text story.labels, :size => 8
              pdf.text "\n", :size => 14
              pdf.fill_color "444444"
              pdf.text story.description.force_encoding("UTF-8") || "", :size => 10

              #pdf.fill_color ""
              pdf.text story.task_list, :size => 8

              pdf.fill_color "000000"
              pdf.text_box story.points, :size => 12, :align => :center, :valign => :bottom unless story.points.nil?

              #pdf.text_box "Owner: " + (story.respond_to?(:owned_by) ? story.owned_by : "None"), :size => 8, :valign => :bottom

              pdf.fill_color "999999"
              pdf.text_box story.story_type.force_encoding("UTF-8").capitalize, :size => 8, :align => :right, :valign => :bottom
              pdf.fill_color "000000"
            end
          end
          index = index + 1

          if (index % 4) == 0
            pdf.start_new_page unless index == @stories.size
          end

        end
        @filename.write (pdf.render().force_encoding("UTF-8"))
      end


    rescue Exception
      puts "[!] There was an error while generating the PDF file... What happened was:".foreground(:red)
      raise
    else
      @filename
    ensure
      @filename.close unless @filename.nil?
    end


    def get_bounding_box(position)
      case (position)
        when 0
          {:top => 185.mm, :left => 0.mm, :width => 140.mm, :height => 90.mm}
        when 1
          {:top => 185.mm, :left => 148.mm, :width => 140.mm, :height => 90.mm}
        when 2
          {:top => 80.mm, :left => 0.mm, :width => 140.mm, :height => 90.mm}
        when 3
          {:top => 80.mm, :left => 148.mm, :width => 140.mm, :height => 90.mm}
        else
          {:top => 0.mm, :left => 0.mm, :width => 140.mm, :height => 90.mm}
      end
    end
  end

end