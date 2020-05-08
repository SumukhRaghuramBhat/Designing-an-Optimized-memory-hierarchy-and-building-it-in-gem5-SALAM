; ModuleID = 'md.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dvector_t = type { double, double, double }
%struct.ivector_t = type { i32, i32, i32 }

; Function Attrs: nounwind uwtable
define void @md([4 x [4 x i32]]* %n_points, [4 x [4 x [10 x %struct.dvector_t]]]* %force, [4 x [4 x [10 x %struct.dvector_t]]]* %position) #0 {
  tail call void @llvm.dbg.value(metadata !{[4 x [4 x i32]]* %n_points}, i64 0, metadata !26), !dbg !72
  tail call void @llvm.dbg.value(metadata !{[4 x [4 x [10 x %struct.dvector_t]]]* %force}, i64 0, metadata !27), !dbg !73
  tail call void @llvm.dbg.value(metadata !{[4 x [4 x [10 x %struct.dvector_t]]]* %position}, i64 0, metadata !28), !dbg !74
  tail call void @llvm.dbg.declare(metadata !75, metadata !29), !dbg !76
  tail call void @llvm.dbg.declare(metadata !75, metadata !37), !dbg !76
  tail call void @llvm.dbg.declare(metadata !77, metadata !38), !dbg !78
  tail call void @llvm.dbg.declare(metadata !77, metadata !39), !dbg !78
  %1 = bitcast [4 x [4 x i32]]* %n_points to i8*, !dbg !79
  %2 = tail call i8* @dmaLoad(i8* %1, i64 0, i64 256) #3, !dbg !79
  %3 = bitcast [4 x [4 x [10 x %struct.dvector_t]]]* %position to i8*, !dbg !80
  %4 = tail call i8* @dmaLoad(i8* %3, i64 0, i64 4080) #3, !dbg !80
  %5 = tail call i8* @dmaLoad(i8* %3, i64 4080, i64 4080) #3, !dbg !81
  %6 = tail call i8* @dmaLoad(i8* %3, i64 8160, i64 4080) #3, !dbg !82
  %7 = tail call i8* @dmaLoad(i8* %3, i64 12240, i64 3120) #3, !dbg !83
  %8 = bitcast [4 x [4 x [10 x %struct.dvector_t]]]* %force to i8*, !dbg !84
  %9 = tail call i8* @dmaLoad(i8* %8, i64 0, i64 4080) #3, !dbg !84
  %10 = tail call i8* @dmaLoad(i8* %8, i64 4080, i64 4080) #3, !dbg !85
  %11 = tail call i8* @dmaLoad(i8* %8, i64 8160, i64 4080) #3, !dbg !86
  %12 = tail call i8* @dmaLoad(i8* %8, i64 12240, i64 3120) #3, !dbg !87
  br label %.preheader30, !dbg !88

.preheader30:                                     ; preds = %115, %0
  %indvars.iv67 = phi i64 [ 0, %0 ], [ %indvars.iv.next68, %115 ]
  %indvars.iv57 = phi i32 [ -3, %0 ], [ %indvars.iv.next58, %115 ]
  %indvars.iv52 = phi i32 [ 0, %0 ], [ %indvars.iv.next53, %115 ]
  %13 = icmp sgt i32 %indvars.iv52, 1
  %indvars.iv52.op = add i32 %indvars.iv52, -1, !dbg !89
  %14 = zext i32 %indvars.iv52.op to i64
  %15 = select i1 %13, i64 %14, i64 0
  %16 = icmp sgt i32 %indvars.iv57, -5
  %indvars.iv57.op = xor i32 %indvars.iv57, -1, !dbg !89
  %17 = select i1 %16, i32 %indvars.iv57.op, i32 4, !dbg !89
  %18 = trunc i64 %indvars.iv67 to i32, !dbg !89
  %19 = icmp slt i32 %18, 1, !dbg !89
  %20 = add nsw i64 %indvars.iv67, 4294967295, !dbg !89
  %21 = trunc i64 %20 to i32, !dbg !89
  %. = select i1 %19, i32 0, i32 %21, !dbg !89
  %22 = add nsw i64 %indvars.iv67, 2, !dbg !89
  %23 = trunc i64 %22 to i32, !dbg !89
  %24 = icmp sgt i32 %23, 4, !dbg !89
  %25 = trunc i64 %22 to i32, !dbg !89
  %.1 = select i1 %24, i32 4, i32 %25, !dbg !89
  %26 = icmp slt i32 %., %.1, !dbg !89
  br label %.preheader, !dbg !90

