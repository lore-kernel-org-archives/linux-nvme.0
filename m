From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Thu, 5 Apr 2018 17:18:11 -0700
Subject: [PATCH] nvme: fix flush dependency in delete controller flow
In-Reply-To: <20180405195512.GA12678@lst.de>
References: <20180402123727.3961-1-nitzanc@mellanox.com>
 <20180405085438.GC2286@lst.de>
 <20180405131426.GL3948@linux.vnet.ibm.com>
 <20180405160852.GA11416@linux.vnet.ibm.com>
 <20180405195512.GA12678@lst.de>
Message-ID: <20180406001811.GQ3948@linux.vnet.ibm.com>

On Thu, Apr 05, 2018@09:55:12PM +0200, Christoph Hellwig wrote:
> On Thu, Apr 05, 2018@09:08:52AM -0700, Paul E. McKenney wrote:
> > > But if this SRCU use case doesn't ever invoke call_srcu(), I
> > > -think- that shouldn't need to do the flush_delayed_work() calls in
> > > cleanup_srcu_struct().  I think.  It is a bit early out here, so I don't
> > > trust myself on this one just now, and need to take another look when
> > > fully awake.
> > > 
> > > But in the meantime, is it really the case that this SRCU use case never
> > > ever invokes call_srcu()?
> 
> We never use call_srcu().
> 
> > And I can do a bit better than this.  I could provide something like a
> > cleanup_srcu_struct_quiesced() that would avoid blocking if the caller had
> > quiesced it.  Here, to quiesce is to make sure that any synchronize_srcu()
> > or synchronize_srcu_expedited() calls have returned before the call to
> > cleanup_srcu_struct_quiesced(), and that any callbacks from call_srcu()
> > have completed.  Of course, srcu_barrier() could be used to wait for
> > the callbacks from earlier call_srcu().
> > 
> > Would something like this help?
> 
> Yes.  Note that blocking isn't even the problem, just the flush_work.
> But not blocking at all would be fine of course.
> 
> The pattern in nvme is that we have a struct nvme_ns_head, which has a
> list of struct nvme_ns structures hanging off it.  We use SRCU to protect
> lookups in said list.  We call synchronize_srcu after removing a nvme_ns
> from the list in struct nvme_ns_head and nowhere else.  A struct
> nvme_ns_head is freed (and we thus call cleanup_srcu_struct) once the
> reference count on it hits zero, which can only happen after the last
> nvme_ns has been removed from the list.
> 
> I suspect this might be a common patter in other parts of the kernel as
> well.

OK, how does the following (untested) patch look?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 33c1c698df09..91494d7e8e41 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -69,11 +69,45 @@ struct srcu_struct { };
 
 void call_srcu(struct srcu_struct *sp, struct rcu_head *head,
 		void (*func)(struct rcu_head *head));
-void cleanup_srcu_struct(struct srcu_struct *sp);
+void _cleanup_srcu_struct(struct srcu_struct *sp, bool quiesced);
 int __srcu_read_lock(struct srcu_struct *sp) __acquires(sp);
 void __srcu_read_unlock(struct srcu_struct *sp, int idx) __releases(sp);
 void synchronize_srcu(struct srcu_struct *sp);
 
+/**
+ * cleanup_srcu_struct - deconstruct a sleep-RCU structure
+ * @sp: structure to clean up.
+ *
+ * Must invoke this after you are finished using a given srcu_struct that
+ * was initialized via init_srcu_struct(), else you leak memory.
+ */
+static inline void cleanup_srcu_struct(struct srcu_struct *sp)
+{
+	_cleanup_srcu_struct(sp, false);
+}
+
+/**
+ * cleanup_srcu_struct_quiesced - deconstruct a quiesced sleep-RCU structure
+ * @sp: structure to clean up.
+ *
+ * Must invoke this after you are finished using a given srcu_struct that
+ * was initialized via init_srcu_struct(), else you leak memory.  Also,
+ * all grace-period processing must have completed.
+ *
+ * "Completed" means that the last synchronize_srcu() and
+ * synchronize_srcu_expedited() calls must have returned before the call
+ * to cleanup_srcu_struct_quiesced().  It also means that the callback
+ * from the last call_srcu() must have been invoked before the call to
+ * cleanup_srcu_struct_quiesced(), but you can use srcu_barrier() to help
+ * with this last.  Violating these rules will get you a WARN_ON() splat
+ * (with high probability, anyway), and will also cause the srcu_struct
+ * to be leaked.
+ */
+static inline void cleanup_srcu_struct_quiesced(struct srcu_struct *sp)
+{
+	_cleanup_srcu_struct(sp, true);
+}
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 /**
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 680c96d8c00f..f0e1d44459f8 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -593,7 +593,12 @@ static void srcu_torture_init(void)
 
 static void srcu_torture_cleanup(void)
 {
-	cleanup_srcu_struct(&srcu_ctld);
+	static DEFINE_TORTURE_RANDOM(rand);
+
+	if (torture_random(&rand) & 0x800)
+		cleanup_srcu_struct(&srcu_ctld);
+	else
+		cleanup_srcu_struct_quiesced(&srcu_ctld);
 	srcu_ctlp = &srcu_ctl; /* In case of a later rcutorture run. */
 }
 
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 76ac5f50b2c7..622792abe41a 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -86,16 +86,19 @@ EXPORT_SYMBOL_GPL(init_srcu_struct);
  * Must invoke this after you are finished using a given srcu_struct that
  * was initialized via init_srcu_struct(), else you leak memory.
  */
