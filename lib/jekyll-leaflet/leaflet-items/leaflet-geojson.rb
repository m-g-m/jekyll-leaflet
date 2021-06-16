require "securerandom"

module Jekyll
    class LeafletGeoJSON < Liquid::Tag

        def initialize(tag_name, input, tokens)
            super
            if input.empty?
                @input = '{}'
            else
	        args=input.split(",",2) # everything after comma is expected to be a style string, add more later ?
                @input = args[0]
                if (args.size()>1) 
                  @stylestr = ",style:"+args[1]
                else
                  @stylestr = ""
                end
            end
        end

        def render(context)
            value = parse_liquid_output_in(@input, context)
            '{id: "' + SecureRandom.hex + '",
              type: "LeafletGeoJSON",
              value: ' + value + @stylestr + '},'
        end
    end
end

Liquid::Template.register_tag('leaflet_geojson', Jekyll::LeafletGeoJSON)
