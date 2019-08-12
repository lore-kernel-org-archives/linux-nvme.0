From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 12 Aug 2019 17:57:09 +0800
Subject: [PATCH V2 3/3] genirq/affinity: Enhance warning check
In-Reply-To: <20190812095709.25623-1-ming.lei@redhat.com>
References: <20190812095709.25623-1-ming.lei@redhat.com>
Message-ID: <20190812095709.25623-4-ming.lei@redhat.com>

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
index 927dcbe80482..178dc7eb7b35 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -318,8 +318,7 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 					       npresmsk, nmsk, masks);
 	put_online_cpus();
 
-	if (nr_present < numvecs)
-		WARN_ON(nr_present + nr_others < numvecs);
+	WARN_ON(max(nr_present, nr_others) < numvecs);
 
 	free_node_to_cpumask(node_to_cpumask);
 
-- 
2.20.1
