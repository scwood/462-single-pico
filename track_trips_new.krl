ruleset track_trips_new {

  meta {
    name "track_trips_new"
    author "Spencer Wood"
    logging on
    shares process_trip_new, find_long_trips, process_found_long_trip
  }

  global {
    long_trip = 40
  }

  rule process_trip_new {
    select when car new_trip
    fired {
      raise explicit event "trip_processed"
        with mileage = event:attr("mileage")
    }
  }

  rule find_long_trips {
    select when explicit trip_processed
    pre {
      mileage = event:attr("mileage").as("Number")
    }
    fired {
      raise explicit event "found_long_trip"
        with mileage = event:attr("mileage").as("Number")
      if (mileage > long_trip)
    }
  }

  rule process_found_long_trip {
    select when explicit found_long_trip
  }

}
