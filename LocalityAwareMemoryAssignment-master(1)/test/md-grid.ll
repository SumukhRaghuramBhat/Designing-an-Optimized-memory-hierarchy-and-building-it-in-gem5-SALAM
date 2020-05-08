; ModuleID = 'md-grid.c'
target datalayout = "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

%struct.dvector_t = type { double, double, double }

; Function Attrs: noinline norecurse nounwind
define void @md([4 x [4 x i32]]* nocapture readonly %n_points, [4 x [4 x [10 x %struct.dvector_t]]]* nocapture %force, [4 x [4 x [10 x %struct.dvector_t]]]* nocapture readonly %position) #0 {
  br label %.preheader2

.preheader2:                                      ; preds = %88, %0
  %b0.sroa.0.031 = phi i32 [ 0, %0 ], [ %89, %88 ]
  %1 = add nsw i32 %b0.sroa.0.031, -1
  %2 = icmp slt i32 %1, 0
  %3 = select i1 %2, i32 0, i32 %1
  %4 = add nuw nsw i32 %b0.sroa.0.031, 2
  %5 = icmp sgt i32 %4, 4
  %6 = select i1 %5, i32 4, i32 %4
  %7 = icmp slt i32 %3, %6
  br label %.preheader

.preheader:                                       ; preds = %86, %.preheader2
  %b0.sroa.18.030 = phi i32 [ 0, %.preheader2 ], [ %87, %86 ]
  %8 = add nsw i32 %b0.sroa.18.030, -1
  %9 = icmp slt i32 %8, 0
  %10 = select i1 %9, i32 0, i32 %8
  %11 = add nuw nsw i32 %b0.sroa.18.030, 2
  %12 = icmp sgt i32 %11, 4
  %13 = select i1 %12, i32 4, i32 %11
  %14 = icmp slt i32 %10, %13
  br label %15

; <label>:15                                      ; preds = %._crit_edge27, %.preheader
  %b0.sroa.34.028 = phi i32 [ 0, %.preheader ], [ %85, %._crit_edge27 ]
  br i1 %7, label %.lr.ph26, label %._crit_edge27

.lr.ph26:                                         ; preds = %15
  %16 = add nsw i32 %b0.sroa.34.028, -1
  %17 = icmp slt i32 %16, 0
  %18 = select i1 %17, i32 0, i32 %16
  %19 = add nuw nsw i32 %b0.sroa.34.028, 2
  %20 = icmp sgt i32 %19, 4
  %21 = select i1 %20, i32 4, i32 %19
  %22 = icmp slt i32 %18, %21
  %23 = getelementptr inbounds [4 x [4 x i32]], [4 x [4 x i32]]* %n_points, i32 %b0.sroa.0.031, i32 %b0.sroa.18.030, i32 %b0.sroa.34.028
  br label %24

; <label>:24                                      ; preds = %.lr.ph26, %._crit_edge22
  %b1.sroa.0.023 = phi i32 [ %3, %.lr.ph26 ], [ %83, %._crit_edge22 ]
  br i1 %14, label %.lr.ph21, label %._crit_edge22

.lr.ph21:                                         ; preds = %24, %._crit_edge17
  %b1.sroa.8.018 = phi i32 [ %81, %._crit_edge17 ], [ %10, %24 ]
  br i1 %22, label %.lr.ph16, label %._crit_edge17

.lr.ph16:                                         ; preds = %.lr.ph21, %._crit_edge12
  %b1.sroa.14.013 = phi i32 [ %79, %._crit_edge12 ], [ %18, %.lr.ph21 ]
  %25 = getelementptr inbounds [4 x [4 x i32]], [4 x [4 x i32]]* %n_points, i32 %b1.sroa.0.023, i32 %b1.sroa.8.018, i32 %b1.sroa.14.013
  %26 = load i32, i32* %25, align 4, !tbaa !1
  %27 = load i32, i32* %23, align 4, !tbaa !1
  %28 = icmp sgt i32 %27, 0
  br i1 %28, label %.lr.ph11, label %._crit_edge12

