; ModuleID = 'mytest.c'
source_filename = "mytest.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx14.0.0"

@.str = private unnamed_addr constant [8 x i8] c"In foo\0A\00", align 1, !dbg !0
@.str.1 = private unnamed_addr constant [7 x i8] c"Start\0A\00", align 1, !dbg !7
@.str.2 = private unnamed_addr constant [5 x i8] c"End\0A\00", align 1, !dbg !12

; Function Attrs: noinline nounwind ssp uwtable(sync)
define void @foo() #0 !dbg !27 {
  %1 = call i32 (ptr, ...) @printf(ptr noundef @.str), !dbg !31
  ret void, !dbg !32
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define i32 @main() #0 !dbg !33 {
  %1 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %2 = call i32 (ptr, ...) @printf(ptr noundef @.str.1), !dbg !37
  call void @foo(), !dbg !38
  %3 = call i32 (ptr, ...) @printf(ptr noundef @.str.2), !dbg !39
  ret i32 0, !dbg !40
}

attributes #0 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!17, !18, !19, !20, !21, !22, !23}
!llvm.dbg.cu = !{!24}
!llvm.ident = !{!26}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 3, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "mytest.c", directory: "/Users/jiayi/TASA/benchmarks/tmux")
!3 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 64, elements: !5)
!4 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!5 = !{!6}
!6 = !DISubrange(count: 8)
!7 = !DIGlobalVariableExpression(var: !8, expr: !DIExpression())
!8 = distinct !DIGlobalVariable(scope: null, file: !2, line: 6, type: !9, isLocal: true, isDefinition: true)
!9 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 56, elements: !10)
!10 = !{!11}
!11 = !DISubrange(count: 7)
!12 = !DIGlobalVariableExpression(var: !13, expr: !DIExpression())
!13 = distinct !DIGlobalVariable(scope: null, file: !2, line: 8, type: !14, isLocal: true, isDefinition: true)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 40, elements: !15)
!15 = !{!16}
!16 = !DISubrange(count: 5)
!17 = !{i32 2, !"SDK Version", [2 x i32] [i32 14, i32 5]}
!18 = !{i32 7, !"Dwarf Version", i32 4}
!19 = !{i32 2, !"Debug Info Version", i32 3}
!20 = !{i32 1, !"wchar_size", i32 4}
!21 = !{i32 8, !"PIC Level", i32 2}
!22 = !{i32 7, !"uwtable", i32 1}
!23 = !{i32 7, !"frame-pointer", i32 1}
!24 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "Homebrew clang version 16.0.6", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, globals: !25, splitDebugInlining: false, nameTableKind: None, sysroot: "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX14.5.sdk", sdk: "MacOSX14.5.sdk")
!25 = !{!0, !7, !12}
!26 = !{!"Homebrew clang version 16.0.6"}
!27 = distinct !DISubprogram(name: "foo", scope: !2, file: !2, line: 3, type: !28, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !24, retainedNodes: !30)
!28 = !DISubroutineType(types: !29)
!29 = !{null}
!30 = !{}
!31 = !DILocation(line: 3, column: 14, scope: !27)
!32 = !DILocation(line: 3, column: 34, scope: !27)
!33 = distinct !DISubprogram(name: "main", scope: !2, file: !2, line: 5, type: !34, scopeLine: 5, spFlags: DISPFlagDefinition, unit: !24, retainedNodes: !30)
!34 = !DISubroutineType(types: !35)
!35 = !{!36}
!36 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!37 = !DILocation(line: 6, column: 5, scope: !33)
!38 = !DILocation(line: 7, column: 5, scope: !33)
!39 = !DILocation(line: 8, column: 5, scope: !33)
!40 = !DILocation(line: 9, column: 5, scope: !33)
