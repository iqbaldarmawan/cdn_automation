Given(/I have successfully navigated to the car next door searchpage/) do
  @search_page = SearchPage.new
  @search_page.load
  @search_page.verify_search_page
end

When(/^I search location "([^"]*)"$/) do |location|
  @search_page.search_location location
end

And(/^I select month "([^"]*) from date "([^"]*) to "([^"]*)"$/) do |month,pickup_date,return_date|
  @search_page.select_month
  find(:xpath, "//*[contains(text(),'#{month}')]").click
  find(:xpath, "(//*[@data-full='2022-12-#{pickup_date}']//*[contains(@class, 'mbsc-cal-day-date mbsc-cal-cell-txt')])[2]").click
  find(:xpath, "(//*[@data-full='2022-12-#{return_date}']//*[contains(@class, 'mbsc-cal-day-date mbsc-cal-cell-txt')])[2]").click
end

And(/I set times for pickup and return/) do
  @search_page.select_hours_pickup
  @search_page.select_minutes_pickup
  @search_page.select_hours_return
  @search_page.select_minutes_return
  @search_page.click_set_times_button
end

Then(/I see the result vehicle on map match with the list/) do
  @search_page.verify_result_vehicle
end

When(/I open detail vehicle/) do
  @search_page.open_detail_vehicle
end

Then(/I am on detail page vehicle/) do
  @search_page.verify_detail_page_vehicle
end
