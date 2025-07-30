require "katex"

module Jekyll
  Jekyll::Hooks.register :documents, :post_render do |doc|
    # only run on HTML output
    next unless doc.output_ext == ".html"

    html = doc.output

    # Render $$ … $$ blocks
    html.gsub!(/\$\$\s*(.+?)\s*\$\$/m) do
      Katex.render($1, display_mode: true)
    end

    doc.output = html
  end
end
