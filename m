From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 10:51:31 +0200
Subject: [PATCH RFC 20/21] blk-mq: Allow combined hardware queues
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <922794bc1f024572f19c1c00d204e2d18faf21f7.1474014910.git.agordeev@redhat.com>

This is 4th and last step change in a bid to enable mapping
of multiple device hardware queues to a single CPU.

Available hardware queues are evenly distributed to CPUs.
Still, there might some number of queues left spared, but no
more than (number of queues) % (number of CPUs) in the worst
case.

CC: Jens Axboe <axboe at kernel.dk>
CC: linux-nvme at lists.infradead.org
Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 block/blk-mq-cpumap.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq.c        | 14 +-------------
 block/blk-mq.h        |  2 ++
 3 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index ee553a4..0b49f30 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/cpu.h>
+#include <linux/crash_dump.h>
 
 #include <linux/blk-mq.h>
 #include "blk.h"
@@ -86,6 +87,49 @@ int blk_mq_update_queue_map(unsigned int *map, unsigned int nr_queues,
 	return 0;
 }
 
+void blk_mq_adjust_tag_set(struct blk_mq_tag_set *set,
+			   const struct cpumask *online_mask)
+{
+	unsigned int nr_cpus, nr_uniq_cpus, first_sibling;
+	cpumask_var_t cpus;
+	int i;
+
+	/*
+	 * If a crashdump is active, then we are potentially in a very
+	 * memory constrained environment. Limit us to 1 queue.
+	 */
+	if (is_kdump_kernel())
+		goto default_map;
+
+	if (!alloc_cpumask_var(&cpus, GFP_ATOMIC))
+		goto default_map;
+
+	cpumask_clear(cpus);
+	nr_cpus = nr_uniq_cpus = 0;
+
+	for_each_cpu(i, online_mask) {
+		nr_cpus++;
+		first_sibling = get_first_sibling(i);
+		if (!cpumask_test_cpu(first_sibling, cpus))
+			nr_uniq_cpus++;
+		cpumask_set_cpu(i, cpus);
+	}
+
+	free_cpumask_var(cpus);
+
+	if (set->nr_hw_queues < nr_uniq_cpus) {
+default_map:
+		set->nr_co_queues = set->nr_hw_queues;
+		set->co_queue_size = 1;
+	} else if (set->nr_hw_queues < nr_cpus) {
+		set->nr_co_queues = nr_uniq_cpus;
+		set->co_queue_size = set->nr_hw_queues / nr_uniq_cpus;
+	} else {
+		set->nr_co_queues = nr_cpus;
+		set->co_queue_size = set->nr_hw_queues / nr_cpus;
+	}
+}
+
 /*
  * We have no quick way of doing reverse lookups. This is only used at
  * queue init time, so runtime isn't important.
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 450a3ed..ee05ea9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -21,7 +21,6 @@
 #include <linux/cache.h>
 #include <linux/sched/sysctl.h>
 #include <linux/delay.h>
-#include <linux/crash_dump.h>
 
 #include <trace/events/block.h>
 
@@ -2286,24 +2285,13 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	 * TODO	Restore original queue depth and count limits
 	 */
 
-	/*
-	 * If a crashdump is active, then we are potentially in a very
-	 * memory constrained environment. Limit us to 1 queue.
-	 */
-	set->nr_co_queues = is_kdump_kernel() ? 1 : set->nr_hw_queues;
-	set->co_queue_size = 1;
+	blk_mq_adjust_tag_set(set, cpu_online_mask);
 
 	if (queue_depth(set) < set->reserved_tags + BLK_MQ_TAG_MIN)
 		return -EINVAL;
 	if (queue_depth(set) > BLK_MQ_MAX_DEPTH)
 		return -EINVAL;
 
-	/*
-	 * There is no use for more h/w queues than cpus.
-	 */
-	if (set->nr_co_queues > nr_cpu_ids)
-		set->nr_co_queues = nr_cpu_ids;
-
 	set->tags = kzalloc_node(set->nr_co_queues * sizeof(*set->tags),
 				 GFP_KERNEL, set->numa_node);
 	if (!set->tags)
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 592e308..70704f7 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -49,6 +49,8 @@ void blk_mq_disable_hotplug(void);
  */
 extern int blk_mq_update_queue_map(unsigned int *map, unsigned int nr_queues,
 				   const struct cpumask *online_mask);
+extern void blk_mq_adjust_tag_set(struct blk_mq_tag_set *set,
+				  const struct cpumask *online_mask);
 extern int blk_mq_hw_queue_to_node(unsigned int *map, unsigned int);
 
 /*
-- 
1.8.3.1
