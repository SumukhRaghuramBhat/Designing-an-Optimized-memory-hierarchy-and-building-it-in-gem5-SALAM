; ModuleID = 'bfs.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.node_t_struct = type { i64, i64 }
%struct.edge_t_struct = type { i64 }

; Function Attrs: noinline norecurse nounwind uwtable
define void @bfs(%struct.node_t_struct* nocapture readonly %nodes, %struct.edge_t_struct* nocapture readonly %edges, i64 %starting_node, i8* nocapture %level, i64* nocapture %level_counts) #0 {
  %1 = getelementptr inbounds i8, i8* %level, i64 %starting_node
  store i8 0, i8* %1, align 1, !tbaa !1
  store i64 1, i64* %level_counts, align 8, !tbaa !4
  br label %.preheader

.preheader:                                       ; preds = %24, %0
  %indvars.iv = phi i64 [ 0, %0 ], [ %indvars.iv.next, %24 ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %2 = trunc i64 %indvars.iv.next to i8
  br label %3

; <label>:3                                       ; preds = %.loopexit, %.preheader
  %n.04 = phi i64 [ 0, %.preheader ], [ %23, %.loopexit ]
  %cnt.03 = phi i64 [ 0, %.preheader ], [ %cnt.3, %.loopexit ]
  %4 = getelementptr inbounds i8, i8* %level, i64 %n.04
  %5 = load i8, i8* %4, align 1, !tbaa !1
  %6 = zext i8 %5 to i64
  %7 = icmp eq i64 %6, %indvars.iv
  br i1 %7, label %8, label %.loopexit

; <label>:8                                       ; preds = %3
  %9 = getelementptr inbounds %struct.node_t_struct, %struct.node_t_struct* %nodes, i64 %n.04, i32 0
  %10 = load i64, i64* %9, align 8, !tbaa !6
  %11 = getelementptr inbounds %struct.node_t_struct, %struct.node_t_struct* %nodes, i64 %n.04, i32 1
  %12 = load i64, i64* %11, align 8, !tbaa !8
  %13 = icmp ult i64 %10, %12
  br i1 %13, label %.lr.ph, label %.loopexit

.lr.ph:                                           ; preds = %8, %21
  %e.02 = phi i64 [ %22, %21 ], [ %10, %8 ]
  %cnt.11 = phi i64 [ %cnt.2, %21 ], [ %cnt.03, %8 ]
  %14 = getelementptr inbounds %struct.edge_t_struct, %struct.edge_t_struct* %edges, i64 %e.02, i32 0
  %15 = load i64, i64* %14, align 8, !tbaa !9
  %16 = getelementptr inbounds i8, i8* %level, i64 %15
  %17 = load i8, i8* %16, align 1, !tbaa !1
  %18 = icmp eq i8 %17, 127
  br i1 %18, label %19, label %21

; <label>:19                                      ; preds = %.lr.ph
  store i8 %2, i8* %16, align 1, !tbaa !1
  %20 = add i64 %cnt.11, 1
  br label %21

; <label>:21                                      ; preds = %19, %.lr.ph
  %cnt.2 = phi i64 [ %20, %19 ], [ %cnt.11, %.lr.ph ]
  %22 = add nuw i64 %e.02, 1
  %exitcond = icmp eq i64 %22, %12
  br i1 %exitcond, label %.loopexit, label %.lr.ph

.loopexit:                                        ; preds = %21, %8, %3
  %cnt.3 = phi i64 [ %cnt.03, %3 ], [ %cnt.03, %8 ], [ %cnt.2, %21 ]
  %23 = add nuw nsw i64 %n.04, 1
  %exitcond6 = icmp eq i64 %23, 256
  br i1 %exitcond6, label %24, label %3

; <label>:24                                      ; preds = %.loopexit
  %25 = add nuw nsw i64 %indvars.iv, 1
  %26 = getelementptr inbounds i64, i64* %level_counts, i64 %25
  store i64 %cnt.3, i64* %26, align 8, !tbaa !4
  %27 = icmp ne i64 %cnt.3, 0
  %28 = icmp slt i64 %indvars.iv.next, 10
  %or.cond = and i1 %27, %28
  br i1 %or.cond, label %.preheader, label %29

; <label>:29                                      ; preds = %24
  ret void
}

attributes #0 = { noinline norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"omnipotent char", !3, i64 0}
!3 = !{!"Simple C/C++ TBAA"}
!4 = !{!5, !5, i64 0}
!5 = !{!"long", !2, i64 0}
!6 = !{!7, !5, i64 0}
!7 = !{!"node_t_struct", !5, i64 0, !5, i64 8}
!8 = !{!7, !5, i64 8}
!9 = !{!10, !5, i64 0}
!10 = !{!"edge_t_struct", !5, i64 0}
