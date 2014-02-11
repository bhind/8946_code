require 'rubygems'
require 'origami'
include Origami

fname = "take36.pdf"
puts "filename: #{fname}"
pdf = PDF.read(fname, :verbosity => Parser::VERBOSE_QUIET)


# extract javascript part
objects = pdf.objects()
# << /S /JavaScript ... >>となっているDictionaryを抽出
js = objects.find_all{|obj| obj.is_a?(Dictionary) and obj[:S] == :JavaScript }
puts "num of js: #{js.size}"

# javascriptのコンテンツを出力する
js.each do |obj|
  puts "-" * 30
  # objがRefであれば、それを解決する
  entity = (obj[:JS].is_a?(Reference) ? obj[:JS].solve() : obj[:JS])

  # entityがStreamであれば、decodeを実施する
  script = entity.is_a?(Stream) ? entity.decode!.data : entity

  puts script
end
