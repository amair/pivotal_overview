module XmlSpecHelper
def load_xml_fixture_file(name)
  path = Rails.root.join("spec","fixtures","#{name}.xml")
  if File.exists?(path)
   contents = ""
   File.open(path).each do |line|
     contents << line
   end
   contents
  else
   nil
  end
end


def help
  :available
end

end