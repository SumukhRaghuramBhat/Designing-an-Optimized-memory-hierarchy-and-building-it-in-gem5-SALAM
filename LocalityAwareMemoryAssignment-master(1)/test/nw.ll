; ModuleID = 'nw.c'
target datalayout = "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

; Function Attrs: noinline norecurse nounwind
define void @needwun(i8* nocapture readonly %SEQA, i8* nocapture readonly %SEQB, i8* nocapture %alignedA, i8* nocapture %alignedB, i32* nocapture %M, i8* nocapture %ptr) #0 {
  br label %1

; <label>:1                                       ; preds = %1, %0
  %a_idx.029 = phi i32 [ 0, %0 ], [ %4, %1 ]
  %2 = sub nsw i32 0, %a_idx.029
  %3 = getelementptr inbounds i32, i32* %M, i32 %a_idx.029
  store i32 %2, i32* %3, align 4, !tbaa !1
  %4 = add nuw nsw i32 %a_idx.029, 1
  %exitcond44 = icmp eq i32 %4, 129
  br i1 %exitcond44, label %.preheader5, label %1

.preheader5:                                      ; preds = %1, %.preheader5
  %b_idx.028 = phi i32 [ %8, %.preheader5 ], [ 0, %1 ]
  %5 = sub nsw i32 0, %b_idx.028
  %6 = mul nuw nsw i32 %b_idx.028, 129
  %7 = getelementptr inbounds i32, i32* %M, i32 %6
  store i32 %5, i32* %7, align 4, !tbaa !1
  %8 = add nuw nsw i32 %b_idx.028, 1
  %exitcond43 = icmp eq i32 %8, 129
  br i1 %exitcond43, label %.preheader3, label %.preheader5

.preheader3:                                      ; preds = %.preheader5, %47
  %b_idx.127 = phi i32 [ %48, %47 ], [ 1, %.preheader5 ]
  %9 = add nsw i32 %b_idx.127, -1
  %10 = getelementptr inbounds i8, i8* %SEQB, i32 %9
  %11 = mul nuw nsw i32 %9, 129
  %12 = mul nuw nsw i32 %b_idx.127, 129
  br label %13

; <label>:13                                      ; preds = %45, %.preheader3
  %a_idx.126 = phi i32 [ 1, %.preheader3 ], [ %46, %45 ]
  %14 = add nsw i32 %a_idx.126, -1
  %15 = getelementptr inbounds i8, i8* %SEQA, i32 %14
  %16 = load i8, i8* %15, align 1, !tbaa !5
  %17 = load i8, i8* %10, align 1, !tbaa !5
  %18 = icmp eq i8 %16, %17
  %. = select i1 %18, i32 1, i32 -1
  %19 = add nuw nsw i32 %14, %11
  %20 = getelementptr inbounds i32, i32* %M, i32 %19
  %21 = load i32, i32* %20, align 4, !tbaa !1
  %22 = add nsw i32 %., %21
  %23 = add nuw nsw i32 %a_idx.126, %11
  %24 = getelementptr inbounds i32, i32* %M, i32 %23
  %25 = load i32, i32* %24, align 4, !tbaa !1
  %26 = add nsw i32 %25, -1
  %27 = add nuw nsw i32 %14, %12
  %28 = getelementptr inbounds i32, i32* %M, i32 %27
  %29 = load i32, i32* %28, align 4, !tbaa !1
  %30 = add nsw i32 %29, -1
  %31 = icmp sgt i32 %26, %30
  %32 = select i1 %31, i32 %26, i32 %30
  %33 = icmp sgt i32 %22, %32
  %34 = select i1 %33, i32 %22, i32 %32
  %35 = add nuw nsw i32 %a_idx.126, %12
  %36 = getelementptr inbounds i32, i32* %M, i32 %35
  store i32 %34, i32* %36, align 4, !tbaa !1
  %37 = icmp eq i32 %34, %30
  br i1 %37, label %38, label %40

; <label>:38                                      ; preds = %13
  %39 = getelementptr inbounds i8, i8* %ptr, i32 %35
  store i8 60, i8* %39, align 1, !tbaa !5
  br label %45

; <label>:40                                      ; preds = %13
  %41 = icmp eq i32 %34, %26
  %42 = getelementptr inbounds i8, i8* %ptr, i32 %35
  br i1 %41, label %43, label %44

; <label>:43                                      ; preds = %40
  store i8 94, i8* %42, align 1, !tbaa !5
  br label %45

; <label>:44                                      ; preds = %40
  store i8 92, i8* %42, align 1, !tbaa !5
  br label %45

; <label>:45                                      ; preds = %38, %44, %43
  %46 = add nuw nsw i32 %a_idx.126, 1
  %exitcond41 = icmp eq i32 %46, 129
  br i1 %exitcond41, label %47, label %13

; <label>:47                                      ; preds = %45
  %48 = add nuw nsw i32 %b_idx.127, 1
  %exitcond42 = icmp eq i32 %48, 129
  br i1 %exitcond42, label %.lr.ph18, label %.preheader3

.preheader1:                                      ; preds = %.outer.backedge, %74
  %b_str_idx.0.lcssa = phi i32 [ %80, %74 ], [ %b_str_idx.0.ph.be, %.outer.backedge ]
  %a_str_idx.0.lcssa = phi i32 [ %75, %74 ], [ %a_str_idx.0.ph.be, %.outer.backedge ]
  %49 = icmp slt i32 %a_str_idx.0.lcssa, 256
  br i1 %49, label %.lr.ph14, label %.preheader

