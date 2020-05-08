; ModuleID = 'aes.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.aes256_context = type { [32 x i8], [32 x i8], [32 x i8] }

@sbox = constant [256 x i8] c"c|w{\F2ko\C50\01g+\FE\D7\ABv\CA\82\C9}\FAYG\F0\AD\D4\A2\AF\9C\A4r\C0\B7\FD\93&6?\F7\CC4\A5\E5\F1q\D81\15\04\C7#\C3\18\96\05\9A\07\12\80\E2\EB'\B2u\09\83,\1A\1BnZ\A0R;\D6\B3)\E3/\84S\D1\00\ED \FC\B1[j\CB\BE9JLX\CF\D0\EF\AA\FBCM3\85E\F9\02\7FP<\9F\A8Q\A3@\8F\92\9D8\F5\BC\B6\DA!\10\FF\F3\D2\CD\0C\13\EC_\97D\17\C4\A7~=d]\19s`\81O\DC\22*\90\88F\EE\B8\14\DE^\0B\DB\E02:\0AI\06$\5C\C2\D3\ACb\91\95\E4y\E7\C87m\8D\D5N\A9lV\F4\EAez\AE\08\BAx%.\1C\A6\B4\C6\E8\DDt\1FK\BD\8B\8Ap>\B5fH\03\F6\0Ea5W\B9\86\C1\1D\9E\E1\F8\98\11i\D9\8E\94\9B\1E\87\E9\CEU(\DF\8C\A1\89\0D\BF\E6BhA\99-\0F\B0T\BB\16", align 16

; Function Attrs: nounwind readnone uwtable
define zeroext i8 @rj_xtime(i8 zeroext %x) #0 {
  tail call void @llvm.dbg.value(metadata !{i8 %x}, i64 0, metadata !11), !dbg !84
  %1 = zext i8 %x to i32, !dbg !85
  %2 = and i32 %1, 128, !dbg !85
  %3 = icmp ne i32 %2, 0, !dbg !85
  %4 = shl nuw nsw i32 %1, 1, !dbg !85
  %5 = xor i32 %4, 27, !dbg !85
  %6 = select i1 %3, i32 %5, i32 %4, !dbg !85
  %7 = trunc i32 %6 to i8, !dbg !85
  ret i8 %7, !dbg !85
}

; Function Attrs: nounwind uwtable
define void @aes_subBytes(i8* nocapture %buf) #1 {
  tail call void @llvm.dbg.value(metadata !{i8* %buf}, i64 0, metadata !17), !dbg !86
  tail call void @llvm.dbg.value(metadata !87, i64 0, metadata !18), !dbg !88
  tail call void @llvm.dbg.value(metadata !89, i64 0, metadata !18), !dbg !90
  br label %1, !dbg !90

; <label>:1                                       ; preds = %0, %1
  %indvars.iv = phi i64 [ 15, %0 ], [ %indvars.iv.next, %1 ]
  %2 = getelementptr inbounds i8* %buf, i64 %indvars.iv, !dbg !90
  %3 = load i8* %2, align 1, !dbg !90, !tbaa !91
  %4 = zext i8 %3 to i64, !dbg !90
  %5 = getelementptr inbounds [256 x i8]* @sbox, i64 0, i64 %4, !dbg !90
  %6 = load i8* %5, align 1, !dbg !90, !tbaa !91
  store i8 %6, i8* %2, align 1, !dbg !90, !tbaa !91
  %7 = trunc i64 %indvars.iv to i8, !dbg !90
  %8 = icmp eq i8 %7, 0, !dbg !90
  %indvars.iv.next = add i64 %indvars.iv, -1, !dbg !90
  br i1 %8, label %9, label %1, !dbg !90

; <label>:9                                       ; preds = %1
  ret void, !dbg !94
}

; Function Attrs: nounwind uwtable
define void @aes_addRoundKey(i8* nocapture %buf, i8* nocapture readonly %key) #1 {
  tail call void @llvm.dbg.value(metadata !{i8* %buf}, i64 0, metadata !23), !dbg !95
  tail call void @llvm.dbg.value(metadata !{i8* %key}, i64 0, metadata !24), !dbg !95
  tail call void @llvm.dbg.value(metadata !87, i64 0, metadata !25), !dbg !96
  tail call void @llvm.dbg.value(metadata !89, i64 0, metadata !25), !dbg !97
  br label %1, !dbg !97

; <label>:1                                       ; preds = %0, %1
  %indvars.iv = phi i64 [ 15, %0 ], [ %indvars.iv.next, %1 ]
  %2 = getelementptr inbounds i8* %key, i64 %indvars.iv, !dbg !97
  %3 = load i8* %2, align 1, !dbg !97, !tbaa !91
  %4 = getelementptr inbounds i8* %buf, i64 %indvars.iv, !dbg !97
  %5 = load i8* %4, align 1, !dbg !97, !tbaa !91
  %6 = xor i8 %5, %3, !dbg !97
  store i8 %6, i8* %4, align 1, !dbg !97, !tbaa !91
  %7 = trunc i64 %indvars.iv to i8, !dbg !97
  %8 = icmp eq i8 %7, 0, !dbg !97
  %indvars.iv.next = add i64 %indvars.iv, -1, !dbg !97
  br i1 %8, label %9, label %1, !dbg !97

; <label>:9                                       ; preds = %1
  ret void, !dbg !98
}

; Function Attrs: nounwind uwtable
define void @aes_addRoundKey_cpy(i8* nocapture %buf, i8* nocapture readonly %key, i8* nocapture %cpk) #1 {
  tail call void @llvm.dbg.value(metadata !{i8* %buf}, i64 0, metadata !30), !dbg !99
  tail call void @llvm.dbg.value(metadata !{i8* %key}, i64 0, metadata !31), !dbg !99
  tail call void @llvm.dbg.value(metadata !{i8* %cpk}, i64 0, metadata !32), !dbg !99
  tail call void @llvm.dbg.value(metadata !87, i64 0, metadata !33), !dbg !100
  tail call void @llvm.dbg.value(metadata !89, i64 0, metadata !33), !dbg !101
  br label %1, !dbg !101

