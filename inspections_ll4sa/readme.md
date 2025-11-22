错误的分析结果用-incorrect标记



经过考察，LLM4SA不具有检测相反数据流的Double Free能力，例如
1 T
file: file-check/src/buffer.c
line: 90
file: file-check/src/buffer.c
line: 81
2 F
file: file-check/src/buffer.c
line: 81
file: file-check/src/buffer.c
line: 90
LLM4SA对于两个告警的输出一致，因此结果文件中不再包含相反数据流的LLM4SA输出结果，默认所有相反数据流的测试都是错误的



有两个因单一函数多次调用导致的的Double Free告警测试：

3 F

file: file-check/src/buffer.c

line: 81

file: file-check/src/buffer.c

line: 81

00:01:29



4 F

file: file-check/src/buffer.c

line: 90

file: file-check/src/buffer.c

line: 90

00:04:21

结果在special文件夹中，显然分析结果都是错误的

