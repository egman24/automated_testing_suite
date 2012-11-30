def tests(b, info, screenshot)
  puts "I'm going to visit the homepage..."

  b.goto "http://#{info[:url]}"
  b.screenshot.save screenshot + "homepage.png"

  puts "I'm going to try to register..."

  if b.text.include? "Sign"
    b.link(:href => /.*users\/sign_up/).click
    b.h1(:text => /Registration/).when_present { b.screenshot.save screenshot + "registration.png" }
    ## embed to an html report based on types of tests, sections, etc...
    # embed screenshot, 'image/png'
  else
    puts "...I can't find the link to register!"
  end

  puts " "
end