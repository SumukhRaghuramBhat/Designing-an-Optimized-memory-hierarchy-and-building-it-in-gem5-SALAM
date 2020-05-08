; ModuleID = 'stencil2d.c'
target datalayout = "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

; Function Attrs: noinline norecurse nounwind
define void @stencil(i32* nocapture readonly %orig, i32* nocapture %sol, i32* nocapture readonly %filter) #0 {
  br label %.preheader2

.preheader2:                                      ; preds = %22, %0
  %r.08 = phi i32 [ 0, %0 ], [ %23, %22 ]
  %1 = shl i32 %r.08, 6
  br label %.preheader1

.preheader1:                                      ; preds = %18, %.preheader2
  %c.07 = phi i32 [ 0, %.preheader2 ], [ %21, %18 ]
  br label %.preheader

.preheader:                                       ; preds = %16, %.preheader1
  %temp.06 = phi i32 [ 0, %.preheader1 ], [ %14, %16 ]
  %k1.05 = phi i32 [ 0, %.preheader1 ], [ %17, %16 ]
  %2 = mul nuw nsw i32 %k1.05, 3
  %3 = add nuw nsw i32 %k1.05, %r.08
  %4 = shl i32 %3, 6
  %5 = add nuw nsw i32 %4, %c.07
  br label %6

; <label>:6                                       ; preds = %6, %.preheader
  %temp.14 = phi i32 [ %temp.06, %.preheader ], [ %14, %6 ]
  %k2.03 = phi i32 [ 0, %.preheader ], [ %15, %6 ]
  %7 = add nuw nsw i32 %k2.03, %2
  %8 = getelementptr inbounds i32, i32* %filter, i32 %7
  %9 = load i32, i32* %8, align 4, !tbaa !1
  %10 = add nuw nsw i32 %5, %k2.03
  %11 = getelementptr inbounds i32, i32* %orig, i32 %10
  %12 = load i32, i32* %11, align 4, !tbaa !1
  %13 = mul nsw i32 %12, %9
  %14 = add nsw i32 %13, %temp.14
  %15 = add nuw nsw i32 %k2.03, 1
  %exitcond = icmp eq i32 %15, 3
  br i1 %exitcond, label %16, label %6

; <label>:16                                      ; preds = %6
  %17 = add nuw nsw i32 %k1.05, 1
  %exitcond9 = icmp eq i32 %17, 3
  br i1 %exitcond9, label %18, label %.preheader

; <label>:18                                      ; preds = %16
  %19 = add nuw nsw i32 %c.07, %1
  %20 = getelementptr inbounds i32, i32* %sol, i32 %19
  store i32 %14, i32* %20, align 4, !tbaa !1
  %21 = add nuw nsw i32 %c.07, 1
  %exitcond10 = icmp eq i32 %21, 62
  br i1 %exitcond10, label %22, label %.preheader1

; <label>:22                                      ; preds = %18
  %23 = add nuw nsw i32 %r.08, 1
  %exitcond11 = icmp eq i32 %23, 126
  br i1 %exitcond11, label %24, label %.preheader2

; <label>:24                                      ; preds = %22
  ret void
}

attributes #0 = { noinline norecurse nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
