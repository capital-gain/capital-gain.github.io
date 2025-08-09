module HeadingAnchorsFilter
  include Liquid::StandardFilters

  def add_heading_anchors(input)
    return '' if input.nil?

    # Regex to match heading tags (h2-h6) with id attributes
    heading_regex = /<(h[2-6])\s+id="([^"]+)"([^>]*)>(.+?)<\/\1>/mi

    input.gsub(heading_regex) do |match|
      tag = $1           # h2, h3, h4, etc.
      id = $2            # id attribute value
      attributes = $3    # any other attributes
      content = $4       # heading content

      # Create anchor link with pilcrow symbol
      anchor_link = %Q{ <a href="##{id}" class="heading-anchor" aria-label="Ссылка на этот заголовок">¶</a>}

      # Return the heading with anchor link added before closing tag
      %Q{<#{tag} id="#{id}"#{attributes}>#{content}#{anchor_link}</#{tag}>}
    end
  end
end

Liquid::Template.register_filter(HeadingAnchorsFilter)
