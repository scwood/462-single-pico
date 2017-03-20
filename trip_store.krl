ruleset trip_store {

  meta {
    name "track_trips_new"
    author "Spencer Wood"
    logging on
    shares process_trip_new
  }

  global {
    all_trips = []
    long_trips = []
  }

  rule collect_trips {
    select when explicit trip_processed
  }

  rule collect_long_trips {
  }

  rule clear_trips {
  }

}
