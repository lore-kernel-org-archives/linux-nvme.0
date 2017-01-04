From: keith.busch@intel.com (Keith Busch)
Date: Wed,  4 Jan 2017 17:41:07 -0500
Subject: [PATCH 2/6] irq/affinity: Assign offline CPUs a vector
In-Reply-To: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
Message-ID: <1483569671-1462-3-git-send-email-keith.busch@intel.com>

The offline CPUs need to assigned to something incase they come online
later, otherwise anyone using the mapping for things other than affinity
will have blank entries for that online CPU.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 kernel/irq/affinity.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index b25dce0..2367531 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -129,6 +129,14 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	}
 
 done:
+	/*
+	 * Assign offline CPUs to first mask in case they come online later. A
+	 * driver can rerun this from a cpu notifier if they want a more optimal
+	 * spread.
+	 */
+	cpumask_andnot(nmsk, cpu_possible_mask, cpu_online_mask);
+	irq_spread_init_one(masks, nmsk, cpumask_weight(nmsk));
+
 	put_online_cpus();
 
 	/* Fill out vectors at the end that don't need affinity */
-- 
2.5.5
