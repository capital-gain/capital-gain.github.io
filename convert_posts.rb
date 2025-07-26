#!/usr/bin/env ruby
require 'nokogiri'
require 'reverse_markdown'
require 'fileutils'

Dir.glob('_posts/*.html').each do |file|
  content = File.read(file)

  # Извлекаем YAML front matter
  if content =~ /\A(---\s*\n.*?\n?)^(---\s*$\n?)/m
    front_matter = $1 + $2
    html_content = content.sub(/\A---.*?---\n?/m, '')

    # Конвертируем HTML в Markdown
    markdown_content = ReverseMarkdown.convert(html_content)

    # Создаем новый файл
    new_filename = file.sub('.html', '.md')
    new_content = front_matter + markdown_content

    File.write(new_filename, new_content)
    puts "Converted #{file} to #{new_filename}"

    # Удаляем оригинальный HTML файл
    File.delete(file)
    puts "Deleted #{file}"
  else
    puts "Warning: Could not parse front matter in #{file}"
  end
end

puts "Conversion complete!"
