; ModuleID = 'spmv.c'
target datalayout = "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

; Function Attrs: noinline norecurse nounwind
define void @spmv(double* nocapture readonly %val, i32* nocapture readonly %cols, i32* nocapture readonly %rowDelimiters, double* nocapture readonly %vec, double* nocapture %out) #0 {
  br label %1

; <label>:1                                       ; preds = %._crit_edge, %0
  %i.03 = phi i32 [ 0, %0 ], [ %4, %._crit_edge ]
  %2 = getelementptr inbounds i32, i32* %rowDelimiters, i32 %i.03
  %3 = load i32, i32* %2, align 4, !tbaa !1
  %4 = add nuw nsw i32 %i.03, 1
  %5 = getelementptr inbounds i32, i32* %rowDelimiters, i32 %4
  %6 = load i32, i32* %5, align 4, !tbaa !1
  %7 = icmp slt i32 %3, %6
  br i1 %7, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %1, %.lr.ph
  %j.02 = phi i32 [ %16, %.lr.ph ], [ %3, %1 ]
  %sum.01 = phi double [ %15, %.lr.ph ], [ 0.000000e+00, %1 ]
  %8 = getelementptr inbounds double, double* %val, i32 %j.02
  %9 = load double, double* %8, align 4, !tbaa !5
  %10 = getelementptr inbounds i32, i32* %cols, i32 %j.02
  %11 = load i32, i32* %10, align 4, !tbaa !1
  %12 = getelementptr inbounds double, double* %vec, i32 %11
  %13 = load double, double* %12, align 4, !tbaa !5
  %14 = fmul double %9, %13
  %15 = fadd double %sum.01, %14
  %16 = add nsw i32 %j.02, 1
  %exitcond = icmp eq i32 %16, %6
  br i1 %exitcond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %1
  %sum.0.lcssa = phi double [ 0.000000e+00, %1 ], [ %15, %.lr.ph ]
  %17 = getelementptr inbounds double, double* %out, i32 %i.03
  store double %sum.0.lcssa, double* %17, align 4, !tbaa !5
  %exitcond4 = icmp eq i32 %4, 494
  br i1 %exitcond4, label %18, label %1

; <label>:18                                      ; preds = %._crit_edge
  ret void
}

attributes #0 = { noinline norecurse nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = !{!6, !6, i64 0}
!6 = !{!"double", !3, i64 0}
