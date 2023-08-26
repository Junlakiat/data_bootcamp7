saybot <- function(){
  print("Hello i am saybot")
  
  name = readline("What you name ?")
  print(paste("nice to meet you",name))
  
  hobby = readline("What is you hobby ?")
  print(paste(hobby,"interesting"))
  
  readline(paste("Tell me more about your",hobby,"."))
  
  drink = readline("Which beer type do you chose ?")
  print(paste("Great choose that you",drink))
  
  readline("OH! midnight can i have you number ?")
  print(paste("thank you, i wiil text see you next time",name))
}



chatbot <- function(){
  print("let to say HI")
  print("you can 'exit' to done")
  
  while (TRUE){
    name = readline("Hello i'm BOTMATIC, What you name ?")
    if (name == "exit"){
      print("Bye have a good day STANGER.")
      break
    } else {
      print(paste("Hello",name))
      
      hobby = readline("What is you hobby ?")
      print(paste(hobby,"interesting"))
      
      readline(paste("Tell me more about your",hobby,"."))
      
      drink = readline("Which beer type do you chose ?")
      print(paste("Great choose that you",drink))
      
      readline("OH! midnight can i have you number ?")
      print(paste("thank you, i wiil text see you next time",name))
      break
    }
  }
}