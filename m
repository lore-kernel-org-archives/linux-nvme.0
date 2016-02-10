From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 Feb 2016 23:37:47 +0000
Subject: [PATCH for-4.5 06/13] NVMe: Remove WQ_MEM_RECLAIM from nvme
 work queue
In-Reply-To: <20160210184641.GA26933@infradead.org>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-7-git-send-email-keith.busch@intel.com>
 <20160210184641.GA26933@infradead.org>
Message-ID: <20160210233747.GA25988@localhost.localdomain>

On Wed, Feb 10, 2016@10:46:41AM -0800, Christoph Hellwig wrote:
> On Wed, Feb 10, 2016@11:17:23AM -0700, Keith Busch wrote:
> > This isn't used for work in the memory reclaim path, and we may need
> > to sync with work queues that also are not flagged memory relaim. This
> > fixes a kernel warning if we ever do sync with such a work queue.
> 
> We do need it during memory reclaim: memory reclaim in general
> does I/O, which can be on NVMe.  We then need the workqueue to
> abort a command or reset an overloaded controller to make progress.
> Not having WQ_MEM_RECLAIM risks deadlocks in heavily loaded systems.

Darn. Invalidating a disk drains lru, which syncs with work scheduled
on the system_wq. Syncing with that from a memory reclaim work queue
hits a kernel warning.

That lru drain work is reclaiming memory, though. Does this need
to be using a WQ_MEM_RECLAIM queue, then?

This is the alternate patch I didn't plan to submit:

---
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 0e32bc7..f7cc91e 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -356,6 +359,7 @@ extern struct workqueue_struct *system_unbound_wq;
 extern struct workqueue_struct *system_freezable_wq;
 extern struct workqueue_struct *system_power_efficient_wq;
 extern struct workqueue_struct *system_freezable_power_efficient_wq;
+extern struct workqueue_struct *system_mem_wq;

 extern struct workqueue_struct *
 __alloc_workqueue_key(const char *fmt, unsigned int flags, int max_active,
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 61a0264..57a50d2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5483,10 +5483,13 @@ static int __init init_workqueues(void)
        system_freezable_power_efficient_wq = alloc_workqueue("events_freezable_power_efficient",
                                              WQ_FREEZABLE | WQ_POWER_EFFICIENT,
                                              0);
+       system_mem_wq = alloc_workqueue("events_mem_unbound", WQ_UNBOUND | WQ_MEM_RECLAIM,
+                                           WQ_UNBOUND_MAX_ACTIVE);
        BUG_ON(!system_wq || !system_highpri_wq || !system_long_wq ||
               !system_unbound_wq || !system_freezable_wq ||
               !system_power_efficient_wq ||
-              !system_freezable_power_efficient_wq);
+              !system_freezable_power_efficient_wq ||
+              !system_mem_wq);

        wq_watchdog_init();

diff --git a/mm/swap.c b/mm/swap.c
index 09fe5e9..eecf98a 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -685,7 +685,7 @@ void lru_add_drain_all(void)
                    pagevec_count(&per_cpu(lru_deactivate_pvecs, cpu)) ||
                    need_activate_page_drain(cpu)) {
                        INIT_WORK(work, lru_add_drain_per_cpu);
-                       schedule_work_on(cpu, work);
+                       queue_work_on(cpu, system_mem_wq, work);
                        cpumask_set_cpu(cpu, &has_work);
                }
        }
--
