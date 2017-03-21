ruleset trip_store {

  meta {
    name "track_trips_new"
    author "Spencer Wood"
    logging on
    provides trips, long_trips, short_trips
    shares trips, long_trips, short_trips
  }

  global {
    empty_hash = {}
    trips = function () {
      ent:trips.map(function (timestamp, mileage) {
        {"timestamp": timestamp, "mileage": mileage}
      })
    }

    long_trips = function () {
      ent:long_trips
    } 
    short_trips = function () {
      ent:trips.filter(function (timestamp, mileage) {
        ent:long_trips{timestamp} != ent:trips{time}
      })
    }
  }

  rule collect_trips {
    select when explicit trip_processed
    pre {
      mileage = event:attr("mileage")
      timestamp = event:attr("timestamp")
    }
    always {
      ent:trips := ent:trips.defaultsTo(empty_hash, "initializing");
      ent:trips{[timestamp]} := mileage
    }
  }

  rule collect_long_trips {
    select when explicit found_long_trip
    always {
      ent:long_trips := ent:long_trips.defaultsTo(empty_array, "initializing")
    }
  }

  rule clear_trips {
    select when explicit trip_reset
    fired {
      ent:trips := empty_hash
    }
  }

}
