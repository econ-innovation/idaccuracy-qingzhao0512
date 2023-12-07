
# 使用R中的数据读写，文件路径，for循环语句，读入路径“/assignment_idaccuracy/Aminer”总的所有文件，并将数据合并成为一个data.frame输出。要求data.frame中至少要包括论文的doi号，发表年份，杂志，标题；

getwd()    # 查看当前工作路径
mypath = "~/assignment_idaccuracy/Aminer" 
setwd(mypath)   # 设定当前工作路径


file_list <- dir(mypath, full.names = TRUE, all.files = TRUE)    # 获取目录下所有文件，包含隐藏文件


merged_data <- data.frame()        # 初始化一个空的数据框
# 使用for循环读取并合并数据，假设是CSV格式，假设是按照行合并
for (file_path in file_list) {
  current_data <- read.csv(file_path, header = TRUE)
  merged_data <- rbind(merged_data, current_data)
}
print(merged_data)       # 输出合并后的数据框






# 使用apply家族函数替代上述步骤中的for循环
## 使用lapply读取文件并返回数据框的列表
data_list <- lapply(file_list, function(file_path) {
  read.csv(file_path, header = TRUE)
})
## 使用do.call和cbind将数据框列表合并为一个数据框（列合并）
merged_data <- do.call(cbind, data_list)





# 将2中代码封装成为一个可以在命令行运行的脚本，脚本的唯一一个参数为aminer论文文件所在的路径


首先新建一个merge_files.R的脚本，然后在脚本里输入：

#!/usr/bin/env Rscript

setwd(~/assignment_idaccuracy/Aminer)   # 设定当前工作路径
mypath <- commandArgs(trailingOnly = TRUE)
file_list <- dir(mypath, full.names = TRUE, all.files = TRUE)   
data_list <- lapply(file_list, function(file_path) {
  read.csv(file_path, header = TRUE)
})

merged_data <- do.call(cbind, data_list)
print(merged_data)

接着返回命令行，输入Rscript merge_files.R ~/assignment_idaccuracy/Aminer)就好


