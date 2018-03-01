### hw_1_question


########################################################### Task 1

# 查看內建資料集: 鳶尾花(iris)資料集
iris

# 使用dim(), 回傳iris的列數與欄數
dim(iris)

# 使用head() 回傳iris的前六列
head(iris)

# 使用tail() 回傳iris的後六列
tail(iris)

# 使用str() 
str(iris)

# 使用summary() 查看iris敘述性統計、類別型資料概述。
summary(iris)

########################################################### Task 2

# 使用for loop 印出九九乘法表
# Ex: (1x1=1 1x2=2...1x9=9 ~ 9x1=9 9x2=18... 9x9=81)

for(i in 1:9){
  for(j in 1:9){
    print(paste(i,"x", j,"=", format(i*j, width = 2)))
  }
}
########################################################### Task 3

# 使用sample(), 產出10個介於10~100的整數，並存在變數 nums

nums = sample(x = c(10:100), size = 10)
# 查看nums

nums

# 1.使用for loop 以及 if-else，印出大於50的偶數，並提示("偶數且大於50": 數字value)
# 2.特別規則：若數字為66，則提示("太66666666666了")並中止迴圈。

for(i in 1:100){
  if(i == 66){
    print("太66666666666了")
    break
  }
  if(i %% 2 == 0 && i > 50){
    print(paste("偶數且大於50:",i))
  }
}  

########################################################### Task 4

# 請寫一段程式碼，能判斷輸入之西元年分 year 是否為閏年
print("輸入 -1 結束判斷")
while(TRUE){
  year = strtoi(readline(prompt = "請輸入西元年分: "))
  if(year %% 400 == 0 ){
    print(paste(year, "是閏年"))
  } else if(year %% 4 == 0 && year %% 100 != 0) {
    print(paste(year, "是閏年"))
  } else if(year == -1) {
    break
  } else {
    print(paste(year, "是平年"))
  }
}

########################################################### Task 5

# 猜數字遊戲
# 1. 請寫一個由電腦隨機產生不同數字的四位數(1A2B遊戲)
# 2. 玩家可重覆猜電腦所產生的數字，並提示猜測的結果(EX:1A2B)
# 3. 一旦猜對，系統可自動計算玩家猜測的次數

answer = sample(x = c(0:9), size = 4)
try_times <- 0
while(TRUE){
  number_of_A <- 0
  number_of_B <- 0
  
  raw_guess <- readline(prompt = "請輸入猜測四位數: ")
  guess <- strtoi(unlist(strsplit(raw_guess, "")))
  
  for(i in 1:4){
    for(j in 1:4){
      if(guess[i] == answer[i]){
        number_of_A <- number_of_A + 1
        break
      } else if(guess[i] == answer[j]){
        number_of_B <- number_of_B + 1
      }
    }
  }
  
  print(paste(number_of_A, "A", number_of_B, "B"))
  
  if(number_of_A == 4){
    print(paste("Congrats, you have tried", try_times+1, "times"))
    break
  } else {
    try_times <- try_times + 1
  }
}