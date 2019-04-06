From: ming.lei@redhat.com (Ming Lei)
Date: Sun, 7 Apr 2019 05:27:10 +0800
Subject: [PATCH] blk-mq: Wait for for hctx requests on CPU unplug
In-Reply-To: <CAOSXXT7V3E2j_Ut=hJ2X3QcdLwuWGRFtgzTs4iTe+RDMeHg8nA@mail.gmail.com>
References: <20190405215920.27085-1-keith.busch@intel.com>
 <226503cd-53ac-902c-7944-b2748407b1d3@kernel.dk>
 <20190405223719.GC25081@localhost.localdomain>
 <d4a4b6c0-3ea8-f748-85b0-6b39c5023a6f@kernel.dk>
 <CAOSXXT7V3E2j_Ut=hJ2X3QcdLwuWGRFtgzTs4iTe+RDMeHg8nA@mail.gmail.com>
Message-ID: <20190406212709.GA29871@ming.t460p>

On Fri, Apr 05, 2019@05:36:32PM -0600, Keith Busch wrote:
> On Fri, Apr 5, 2019@5:04 PM Jens Axboe <axboe@kernel.dk> wrote:
> > Looking at current peak testing, I've got around 1.2% in queue enter
> > and exit. It's definitely not free, hence my question. Probably safe
> > to assume that we'll double that cycle counter, per IO.
> 
> Okay, that's not negligible at all. I don't know of a faster reference
> than the percpu_ref, but that much overhead would have to rule out
> having a per hctx counter.

Or not using any refcount in fast path, how about the following one?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ff3d7b49969..6fe334e12236 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2199,6 +2199,23 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	return -ENOMEM;
 }
 
+static void blk_mq_wait_hctx_become_idle(struct blk_mq_hw_ctx *hctx,
+		int dead_cpu)
+{
+	unsigned long msecs_left = 1000 * 10;
+
+	while (msecs_left > 0) {
+		if (blk_mq_hctx_idle(hctx))
+			break;
+		msleep(5);
+		msecs_left -= 5;
+	}
+
+	if (msecs_left > 0)
+		printk(KERN_WARNING "requests not completed from "
+			"CPU %d\n", dead_cpu);
+}
+
 /*
  * 'cpu' is going away. splice any existing rq_list entries from this
  * software queue to the hw queue dispatch list, and ensure that it
@@ -2230,6 +2247,14 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	spin_unlock(&hctx->lock);
 
 	blk_mq_run_hw_queue(hctx, true);
+
+	/*
+	 * Interrupt for this queue will be shutdown, so wait until all
+	 * requests from this hctx is done or timeout.
+	 */
+	if (cpumask_first_and(hctx->cpumask, cpu_online_mask) >= nr_cpu_ids)
+		blk_mq_wait_hctx_become_idle(hctx, cpu);
+
 	return 0;
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d704fc7766f4..935cf8519bf2 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -240,4 +240,15 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
 		qmap->mq_map[cpu] = 0;
 }
 
+static inline bool blk_mq_hctx_idle(struct blk_mq_hw_ctx *hctx)
+{
+	struct blk_mq_tags *tags = hctx->sched_tags ?: hctx->tags;
+
+	if (!tags)
+		return true;
+
+	return !sbitmap_any_bit_set(&tags->bitmap_tags.sb) &&
+                       !sbitmap_any_bit_set(&tags->bitmap_tags.sb);
+}
+
 #endif

Thanks,
Ming
