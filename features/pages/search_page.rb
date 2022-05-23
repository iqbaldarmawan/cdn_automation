class SearchPage < SitePrism::Page
  set_url "https://www.carnextdoor.com.au/search"

  element :vehicle_map,".cnd-vehicle-map__container"
  element :search_location_text_field,".cyp-search-autocomplete"
  element :first_suggestion_text,:xpath,"(//*[contains(@class, 'suggestions')])[1]//li[@class=' active']"
  element :add_dates_filter_button,".cyp-datetime-picker-modal"
  element :pickup_and_return_calender_modal_text,:xpath,"//*[contains(text(),'Pickup & return')]"
  element :calender_month_text,".mbsc-cal-month"

  element :calender_pickup_selected_hours,:xpath,:"(//div[@class='search-start-time']//*[contains(@data-val, '14')])[2]"
  element :calender_pickup_next_hours,:xpath,:"//div[@class='search-start-time']//div[@class='mbsc-sc-whl-w mbsc-dt-whl-h mbsc-comp']//div[43]"
  element :calender_pickup_minutes,:xpath,:"//div[@class='search-start-time']//div[@class='mbsc-sc-whl-w mbsc-dt-whl-i mbsc-comp']//div[.='00']"
  element :calender_pickup_before_minutes,:xpath,:"//div[@class='search-start-time']//div[@class='mbsc-sc-whl-w mbsc-dt-whl-i mbsc-comp']//div[.='15']"

  element :calender_return_selected_hours,:xpath,"(//div[@class='search-end-time']//*[contains(@data-val, '15')])[2]"
  element :calender_return_next_hours,:xpath,:"//div[@class='search-end-time']//div[@class='mbsc-sc-whl-w mbsc-dt-whl-h mbsc-comp']//div[43]"
  element :calender_return_minutes,:xpath,:"//div[@class='search-end-time']//div[@class='mbsc-sc-whl-w mbsc-dt-whl-i mbsc-comp']//div[.='00']"
  element :calender_return_before_minutes,:xpath,:"//div[@class='search-end-time']//div[@class='mbsc-sc-whl-w mbsc-dt-whl-i mbsc-comp']//div[.='15']"

  element :calender_set_time_button,:xpath,"//button[@name='search']"

  element :first_vehicle_marker,:xpath,'//div[@class="mapboxgl-canvas-container mapboxgl-interactive mapboxgl-touch-drag-pan mapboxgl-touch-zoom-rotate"]/div[2]'
  element :first_vehicle_marker_detail,:xpath,'//*[@id="vehicle-search-container"]/div[6]/div/div[4]/div[2]/a/cnd-vehicle-card'

  element :first_vehicle_list_detail,:xpath,"//div[@class='cnd-row md:cnd--mx-2 cnd-mt-4']/div[1]//cnd-vehicle-card[@class='cnd-text-black cnd-border-b cnd-border-grey cnd-pb-4 cnd-mb-8 hydrated']"
  element :detail_page_information_vehicle,:xpath,"//div[@class='cnd-panel cnd-hidden lg:cnd-block']//div[@class='cnd-pr-4']"


  def verify_search_page
    wait_until_vehicle_map_visible
    wait_until_search_location_text_field_visible
  end

  def search_location(location)
    search_location_text_field.set location
    wait_until_first_suggestion_text_visible
    first_suggestion_text.click
    wait_until_vehicle_map_visible
  end

  def select_month ()
    add_dates_filter_button.click
    wait_until_pickup_and_return_calender_modal_text_visible
    wait_until_calender_month_text_visible
    calender_month_text.click
  end

  def select_hours_pickup ()
    while has_calender_pickup_selected_hours?(visible: false)
    calender_pickup_next_hours.click
    pickup_and_return_calender_modal_text.click
    if has_calender_pickup_selected_hours?(visible: true )
      calender_pickup_selected_hours.click
      @hours_pickup = calender_pickup_selected_hours.text
      puts @hours_pickup
      break
    end
    end
  end

  def select_minutes_pickup ()
    while has_calender_pickup_minutes?(visible: false)
      calender_pickup_before_minutes.click
      pickup_and_return_calender_modal_text.click
      if has_calender_pickup_minutes?(visible: true )
        calender_pickup_minutes.click
        @minutes_pickup = calender_pickup_minutes.text
        puts @minutes_pickup
        break
      end
    end
  end


  def select_hours_return ()
    while has_calender_return_selected_hours?(visible: false)
      calender_return_next_hours.click
      pickup_and_return_calender_modal_text.click
      if has_calender_return_selected_hours?(visible: true )
        calender_return_selected_hours.click
        @hours_return = calender_return_selected_hours.text
        puts @hours_return
        break
      end
    end
  end

  def select_minutes_return ()
    while has_calender_return_minutes?(visible: false)
      calender_return_before_minutes.click
      pickup_and_return_calender_modal_text.click
      if has_calender_return_minutes?(visible: true )
        calender_return_minutes.click
        @minuts_return = calender_pickup_selected_hours.text
        puts @minuts_return
        break
      end
    end
  end

  def click_set_times_button ()
    wait_until_calender_set_time_button_visible
    calender_set_time_button.click
  end

  def scroll_page(horizontal, vertical, obj = self)
    obj.page.execute_script "window.scrollBy(#{horizontal},#{vertical})"
  end

  def scroll_down(range, obj = self)
    scroll_page(0, range, obj)
  end

  def verify_result_vehicle ()
    wait_until_vehicle_map_visible(wait: 30)
    wait_until_first_vehicle_marker_visible
    first_vehicle_marker.click
    @first_vehicle_marker_detail = first_vehicle_marker_detail.text
    puts @first_vehicle_marker_detail
    scroll_down(500)
    @first_vehicle_list_detail = first_vehicle_list_detail.text
    puts @first_vehicle_list_detail
    @first_vehicle_marker_name.should == @first_vehicle_list_name
  end

  def open_detail_vehicle ()
    first_vehicle_list_detail.click
  end

  def verify_detail_page_vehicle ()
    scroll_down(500)
    wait_until_detail_page_information_vehicle_visible
    @expected_url = "https://www.carnextdoor.com.au/trips/new?end_time_iso=2022-12-04T15:00:00&search_sydney_airport=false&start_time_iso=2022-12-02T14:00:00&vehicle_id=182303&click_source=search_list"
    current_url.should == @expected_url
  end


end