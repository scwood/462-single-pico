ruleset echo {

  meta {
    name "Echo"
    author "Spencer Wood"
    logging on
    shares hello
  }
  
  rule hello {
    select when echo hello
    send_directive("say") with
      something = "Hello World"
  }

}
