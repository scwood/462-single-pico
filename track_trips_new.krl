ruleset track_trips_new {

  meta {
    name "track_trips_new"
    author "Spencer Wood"
    logging on
    shares process_trip_new
  }

  rule process_trip_new {
    select when car new_trip
    pre {
      mileage = event:attr("mileage")
    }
    fired {
      raise explicit event "trip_processed"
        with mileage = event:attr("mileage")
    }
  }

  rule find_long_trips {
    select when explicit trip_processed
    log ("HELO")
  }

}
