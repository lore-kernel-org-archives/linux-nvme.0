From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 14 Aug 2019 16:40:42 +0800
Subject: [PATCH V4 1/3] genirq/affinity: Enhance warning check
In-Reply-To: <20190814084044.21699-1-ming.lei@redhat.com>
References: <20190814084044.21699-1-ming.lei@redhat.com>
Message-ID: <20190814084044.21699-2-ming.lei@redhat.com>

The two-stage spread is done on same irq vectors, and we just need that
either one stage covers all vector, not two stage work together to cover
all vectors.

So enhance the warning check to make sure all vectors are spread.

Cc: Christoph Hellwig <hch at lst.de>
Cc: Keith Busch <kbusch at kernel.org>
Cc: linux-nvme at lists.infradead.org,
Cc: Jon Derrick <jonathan.derrick at intel.com>
Cc: Jens Axboe <axboe at kernel.dk>
Fixes: 6da4b3ab9a6 ("genirq/affinity: Add support for allocating interrupt sets")
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 kernel/irq/affinity.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 6fef48033f96..265b3076f16b 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -215,8 +215,7 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 					       npresmsk, nmsk, masks);
 	put_online_cpus();
 
-	if (nr_present < numvecs)
-		WARN_ON(nr_present + nr_others < numvecs);
+	WARN_ON(max(nr_present, nr_others) < numvecs);
 
 	free_node_to_cpumask(node_to_cpumask);
 
-- 
2.20.1
