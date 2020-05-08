; ModuleID = 'gemm.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline norecurse nounwind uwtable
define void @gemm(double* nocapture readonly %m1, double* nocapture readonly %m2, double* nocapture %prod) #0 {
  br label %.preheader

.preheader:                                       ; preds = %16, %0
  %indvars.iv8 = phi i64 [ 0, %0 ], [ %indvars.iv.next9, %16 ]
  %1 = shl nsw i64 %indvars.iv8, 6
  br label %2

; <label>:2                                       ; preds = %13, %.preheader
  %indvars.iv5 = phi i64 [ 0, %.preheader ], [ %indvars.iv.next6, %13 ]
  br label %3

; <label>:3                                       ; preds = %3, %2
  %indvars.iv = phi i64 [ 0, %2 ], [ %indvars.iv.next, %3 ]
  %sum.02 = phi double [ 0.000000e+00, %2 ], [ %12, %3 ]
  %4 = shl i64 %indvars.iv, 6
  %5 = add nuw nsw i64 %indvars.iv, %1
  %6 = getelementptr inbounds double, double* %m1, i64 %5
  %7 = load double, double* %6, align 8, !tbaa !1
  %8 = add nuw nsw i64 %4, %indvars.iv5
  %9 = getelementptr inbounds double, double* %m2, i64 %8
  %10 = load double, double* %9, align 8, !tbaa !1
  %11 = fmul double %7, %10
  %12 = fadd double %sum.02, %11
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 64
  br i1 %exitcond, label %13, label %3, !llvm.loop !5

; <label>:13                                      ; preds = %3
  %14 = add nuw nsw i64 %indvars.iv5, %1
  %15 = getelementptr inbounds double, double* %prod, i64 %14
  store double %12, double* %15, align 8, !tbaa !1
  %indvars.iv.next6 = add nuw nsw i64 %indvars.iv5, 1
  %exitcond7 = icmp eq i64 %indvars.iv.next6, 64
  br i1 %exitcond7, label %16, label %2, !llvm.loop !7

; <label>:16                                      ; preds = %13
  %indvars.iv.next9 = add nuw nsw i64 %indvars.iv8, 1
  %exitcond10 = icmp eq i64 %indvars.iv.next9, 64
  br i1 %exitcond10, label %17, label %.preheader, !llvm.loop !8

; <label>:17                                      ; preds = %16
  ret void
}

attributes #0 = { noinline norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"double", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.unroll.full"}
!7 = distinct !{!7, !6}
!8 = distinct !{!8, !6}
