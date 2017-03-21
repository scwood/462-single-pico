ruleset trip_store {

  meta {
    name "track_trips_new"
    author "Spencer Wood"
    logging on
    shares process_trip_new
    provides trips, long_trips, short_trips
    shares trips, long_trips, short_trips
  }

/*   global { */
/*     trips = function () { */
/*       ent:trips */
/*     } */

/*     long_trips = function () { */
/*       ent:long_trips */
/*     } */ 
/*     short_trips = function () { */
/*       ent:trips.filter(function (timestamp, mileage) { */
/*         ent:long_trips{timestamp} != ent:trips{time} */
/*       }) */
/*     } */
/*   } */

  rule collect_trips {
    select when explicit trip_processed
    pre {
      mileage = event:attr("mileage")
      timestamp = event:attr("time")
    }
    fired {
      ent:trips := 4
    }
  }

  rule collect_long_trips {
    select when explicit found_long_trip
    always {
      /* set ent:long_trips{event:attr{"timestamp"}} event:attr{"mileage"}; */
    }
  }

  rule clear_trips {
    select when explicit trip_reset
  }

}