; <label>:1                                       ; preds = %0, %1
  %indvars.iv = phi i64 [ 15, %0 ], [ %indvars.iv.next, %1 ]
  %2 = getelementptr inbounds i8* %key, i64 %indvars.iv, !dbg !101
  %3 = load i8* %2, align 1, !dbg !101, !tbaa !91
  %4 = getelementptr inbounds i8* %cpk, i64 %indvars.iv, !dbg !101
  store i8 %3, i8* %4, align 1, !dbg !101, !tbaa !91
  %5 = getelementptr inbounds i8* %buf, i64 %indvars.iv, !dbg !101
  %6 = load i8* %5, align 1, !dbg !101, !tbaa !91
  %7 = xor i8 %6, %3, !dbg !101
  store i8 %7, i8* %5, align 1, !dbg !101, !tbaa !91
  %8 = add i64 %indvars.iv, 16, !dbg !101
  %9 = getelementptr inbounds i8* %key, i64 %8, !dbg !101
  %10 = load i8* %9, align 1, !dbg !101, !tbaa !91
  %11 = getelementptr inbounds i8* %cpk, i64 %8, !dbg !101
  store i8 %10, i8* %11, align 1, !dbg !101, !tbaa !91
  %12 = trunc i64 %indvars.iv to i8, !dbg !101
  %13 = icmp eq i8 %12, 0, !dbg !101
  %indvars.iv.next = add i64 %indvars.iv, -1, !dbg !101
  br i1 %13, label %14, label %1, !dbg !101

; <label>:14                                      ; preds = %1
  ret void, !dbg !102
}

; Function Attrs: nounwind uwtable
define void @aes_shiftRows(i8* nocapture %buf) #1 {
  tail call void @llvm.dbg.value(metadata !{i8* %buf}, i64 0, metadata !36), !dbg !103
  %1 = getelementptr inbounds i8* %buf, i64 1, !dbg !104
  %2 = load i8* %1, align 1, !dbg !104, !tbaa !91
  tail call void @llvm.dbg.value(metadata !{i8 %2}, i64 0, metadata !37), !dbg !104
  %3 = getelementptr inbounds i8* %buf, i64 5, !dbg !104
  %4 = load i8* %3, align 1, !dbg !104, !tbaa !91
  store i8 %4, i8* %1, align 1, !dbg !104, !tbaa !91
  %5 = getelementptr inbounds i8* %buf, i64 9, !dbg !104
  %6 = load i8* %5, align 1, !dbg !104, !tbaa !91
  store i8 %6, i8* %3, align 1, !dbg !104, !tbaa !91
  %7 = getelementptr inbounds i8* %buf, i64 13, !dbg !104
  %8 = load i8* %7, align 1, !dbg !104, !tbaa !91
  store i8 %8, i8* %5, align 1, !dbg !104, !tbaa !91
  store i8 %2, i8* %7, align 1, !dbg !104, !tbaa !91
  %9 = getelementptr inbounds i8* %buf, i64 10, !dbg !105
  %10 = load i8* %9, align 1, !dbg !105, !tbaa !91
  tail call void @llvm.dbg.value(metadata !{i8 %10}, i64 0, metadata !37), !dbg !105
  %11 = getelementptr inbounds i8* %buf, i64 2, !dbg !105
  %12 = load i8* %11, align 1, !dbg !105, !tbaa !91
  store i8 %12, i8* %9, align 1, !dbg !105, !tbaa !91
  store i8 %10, i8* %11, align 1, !dbg !105, !tbaa !91
  %13 = getelementptr inbounds i8* %buf, i64 3, !dbg !106
  %14 = load i8* %13, align 1, !dbg !106, !tbaa !91
  tail call void @llvm.dbg.value(metadata !{i8 %14}, i64 0, metadata !38), !dbg !106
  %15 = getelementptr inbounds i8* %buf, i64 15, !dbg !106
  %16 = load i8* %15, align 1, !dbg !106, !tbaa !91
  store i8 %16, i8* %13, align 1, !dbg !106, !tbaa !91
  %17 = getelementptr inbounds i8* %buf, i64 11, !dbg !106
  %18 = load i8* %17, align 1, !dbg !106, !tbaa !91
  store i8 %18, i8* %15, align 1, !dbg !106, !tbaa !91
  %19 = getelementptr inbounds i8* %buf, i64 7, !dbg !106
  %20 = load i8* %19, align 1, !dbg !106, !tbaa !91
  store i8 %20, i8* %17, align 1, !dbg !106, !tbaa !91
  store i8 %14, i8* %19, align 1, !dbg !106, !tbaa !91
  %21 = getelementptr inbounds i8* %buf, i64 14, !dbg !107
  %22 = load i8* %21, align 1, !dbg !107, !tbaa !91
  tail call void @llvm.dbg.value(metadata !{i8 %22}, i64 0, metadata !38), !dbg !107
  %23 = getelementptr inbounds i8* %buf, i64 6, !dbg !107
  %24 = load i8* %23, align 1, !dbg !107, !tbaa !91
  store i8 %24, i8* %21, align 1, !dbg !107, !tbaa !91
  store i8 %22, i8* %23, align 1, !dbg !107, !tbaa !91
  ret void, !dbg !108
}

; Function Attrs: nounwind uwtable
define void @aes_mixColumns(i8* nocapture %buf) #1 {
  tail call void @llvm.dbg.value(metadata !{i8* %buf}, i64 0, metadata !41), !dbg !109
  tail call void @llvm.dbg.value(metadata !110, i64 0, metadata !42), !dbg !111
  br label %1, !dbg !111