.preheader:                                       ; preds = %114, %.preheader30
  %indvars.iv64 = phi i64 [ 0, %.preheader30 ], [ %indvars.iv.next65, %114 ]
  %indvars.iv48 = phi i32 [ -3, %.preheader30 ], [ %indvars.iv.next49, %114 ]
  %indvars.iv43 = phi i32 [ 0, %.preheader30 ], [ %indvars.iv.next44, %114 ]
  %27 = icmp sgt i32 %indvars.iv43, 1
  %indvars.iv43.op = add i32 %indvars.iv43, -1, !dbg !91
  %28 = zext i32 %indvars.iv43.op to i64
  %29 = select i1 %27, i64 %28, i64 0
  %30 = icmp sgt i32 %indvars.iv48, -5
  %indvars.iv48.op = xor i32 %indvars.iv48, -1, !dbg !91
  %31 = select i1 %30, i32 %indvars.iv48.op, i32 4, !dbg !91
  %32 = trunc i64 %indvars.iv64 to i32, !dbg !91
  %33 = icmp slt i32 %32, 1, !dbg !91
  %34 = add nsw i64 %indvars.iv64, 4294967295, !dbg !91
  %35 = trunc i64 %34 to i32, !dbg !91
  %.2 = select i1 %33, i32 0, i32 %35, !dbg !91
  %36 = add nsw i64 %indvars.iv64, 2, !dbg !91
  %37 = trunc i64 %36 to i32, !dbg !91
  %38 = icmp sgt i32 %37, 4, !dbg !91
  %39 = trunc i64 %36 to i32, !dbg !91
  %.3 = select i1 %38, i32 4, i32 %39, !dbg !91
  %40 = icmp slt i32 %.2, %.3, !dbg !91
  br label %41, !dbg !92

; <label>:41                                      ; preds = %._crit_edge28, %.preheader
  %indvars.iv61 = phi i64 [ 0, %.preheader ], [ %indvars.iv.next62, %._crit_edge28 ]
  %indvars.iv39 = phi i32 [ -3, %.preheader ], [ %indvars.iv.next40, %._crit_edge28 ]
  %indvars.iv35 = phi i32 [ 0, %.preheader ], [ %indvars.iv.next36, %._crit_edge28 ]
  %42 = icmp sgt i32 %indvars.iv35, 1
  %indvars.iv35.op = add i32 %indvars.iv35, -1, !dbg !89
  %43 = zext i32 %indvars.iv35.op to i64
  %44 = select i1 %42, i64 %43, i64 0
  %45 = icmp sgt i32 %indvars.iv39, -5
  %indvars.iv39.op = xor i32 %indvars.iv39, -1, !dbg !89
  %46 = select i1 %45, i32 %indvars.iv39.op, i32 4, !dbg !89
  br i1 %26, label %.lr.ph27, label %._crit_edge28, !dbg !89

.lr.ph27:                                         ; preds = %41
  %47 = trunc i64 %indvars.iv61 to i32, !dbg !93
  %48 = icmp slt i32 %47, 1, !dbg !93
  %49 = add nsw i64 %indvars.iv61, 4294967295, !dbg !93
  %50 = trunc i64 %49 to i32, !dbg !93
  %.4 = select i1 %48, i32 0, i32 %50, !dbg !93
  %51 = add nsw i64 %indvars.iv61, 2, !dbg !93
  %52 = trunc i64 %51 to i32, !dbg !93
  %53 = icmp sgt i32 %52, 4, !dbg !93
  %54 = trunc i64 %51 to i32, !dbg !93
  %.5 = select i1 %53, i32 4, i32 %54, !dbg !93
  %55 = icmp slt i32 %.4, %.5, !dbg !93
  %56 = getelementptr inbounds [4 x [4 x i32]]* %n_points, i64 %indvars.iv67, i64 %indvars.iv64, i64 %indvars.iv61, !dbg !94
  br label %57, !dbg !89

; <label>:57                                      ; preds = %._crit_edge24, %.lr.ph27
  %indvars.iv55 = phi i64 [ %15, %.lr.ph27 ], [ %indvars.iv.next56, %._crit_edge24 ]
  %b1.sroa.0.025 = phi i32 [ %., %.lr.ph27 ], [ %113, %._crit_edge24 ]
  br i1 %40, label %.lr.ph23, label %._crit_edge24, !dbg !91

