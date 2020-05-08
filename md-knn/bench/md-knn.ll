; ModuleID = 'md-knn.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline norecurse nounwind uwtable
define void @md_kernel(double* nocapture %force_x, double* nocapture %force_y, double* nocapture %force_z, double* nocapture readonly %position_x, double* nocapture readonly %position_y, double* nocapture readonly %position_z, i32* nocapture readonly %NL) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.end, %entry
  %indvars.iv99 = phi i64 [ 0, %entry ], [ %indvars.iv.next100, %for.end ]
  %arrayidx = getelementptr inbounds double, double* %position_x, i64 %indvars.iv99
  %0 = load double, double* %arrayidx, align 8, !tbaa !1
  %arrayidx2 = getelementptr inbounds double, double* %position_y, i64 %indvars.iv99
  %1 = load double, double* %arrayidx2, align 8, !tbaa !1
  %arrayidx4 = getelementptr inbounds double, double* %position_z, i64 %indvars.iv99
  %2 = load double, double* %arrayidx4, align 8, !tbaa !1
  %3 = shl i64 %indvars.iv99, 4
  br label %for.body7

for.body7:                                        ; preds = %for.body7, %for.body
  %indvars.iv = phi i64 [ 0, %for.body ], [ %indvars.iv.next, %for.body7 ]
  %fx.096 = phi double [ 0.000000e+00, %for.body ], [ %add30, %for.body7 ]
  %fz.094 = phi double [ 0.000000e+00, %for.body ], [ %add34, %for.body7 ]
  %fy.093 = phi double [ 0.000000e+00, %for.body ], [ %add32, %for.body7 ]
  %4 = add nuw nsw i64 %indvars.iv, %3
  %arrayidx9 = getelementptr inbounds i32, i32* %NL, i64 %4
  %5 = load i32, i32* %arrayidx9, align 4, !tbaa !5
  %idxprom10 = sext i32 %5 to i64
  %arrayidx11 = getelementptr inbounds double, double* %position_x, i64 %idxprom10
  %6 = load double, double* %arrayidx11, align 8, !tbaa !1
  %arrayidx13 = getelementptr inbounds double, double* %position_y, i64 %idxprom10
  %7 = load double, double* %arrayidx13, align 8, !tbaa !1
  %arrayidx15 = getelementptr inbounds double, double* %position_z, i64 %idxprom10
  %8 = load double, double* %arrayidx15, align 8, !tbaa !1
  %sub = fsub double %0, %6
  %sub16 = fsub double %1, %7
  %sub17 = fsub double %2, %8
  %mul18 = fmul double %sub, %sub
  %mul19 = fmul double %sub16, %sub16
  %add20 = fadd double %mul18, %mul19
  %mul21 = fmul double %sub17, %sub17
  %add22 = fadd double %add20, %mul21
  %div = fdiv double 1.000000e+00, %add22
  %mul23 = fmul double %div, %div
  %mul24 = fmul double %div, %mul23
  %mul25 = fmul double %mul24, 1.500000e+00
  %sub26 = fadd double %mul25, -2.000000e+00
  %mul27 = fmul double %mul24, %sub26
  %mul28 = fmul double %div, %mul27
  %mul29 = fmul double %sub, %mul28
  %add30 = fadd double %fx.096, %mul29
  %mul31 = fmul double %sub16, %mul28
  %add32 = fadd double %fy.093, %mul31
  %mul33 = fmul double %sub17, %mul28
  %add34 = fadd double %fz.094, %mul33
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 16
  br i1 %exitcond, label %for.end, label %for.body7

for.end:                                          ; preds = %for.body7
  %arrayidx36 = getelementptr inbounds double, double* %force_x, i64 %indvars.iv99
  store double %add30, double* %arrayidx36, align 8, !tbaa !1
  %arrayidx38 = getelementptr inbounds double, double* %force_y, i64 %indvars.iv99
  store double %add32, double* %arrayidx38, align 8, !tbaa !1
  %arrayidx40 = getelementptr inbounds double, double* %force_z, i64 %indvars.iv99
  store double %add34, double* %arrayidx40, align 8, !tbaa !1
  %indvars.iv.next100 = add nuw nsw i64 %indvars.iv99, 1
  %exitcond102 = icmp eq i64 %indvars.iv.next100, 256
  br i1 %exitcond102, label %for.end43, label %for.body

for.end43:                                        ; preds = %for.end
  ret void
}

attributes #0 = { noinline norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0 (tags/RELEASE_381/final)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"double", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = !{!6, !6, i64 0}
!6 = !{!"int", !3, i64 0}