; <label>:1                                       ; preds = %0, %1
  %indvars.iv = phi i64 [ 0, %0 ], [ %indvars.iv.next, %1 ]
  %2 = getelementptr inbounds i8* %buf, i64 %indvars.iv, !dbg !113
  %3 = load i8* %2, align 1, !dbg !113, !tbaa !91
  tail call void @llvm.dbg.value(metadata !{i8 %3}, i64 0, metadata !43), !dbg !113
  %4 = or i64 %indvars.iv, 1, !dbg !113
  %5 = getelementptr inbounds i8* %buf, i64 %4, !dbg !113
  %6 = load i8* %5, align 1, !dbg !113, !tbaa !91
  tail call void @llvm.dbg.value(metadata !{i8 %6}, i64 0, metadata !44), !dbg !113
  %7 = or i64 %indvars.iv, 2, !dbg !113
  %8 = getelementptr inbounds i8* %buf, i64 %7, !dbg !113
  %9 = load i8* %8, align 1, !dbg !113, !tbaa !91
  tail call void @llvm.dbg.value(metadata !{i8 %9}, i64 0, metadata !45), !dbg !113
  %10 = or i64 %indvars.iv, 3, !dbg !113
  %11 = getelementptr inbounds i8* %buf, i64 %10, !dbg !113
  %12 = load i8* %11, align 1, !dbg !113, !tbaa !91
  tail call void @llvm.dbg.value(metadata !{i8 %12}, i64 0, metadata !46), !dbg !113
  %13 = xor i8 %6, %3, !dbg !115
  %14 = xor i8 %13, %9, !dbg !115
  %15 = xor i8 %14, %12, !dbg !115
  tail call void @llvm.dbg.value(metadata !{i8 %15}, i64 0, metadata !47), !dbg !115
  %16 = tail call zeroext i8 @rj_xtime(i8 zeroext %13) #4, !dbg !116
  %17 = xor i8 %16, %3, !dbg !116
  %18 = xor i8 %17, %15, !dbg !116
  store i8 %18, i8* %2, align 1, !dbg !116, !tbaa !91
  %19 = xor i8 %9, %6, !dbg !116
  %20 = tail call zeroext i8 @rj_xtime(i8 zeroext %19) #4, !dbg !116
  %21 = xor i8 %20, %15, !dbg !116
  %22 = load i8* %5, align 1, !dbg !116, !tbaa !91
  %23 = xor i8 %21, %22, !dbg !116
  store i8 %23, i8* %5, align 1, !dbg !116, !tbaa !91
  %24 = xor i8 %12, %9, !dbg !117
  %25 = tail call zeroext i8 @rj_xtime(i8 zeroext %24) #4, !dbg !117
  %26 = xor i8 %25, %15, !dbg !117
  %27 = load i8* %8, align 1, !dbg !117, !tbaa !91
  %28 = xor i8 %26, %27, !dbg !117
  store i8 %28, i8* %8, align 1, !dbg !117, !tbaa !91
  %29 = xor i8 %12, %3, !dbg !117
  %30 = tail call zeroext i8 @rj_xtime(i8 zeroext %29) #4, !dbg !117
  %31 = xor i8 %30, %15, !dbg !117
  %32 = load i8* %11, align 1, !dbg !117, !tbaa !91
  %33 = xor i8 %31, %32, !dbg !117
  store i8 %33, i8* %11, align 1, !dbg !117, !tbaa !91
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 4, !dbg !111
  %34 = trunc i64 %indvars.iv.next to i8, !dbg !111
  %35 = icmp ult i8 %34, 16, !dbg !111
  br i1 %35, label %1, label %36, !dbg !111

; <label>:36                                      ; preds = %1
  ret void, !dbg !118
}

; Function Attrs: nounwind uwtable
define zeroext i8 @aes_expandEncKey(i8* %k, i8 zeroext %rc) #1 {
  tail call void @llvm.dbg.value(metadata !{i8* %k}, i64 0, metadata !52), !dbg !119
  tail call void @llvm.dbg.value(metadata !{i8 %rc}, i64 0, metadata !53), !dbg !119
  %1 = getelementptr inbounds i8* %k, i64 29, !dbg !120
  %2 = load i8* %1, align 1, !dbg !120, !tbaa !91
  %3 = zext i8 %2 to i64, !dbg !120
  %4 = getelementptr inbounds [256 x i8]* @sbox, i64 0, i64 %3, !dbg !120
  %5 = load i8* %4, align 1, !dbg !120, !tbaa !91
  %6 = xor i8 %5, %rc, !dbg !120
  %7 = load i8* %k, align 1, !dbg !120, !tbaa !91
  %8 = xor i8 %6, %7, !dbg !120
  store i8 %8, i8* %k, align 1, !dbg !120, !tbaa !91
  %9 = getelementptr inbounds i8* %k, i64 30, !dbg !121
  %10 = load i8* %9, align 1, !dbg !121, !tbaa !91
  %11 = zext i8 %10 to i64, !dbg !121
  %12 = getelementptr inbounds [256 x i8]* @sbox, i64 0, i64 %11, !dbg !121
  %13 = load i8* %12, align 1, !dbg !121, !tbaa !91
  %14 = getelementptr inbounds i8* %k, i64 1, !dbg !121
  %15 = load i8* %14, align 1, !dbg !121, !tbaa !91
  %16 = xor i8 %15, %13, !dbg !121
  store i8 %16, i8* %14, align 1, !dbg !121, !tbaa !91
  %17 = getelementptr inbounds i8* %k, i64 31, !dbg !122
  %18 = load i8* %17, align 1, !dbg !122, !tbaa !91
  %19 = zext i8 %18 to i64, !dbg !122
  %20 = getelementptr inbounds [256 x i8]* @sbox, i64 0, i64 %19, !dbg !122
  %21 = load i8* %20, align 1, !dbg !122, !tbaa !91
  %22 = getelementptr inbounds i8* %k, i64 2, !dbg !122
  %23 = load i8* %22, align 1, !dbg !122, !tbaa !91
  %24 = xor i8 %23, %21, !dbg !122
  store i8 %24, i8* %22, align 1, !dbg !122, !tbaa !91
  %25 = getelementptr inbounds i8* %k, i64 28, !dbg !123
  %26 = load i8* %25, align 1, !dbg !123, !tbaa !91
  %27 = zext i8 %26 to i64, !dbg !123
  %28 = getelementptr inbounds [256 x i8]* @sbox, i64 0, i64 %27, !dbg !123
  %29 = load i8* %28, align 1, !dbg !123, !tbaa !91
  %30 = getelementptr inbounds i8* %k, i64 3, !dbg !123
  %31 = load i8* %30, align 1, !dbg !123, !tbaa !91
  %32 = xor i8 %31, %29, !dbg !123
  store i8 %32, i8* %30, align 1, !dbg !123, !tbaa !91
  %33 = ashr i8 %rc, 7, !dbg !124
  %34 = and i8 %33, 27, !dbg !124
  tail call void @llvm.dbg.value(metadata !{i8 %73}, i64 0, metadata !53), !dbg !124
  tail call void @llvm.dbg.value(metadata !125, i64 0, metadata !54), !dbg !126
  br label %35, !dbg !126

