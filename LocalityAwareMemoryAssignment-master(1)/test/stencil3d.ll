; ModuleID = 'stencil3d.c'
target datalayout = "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

; Function Attrs: noinline norecurse nounwind
define void @stencil3d(i32* nocapture readonly %C, i32* nocapture readonly %orig, i32* nocapture %sol) #0 {
  br label %.preheader7

.preheader7:                                      ; preds = %14, %0
  %j.016 = phi i32 [ 0, %0 ], [ %15, %14 ]
  %1 = shl nsw i32 %j.016, 4
  %2 = shl i32 %j.016, 4
  %3 = add nuw nsw i32 %2, 15872
  br label %4

; <label>:4                                       ; preds = %4, %.preheader7
  %k.015 = phi i32 [ 0, %.preheader7 ], [ %13, %4 ]
  %5 = add nuw nsw i32 %k.015, %1
  %6 = getelementptr inbounds i32, i32* %orig, i32 %5
  %7 = load i32, i32* %6, align 4, !tbaa !1
  %8 = getelementptr inbounds i32, i32* %sol, i32 %5
  store i32 %7, i32* %8, align 4, !tbaa !1
  %9 = add nuw nsw i32 %3, %k.015
  %10 = getelementptr inbounds i32, i32* %orig, i32 %9
  %11 = load i32, i32* %10, align 4, !tbaa !1
  %12 = getelementptr inbounds i32, i32* %sol, i32 %9
  store i32 %11, i32* %12, align 4, !tbaa !1
  %13 = add nuw nsw i32 %k.015, 1
  %exitcond23 = icmp eq i32 %13, 16
  br i1 %exitcond23, label %14, label %4

; <label>:14                                      ; preds = %4
  %15 = add nuw nsw i32 %j.016, 1
  %exitcond24 = icmp eq i32 %15, 32
  br i1 %exitcond24, label %.preheader5, label %.preheader7

.preheader5:                                      ; preds = %14, %29
  %i.014 = phi i32 [ %30, %29 ], [ 1, %14 ]
  %16 = shl i32 %i.014, 9
  %17 = shl nsw i32 %i.014, 9
  %18 = or i32 %16, 496
  br label %19

; <label>:19                                      ; preds = %19, %.preheader5
  %k.113 = phi i32 [ 0, %.preheader5 ], [ %28, %19 ]
  %20 = add nuw nsw i32 %k.113, %17
  %21 = getelementptr inbounds i32, i32* %orig, i32 %20
  %22 = load i32, i32* %21, align 4, !tbaa !1
  %23 = getelementptr inbounds i32, i32* %sol, i32 %20
  store i32 %22, i32* %23, align 4, !tbaa !1
  %24 = add nuw nsw i32 %k.113, %18
  %25 = getelementptr inbounds i32, i32* %orig, i32 %24
  %26 = load i32, i32* %25, align 4, !tbaa !1
  %27 = getelementptr inbounds i32, i32* %sol, i32 %24
  store i32 %26, i32* %27, align 4, !tbaa !1
  %28 = add nuw nsw i32 %k.113, 1
  %exitcond21 = icmp eq i32 %28, 16
  br i1 %exitcond21, label %29, label %19

; <label>:29                                      ; preds = %19
  %30 = add nuw nsw i32 %i.014, 1
  %exitcond22 = icmp eq i32 %30, 31
  br i1 %exitcond22, label %.preheader3, label %.preheader5

.preheader3:                                      ; preds = %29, %44
  %i.112 = phi i32 [ %45, %44 ], [ 1, %29 ]
  %31 = shl i32 %i.112, 5
  br label %33

.preheader2:                                      ; preds = %44
  %32 = getelementptr inbounds i32, i32* %C, i32 1
  br label %.preheader1

; <label>:33                                      ; preds = %33, %.preheader3
  %j.111 = phi i32 [ 1, %.preheader3 ], [ %43, %33 ]
  %34 = add nuw nsw i32 %j.111, %31
  %35 = shl nsw i32 %34, 4
  %36 = getelementptr inbounds i32, i32* %orig, i32 %35
  %37 = load i32, i32* %36, align 4, !tbaa !1
  %38 = getelementptr inbounds i32, i32* %sol, i32 %35
  store i32 %37, i32* %38, align 4, !tbaa !1
  %39 = or i32 %35, 15
  %40 = getelementptr inbounds i32, i32* %orig, i32 %39
  %41 = load i32, i32* %40, align 4, !tbaa !1
  %42 = getelementptr inbounds i32, i32* %sol, i32 %39
  store i32 %41, i32* %42, align 4, !tbaa !1
  %43 = add nuw nsw i32 %j.111, 1
  %exitcond19 = icmp eq i32 %43, 31
  br i1 %exitcond19, label %44, label %33