.lr.ph23:                                         ; preds = %57, %._crit_edge20
  %indvars.iv46 = phi i64 [ %indvars.iv.next47, %._crit_edge20 ], [ %29, %57 ]
  %b1.sroa.6.021 = phi i32 [ %112, %._crit_edge20 ], [ %.2, %57 ]
  br i1 %55, label %.lr.ph19, label %._crit_edge20, !dbg !93

.lr.ph19:                                         ; preds = %.lr.ph23, %._crit_edge16
  %indvars.iv37 = phi i64 [ %indvars.iv.next38, %._crit_edge16 ], [ %44, %.lr.ph23 ]
  %b1.sroa.12.017 = phi i32 [ %111, %._crit_edge16 ], [ %.4, %.lr.ph23 ]
  %58 = getelementptr inbounds [4 x [4 x i32]]* %n_points, i64 %indvars.iv55, i64 %indvars.iv46, i64 %indvars.iv37, !dbg !95
  %59 = load i32* %58, align 4, !dbg !95, !tbaa !96
  tail call void @llvm.dbg.value(metadata !{i32 %59}, i64 0, metadata !63), !dbg !95
  tail call void @llvm.dbg.value(metadata !2, i64 0, metadata !40), !dbg !94
  %60 = load i32* %56, align 4, !dbg !94, !tbaa !96
  %61 = icmp sgt i32 %60, 0, !dbg !94
  br i1 %61, label %.lr.ph15, label %._crit_edge16, !dbg !94

.lr.ph15:                                         ; preds = %.lr.ph19
  %62 = icmp sgt i32 %59, 0, !dbg !100
  br label %63, !dbg !94

; <label>:63                                      ; preds = %.lr.ph15, %._crit_edge
  %indvars.iv33 = phi i64 [ 0, %.lr.ph15 ], [ %indvars.iv.next34, %._crit_edge ]
  %64 = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]]* %position, i64 %indvars.iv67, i64 %indvars.iv64, i64 %indvars.iv61, i64 %indvars.iv33, i32 0, !dbg !102
  %65 = load double* %64, align 8, !dbg !102
  %66 = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]]* %position, i64 %indvars.iv67, i64 %indvars.iv64, i64 %indvars.iv61, i64 %indvars.iv33, i32 1, !dbg !102
  %67 = load double* %66, align 8, !dbg !102
  %68 = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]]* %position, i64 %indvars.iv67, i64 %indvars.iv64, i64 %indvars.iv61, i64 %indvars.iv33, i32 2, !dbg !102
  %69 = load double* %68, align 8, !dbg !102
  %70 = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]]* %force, i64 %indvars.iv67, i64 %indvars.iv64, i64 %indvars.iv61, i64 %indvars.iv33, i32 0, !dbg !103
  %71 = load double* %70, align 8, !dbg !103, !tbaa !104
  tail call void @llvm.dbg.value(metadata !{double %71}, i64 0, metadata !64), !dbg !103
  %72 = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]]* %force, i64 %indvars.iv67, i64 %indvars.iv64, i64 %indvars.iv61, i64 %indvars.iv33, i32 1, !dbg !107
  %73 = load double* %72, align 8, !dbg !107, !tbaa !108
  tail call void @llvm.dbg.value(metadata !{double %73}, i64 0, metadata !67), !dbg !107
  %74 = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]]* %force, i64 %indvars.iv67, i64 %indvars.iv64, i64 %indvars.iv61, i64 %indvars.iv33, i32 2, !dbg !109
  %75 = load double* %74, align 8, !dbg !109, !tbaa !110
  tail call void @llvm.dbg.value(metadata !{double %75}, i64 0, metadata !68), !dbg !109
  tail call void @llvm.dbg.value(metadata !2, i64 0, metadata !41), !dbg !100
  br i1 %62, label %.lr.ph, label %._crit_edge, !dbg !100

.lr.ph:                                           ; preds = %63, %107
  %indvars.iv = phi i64 [ %indvars.iv.next, %107 ], [ 0, %63 ]
  %sum_z.010 = phi double [ %sum_z.1, %107 ], [ %75, %63 ]
  %sum_y.09 = phi double [ %sum_y.1, %107 ], [ %73, %63 ]
  %sum_x.08 = phi double [ %sum_x.1, %107 ], [ %71, %63 ]
  %76 = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]]* %position, i64 %indvars.iv55, i64 %indvars.iv46, i64 %indvars.iv37, i64 %indvars.iv, i32 0, !dbg !111
  %77 = load double* %76, align 8, !dbg !111
  %78 = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]]* %position, i64 %indvars.iv55, i64 %indvars.iv46, i64 %indvars.iv37, i64 %indvars.iv, i32 1, !dbg !111
  %79 = load double* %78, align 8, !dbg !111
  %80 = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]]* %position, i64 %indvars.iv55, i64 %indvars.iv46, i64 %indvars.iv37, i64 %indvars.iv, i32 2, !dbg !111
  %81 = load double* %80, align 8, !dbg !111
  %82 = fcmp une double %77, %65, !dbg !113
  %83 = fcmp une double %79, %67, !dbg !113
  %or.cond = or i1 %82, %83, !dbg !113
  %84 = fcmp une double %81, %69, !dbg !113
  %or.cond6 = or i1 %or.cond, %84, !dbg !113
  br i1 %or.cond6, label %85, label %107, !dbg !113