; <label>:35                                      ; preds = %0, %35
  %indvars.iv5 = phi i64 [ 4, %0 ], [ %indvars.iv.next6, %35 ]
  %36 = phi i32 [ 4, %0 ], [ %68, %35 ]
  %37 = add nsw i32 %36, -4, !dbg !126
  %38 = sext i32 %37 to i64, !dbg !126
  %39 = getelementptr inbounds i8* %k, i64 %38, !dbg !126
  %40 = load i8* %39, align 1, !dbg !126, !tbaa !91
  %41 = getelementptr inbounds i8* %k, i64 %indvars.iv5, !dbg !126
  %42 = load i8* %41, align 1, !dbg !126, !tbaa !91
  %43 = xor i8 %42, %40, !dbg !126
  store i8 %43, i8* %41, align 1, !dbg !126, !tbaa !91
  %44 = add nsw i32 %36, -3, !dbg !126
  %45 = sext i32 %44 to i64, !dbg !126
  %46 = getelementptr inbounds i8* %k, i64 %45, !dbg !126
  %47 = load i8* %46, align 1, !dbg !126, !tbaa !91
  %48 = or i64 %indvars.iv5, 1, !dbg !126
  %49 = getelementptr inbounds i8* %k, i64 %48, !dbg !126
  %50 = load i8* %49, align 1, !dbg !126, !tbaa !91
  %51 = xor i8 %50, %47, !dbg !126
  store i8 %51, i8* %49, align 1, !dbg !126, !tbaa !91
  %52 = add nsw i32 %36, -2, !dbg !126
  %53 = sext i32 %52 to i64, !dbg !126
  %54 = getelementptr inbounds i8* %k, i64 %53, !dbg !126
  %55 = load i8* %54, align 1, !dbg !126, !tbaa !91
  %56 = or i64 %indvars.iv5, 2, !dbg !126
  %57 = getelementptr inbounds i8* %k, i64 %56, !dbg !126
  %58 = load i8* %57, align 1, !dbg !126, !tbaa !91
  %59 = xor i8 %58, %55, !dbg !126
  store i8 %59, i8* %57, align 1, !dbg !126, !tbaa !91
  %60 = add nsw i32 %36, -1, !dbg !126
  %61 = sext i32 %60 to i64, !dbg !126
  %62 = getelementptr inbounds i8* %k, i64 %61, !dbg !126
  %63 = load i8* %62, align 1, !dbg !126, !tbaa !91
  %64 = or i64 %indvars.iv5, 3, !dbg !126
  %65 = getelementptr inbounds i8* %k, i64 %64, !dbg !126
  %66 = load i8* %65, align 1, !dbg !126, !tbaa !91
  %67 = xor i8 %66, %63, !dbg !126
  store i8 %67, i8* %65, align 1, !dbg !126, !tbaa !91
  %indvars.iv.next6 = add nuw nsw i64 %indvars.iv5, 4, !dbg !126
  %68 = trunc i64 %indvars.iv.next6 to i32, !dbg !126
  %69 = trunc i64 %indvars.iv.next6 to i8, !dbg !126
  %70 = icmp ult i8 %69, 16, !dbg !126
  br i1 %70, label %35, label %71, !dbg !126

; <label>:71                                      ; preds = %35
  %72 = shl i8 %rc, 1, !dbg !124
  %73 = xor i8 %34, %72, !dbg !124
  %74 = getelementptr inbounds i8* %k, i64 12, !dbg !128
  %75 = load i8* %74, align 1, !dbg !128, !tbaa !91
  %76 = zext i8 %75 to i64, !dbg !128
  %77 = getelementptr inbounds [256 x i8]* @sbox, i64 0, i64 %76, !dbg !128
  %78 = load i8* %77, align 1, !dbg !128, !tbaa !91
  %79 = getelementptr inbounds i8* %k, i64 16, !dbg !128
  %80 = load i8* %79, align 1, !dbg !128, !tbaa !91
  %81 = xor i8 %80, %78, !dbg !128
  store i8 %81, i8* %79, align 1, !dbg !128, !tbaa !91
  %82 = getelementptr inbounds i8* %k, i64 13, !dbg !129
  %83 = load i8* %82, align 1, !dbg !129, !tbaa !91
  %84 = zext i8 %83 to i64, !dbg !129
  %85 = getelementptr inbounds [256 x i8]* @sbox, i64 0, i64 %84, !dbg !129
  %86 = load i8* %85, align 1, !dbg !129, !tbaa !91
  %87 = getelementptr inbounds i8* %k, i64 17, !dbg !129
  %88 = load i8* %87, align 1, !dbg !129, !tbaa !91
  %89 = xor i8 %88, %86, !dbg !129
  store i8 %89, i8* %87, align 1, !dbg !129, !tbaa !91
  %90 = getelementptr inbounds i8* %k, i64 14, !dbg !130
  %91 = load i8* %90, align 1, !dbg !130, !tbaa !91
  %92 = zext i8 %91 to i64, !dbg !130
  %93 = getelementptr inbounds [256 x i8]* @sbox, i64 0, i64 %92, !dbg !130
  %94 = load i8* %93, align 1, !dbg !130, !tbaa !91
  %95 = getelementptr inbounds i8* %k, i64 18, !dbg !130
  %96 = load i8* %95, align 1, !dbg !130, !tbaa !91
  %97 = xor i8 %96, %94, !dbg !130
  store i8 %97, i8* %95, align 1, !dbg !130, !tbaa !91
  %98 = getelementptr inbounds i8* %k, i64 15, !dbg !131
  %99 = load i8* %98, align 1, !dbg !131, !tbaa !91
  %100 = zext i8 %99 to i64, !dbg !131
  %101 = getelementptr inbounds [256 x i8]* @sbox, i64 0, i64 %100, !dbg !131
  %102 = load i8* %101, align 1, !dbg !131, !tbaa !91
  %103 = getelementptr inbounds i8* %k, i64 19, !dbg !131
  %104 = load i8* %103, align 1, !dbg !131, !tbaa !91
  %105 = xor i8 %104, %102, !dbg !131
  store i8 %105, i8* %103, align 1, !dbg !131, !tbaa !91
  tail call void @llvm.dbg.value(metadata !132, i64 0, metadata !54), !dbg !133
  br label %106, !dbg !133

