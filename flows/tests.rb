def tests(b, info, screenshot)

  puts " "
  puts feature("\tRegistration")

  b.goto "http://#{info[:url]}"
  b.screenshot.save screenshot + "homepage.png"

  puts attempt("\t\t I'm going to try to register...")

  if b.text.include? "Sign"
    b.link(:href => /.*users\/sign_up/).click
    b.h1(:text => /Registration/).when_present { b.screenshot.save screenshot + "registration.png" }
    ## embed to an html report based on types of tests, sections, etc...
    # embed screenshot, 'image/png'
    # ....
    puts attempt_success("\t\t\t ... finished registering! :) ")
  else
    puts attempt_fail("\t\t\t ...I can't find the link to register! :( ")
  end

  puts " "

end