require "watir"
Watir.driver = :webdriver
browser = Watir::Browser.new

3.times { |i|
browser.goto 'http://google.com'
browser.text_field(:name => 'q').set "#{i}07"
browser.button(:name => 'btnG').click
picture = browser.url + "@" + Time.now.to_s.gsub(" ","")
puts "#{picture}"
browser.div(:id => "resultStats").when_present { browser.screenshot.save "#{i}.png" }
}
browser.close


## use erb? -- <% instance_name %> = Watir::Browser.new

instance_name = []
instance_url = ['http://cardiovillage.com', 'http://prenatalnutritiontraining.com', 'http://learn.montpelier.org', 'http://onlinehsfc.org', 'http://uvagrandrounds.com']

montpelier = Watir::Browser.new
montpelier.goto 'http://learn.montpelier.org'
montpelier.link(:href => 'https://learn.montpelier.org/users/sign_up').click

hsfc = Watir::Browser.new
hsfc.goto 'http://onlinehsfc.org'
hsfc.link(:href => 'https://onlinehsfc.org/users/sign_up').click

grounds = Watir::Browser.new
grounds.goto 'http://uvagrandrounds.com'
grounds.link(:href => 'https://uvagrandrounds.com/users/sign_up').click

# Registration Tests

# PDF Integrity Tests

# Javascript Heavy Location Tests

##
## How can we drive the flash elements in the captivate courses?
##

##
## Nightly automated test sweeps, all screenshots posted to timeline of growth for human eyes and backed up in zipfiles
##