.lr.ph11:                                         ; preds = %.lr.ph16
  %29 = icmp sgt i32 %26, 0
  br label %30

; <label>:30                                      ; preds = %.lr.ph11, %._crit_edge
  %p_idx.09 = phi i32 [ 0, %.lr.ph11 ], [ %76, %._crit_edge ]
  %31 = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]], [4 x [4 x [10 x %struct.dvector_t]]]* %position, i32 %b0.sroa.0.031, i32 %b0.sroa.18.030, i32 %b0.sroa.34.028, i32 %p_idx.09, i32 0
  %32 = load double, double* %31, align 4
  %33 = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]], [4 x [4 x [10 x %struct.dvector_t]]]* %position, i32 %b0.sroa.0.031, i32 %b0.sroa.18.030, i32 %b0.sroa.34.028, i32 %p_idx.09, i32 1
  %34 = load double, double* %33, align 4
  %35 = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]], [4 x [4 x [10 x %struct.dvector_t]]]* %position, i32 %b0.sroa.0.031, i32 %b0.sroa.18.030, i32 %b0.sroa.34.028, i32 %p_idx.09, i32 2
  %36 = load double, double* %35, align 4
  %37 = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]], [4 x [4 x [10 x %struct.dvector_t]]]* %force, i32 %b0.sroa.0.031, i32 %b0.sroa.18.030, i32 %b0.sroa.34.028, i32 %p_idx.09, i32 0
  %38 = load double, double* %37, align 4, !tbaa !5
  %39 = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]], [4 x [4 x [10 x %struct.dvector_t]]]* %force, i32 %b0.sroa.0.031, i32 %b0.sroa.18.030, i32 %b0.sroa.34.028, i32 %p_idx.09, i32 1
  %40 = load double, double* %39, align 4, !tbaa !8
  %41 = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]], [4 x [4 x [10 x %struct.dvector_t]]]* %force, i32 %b0.sroa.0.031, i32 %b0.sroa.18.030, i32 %b0.sroa.34.028, i32 %p_idx.09, i32 2
  %42 = load double, double* %41, align 4, !tbaa !9
  br i1 %29, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %30, %74
  %sum_z.06 = phi double [ %sum_z.1, %74 ], [ %42, %30 ]
  %sum_y.05 = phi double [ %sum_y.1, %74 ], [ %40, %30 ]
  %sum_x.04 = phi double [ %sum_x.1, %74 ], [ %38, %30 ]
  %q_idx.03 = phi i32 [ %75, %74 ], [ 0, %30 ]
  %43 = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]], [4 x [4 x [10 x %struct.dvector_t]]]* %position, i32 %b1.sroa.0.023, i32 %b1.sroa.8.018, i32 %b1.sroa.14.013, i32 %q_idx.03, i32 0
  %44 = load double, double* %43, align 4
  %45 = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]], [4 x [4 x [10 x %struct.dvector_t]]]* %position, i32 %b1.sroa.0.023, i32 %b1.sroa.8.018, i32 %b1.sroa.14.013, i32 %q_idx.03, i32 1
  %46 = load double, double* %45, align 4
  %47 = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]], [4 x [4 x [10 x %struct.dvector_t]]]* %position, i32 %b1.sroa.0.023, i32 %b1.sroa.8.018, i32 %b1.sroa.14.013, i32 %q_idx.03, i32 2
  %48 = load double, double* %47, align 4
  %49 = fcmp une double %44, %32
  %50 = fcmp une double %46, %34
  %or.cond = or i1 %49, %50
  %51 = fcmp une double %48, %36
  %or.cond1 = or i1 %or.cond, %51
  br i1 %or.cond1, label %52, label %74

