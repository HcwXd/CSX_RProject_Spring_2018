## R_Week_2_Notes

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

  - ```R
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

  - ```R
    titles <- page.source %>% html_nodes('.pcontent .title') %>% html_text(trim=TRUE)
    ```

- Get links

  - ```R
    name <- page %>% html_nodes(".biz-name") %>% html_attr('href')
    ```





