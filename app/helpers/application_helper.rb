module ApplicationHelper
  def full_title page_title
    base_title = "LiquickCleany"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def address_decode city_code, district_code
    begin
      districts = JSON.parse(File.read(Rails.root.join('db/quan-huyen/' + city_code + '.json')))
      districts.each do |district|
        if district[0].to_i == district_code.to_i
          return district[1]['name_with_type']
        end  
      end
    rescue StandardError => e
      return "#no_address"
    end
  end
end
