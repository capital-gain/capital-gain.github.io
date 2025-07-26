#!/usr/bin/env ruby

Dir.glob('_posts/*.html').each do |file|
  content = File.read(file)
  original_content = content.dup

  # Разделяем front matter и содержимое
  if content =~ /\A(---\s*\n.*?\n?)^(---\s*$\n?)(.*)/m
    front_matter = $1 + $2
    body_content = $3

    # Сохраняем URL и заменяем их плейсхолдерами
    urls = []
    placeholder_counter = 0

    # Защищаем href и src атрибуты уникальными плейсхолдерами
    body_content.gsub!(/(href|src)=["']([^"']+)["']/) do
      attr = $1
      url = $2
      urls << url
      placeholder = "#{attr}=\"___URLSAFE#{placeholder_counter}SAFE___\""
      placeholder_counter += 1
      placeholder
    end

    # Дефисы на em dash (тире), но НЕ в HTML комментариях
    body_content.gsub!(/ - /, ' — ')
    body_content.gsub!(/(?<!<!)--(?!>)/, '—')

    # En dash для диапазонов годов и чисел
    body_content.gsub!(/(\d{4})-(\d{4})/, '\1–\2')
    body_content.gsub!(/(\d+)-(\d+)/, '\1–\2')

    # Многоточие
    body_content.gsub!(/\.{3}/, '…')

    # Простые кавычки "текст" → «текст»
    body_content.gsub!(/(\s|^|>)"([^"]+)"(\s|[.,:;!?\n]|<|$)/, '\1«\2»\3')

    # Возвращаем URL обратно
    urls.each_with_index do |url, index|
      body_content.gsub!("___URLSAFE#{index}SAFE___", url)
    end

    new_content = front_matter + body_content

    if new_content != original_content
      File.write(file, new_content)
      puts "Updated: #{file}"
    end
  else
    puts "Warning: Could not parse front matter in #{file}"
  end
end
