def tests(b, info, screenshot)

  puts " "
  puts feature("Registration")
  puts action("\t I'm going to visit the homepage...")

  b.goto "http://#{info[:url]}"
  b.screenshot.save screenshot + "homepage.png"

  puts attempt("\t I'm going to try to register...")

  if b.text.include? "Sign"
    b.link(:href => /.*users\/sign_up/).click
    b.h1(:text => /Registration/).when_present { b.screenshot.save screenshot + "registration.png" }
    ## embed to an html report based on types of tests, sections, etc...
    # embed screenshot, 'image/png'
    # ....
    puts attempt_success("\t\t ... finished registering! :) ")
  else
    puts attempt_fail("\t\t ...I can't find the link to register! :( ")
  end

  puts " "

end