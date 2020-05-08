; ModuleID = 'spmv.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline norecurse nounwind uwtable
define void @spmv(double* nocapture readonly %val, i32* nocapture readonly %cols, i32* nocapture readonly %rowDelimiters, double* nocapture readonly %vec, double* nocapture %out) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.end, %entry
  %indvars.iv37 = phi i64 [ 0, %entry ], [ %indvars.iv.next38, %for.end ]
  %arrayidx = getelementptr inbounds i32, i32* %rowDelimiters, i64 %indvars.iv37
  %0 = load i32, i32* %arrayidx, align 4, !tbaa !1
  %indvars.iv.next38 = add nuw nsw i64 %indvars.iv37, 1
  %arrayidx2 = getelementptr inbounds i32, i32* %rowDelimiters, i64 %indvars.iv.next38
  %1 = load i32, i32* %arrayidx2, align 4, !tbaa !1
  %cmp433 = icmp slt i32 %0, %1
  br i1 %cmp433, label %for.body5.preheader, label %for.end

for.body5.preheader:                              ; preds = %for.body
  %2 = sext i32 %0 to i64
  br label %for.body5

for.body5:                                        ; preds = %for.body5, %for.body5.preheader
  %indvars.iv = phi i64 [ %2, %for.body5.preheader ], [ %indvars.iv.next, %for.body5 ]
  %sum.034 = phi double [ 0.000000e+00, %for.body5.preheader ], [ %add12, %for.body5 ]
  %arrayidx7 = getelementptr inbounds double, double* %val, i64 %indvars.iv
  %3 = load double, double* %arrayidx7, align 8, !tbaa !5
  %arrayidx9 = getelementptr inbounds i32, i32* %cols, i64 %indvars.iv
  %4 = load i32, i32* %arrayidx9, align 4, !tbaa !1
  %idxprom10 = sext i32 %4 to i64
  %arrayidx11 = getelementptr inbounds double, double* %vec, i64 %idxprom10
  %5 = load double, double* %arrayidx11, align 8, !tbaa !5
  %mul = fmul double %3, %5
  %add12 = fadd double %sum.034, %mul
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %1
  br i1 %exitcond, label %for.end, label %for.body5

for.end:                                          ; preds = %for.body5, %for.body
  %sum.0.lcssa = phi double [ 0.000000e+00, %for.body ], [ %add12, %for.body5 ]
  %arrayidx14 = getelementptr inbounds double, double* %out, i64 %indvars.iv37
  store double %sum.0.lcssa, double* %arrayidx14, align 8, !tbaa !5
  %exitcond39 = icmp eq i64 %indvars.iv.next38, 494
  br i1 %exitcond39, label %for.end17, label %for.body

for.end17:                                        ; preds = %for.end
  ret void
}

attributes #0 = { noinline norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0 (tags/RELEASE_381/final)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = !{!6, !6, i64 0}
!6 = !{!"double", !3, i64 0}