; <label>:52                                      ; preds = %.lr.ph
  %53 = fsub double %32, %44
  %54 = fsub double %34, %46
  %55 = fsub double %36, %48
  %56 = fmul double %53, %53
  %57 = fmul double %54, %54
  %58 = fadd double %56, %57
  %59 = fmul double %55, %55
  %60 = fadd double %58, %59
  %61 = fdiv double 1.000000e+00, %60
  %62 = fmul double %61, %61
  %63 = fmul double %61, %62
  %64 = fmul double %63, 1.500000e+00
  %65 = fadd double %64, -2.000000e+00
  %66 = fmul double %63, %65
  %67 = fmul double %61, %66
  %68 = fmul double %53, %67
  %69 = fadd double %sum_x.04, %68
  %70 = fmul double %54, %67
  %71 = fadd double %sum_y.05, %70
  %72 = fmul double %55, %67
  %73 = fadd double %sum_z.06, %72
  br label %74

; <label>:74                                      ; preds = %.lr.ph, %52
  %sum_x.1 = phi double [ %69, %52 ], [ %sum_x.04, %.lr.ph ]
  %sum_y.1 = phi double [ %71, %52 ], [ %sum_y.05, %.lr.ph ]
  %sum_z.1 = phi double [ %73, %52 ], [ %sum_z.06, %.lr.ph ]
  %75 = add nuw nsw i32 %q_idx.03, 1
  %exitcond = icmp eq i32 %75, %26
  br i1 %exitcond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %74, %30
  %sum_z.0.lcssa = phi double [ %42, %30 ], [ %sum_z.1, %74 ]
  %sum_y.0.lcssa = phi double [ %40, %30 ], [ %sum_y.1, %74 ]
  %sum_x.0.lcssa = phi double [ %38, %30 ], [ %sum_x.1, %74 ]
  store double %sum_x.0.lcssa, double* %37, align 4, !tbaa !5
  store double %sum_y.0.lcssa, double* %39, align 4, !tbaa !8
  store double %sum_z.0.lcssa, double* %41, align 4, !tbaa !9
  %76 = add nuw nsw i32 %p_idx.09, 1
  %77 = load i32, i32* %23, align 4, !tbaa !1
  %78 = icmp slt i32 %76, %77
  br i1 %78, label %30, label %._crit_edge12

._crit_edge12:                                    ; preds = %._crit_edge, %.lr.ph16
  %79 = add nuw nsw i32 %b1.sroa.14.013, 1
  %80 = icmp slt i32 %79, %21
  br i1 %80, label %.lr.ph16, label %._crit_edge17

._crit_edge17:                                    ; preds = %._crit_edge12, %.lr.ph21
  %81 = add nuw nsw i32 %b1.sroa.8.018, 1
  %82 = icmp slt i32 %81, %13
  br i1 %82, label %.lr.ph21, label %._crit_edge22

._crit_edge22:                                    ; preds = %._crit_edge17, %24
  %83 = add nuw nsw i32 %b1.sroa.0.023, 1
  %84 = icmp slt i32 %83, %6
  br i1 %84, label %24, label %._crit_edge27

._crit_edge27:                                    ; preds = %._crit_edge22, %15
  %85 = add nuw nsw i32 %b0.sroa.34.028, 1
  %exitcond32 = icmp eq i32 %85, 4
  br i1 %exitcond32, label %86, label %15

; <label>:86                                      ; preds = %._crit_edge27
  %87 = add nuw nsw i32 %b0.sroa.18.030, 1
  %exitcond33 = icmp eq i32 %87, 4
  br i1 %exitcond33, label %88, label %.preheader

; <label>:88                                      ; preds = %86
  %89 = add nuw nsw i32 %b0.sroa.0.031, 1
  %exitcond34 = icmp eq i32 %89, 4
  br i1 %exitcond34, label %90, label %.preheader2

; <label>:90                                      ; preds = %88
  ret void
}

attributes #0 = { noinline norecurse nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = !{!6, !7, i64 0}
!6 = !{!"", !7, i64 0, !7, i64 8, !7, i64 16}
!7 = !{!"double", !3, i64 0}
!8 = !{!6, !7, i64 8}
!9 = !{!6, !7, i64 16}
