module ReadingTimeFilter
  include Liquid::StandardFilters

  def reading_time(input)
    # Get words count.
    total_words = get_plain_text(input).split.size

    # Load configuration.
    config = @context.registers[:site].config["reading_time"]

    # Average reading words per minute.
    words_per_minute = 150

    # Calculate reading time.
    minutes = ( total_words.to_f / words_per_minute ).ceil

    return "#{minutes}";
  end

  def get_plain_text(input)
    strip_html(strip_pre_tags(input))
  end

  def strip_pre_tags(input)
    empty = ''.freeze
    input.to_s.gsub(/<pre(?:(?!<\/pre).|\s)*<\/pre>/mi, empty)
  end
end

Liquid::Template.register_filter(ReadingTimeFilter)
