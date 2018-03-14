### CSX_RProject_Spring_2018

> Hi, I'm David C.W Hu, currently a National Taiwan University student with a major of finance. I love building things with code! You can find my brief resume [here](https://hcwxd.github.io/). Also, I enjoy writing articles a lot to share things! You can find my articles on Medium [here](https://medium.com/@C.W.Hu).
>
> This repo is for CSX_RProject_Spring_2018! I will have my notes about this courses here. Feel free to give me suggestion and advice :)

## Week 1

### R Properties

- Vector index start with 1, not 0

### Generate vector contains boolean to make filter for dataframe

```r
# Create a vector csg.over.80, with the logical result of course.student.grade over 80
csg.over.80 <- course.student.grade >= 80
# Print over 80 details
print(paste("高於80分總人數：", length(course.student.grade[csg.over.80])))
print(paste("高於80分座號：", names(course.student.grade[csg.over.80])))
```

### Sorted dataframe by one row/column

```r
days.position <- order(person.df$person.days)
person.df[days.position, ]
```

### Print format

```r
print(paste(i,"x", j,"=", format(i*j, width = 2))
```

### Others

- Convert string to int: `strtoi()`
- Read from user input: `readline(prompt = "message")`
- Spilt String: `strsplit(source, "pattern")`
  - Notes: `strsplit()` returns a list type
- Turn list into vector: `unlist()`

---

## Week 2

### Data Type Conversion

- `as.datatype()`
- `as.factor()`, `as.integer()`,`as.numeric()`
- ref: https://www.statmethods.net/input/datatypes.html

### Merge vector/dataframe

- `cbind(df, col1, col2)`
- `rbind(df, row1)`

### Subset()

- Deletion:
  - `df <- subset(df, select = c(-Age))`
- Filter with condtion and show selected info:
  - `subset(df, Height > 170 & ToeicGrade > 900, select = c(Name, ToeicGrade, Height))`

### Cut()

- Set interval

  - ```r
    df$ToeicLevel <- cut(x = df$ToeicGrade, 
                         breaks = c(0, 600, 700, 800, 900, Inf),
                         labels = c("E", "D", "C", "B", "A"))
    ```

### Iterate argument through function

- `mapply(func, arg1, arg2)`

### Crawler

- Table element: use `readHTMLTable()` w/  `XML`
- Other element: use `rvest` w/ `magrittr`

### readHTMLTable()

- `readHTMLTable(url)` return a list of dataframe
- To access list data, use `list[[index]]` instead of  `list[index]`

### rvest & magrittr

- use `read_html(url)` to get html data

- Get info by html class

  - ```r
    titles <- page.source %>% html_nodes('.pcontent .title') %>% html_text(trim=TRUE)
    ```

- Get links

  - ```r
    name <- page %>% html_nodes(".biz-name") %>% html_attr('href')
    ```





