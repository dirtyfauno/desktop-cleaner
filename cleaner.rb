#! /usr/bin/env ruby
all_files = `ls`.split(/$/).map(&:strip)

all_extensions = all_files.map do |f|
  File.extname(f).delete('.')
end

def get_unique_extensions all_extensions
  extensions = []

  until all_extensions.length <= 0
    last_extension = all_extensions.pop
    extensions.push last_extension

    all_extensions = all_extensions.select do |f|
      f != last_extension
    end
  end
  extensions = extensions.select(& lambda { |x| !x.empty? })
  puts extensions.inspect
  extensions
end

unique_extensions = get_unique_extensions all_extensions

unique_extensions.each(& lambda { |x| `mkdir #{x}` })
unique_extensions.each(& lambda { |x| `mv *.#{x} #{x}/` })

