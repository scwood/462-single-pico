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
    send_directive("trip") with
      trip_length = mileage
  }

}
