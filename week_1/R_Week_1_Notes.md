## R_Week_1_Notes

### R Properties

- Vector index start with 1, not 0

###Generate vector contains boolean to make filter for dataframe

```R
# Create a vector csg.over.80, with the logical result of course.student.grade over 80
csg.over.80 <- course.student.grade >= 80
# Print over 80 details
print(paste("高於80分總人數：", length(course.student.grade[csg.over.80])))
print(paste("高於80分座號：", names(course.student.grade[csg.over.80])))
```

### Sorted dataframe by one row/column

```R
days.position <- order(person.df$person.days)
person.df[days.position, ]
```

### Print format

```R
print(paste(i,"x", j,"=", format(i*j, width = 2))
```

### Others

- Convert string to int: `strtoi()`
- Read from user input: `readline(prompt = "message")`
- Spilt String: `strsplit(source, "pattern")`
  - Notes: `strsplit()` returns a list type
- Turn list into vector: `unlist()`