; <label>:85                                      ; preds = %.lr.ph
  %86 = fsub double %65, %77, !dbg !115
  tail call void @llvm.dbg.value(metadata !{double %86}, i64 0, metadata !42), !dbg !115
  %87 = fsub double %67, %79, !dbg !117
  tail call void @llvm.dbg.value(metadata !{double %87}, i64 0, metadata !43), !dbg !117
  %88 = fsub double %69, %81, !dbg !118
  tail call void @llvm.dbg.value(metadata !{double %88}, i64 0, metadata !44), !dbg !118
  %89 = fmul double %86, %86, !dbg !119
  %90 = fmul double %87, %87, !dbg !119
  %91 = fadd double %89, %90, !dbg !119
  %92 = fmul double %88, %88, !dbg !119
  %93 = fadd double %91, %92, !dbg !119
  %94 = fdiv double 1.000000e+00, %93, !dbg !119
  tail call void @llvm.dbg.value(metadata !{double %94}, i64 0, metadata !45), !dbg !119
  %95 = fmul double %94, %94, !dbg !120
  %96 = fmul double %94, %95, !dbg !120
  tail call void @llvm.dbg.value(metadata !{double %96}, i64 0, metadata !46), !dbg !120
  %97 = fmul double %96, 1.500000e+00, !dbg !121
  %98 = fadd double %97, -2.000000e+00, !dbg !121
  %99 = fmul double %96, %98, !dbg !121
  tail call void @llvm.dbg.value(metadata !{double %99}, i64 0, metadata !47), !dbg !121
  %100 = fmul double %94, %99, !dbg !122
  tail call void @llvm.dbg.value(metadata !{double %100}, i64 0, metadata !48), !dbg !122
  %101 = fmul double %86, %100, !dbg !123
  %102 = fadd double %sum_x.08, %101, !dbg !123
  tail call void @llvm.dbg.value(metadata !{double %102}, i64 0, metadata !64), !dbg !123
  %103 = fmul double %87, %100, !dbg !124
  %104 = fadd double %sum_y.09, %103, !dbg !124
  tail call void @llvm.dbg.value(metadata !{double %104}, i64 0, metadata !67), !dbg !124
  %105 = fmul double %88, %100, !dbg !125
  %106 = fadd double %sum_z.010, %105, !dbg !125
  tail call void @llvm.dbg.value(metadata !{double %106}, i64 0, metadata !68), !dbg !125
  br label %107, !dbg !126

