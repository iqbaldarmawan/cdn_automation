After do |scenario|

  if scenario.failed?
    screenshot_file = "output/screenshots/#{sanitize_filename(scenario.name)}.jpg"
    Capybara.save_screenshot(screenshot_file)
    base64_img = Base64.encode64(File.open(screenshot_file, 'r:UTF-8', &:read))
    embed(base64_img, 'image/png;base64')
    puts "Screenshot saved to #{screenshot_file}"
  end
end

def sanitize_filename(filename)
  filename.gsub!(/^.*(\\|\/)/, '')
  filename.gsub!(/[^0-9A-Za-z.\-]/, '_')
  filename.gsub!(' ', '_')
  filename[0..200]
end