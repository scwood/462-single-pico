ruleset trip_store {

  meta {
    name "track_trips_new"
    author "Spencer Wood"
    logging on
    shares process_trip_new
  }

  global {
    trips = function () {
      ent:trips
    }

    long_trips = function () {
      ent:long_trips
    }

    short_trips = function () {
      ent:trips.filter(function (time, mileage) {
        ent:long_trips{time} != ent:trips{time}
      })
    }
  }

  rule collect_trips {
    select when explicit trip_processed
  }

  rule collect_long_trips {
    select when explicit found_long_trip
  }

  rule clear_trips {
    select when explicit trip_reset
  }

}