; <label>:107                                     ; preds = %.lr.ph, %85
  %sum_x.1 = phi double [ %102, %85 ], [ %sum_x.08, %.lr.ph ]
  %sum_y.1 = phi double [ %104, %85 ], [ %sum_y.09, %.lr.ph ]
  %sum_z.1 = phi double [ %106, %85 ], [ %sum_z.010, %.lr.ph ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !100
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32, !dbg !100
  %exitcond = icmp eq i32 %lftr.wideiv, %59, !dbg !100
  br i1 %exitcond, label %._crit_edge, label %.lr.ph, !dbg !100

._crit_edge:                                      ; preds = %107, %63
  %sum_z.0.lcssa = phi double [ %75, %63 ], [ %sum_z.1, %107 ]
  %sum_y.0.lcssa = phi double [ %73, %63 ], [ %sum_y.1, %107 ]
  %sum_x.0.lcssa = phi double [ %71, %63 ], [ %sum_x.1, %107 ]
  store double %sum_x.0.lcssa, double* %70, align 8, !dbg !127, !tbaa !104
  store double %sum_y.0.lcssa, double* %72, align 8, !dbg !128, !tbaa !108
  store double %sum_z.0.lcssa, double* %74, align 8, !dbg !129, !tbaa !110
  %indvars.iv.next34 = add nuw nsw i64 %indvars.iv33, 1, !dbg !94
  %108 = load i32* %56, align 4, !dbg !94, !tbaa !96
  %109 = trunc i64 %indvars.iv.next34 to i32, !dbg !94
  %110 = icmp slt i32 %109, %108, !dbg !94
  br i1 %110, label %63, label %._crit_edge16, !dbg !94

._crit_edge16:                                    ; preds = %._crit_edge, %.lr.ph19
  %111 = add nsw i32 %b1.sroa.12.017, 1, !dbg !93
  %indvars.iv.next38 = add nuw nsw i64 %indvars.iv37, 1, !dbg !93
  %exitcond42 = icmp eq i32 %111, %46, !dbg !93
  br i1 %exitcond42, label %._crit_edge20, label %.lr.ph19, !dbg !93

._crit_edge20:                                    ; preds = %._crit_edge16, %.lr.ph23
  %112 = add nsw i32 %b1.sroa.6.021, 1, !dbg !91
  %indvars.iv.next47 = add nuw nsw i64 %indvars.iv46, 1, !dbg !91
  %exitcond51 = icmp eq i32 %112, %31, !dbg !91
  br i1 %exitcond51, label %._crit_edge24, label %.lr.ph23, !dbg !91

._crit_edge24:                                    ; preds = %._crit_edge20, %57
  %113 = add nsw i32 %b1.sroa.0.025, 1, !dbg !89
  %indvars.iv.next56 = add nuw nsw i64 %indvars.iv55, 1, !dbg !89
  %exitcond60 = icmp eq i32 %113, %17, !dbg !89
  br i1 %exitcond60, label %._crit_edge28, label %57, !dbg !89

._crit_edge28:                                    ; preds = %._crit_edge24, %41
  %indvars.iv.next62 = add nuw nsw i64 %indvars.iv61, 1, !dbg !92
  %indvars.iv.next36 = add nuw nsw i32 %indvars.iv35, 1, !dbg !92
  %indvars.iv.next40 = add i32 %indvars.iv39, -1, !dbg !92
  %exitcond63 = icmp eq i64 %indvars.iv.next62, 4, !dbg !92
  br i1 %exitcond63, label %114, label %41, !dbg !92

; <label>:114                                     ; preds = %._crit_edge28
  %indvars.iv.next65 = add nuw nsw i64 %indvars.iv64, 1, !dbg !90
  %indvars.iv.next44 = add nuw nsw i32 %indvars.iv43, 1, !dbg !90
  %indvars.iv.next49 = add i32 %indvars.iv48, -1, !dbg !90
  %exitcond66 = icmp eq i64 %indvars.iv.next65, 4, !dbg !90
  br i1 %exitcond66, label %115, label %.preheader, !dbg !90

; <label>:115                                     ; preds = %114
  %indvars.iv.next68 = add nuw nsw i64 %indvars.iv67, 1, !dbg !88
  %indvars.iv.next53 = add nuw nsw i32 %indvars.iv52, 1, !dbg !88
  %indvars.iv.next58 = add i32 %indvars.iv57, -1, !dbg !88
  %exitcond69 = icmp eq i64 %indvars.iv.next68, 4, !dbg !88
  br i1 %exitcond69, label %116, label %.preheader30, !dbg !88

; <label>:116                                     ; preds = %115
  %117 = tail call i8* @dmaStore(i8* %8, i64 0, i64 4080) #3, !dbg !130
  %118 = tail call i8* @dmaStore(i8* %8, i64 4080, i64 4080) #3, !dbg !131
  %119 = tail call i8* @dmaStore(i8* %8, i64 8160, i64 4080) #3, !dbg !132
  %120 = tail call i8* @dmaStore(i8* %8, i64 12240, i64 3120) #3, !dbg !133
  ret void, !dbg !134
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare i8* @dmaLoad(i8*, i64, i64) #2

declare i8* @dmaStore(i8*, i64, i64) #2

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nobuiltin nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!69, !70}
!llvm.ident = !{!71}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.4 (tags/RELEASE_34/final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid/md.c] [DW_LANG_C99]
!1 = metadata !{metadata !"md.c", metadata !"/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid"}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"md", metadata !"md", metadata !"", i32 10, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void ([4 x [4 x i32]]*, [4 x [4 x [10 x %struct.dvector_t]]]*, [4 x [4 x [10 x %struct.dvector_t]]]*)* @md, null, null, metadata !25, i32 13} ; [ DW_TAG_subprogram ] [line 10] [def] [scope 13] [md]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid/md.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{null, metadata !8, metadata !13, metadata !13}
!8 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !9} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!9 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 512, i64 32, i32 0, i32 0, metadata !10, metadata !11, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 512, align 32, offset 0] [from int]
!10 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!11 = metadata !{metadata !12, metadata !12}
!12 = metadata !{i32 786465, i64 0, i64 4}        ; [ DW_TAG_subrange_type ] [0, 3]
!13 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !14} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!14 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 30720, i64 64, i32 0, i32 0, metadata !15, metadata !23, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 30720, align 64, offset 0] [from dvector_t]
!15 = metadata !{i32 786454, metadata !1, null, metadata !"dvector_t", i32 25, i64 0, i64 0, i64 0, i32 0, metadata !16} ; [ DW_TAG_typedef ] [dvector_t] [line 25, size 0, align 0, offset 0] [from ]
!16 = metadata !{i32 786451, metadata !17, null, metadata !"", i32 23, i64 192, i64 64, i32 0, i32 0, null, metadata !18, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [line 23, size 192, align 64, offset 0] [def] [from ]
!17 = metadata !{metadata !"./md.h", metadata !"/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid"}
!18 = metadata !{metadata !19, metadata !21, metadata !22}
!19 = metadata !{i32 786445, metadata !17, metadata !16, metadata !"x", i32 24, i64 64, i64 64, i64 0, i32 0, metadata !20} ; [ DW_TAG_member ] [x] [line 24, size 64, align 64, offset 0] [from double]
!20 = metadata !{i32 786468, null, null, metadata !"double", i32 0, i64 64, i64 64, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [double] [line 0, size 64, align 64, offset 0, enc DW_ATE_float]
!21 = metadata !{i32 786445, metadata !17, metadata !16, metadata !"y", i32 24, i64 64, i64 64, i64 64, i32 0, metadata !20} ; [ DW_TAG_member ] [y] [line 24, size 64, align 64, offset 64] [from double]
!22 = metadata !{i32 786445, metadata !17, metadata !16, metadata !"z", i32 24, i64 64, i64 64, i64 128, i32 0, metadata !20} ; [ DW_TAG_member ] [z] [line 24, size 64, align 64, offset 128] [from double]
!23 = metadata !{metadata !12, metadata !12, metadata !24}
!24 = metadata !{i32 786465, i64 0, i64 10}       ; [ DW_TAG_subrange_type ] [0, 9]
!25 = metadata !{metadata !26, metadata !27, metadata !28, metadata !29, metadata !37, metadata !38, metadata !39, metadata !40, metadata !41, metadata !42, metadata !43, metadata !44, metadata !45, metadata !46, metadata !47, metadata !48, metadata !49, metadata !63, metadata !64, metadata !67, metadata !68}
!26 = metadata !{i32 786689, metadata !4, metadata !"n_points", metadata !5, i32 16777226, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n_points] [line 10]
!27 = metadata !{i32 786689, metadata !4, metadata !"force", metadata !5, i32 33554443, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [force] [line 11]
!28 = metadata !{i32 786689, metadata !4, metadata !"position", metadata !5, i32 50331660, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [position] [line 12]
!29 = metadata !{i32 786688, metadata !4, metadata !"b0", metadata !5, i32 14, metadata !30, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b0] [line 14]
!30 = metadata !{i32 786454, metadata !1, null, metadata !"ivector_t", i32 28, i64 0, i64 0, i64 0, i32 0, metadata !31} ; [ DW_TAG_typedef ] [ivector_t] [line 28, size 0, align 0, offset 0] [from ]
!31 = metadata !{i32 786451, metadata !17, null, metadata !"", i32 26, i64 96, i64 32, i32 0, i32 0, null, metadata !32, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [line 26, size 96, align 32, offset 0] [def] [from ]
!32 = metadata !{metadata !33, metadata !35, metadata !36}
!33 = metadata !{i32 786445, metadata !17, metadata !31, metadata !"x", i32 27, i64 32, i64 32, i64 0, i32 0, metadata !34} ; [ DW_TAG_member ] [x] [line 27, size 32, align 32, offset 0] [from int32_t]
!34 = metadata !{i32 786454, metadata !17, null, metadata !"int32_t", i32 196, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_typedef ] [int32_t] [line 196, size 0, align 0, offset 0] [from int]
!35 = metadata !{i32 786445, metadata !17, metadata !31, metadata !"y", i32 27, i64 32, i64 32, i64 32, i32 0, metadata !34} ; [ DW_TAG_member ] [y] [line 27, size 32, align 32, offset 32] [from int32_t]
!36 = metadata !{i32 786445, metadata !17, metadata !31, metadata !"z", i32 27, i64 32, i64 32, i64 64, i32 0, metadata !34} ; [ DW_TAG_member ] [z] [line 27, size 32, align 32, offset 64] [from int32_t]
!37 = metadata !{i32 786688, metadata !4, metadata !"b1", metadata !5, i32 14, metadata !30, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b1] [line 14]
!38 = metadata !{i32 786688, metadata !4, metadata !"p", metadata !5, i32 15, metadata !15, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p] [line 15]
!39 = metadata !{i32 786688, metadata !4, metadata !"q", metadata !5, i32 15, metadata !15, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [q] [line 15]
!40 = metadata !{i32 786688, metadata !4, metadata !"p_idx", metadata !5, i32 16, metadata !34, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p_idx] [line 16]
!41 = metadata !{i32 786688, metadata !4, metadata !"q_idx", metadata !5, i32 16, metadata !34, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [q_idx] [line 16]
!42 = metadata !{i32 786688, metadata !4, metadata !"dx", metadata !5, i32 17, metadata !20, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dx] [line 17]
!43 = metadata !{i32 786688, metadata !4, metadata !"dy", metadata !5, i32 17, metadata !20, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dy] [line 17]
!44 = metadata !{i32 786688, metadata !4, metadata !"dz", metadata !5, i32 17, metadata !20, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dz] [line 17]
!45 = metadata !{i32 786688, metadata !4, metadata !"r2inv", metadata !5, i32 17, metadata !20, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r2inv] [line 17]
!46 = metadata !{i32 786688, metadata !4, metadata !"r6inv", metadata !5, i32 17, metadata !20, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r6inv] [line 17]
!47 = metadata !{i32 786688, metadata !4, metadata !"potential", metadata !5, i32 17, metadata !20, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [potential] [line 17]
!48 = metadata !{i32 786688, metadata !4, metadata !"f", metadata !5, i32 17, metadata !20, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 17]
!49 = metadata !{i32 786688, metadata !50, metadata !"base_q", metadata !5, i32 41, metadata !62, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [base_q] [line 41]
!50 = metadata !{i32 786443, metadata !1, metadata !51, i32 39, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid/md.c]
!51 = metadata !{i32 786443, metadata !1, metadata !52, i32 39, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid/md.c]
!52 = metadata !{i32 786443, metadata !1, metadata !53, i32 38, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid/md.c]
!53 = metadata !{i32 786443, metadata !1, metadata !54, i32 38, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid/md.c]
!54 = metadata !{i32 786443, metadata !1, metadata !55, i32 37, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid/md.c]
!55 = metadata !{i32 786443, metadata !1, metadata !56, i32 37, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid/md.c]
!56 = metadata !{i32 786443, metadata !1, metadata !57, i32 35, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid/md.c]
!57 = metadata !{i32 786443, metadata !1, metadata !58, i32 35, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid/md.c]
!58 = metadata !{i32 786443, metadata !1, metadata !59, i32 34, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid/md.c]
!59 = metadata !{i32 786443, metadata !1, metadata !60, i32 34, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid/md.c]
!60 = metadata !{i32 786443, metadata !1, metadata !61, i32 33, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid/md.c]
!61 = metadata !{i32 786443, metadata !1, metadata !4, i32 33, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid/md.c]
!62 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !15} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from dvector_t]
!63 = metadata !{i32 786688, metadata !50, metadata !"q_idx_range", metadata !5, i32 42, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [q_idx_range] [line 42]
!64 = metadata !{i32 786688, metadata !65, metadata !"sum_x", metadata !5, i32 45, metadata !20, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sum_x] [line 45]
!65 = metadata !{i32 786443, metadata !1, metadata !66, i32 43, i32 0, i32 13} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid/md.c]
!66 = metadata !{i32 786443, metadata !1, metadata !50, i32 43, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid/md.c]
!67 = metadata !{i32 786688, metadata !65, metadata !"sum_y", metadata !5, i32 46, metadata !20, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sum_y] [line 46]
!68 = metadata !{i32 786688, metadata !65, metadata !"sum_z", metadata !5, i32 47, metadata !20, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sum_z] [line 47]
!69 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!70 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!71 = metadata !{metadata !"clang version 3.4 (tags/RELEASE_34/final)"}
!72 = metadata !{i32 10, i32 0, metadata !4, null}
!73 = metadata !{i32 11, i32 0, metadata !4, null}
!74 = metadata !{i32 12, i32 0, metadata !4, null}
!75 = metadata !{%struct.ivector_t* undef}
!76 = metadata !{i32 14, i32 0, metadata !4, null}
!77 = metadata !{%struct.dvector_t* undef}
!78 = metadata !{i32 15, i32 0, metadata !4, null}
!79 = metadata !{i32 20, i32 0, metadata !4, null}
!80 = metadata !{i32 22, i32 0, metadata !4, null}
!81 = metadata !{i32 23, i32 0, metadata !4, null}
!82 = metadata !{i32 24, i32 0, metadata !4, null}
!83 = metadata !{i32 25, i32 0, metadata !4, null}
!84 = metadata !{i32 26, i32 0, metadata !4, null}
!85 = metadata !{i32 27, i32 0, metadata !4, null}
!86 = metadata !{i32 28, i32 0, metadata !4, null}
!87 = metadata !{i32 29, i32 0, metadata !4, null}
!88 = metadata !{i32 33, i32 0, metadata !61, null}
!89 = metadata !{i32 37, i32 0, metadata !55, null}
!90 = metadata !{i32 34, i32 0, metadata !59, null}
!91 = metadata !{i32 38, i32 0, metadata !53, null}
!92 = metadata !{i32 35, i32 0, metadata !57, null}
!93 = metadata !{i32 39, i32 0, metadata !51, null}
!94 = metadata !{i32 43, i32 0, metadata !66, null}
!95 = metadata !{i32 42, i32 0, metadata !50, null}
!96 = metadata !{metadata !97, metadata !97, i64 0}
!97 = metadata !{metadata !"int", metadata !98, i64 0}
!98 = metadata !{metadata !"omnipotent char", metadata !99, i64 0}
!99 = metadata !{metadata !"Simple C/C++ TBAA"}
!100 = metadata !{i32 49, i32 0, metadata !101, null}
!101 = metadata !{i32 786443, metadata !1, metadata !65, i32 49, i32 0, i32 14} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid/md.c]
!102 = metadata !{i32 44, i32 0, metadata !65, null}
!103 = metadata !{i32 45, i32 0, metadata !65, null}
!104 = metadata !{metadata !105, metadata !106, i64 0}
!105 = metadata !{metadata !"", metadata !106, i64 0, metadata !106, i64 8, metadata !106, i64 16}
!106 = metadata !{metadata !"double", metadata !98, i64 0}
!107 = metadata !{i32 46, i32 0, metadata !65, null}
!108 = metadata !{metadata !105, metadata !106, i64 8}
!109 = metadata !{i32 47, i32 0, metadata !65, null}
!110 = metadata !{metadata !105, metadata !106, i64 16}
!111 = metadata !{i32 50, i32 0, metadata !112, null}
!112 = metadata !{i32 786443, metadata !1, metadata !101, i32 49, i32 0, i32 15} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid/md.c]
!113 = metadata !{i32 53, i32 0, metadata !114, null}
!114 = metadata !{i32 786443, metadata !1, metadata !112, i32 53, i32 0, i32 16} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid/md.c]
!115 = metadata !{i32 55, i32 0, metadata !116, null}
!116 = metadata !{i32 786443, metadata !1, metadata !114, i32 53, i32 0, i32 17} ; [ DW_TAG_lexical_block ] [/home/samerogers/gem5-aladdin/src/aladdin/MachSuite/md/grid/md.c]
!117 = metadata !{i32 56, i32 0, metadata !116, null}
!118 = metadata !{i32 57, i32 0, metadata !116, null}
!119 = metadata !{i32 58, i32 0, metadata !116, null} ; [ DW_TAG_imported_module ]
!120 = metadata !{i32 59, i32 0, metadata !116, null}
!121 = metadata !{i32 60, i32 0, metadata !116, null}
!122 = metadata !{i32 62, i32 0, metadata !116, null}
!123 = metadata !{i32 63, i32 0, metadata !116, null}
!124 = metadata !{i32 64, i32 0, metadata !116, null}
!125 = metadata !{i32 65, i32 0, metadata !116, null}
!126 = metadata !{i32 66, i32 0, metadata !116, null}
!127 = metadata !{i32 68, i32 0, metadata !65, null}
!128 = metadata !{i32 69, i32 0, metadata !65, null}
!129 = metadata !{i32 70, i32 0, metadata !65, null}
!130 = metadata !{i32 76, i32 0, metadata !4, null}
!131 = metadata !{i32 77, i32 0, metadata !4, null}
!132 = metadata !{i32 78, i32 0, metadata !4, null}
!133 = metadata !{i32 79, i32 0, metadata !4, null}
!134 = metadata !{i32 81, i32 0, metadata !4, null}
