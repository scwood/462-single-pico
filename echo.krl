ruleset echo {

  meta {
    name "echo"
    author "Spencer Wood"
    logging on
    shares hello
  }
  
  rule hello {
    select when echo hello
    send_directive("say") with
      something = "Hello World"
  }

  rule message {
    select when echo message
    pre {
      input = event:attr("input")
    }
    send_directive("say") with
      something = input
  }

}