; <label>:50                                      ; preds = %.lr.ph18, %74
  %b_str_idx.017 = phi i32 [ %b_str_idx.0.ph25, %.lr.ph18 ], [ %80, %74 ]
  %a_str_idx.016 = phi i32 [ %a_str_idx.0.ph24, %.lr.ph18 ], [ %75, %74 ]
  %b_idx.215 = phi i32 [ %b_idx.2.ph23, %.lr.ph18 ], [ %77, %74 ]
  %51 = mul nsw i32 %b_idx.215, 129
  %52 = add nsw i32 %51, %a_idx.2.ph22
  %53 = getelementptr inbounds i8, i8* %ptr, i32 %52
  %54 = load i8, i8* %53, align 1, !tbaa !5
  switch i8 %54, label %74 [
    i8 92, label %55
    i8 60, label %68
  ]

; <label>:55                                      ; preds = %50
  %56 = add nsw i32 %a_idx.2.ph22, -1
  %57 = getelementptr inbounds i8, i8* %SEQA, i32 %56
  %58 = load i8, i8* %57, align 1, !tbaa !5
  %59 = getelementptr inbounds i8, i8* %alignedA, i32 %a_str_idx.016
  store i8 %58, i8* %59, align 1, !tbaa !5
  %60 = add nsw i32 %b_idx.215, -1
  %61 = getelementptr inbounds i8, i8* %SEQB, i32 %60
  %62 = load i8, i8* %61, align 1, !tbaa !5
  %63 = getelementptr inbounds i8, i8* %alignedB, i32 %b_str_idx.017
  store i8 %62, i8* %63, align 1, !tbaa !5
  br label %.outer.backedge

.outer.backedge:                                  ; preds = %55, %68
  %a_idx.2.ph.be = phi i32 [ %69, %68 ], [ %56, %55 ]
  %b_idx.2.ph.be = phi i32 [ %b_idx.215, %68 ], [ %60, %55 ]
  %b_str_idx.0.ph.be = add nsw i32 %b_str_idx.017, 1
  %a_str_idx.0.ph.be = add nsw i32 %a_str_idx.016, 1
  %64 = icmp sgt i32 %a_idx.2.ph.be, 0
  %65 = icmp sgt i32 %b_idx.2.ph.be, 0
  %66 = or i1 %64, %65
  br i1 %66, label %.lr.ph18, label %.preheader1

.lr.ph18:                                         ; preds = %47, %.outer.backedge
  %67 = phi i1 [ %64, %.outer.backedge ], [ true, %47 ]
  %b_str_idx.0.ph25 = phi i32 [ %b_str_idx.0.ph.be, %.outer.backedge ], [ 0, %47 ]
  %a_str_idx.0.ph24 = phi i32 [ %a_str_idx.0.ph.be, %.outer.backedge ], [ 0, %47 ]
  %b_idx.2.ph23 = phi i32 [ %b_idx.2.ph.be, %.outer.backedge ], [ 128, %47 ]
  %a_idx.2.ph22 = phi i32 [ %a_idx.2.ph.be, %.outer.backedge ], [ 128, %47 ]
  br label %50

; <label>:68                                      ; preds = %50
  %69 = add nsw i32 %a_idx.2.ph22, -1
  %70 = getelementptr inbounds i8, i8* %SEQA, i32 %69
  %71 = load i8, i8* %70, align 1, !tbaa !5
  %72 = getelementptr inbounds i8, i8* %alignedA, i32 %a_str_idx.016
  store i8 %71, i8* %72, align 1, !tbaa !5
  %73 = getelementptr inbounds i8, i8* %alignedB, i32 %b_str_idx.017
  store i8 45, i8* %73, align 1, !tbaa !5
  br label %.outer.backedge

; <label>:74                                      ; preds = %50
  %75 = add nsw i32 %a_str_idx.016, 1
  %76 = getelementptr inbounds i8, i8* %alignedA, i32 %a_str_idx.016
  store i8 45, i8* %76, align 1, !tbaa !5
  %77 = add nsw i32 %b_idx.215, -1
  %78 = getelementptr inbounds i8, i8* %SEQB, i32 %77
  %79 = load i8, i8* %78, align 1, !tbaa !5
  %80 = add nsw i32 %b_str_idx.017, 1
  %81 = getelementptr inbounds i8, i8* %alignedB, i32 %b_str_idx.017
  store i8 %79, i8* %81, align 1, !tbaa !5
  %82 = icmp sgt i32 %b_idx.215, 1
  %83 = or i1 %67, %82
  br i1 %83, label %50, label %.preheader1

.preheader:                                       ; preds = %.lr.ph14, %.preheader1
  %84 = icmp slt i32 %b_str_idx.0.lcssa, 256
  br i1 %84, label %.lr.ph, label %._crit_edge

.lr.ph14:                                         ; preds = %.preheader1, %.lr.ph14
  %a_str_idx.113 = phi i32 [ %86, %.lr.ph14 ], [ %a_str_idx.0.lcssa, %.preheader1 ]
  %85 = getelementptr inbounds i8, i8* %alignedA, i32 %a_str_idx.113
  store i8 95, i8* %85, align 1, !tbaa !5
  %86 = add nsw i32 %a_str_idx.113, 1
  %exitcond40 = icmp eq i32 %86, 256
  br i1 %exitcond40, label %.preheader, label %.lr.ph14

.lr.ph:                                           ; preds = %.preheader, %.lr.ph
  %b_str_idx.112 = phi i32 [ %88, %.lr.ph ], [ %b_str_idx.0.lcssa, %.preheader ]
  %87 = getelementptr inbounds i8, i8* %alignedB, i32 %b_str_idx.112
  store i8 95, i8* %87, align 1, !tbaa !5
  %88 = add nsw i32 %b_str_idx.112, 1
  %exitcond = icmp eq i32 %88, 256
  br i1 %exitcond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %.preheader
  ret void
}

attributes #0 = { noinline norecurse nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = !{!3, !3, i64 0}