; <label>:106                                     ; preds = %71, %106
  %indvars.iv3 = phi i64 [ 20, %71 ], [ %indvars.iv.next4, %106 ]
  %107 = phi i32 [ 20, %71 ], [ %139, %106 ]
  %108 = add nsw i32 %107, -4, !dbg !133
  %109 = sext i32 %108 to i64, !dbg !133
  %110 = getelementptr inbounds i8* %k, i64 %109, !dbg !133
  %111 = load i8* %110, align 1, !dbg !133, !tbaa !91
  %112 = getelementptr inbounds i8* %k, i64 %indvars.iv3, !dbg !133
  %113 = load i8* %112, align 1, !dbg !133, !tbaa !91
  %114 = xor i8 %113, %111, !dbg !133
  store i8 %114, i8* %112, align 1, !dbg !133, !tbaa !91
  %115 = add nsw i32 %107, -3, !dbg !133
  %116 = sext i32 %115 to i64, !dbg !133
  %117 = getelementptr inbounds i8* %k, i64 %116, !dbg !133
  %118 = load i8* %117, align 1, !dbg !133, !tbaa !91
  %119 = or i64 %indvars.iv3, 1, !dbg !133
  %120 = getelementptr inbounds i8* %k, i64 %119, !dbg !133
  %121 = load i8* %120, align 1, !dbg !133, !tbaa !91
  %122 = xor i8 %121, %118, !dbg !133
  store i8 %122, i8* %120, align 1, !dbg !133, !tbaa !91
  %123 = add nsw i32 %107, -2, !dbg !133
  %124 = sext i32 %123 to i64, !dbg !133
  %125 = getelementptr inbounds i8* %k, i64 %124, !dbg !133
  %126 = load i8* %125, align 1, !dbg !133, !tbaa !91
  %127 = or i64 %indvars.iv3, 2, !dbg !133
  %128 = getelementptr inbounds i8* %k, i64 %127, !dbg !133
  %129 = load i8* %128, align 1, !dbg !133, !tbaa !91
  %130 = xor i8 %129, %126, !dbg !133
  store i8 %130, i8* %128, align 1, !dbg !133, !tbaa !91
  %131 = add nsw i32 %107, -1, !dbg !133
  %132 = sext i32 %131 to i64, !dbg !133
  %133 = getelementptr inbounds i8* %k, i64 %132, !dbg !133
  %134 = load i8* %133, align 1, !dbg !133, !tbaa !91
  %135 = or i64 %indvars.iv3, 3, !dbg !133
  %136 = getelementptr inbounds i8* %k, i64 %135, !dbg !133
  %137 = load i8* %136, align 1, !dbg !133, !tbaa !91
  %138 = xor i8 %137, %134, !dbg !133
  store i8 %138, i8* %136, align 1, !dbg !133, !tbaa !91
  %indvars.iv.next4 = add nuw nsw i64 %indvars.iv3, 4, !dbg !133
  %139 = trunc i64 %indvars.iv.next4 to i32, !dbg !133
  %140 = trunc i64 %indvars.iv.next4 to i8, !dbg !133
  %141 = icmp ult i8 %140, 32, !dbg !133
  br i1 %141, label %106, label %142, !dbg !133

; <label>:142                                     ; preds = %106
  ret i8 %73, !dbg !135
}

; Function Attrs: nounwind uwtable
define void @aes256_encrypt_ecb(%struct.aes256_context* %ctx, i8* %k, i8* %buf) #1 {
  tail call void @llvm.dbg.value(metadata !{%struct.aes256_context* %ctx}, i64 0, metadata !70), !dbg !136
  tail call void @llvm.dbg.value(metadata !{i8* %k}, i64 0, metadata !71), !dbg !136
  tail call void @llvm.dbg.value(metadata !{i8* %buf}, i64 0, metadata !72), !dbg !136
  tail call void @llvm.dbg.value(metadata !137, i64 0, metadata !73), !dbg !138
  %1 = tail call i8* @dmaLoad(i8* %k, i64 0, i64 32) #5, !dbg !139
  %2 = tail call i8* @dmaLoad(i8* %buf, i64 0, i64 16) #5, !dbg !140
  tail call void @llvm.dbg.value(metadata !110, i64 0, metadata !74), !dbg !141
  br label %4, !dbg !141

.preheader:                                       ; preds = %4
  tail call void @llvm.dbg.value(metadata !143, i64 0, metadata !74), !dbg !144
  %3 = getelementptr inbounds %struct.aes256_context* %ctx, i64 0, i32 2, i64 0, !dbg !146
  br label %9, !dbg !144

; <label>:4                                       ; preds = %4, %0
  %indvars.iv = phi i64 [ 0, %0 ], [ %indvars.iv.next, %4 ]
  %5 = getelementptr inbounds i8* %k, i64 %indvars.iv, !dbg !148
  %6 = load i8* %5, align 1, !dbg !148, !tbaa !91
  %7 = getelementptr inbounds %struct.aes256_context* %ctx, i64 0, i32 2, i64 %indvars.iv, !dbg !148
  store i8 %6, i8* %7, align 1, !dbg !148, !tbaa !91
  %8 = getelementptr inbounds %struct.aes256_context* %ctx, i64 0, i32 1, i64 %indvars.iv, !dbg !148
  store i8 %6, i8* %8, align 1, !dbg !148, !tbaa !91
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !141
  %exitcond6 = icmp eq i64 %indvars.iv.next, 32, !dbg !141
  br i1 %exitcond6, label %.preheader, label %4, !dbg !141

; <label>:9                                       ; preds = %.preheader, %9
  %i.14 = phi i8 [ 7, %.preheader ], [ %phitmp, %9 ]
  %rcon.03 = phi i8 [ 1, %.preheader ], [ %10, %9 ]
  %10 = tail call zeroext i8 @aes_expandEncKey(i8* %3, i8 zeroext %rcon.03) #4, !dbg !146
  tail call void @llvm.dbg.value(metadata !{i8 %10}, i64 0, metadata !73), !dbg !146
  %phitmp = add i8 %i.14, -1, !dbg !150
  tail call void @llvm.dbg.value(metadata !{i8 %i.14}, i64 0, metadata !74), !dbg !144
  %11 = icmp eq i8 %phitmp, 0, !dbg !144
  br i1 %11, label %12, label %9, !dbg !144

; <label>:12                                      ; preds = %9
  %13 = getelementptr inbounds %struct.aes256_context* %ctx, i64 0, i32 1, i64 0, !dbg !151
  %14 = getelementptr inbounds %struct.aes256_context* %ctx, i64 0, i32 0, i64 0, !dbg !151
  tail call void @aes_addRoundKey_cpy(i8* %buf, i8* %13, i8* %14) #4, !dbg !151
  tail call void @llvm.dbg.value(metadata !137, i64 0, metadata !74), !dbg !152
  tail call void @llvm.dbg.value(metadata !137, i64 0, metadata !73), !dbg !152
  tail call void @aes_subBytes(i8* %buf) #4, !dbg !154
  tail call void @aes_shiftRows(i8* %buf) #4, !dbg !156
  %15 = getelementptr inbounds %struct.aes256_context* %ctx, i64 0, i32 0, i64 16, !dbg !157
  br label %16, !dbg !152

