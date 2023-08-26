rps_game <- function(){
  print("H for Hammer 🔨")
  print("S for Scissors ✂️ ")
  print(" P for Paper 📄")
  options <- c("H","S","P")
  player_score <- 0
  bot_score <- 0
  
  while(TRUE){
    player_select <- readline("Player choose: ")
    if (player_select == "exit"){
      print(paste("Player score :",player_score
                  ,"Bot score :",bot_score))
      if (player_score > bot_score){
          print("Player WIN !!")
      } else if (player_score < bot_score){
          print("Bot WIN !!")
      } else {
          print("TIE")
      }
      break
    }
    bot_select <- sample(options,1)
    print(paste("bot Choose :",bot_select))
    
    if ((player_select == "H")&(bot_select == "S")){
      player_score <- player_score +1
      print("Player WIN")
    } else if ((player_select == "S")&(bot_select == "P")){
      player_score <- player_score +1
      print("Player WIN")
    } else if ((player_select == "P")&(bot_select == "H")){
      player_score <- player_score +1
      print("Player WIN")
    } else if ((player_select == bot_select)){
      print("TIE")
    } else {
      bot_score <- bot_score+1
      print("BOT WIN !! YOU NOOB")
    }
  }
}










play_game <- function(){
  user_score <- 0
  computer_score <- 0
  options <- c("hammer","scissor","paper")
  print(options)
  print("Choose one!")
  
  while (T){
    user_select <- readline("Choose one : ")
    if (user_select == "exit"){
      print(paste("User score :",user_score,
                  "AI score : ",computer_score))
      if(user_score>computer_score){
        print("USER WIN THE GAME")
      } else if(user_score < computer_score){
        print("AI WIN THE GAME")
      } else {
        print("TIE")
      }
      break
    }
    computer_select <- sample(options,1)
    print(paste("AI Choose :",computer_select))
    
    if ((user_select == "hammer")&(computer_select =="scissor")){
      user_score <- user_score +1
      print("USER WIN")
    } else if ((user_select == "scissor")&(computer_select=="paper")){
      user_score <- user_score +1
      print("USER WIN")
    } else if ((user_select == "paper")&(computer_select=="hammer")){
      user_score <- user_score +1
      print("USER WIN")
    } else if (( user_select == computer_select )){
      print("Tie")
    } else {
      computer_score<- computer_score+1
      print("AI WIN")
    }
  }
}

play_game()