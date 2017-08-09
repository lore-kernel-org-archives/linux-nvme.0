From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed,  9 Aug 2017 09:52:38 -0700
Subject: [PATCH 4.12 054/106] blk-mq: Include all present CPUs in the default
 queue mapping
In-Reply-To: <20170809164515.714288642@linuxfoundation.org>
References: <20170809164515.714288642@linuxfoundation.org>
Message-ID: <20170809164524.037800602@linuxfoundation.org>

4.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

commit 5f042e7cbd9ebd3580077dcdc21f35e68c2adf5f upstream.

This way we get a nice distribution independent of the current cpu
online / offline state.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Jens Axboe <axboe at kernel.dk>
Cc: Keith Busch <keith.busch at intel.com>
Cc: linux-block at vger.kernel.org
Cc: linux-nvme at lists.infradead.org
Link: http://lkml.kernel.org/r/20170626102058.10200-2-hch at lst.de
Signed-off-by: Thomas Gleixner <tglx at linutronix.de>
Cc: Oleksandr Natalenko <oleksandr at natalenko.name>
Cc: Mike Galbraith <efault at gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh at linuxfoundation.org>

---
 block/blk-mq-cpumap.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -35,7 +35,6 @@ int blk_mq_map_queues(struct blk_mq_tag_
 {
 	unsigned int *map = set->mq_map;
 	unsigned int nr_queues = set->nr_hw_queues;
-	const struct cpumask *online_mask = cpu_online_mask;
 	unsigned int i, nr_cpus, nr_uniq_cpus, queue, first_sibling;
 	cpumask_var_t cpus;
 
@@ -44,7 +43,7 @@ int blk_mq_map_queues(struct blk_mq_tag_
 
 	cpumask_clear(cpus);
 	nr_cpus = nr_uniq_cpus = 0;
-	for_each_cpu(i, online_mask) {
+	for_each_present_cpu(i) {
 		nr_cpus++;
 		first_sibling = get_first_sibling(i);
 		if (!cpumask_test_cpu(first_sibling, cpus))
@@ -54,7 +53,7 @@ int blk_mq_map_queues(struct blk_mq_tag_
 
 	queue = 0;
 	for_each_possible_cpu(i) {
-		if (!cpumask_test_cpu(i, online_mask)) {
+		if (!cpumask_test_cpu(i, cpu_present_mask)) {
 			map[i] = 0;
 			continue;
 		}