; <label>:16                                      ; preds = %22, %12
  %i.22 = phi i8 [ 1, %12 ], [ %23, %22 ]
  %rcon.11 = phi i8 [ 1, %12 ], [ %rcon.2, %22 ]
  tail call void @aes_mixColumns(i8* %buf) #4, !dbg !160
  %17 = and i8 %i.22, 1, !dbg !161
  %18 = icmp eq i8 %17, 0, !dbg !161
  br i1 %18, label %20, label %19, !dbg !161

; <label>:19                                      ; preds = %16
  tail call void @aes_addRoundKey(i8* %buf, i8* %15) #4, !dbg !157
  br label %22, !dbg !162

; <label>:20                                      ; preds = %16
  %21 = tail call zeroext i8 @aes_expandEncKey(i8* %14, i8 zeroext %rcon.11) #4, !dbg !163
  tail call void @llvm.dbg.value(metadata !{i8 %21}, i64 0, metadata !73), !dbg !163
  tail call void @aes_addRoundKey(i8* %buf, i8* %14) #4, !dbg !165
  br label %22

; <label>:22                                      ; preds = %19, %20
  %rcon.2 = phi i8 [ %rcon.11, %19 ], [ %21, %20 ]
  %23 = add i8 %i.22, 1, !dbg !152
  tail call void @llvm.dbg.value(metadata !{i8 %23}, i64 0, metadata !74), !dbg !152
  tail call void @aes_subBytes(i8* %buf) #4, !dbg !154
  tail call void @aes_shiftRows(i8* %buf) #4, !dbg !156
  %exitcond = icmp eq i8 %23, 14, !dbg !152
  br i1 %exitcond, label %24, label %16, !dbg !152

; <label>:24                                      ; preds = %22
  %25 = tail call zeroext i8 @aes_expandEncKey(i8* %14, i8 zeroext %rcon.2) #4, !dbg !166
  tail call void @llvm.dbg.value(metadata !{i8 %25}, i64 0, metadata !73), !dbg !166
  tail call void @aes_addRoundKey(i8* %buf, i8* %14) #4, !dbg !167
  %26 = tail call i8* @dmaStore(i8* %buf, i64 0, i64 16) #5, !dbg !168
  ret void, !dbg !169
}

declare i8* @dmaLoad(i8*, i64, i64) #2

declare i8* @dmaStore(i8*, i64, i64) #2

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #3

