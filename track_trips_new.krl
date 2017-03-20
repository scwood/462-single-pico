ruleset track_trips_new {

  meta {
    name "track_trips_new"
    author "Spencer Wood"
    logging on
    shares process_trip_new
  }

  global {
    long_trip = 40
  }

  rule process_trip_new {
    select when car new_trip
    pre {
      mileage = event:attr("mileage")
    }
    fired {
      "IT WORKED".klog("TEST: ");
      raise explicit event "trip_processed"
        with mileage = event:attr("mileage")
    }
  }

  rule find_long_trips {
    select when explicit trip_processed
    pre {
      mileage = event:attr("mileage")
    }
  }

}