-void cleanup_srcu_struct(struct srcu_struct *sp)
+void _cleanup_srcu_struct(struct srcu_struct *sp, bool quiesced)
 {
 	WARN_ON(sp->srcu_lock_nesting[0] || sp->srcu_lock_nesting[1]);
-	flush_work(&sp->srcu_work);
+	if (quiesced)
+		WARN_ON(work_pending(&sp->srcu_work));
+	else
+		flush_work(&sp->srcu_work);
 	WARN_ON(sp->srcu_gp_running);
 	WARN_ON(sp->srcu_gp_waiting);
 	WARN_ON(sp->srcu_cb_head);
 	WARN_ON(&sp->srcu_cb_head != sp->srcu_cb_tail);
 }
-EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
+EXPORT_SYMBOL_GPL(_cleanup_srcu_struct);
 
 /*
  * Removes the count for the old reader from the appropriate element of
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index fb560fca9ef4..b4123d7a2cec 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -366,24 +366,28 @@ static unsigned long srcu_get_delay(struct srcu_struct *sp)
 	return SRCU_INTERVAL;
 }
 
-/**
- * cleanup_srcu_struct - deconstruct a sleep-RCU structure
- * @sp: structure to clean up.
- *
- * Must invoke this after you are finished using a given srcu_struct that
- * was initialized via init_srcu_struct(), else you leak memory.
- */
-void cleanup_srcu_struct(struct srcu_struct *sp)
+/* Helper for cleanup_srcu_struct() and cleanup_srcu_struct_quiesced(). */
+void _cleanup_srcu_struct(struct srcu_struct *sp, bool quiesced)
 {
 	int cpu;
 
 	if (WARN_ON(!srcu_get_delay(sp)))
-		return; /* Leakage unless caller handles error. */
+		return; /* Just leak it! */
 	if (WARN_ON(srcu_readers_active(sp)))
-		return; /* Leakage unless caller handles error. */
-	flush_delayed_work(&sp->work);
+		return; /* Just leak it! */
+	if (quiesced) {
+		if (WARN_ON(delayed_work_pending(&sp->work)))
+			return; /* Just leak it! */
+	} else {
+		flush_delayed_work(&sp->work);
+	}
 	for_each_possible_cpu(cpu)
-		flush_delayed_work(&per_cpu_ptr(sp->sda, cpu)->work);
+		if (quiesced) {
+			if (WARN_ON(delayed_work_pending(&per_cpu_ptr(sp->sda, cpu)->work)))
+				return; /* Just leak it! */
+		} else {
+			flush_delayed_work(&per_cpu_ptr(sp->sda, cpu)->work);
+		}
 	if (WARN_ON(rcu_seq_state(READ_ONCE(sp->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
 	    WARN_ON(srcu_readers_active(sp))) {
 		pr_info("%s: Active srcu_struct %p state: %d\n", __func__, sp, rcu_seq_state(READ_ONCE(sp->srcu_gp_seq)));
@@ -392,7 +396,7 @@ void cleanup_srcu_struct(struct srcu_struct *sp)
 	free_percpu(sp->sda);
 	sp->sda = NULL;
 }
-EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
+EXPORT_SYMBOL_GPL(_cleanup_srcu_struct);
 
 /*
  * Counts the new reader in the appropriate per-CPU element of the