attributes #0 = { nounwind readnone uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone }
attributes #4 = { nobuiltin }
attributes #5 = { nobuiltin nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!81, !82}
!llvm.ident = !{!83}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.4 (tags/RELEASE_34/final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !75, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/aes/aes/aes.c] [DW_LANG_C99]
!1 = metadata !{metadata !"aes.c", metadata !"/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/aes/aes"}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4, metadata !12, metadata !19, metadata !26, metadata !34, metadata !39, metadata !48, metadata !55}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"rj_xtime", metadata !"rj_xtime", metadata !"", i32 100, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8 (i8)* @rj_xtime, null, null, metadata !10, i32 101} ; [ DW_TAG_subprogram ] [line 100] [def] [scope 101] [rj_xtime]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/aes/aes/aes.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8}
!8 = metadata !{i32 786454, metadata !1, null, metadata !"uint8_t", i32 48, i64 0, i64 0, i64 0, i32 0, metadata !9} ; [ DW_TAG_typedef ] [uint8_t] [line 48, size 0, align 0, offset 0] [from unsigned char]
!9 = metadata !{i32 786468, null, null, metadata !"unsigned char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 8} ; [ DW_TAG_base_type ] [unsigned char] [line 0, size 8, align 8, offset 0, enc DW_ATE_unsigned_char]
!10 = metadata !{metadata !11}
!11 = metadata !{i32 786689, metadata !4, metadata !"x", metadata !5, i32 16777316, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x] [line 100]
!12 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"aes_subBytes", metadata !"aes_subBytes", metadata !"", i32 106, metadata !13, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i8*)* @aes_subBytes, null, null, metadata !16, i32 107} ; [ DW_TAG_subprogram ] [line 106] [def] [scope 107] [aes_subBytes]
!13 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !14, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!14 = metadata !{null, metadata !15}
!15 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !8} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from uint8_t]
!16 = metadata !{metadata !17, metadata !18}
!17 = metadata !{i32 786689, metadata !12, metadata !"buf", metadata !5, i32 16777322, metadata !15, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 106]
!18 = metadata !{i32 786688, metadata !12, metadata !"i", metadata !5, i32 108, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 108]
!19 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"aes_addRoundKey", metadata !"aes_addRoundKey", metadata !"", i32 114, metadata !20, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i8*, i8*)* @aes_addRoundKey, null, null, metadata !22, i32 115} ; [ DW_TAG_subprogram ] [line 114] [def] [scope 115] [aes_addRoundKey]
!20 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !21, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!21 = metadata !{null, metadata !15, metadata !15}
!22 = metadata !{metadata !23, metadata !24, metadata !25}
!23 = metadata !{i32 786689, metadata !19, metadata !"buf", metadata !5, i32 16777330, metadata !15, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 114]
!24 = metadata !{i32 786689, metadata !19, metadata !"key", metadata !5, i32 33554546, metadata !15, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [key] [line 114]
!25 = metadata !{i32 786688, metadata !19, metadata !"i", metadata !5, i32 116, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 116]
!26 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"aes_addRoundKey_cpy", metadata !"aes_addRoundKey_cpy", metadata !"", i32 122, metadata !27, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i8*, i8*, i8*)* @aes_addRoundKey_cpy, null, null, metadata !29, i32 123} ; [ DW_TAG_subprogram ] [line 122] [def] [scope 123] [aes_addRoundKey_cpy]
!27 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !28, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!28 = metadata !{null, metadata !15, metadata !15, metadata !15}
!29 = metadata !{metadata !30, metadata !31, metadata !32, metadata !33}
!30 = metadata !{i32 786689, metadata !26, metadata !"buf", metadata !5, i32 16777338, metadata !15, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 122]
!31 = metadata !{i32 786689, metadata !26, metadata !"key", metadata !5, i32 33554554, metadata !15, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [key] [line 122]
!32 = metadata !{i32 786689, metadata !26, metadata !"cpk", metadata !5, i32 50331770, metadata !15, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [cpk] [line 122]
!33 = metadata !{i32 786688, metadata !26, metadata !"i", metadata !5, i32 124, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 124]
!34 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"aes_shiftRows", metadata !"aes_shiftRows", metadata !"", i32 131, metadata !13, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i8*)* @aes_shiftRows, null, null, metadata !35, i32 132} ; [ DW_TAG_subprogram ] [line 131] [def] [scope 132] [aes_shiftRows]
!35 = metadata !{metadata !36, metadata !37, metadata !38}
!36 = metadata !{i32 786689, metadata !34, metadata !"buf", metadata !5, i32 16777347, metadata !15, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 131]
!37 = metadata !{i32 786688, metadata !34, metadata !"i", metadata !5, i32 133, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 133]
!38 = metadata !{i32 786688, metadata !34, metadata !"j", metadata !5, i32 133, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 133]
!39 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"aes_mixColumns", metadata !"aes_mixColumns", metadata !"", i32 143, metadata !13, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i8*)* @aes_mixColumns, null, null, metadata !40, i32 144} ; [ DW_TAG_subprogram ] [line 143] [def] [scope 144] [aes_mixColumns]
!40 = metadata !{metadata !41, metadata !42, metadata !43, metadata !44, metadata !45, metadata !46, metadata !47}
!41 = metadata !{i32 786689, metadata !39, metadata !"buf", metadata !5, i32 16777359, metadata !15, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 143]
!42 = metadata !{i32 786688, metadata !39, metadata !"i", metadata !5, i32 145, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 145]
!43 = metadata !{i32 786688, metadata !39, metadata !"a", metadata !5, i32 145, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 145]
!44 = metadata !{i32 786688, metadata !39, metadata !"b", metadata !5, i32 145, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 145]
!45 = metadata !{i32 786688, metadata !39, metadata !"c", metadata !5, i32 145, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [c] [line 145]
!46 = metadata !{i32 786688, metadata !39, metadata !"d", metadata !5, i32 145, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [d] [line 145]
!47 = metadata !{i32 786688, metadata !39, metadata !"e", metadata !5, i32 145, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [e] [line 145]
!48 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"aes_expandEncKey", metadata !"aes_expandEncKey", metadata !"", i32 157, metadata !49, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8 (i8*, i8)* @aes_expandEncKey, null, null, metadata !51, i32 158} ; [ DW_TAG_subprogram ] [line 157] [def] [scope 158] [aes_expandEncKey]
!49 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !50, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!50 = metadata !{metadata !8, metadata !15, metadata !8}
!51 = metadata !{metadata !52, metadata !53, metadata !54}
!52 = metadata !{i32 786689, metadata !48, metadata !"k", metadata !5, i32 16777373, metadata !15, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [k] [line 157]
!53 = metadata !{i32 786689, metadata !48, metadata !"rc", metadata !5, i32 33554589, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [rc] [line 157]
!54 = metadata !{i32 786688, metadata !48, metadata !"i", metadata !5, i32 159, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 159]
!55 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"aes256_encrypt_ecb", metadata !"aes256_encrypt_ecb", metadata !"", i32 181, metadata !56, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (%struct.aes256_context*, i8*, i8*)* @aes256_encrypt_ecb, null, null, metadata !69, i32 182} ; [ DW_TAG_subprogram ] [line 181] [def] [scope 182] [aes256_encrypt_ecb]
!56 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !57, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!57 = metadata !{null, metadata !58, metadata !15, metadata !15}
!58 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !59} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from aes256_context]
!59 = metadata !{i32 786454, metadata !1, null, metadata !"aes256_context", i32 11, i64 0, i64 0, i64 0, i32 0, metadata !60} ; [ DW_TAG_typedef ] [aes256_context] [line 11, size 0, align 0, offset 0] [from ]
!60 = metadata !{i32 786451, metadata !61, null, metadata !"", i32 7, i64 768, i64 8, i32 0, i32 0, null, metadata !62, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [line 7, size 768, align 8, offset 0] [def] [from ]
!61 = metadata !{metadata !"./aes.h", metadata !"/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/aes/aes"}
!62 = metadata !{metadata !63, metadata !67, metadata !68}
!63 = metadata !{i32 786445, metadata !61, metadata !60, metadata !"key", i32 8, i64 256, i64 8, i64 0, i32 0, metadata !64} ; [ DW_TAG_member ] [key] [line 8, size 256, align 8, offset 0] [from ]
!64 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 256, i64 8, i32 0, i32 0, metadata !8, metadata !65, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 256, align 8, offset 0] [from uint8_t]
!65 = metadata !{metadata !66}
!66 = metadata !{i32 786465, i64 0, i64 32}       ; [ DW_TAG_subrange_type ] [0, 31]
!67 = metadata !{i32 786445, metadata !61, metadata !60, metadata !"enckey", i32 9, i64 256, i64 8, i64 256, i32 0, metadata !64} ; [ DW_TAG_member ] [enckey] [line 9, size 256, align 8, offset 256] [from ]
!68 = metadata !{i32 786445, metadata !61, metadata !60, metadata !"deckey", i32 10, i64 256, i64 8, i64 512, i32 0, metadata !64} ; [ DW_TAG_member ] [deckey] [line 10, size 256, align 8, offset 512] [from ]
!69 = metadata !{metadata !70, metadata !71, metadata !72, metadata !73, metadata !74}
!70 = metadata !{i32 786689, metadata !55, metadata !"ctx", metadata !5, i32 16777397, metadata !58, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [ctx] [line 181]
!71 = metadata !{i32 786689, metadata !55, metadata !"k", metadata !5, i32 33554613, metadata !15, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [k] [line 181]
!72 = metadata !{i32 786689, metadata !55, metadata !"buf", metadata !5, i32 50331829, metadata !15, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 181]
!73 = metadata !{i32 786688, metadata !55, metadata !"rcon", metadata !5, i32 184, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [rcon] [line 184]
!74 = metadata !{i32 786688, metadata !55, metadata !"i", metadata !5, i32 185, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 185]
!75 = metadata !{metadata !76}
!76 = metadata !{i32 786484, i32 0, null, metadata !"sbox", metadata !"sbox", metadata !"", metadata !5, i32 17, metadata !77, i32 0, i32 1, [256 x i8]* @sbox, null} ; [ DW_TAG_variable ] [sbox] [line 17] [def]
!77 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 2048, i64 8, i32 0, i32 0, metadata !78, metadata !79, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 2048, align 8, offset 0] [from ]
!78 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !8} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from uint8_t]
!79 = metadata !{metadata !80}
!80 = metadata !{i32 786465, i64 0, i64 256}      ; [ DW_TAG_subrange_type ] [0, 255]
!81 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!82 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!83 = metadata !{metadata !"clang version 3.4 (tags/RELEASE_34/final)"}
!84 = metadata !{i32 100, i32 0, metadata !4, null}
!85 = metadata !{i32 102, i32 0, metadata !4, null}
!86 = metadata !{i32 106, i32 0, metadata !12, null}
!87 = metadata !{i8 16}
!88 = metadata !{i32 108, i32 0, metadata !12, null}
!89 = metadata !{i8 15}
!90 = metadata !{i32 110, i32 0, metadata !12, null}
!91 = metadata !{metadata !92, metadata !92, i64 0}
!92 = metadata !{metadata !"omnipotent char", metadata !93, i64 0}
!93 = metadata !{metadata !"Simple C/C++ TBAA"}
!94 = metadata !{i32 111, i32 0, metadata !12, null}
!95 = metadata !{i32 114, i32 0, metadata !19, null}
!96 = metadata !{i32 116, i32 0, metadata !19, null}
!97 = metadata !{i32 118, i32 0, metadata !19, null}
!98 = metadata !{i32 119, i32 0, metadata !19, null}
!99 = metadata !{i32 122, i32 0, metadata !26, null}
!100 = metadata !{i32 124, i32 0, metadata !26, null}
!101 = metadata !{i32 126, i32 0, metadata !26, null}
!102 = metadata !{i32 127, i32 0, metadata !26, null}
!103 = metadata !{i32 131, i32 0, metadata !34, null}
!104 = metadata !{i32 135, i32 0, metadata !34, null}
!105 = metadata !{i32 136, i32 0, metadata !34, null}
!106 = metadata !{i32 137, i32 0, metadata !34, null}
!107 = metadata !{i32 138, i32 0, metadata !34, null}
!108 = metadata !{i32 140, i32 0, metadata !34, null}
!109 = metadata !{i32 143, i32 0, metadata !39, null}
!110 = metadata !{i8 0}
!111 = metadata !{i32 147, i32 0, metadata !112, null}
!112 = metadata !{i32 786443, metadata !1, metadata !39, i32 147, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/aes/aes/aes.c]
!113 = metadata !{i32 149, i32 0, metadata !114, null}
!114 = metadata !{i32 786443, metadata !1, metadata !112, i32 148, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/aes/aes/aes.c]
!115 = metadata !{i32 150, i32 0, metadata !114, null}
!116 = metadata !{i32 151, i32 0, metadata !114, null}
!117 = metadata !{i32 152, i32 0, metadata !114, null}
!118 = metadata !{i32 154, i32 0, metadata !39, null}
!119 = metadata !{i32 157, i32 0, metadata !48, null}
!120 = metadata !{i32 161, i32 0, metadata !48, null}
!121 = metadata !{i32 162, i32 0, metadata !48, null}
!122 = metadata !{i32 163, i32 0, metadata !48, null}
!123 = metadata !{i32 164, i32 0, metadata !48, null}
!124 = metadata !{i32 165, i32 0, metadata !48, null}
!125 = metadata !{i8 4}
!126 = metadata !{i32 167, i32 0, metadata !127, null}
!127 = metadata !{i32 786443, metadata !1, metadata !48, i32 167, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/aes/aes/aes.c]
!128 = metadata !{i32 169, i32 0, metadata !48, null}
!129 = metadata !{i32 170, i32 0, metadata !48, null}
!130 = metadata !{i32 171, i32 0, metadata !48, null}
!131 = metadata !{i32 172, i32 0, metadata !48, null}
!132 = metadata !{i8 20}
!133 = metadata !{i32 174, i32 0, metadata !134, null}
!134 = metadata !{i32 786443, metadata !1, metadata !48, i32 174, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/aes/aes/aes.c]
!135 = metadata !{i32 177, i32 0, metadata !48, null}
!136 = metadata !{i32 181, i32 0, metadata !55, null}
!137 = metadata !{i8 1}
!138 = metadata !{i32 184, i32 0, metadata !55, null}
!139 = metadata !{i32 188, i32 0, metadata !55, null}
!140 = metadata !{i32 189, i32 0, metadata !55, null}
!141 = metadata !{i32 192, i32 0, metadata !142, null}
!142 = metadata !{i32 786443, metadata !1, metadata !55, i32 192, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/aes/aes/aes.c]
!143 = metadata !{i8 7}
!144 = metadata !{i32 195, i32 0, metadata !145, null}
!145 = metadata !{i32 786443, metadata !1, metadata !55, i32 195, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/aes/aes/aes.c]
!146 = metadata !{i32 196, i32 0, metadata !147, null}
!147 = metadata !{i32 786443, metadata !1, metadata !145, i32 195, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/aes/aes/aes.c]
!148 = metadata !{i32 193, i32 0, metadata !149, null}
!149 = metadata !{i32 786443, metadata !1, metadata !142, i32 192, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/aes/aes/aes.c]
!150 = metadata !{i32 197, i32 0, metadata !147, null}
!151 = metadata !{i32 200, i32 0, metadata !55, null}
!152 = metadata !{i32 201, i32 0, metadata !153, null}
!153 = metadata !{i32 786443, metadata !1, metadata !55, i32 201, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/aes/aes/aes.c]
!154 = metadata !{i32 203, i32 0, metadata !155, null}
!155 = metadata !{i32 786443, metadata !1, metadata !153, i32 202, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/aes/aes/aes.c]
!156 = metadata !{i32 204, i32 0, metadata !155, null}
!157 = metadata !{i32 207, i32 0, metadata !158, null}
!158 = metadata !{i32 786443, metadata !1, metadata !159, i32 206, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/aes/aes/aes.c]
!159 = metadata !{i32 786443, metadata !1, metadata !155, i32 206, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/aes/aes/aes.c]
!160 = metadata !{i32 205, i32 0, metadata !155, null}
!161 = metadata !{i32 206, i32 0, metadata !159, null}
!162 = metadata !{i32 208, i32 0, metadata !158, null}
!163 = metadata !{i32 209, i32 0, metadata !164, null}
!164 = metadata !{i32 786443, metadata !1, metadata !159, i32 208, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/aes/aes/aes.c]
!165 = metadata !{i32 210, i32 0, metadata !164, null}
!166 = metadata !{i32 215, i32 0, metadata !55, null}
!167 = metadata !{i32 216, i32 0, metadata !55, null}
!168 = metadata !{i32 218, i32 0, metadata !55, null}
!169 = metadata !{i32 220, i32 0, metadata !55, null}
