require "jupyter_to_scrapbox/version"
require "JSON"

module JupyterToScrapbox
  # Your code goes here...

  class Converter
    @@verbose=false
    @@converters=[]
    @@parse_markdown_notations=true

    def Converter.set_verbose(v)
      @@verbose=v
    end

    def Converter.set_parse_markdown(v)
      @@parse_markdown_notations=v
    end

    def Converter.add(path)
      @@converters.push Converter.new(path)
    end

    def Converter.start()
      pages=@@converters.collect do |converter|
        converter.start()
      end

      result={
        "pages": pages
      }

      puts result.to_json

    end

    def initialize(path)
      @ipynb_path=File.expand_path(path)
      @sb_json=[]
      @display_input_numbers=false
      @prefix_comment="#"
    end

    def vp(s)
      p(s) if @@verbose
    end

    def vprint(s)
      print(s) if @@verbose
    end

    def vputs(s)
      puts(s) if @@verbose
    end

    def push_empty_text()
      @sb_json << ""
    end

    def push_text(s)
      s.split("\n").each do |s1|
        @sb_json << s1
      end
    end

    def push_texts(ww)
      ww.each do |s|
        push_text(s)
      end
    end

    def push_markdown_text(s)
      s.split("\n").each do |s1|
        if @@parse_markdown_notations
          s1.sub!(%r!^\$\$(.+)\$\$!, '[$\1 ]' ) || s1.gsub!(%r!\$(.+)\$!, '[$\1 ]' )
        end
        @sb_json << s1
      end
    end

    def push_markdown_texts(ww)
      ww.each do |s|
        push_markdown_text(s)
      end
    end

    def parse_cell_markdown(md)
      vputs "-- source"
      vputs md["source"]
      push_markdown_texts(md["source"])
    end

    def push_code(s)
      s.split("\n").each do |s1|
        @sb_json << "\t"+s1
      end
    end

    def push_codes(ww)
      ww.each do |s|
        push_code(s)
      end
    end

    def parse_cell_code(code)
      vputs "-- source"
      vputs code["source"]
      push_text("code:source.jl")
      if @display_input_numbers
        count=code["execution_count"]
        push_code("#{@prefix_comment} In[#{count}]")
      end
      push_codes(code["source"])
      push_empty_text()

      # p w
      vputs "-- outputs"
      if code["outputs"]
        (code["outputs"]).each_with_index do |oo,oo_c|
          vprint "-- outputs #{oo_c} "
          vp oo.keys
          vprint "-- outputs #{oo_c} output_type="+oo["output_type"]+"\n"
          if    oo["evalue"]
            push_text("code:error.txt")
            push_code(oo["evalue"])
            push_empty_text()
          elsif oo["data"]
            out_data_c=1
            oo["data"].each_pair do |out_data_k,out_data_v|
              vputs "-- outputs #{out_data_c} inner data => #{out_data_k}"
              case out_data_k
              when "image/png"
                vputs out_data_v
                push_text("code:output.txt")
                push_code("image/png")
                push_empty_text()
              when "text/plain"
                vputs out_data_v
                push_text("code:output.txt")
                push_codes(out_data_v)
                push_empty_text()
              else
                raise "data unknown"
              end
              out_data_c += 1
            end
          end
        end
      end
    end

    def parse_cells(cells)
      cells.each_with_index do |cell,cell_count|
        vprint "cell #{cell_count} "
        vprint "-- cell_type="+cell["cell_type"]+"\n"
        case cell["cell_type"]
        when "markdown"
          parse_cell_markdown(cell)
        when "code"
          parse_cell_code(cell)
        else
          raise "Unknown cell_type"
        end
      end
    end

    def parse_ipynb()
      texts=File.read(@ipynb_path)
      # vputs texts
      js=JSON.parse(texts)
      vp js.length
      @file_extension=js["metadata"]["language_info"]["file_extension"]
      vp @file_extension

      if %r!\.(jl|py|rb)!i =~ @file_extension
        @display_input_numbers=true
        @prefix_comment="#"
      end

      vputs "----- -----"
      # p js
      parse_cells(js["cells"])
    end

    def start()
      parse_ipynb()

      my_title=File.basename(@ipynb_path,".ipynb")

      page= {
        "title": my_title,
        "lines": @sb_json.unshift(my_title)
      }
      return page
    end

  end
end
