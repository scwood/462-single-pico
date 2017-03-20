ruleset hello_world {
  meta {
    name "Hello World"
    description <<
A first ruleset for the Quickstart
>>
    author "Phil Windley"
    logging on
    shares hello, __testing
  }
  
  global {
    clear_name = { "_0": { "name": { "first": "GlaDOS", "last": "" } } }

    hello = function(obj) {
      msg = "Hello " + obj;
      msg
    }

  }

  rule hello_world {
    select when echo hello
    pre{
      id = event:attr("id").defaultsTo("_0")
      first = ent:name{[id,"name","first"]}
      last = ent:name{[id,"name","last"]}
      name = first + " " + last
    }
    send_directive("say") with
      something = "Hello " + name
  }

  rule store_name {
    select when hello name
    pre{
      name = event:attr("name").klog("our passed in name: ")
    }
    send_directive("store_name") with
      name = name
    always{
      ent:name := name
    }
  }

  rule clear_names {
    select when hello clear
    always {
      ent:name := clear_name
    }
  }
}