; <label>:44                                      ; preds = %33
  %45 = add nuw nsw i32 %i.112, 1
  %exitcond20 = icmp eq i32 %45, 31
  br i1 %exitcond20, label %.preheader2, label %.preheader3

.preheader1:                                      ; preds = %99, %.preheader2
  %i.210 = phi i32 [ 1, %.preheader2 ], [ %100, %99 ]
  %46 = shl nsw i32 %i.210, 5
  %47 = shl i32 %i.210, 5
  %48 = add nuw nsw i32 %47, 32
  %49 = add nuw nsw i32 %47, 268435424
  %50 = or i32 %46, 1
  %51 = add nuw nsw i32 %46, 268435455
  br label %.preheader

.preheader:                                       ; preds = %97, %.preheader1
  %j.29 = phi i32 [ 1, %.preheader1 ], [ %98, %97 ]
  %52 = add nuw nsw i32 %j.29, %46
  %53 = shl nsw i32 %52, 4
  %54 = add nuw nsw i32 %48, %j.29
  %55 = shl i32 %54, 4
  %56 = add nuw nsw i32 %49, %j.29
  %57 = shl i32 %56, 4
  %58 = add nuw nsw i32 %50, %j.29
  %59 = shl i32 %58, 4
  %60 = add nuw nsw i32 %51, %j.29
  %61 = shl i32 %60, 4
  %62 = add nsw i32 %53, -1
  br label %63

; <label>:63                                      ; preds = %63, %.preheader
  %k.28 = phi i32 [ 1, %.preheader ], [ %82, %63 ]
  %64 = add nuw nsw i32 %k.28, %53
  %65 = getelementptr inbounds i32, i32* %orig, i32 %64
  %66 = load i32, i32* %65, align 4, !tbaa !1
  %67 = add nuw nsw i32 %k.28, %55
  %68 = getelementptr inbounds i32, i32* %orig, i32 %67
  %69 = load i32, i32* %68, align 4, !tbaa !1
  %70 = add nuw nsw i32 %k.28, %57
  %71 = getelementptr inbounds i32, i32* %orig, i32 %70
  %72 = load i32, i32* %71, align 4, !tbaa !1
  %73 = add nsw i32 %72, %69
  %74 = add nuw nsw i32 %k.28, %59
  %75 = getelementptr inbounds i32, i32* %orig, i32 %74
  %76 = load i32, i32* %75, align 4, !tbaa !1
  %77 = add nsw i32 %73, %76
  %78 = add nuw nsw i32 %k.28, %61
  %79 = getelementptr inbounds i32, i32* %orig, i32 %78
  %80 = load i32, i32* %79, align 4, !tbaa !1
  %81 = add nsw i32 %77, %80
  %82 = add nuw nsw i32 %k.28, 1
  %83 = add nuw nsw i32 %82, %53
  %84 = getelementptr inbounds i32, i32* %orig, i32 %83
  %85 = load i32, i32* %84, align 4, !tbaa !1
  %86 = add nsw i32 %81, %85
  %87 = add nuw nsw i32 %62, %k.28
  %88 = getelementptr inbounds i32, i32* %orig, i32 %87
  %89 = load i32, i32* %88, align 4, !tbaa !1
  %90 = add nsw i32 %86, %89
  %91 = load i32, i32* %C, align 4, !tbaa !1
  %92 = mul nsw i32 %91, %66
  %93 = load i32, i32* %32, align 4, !tbaa !1
  %94 = mul nsw i32 %93, %90
  %95 = add nsw i32 %94, %92
  %96 = getelementptr inbounds i32, i32* %sol, i32 %64
  store i32 %95, i32* %96, align 4, !tbaa !1
  %exitcond = icmp eq i32 %82, 15
  br i1 %exitcond, label %97, label %63

; <label>:97                                      ; preds = %63
  %98 = add nuw nsw i32 %j.29, 1
  %exitcond17 = icmp eq i32 %98, 31
  br i1 %exitcond17, label %99, label %.preheader

; <label>:99                                      ; preds = %97
  %100 = add nuw nsw i32 %i.210, 1
  %exitcond18 = icmp eq i32 %100, 31
  br i1 %exitcond18, label %101, label %.preheader1

; <label>:101                                     ; preds = %99
  ret void
}

attributes #0 = { noinline norecurse nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
