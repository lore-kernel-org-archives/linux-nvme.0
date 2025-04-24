Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69270C369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 18:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Cz77d1OyEcbrZ7zEvXybunM0xlQBSdzHJ1hhSnOoCY=; b=VtUxqU46R7OdRTYPGLbPENdhHW
	qCsPZ4m1JTCn7nbVJ1c0lyaPzIjKwFqcZILhr2DpAQhmeJMOGejUsLK/cL04meUGk83i35feREH4X
	Ks10Qhf2Z18sZ2CPvZCqrlRb9wXE9mtDkF5hT49ZRzSVZqSKl+O1+fitF2VbilyukB/E2gfURrkC5
	15TH6fJvgK4M/dT3fsRqCt9yf3NyWsToyYR4NktGzGMh51AByw6znJ9vlakL2tTRsdDEv5JHo6kew
	Eu8b1weQYvv6nkChFS+VnEzIPwHA9Iw8Yaur4fYeGd8uIFzfZUwgatcSldJ1OsIYtwMqYerB6e/Mn
	CrKms+Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u81BG-0000000F0A2-3aiZ;
	Thu, 24 Apr 2025 18:20:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u81BF-0000000F08d-3xlZ
	for linux-nvme@bombadil.infradead.org;
	Thu, 24 Apr 2025 18:20:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=7Cz77d1OyEcbrZ7zEvXybunM0xlQBSdzHJ1hhSnOoCY=; b=bFkhoQ9Y/wknBwcbNJzCKwklq5
	Uxs9xyDjnkghCzfPLcN3udSx7YI/OtnVpABN6rsQWIgtXRWrRP13uzgPLwaNdynRLcm+fYpxmB5gC
	FMrFA2L1Yj5XvHVGTM+OyTIOy0HqdUGuPoydxy9kvbU90nfmeveZTU0DrEX2Kuu+ob5HpXDSMzJs0
	45dSFeuQ6zN2l6t2MM18jwL6EmgxkgsEkqF8EH66fT/2lq5GmUxUn91GaVCtvF3d9Z0D3YxUZSRhf
	q4rgIAO9QlbKAplsZYoWVDX/ol5mtqZGmZS42RjoKDZbvIA2W5FPAMKU/eQJ/DHu2Iw4+8RAt4SKq
	+ATGp8Tg==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u81BD-0000000Btm1-0wOM
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 18:20:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A300AA4D087;
	Thu, 24 Apr 2025 18:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B944FC4CEEC;
	Thu, 24 Apr 2025 18:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745518806;
	bh=rDjb0DnW4LDPOm6D5bF8M2KSEcAP2XD//Ks8fwkXcCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F8Y8nlZC79aLc3KNS7NrtR2sYGxEg8KVRlqfDnSMPI05cYTPuAseVrQToUgnuPf4y
	 a3wPYh0MR/lVC3BQ0cNnBKO6pUdEV+lcmiRDvm4gHF0ApkxX5Cjj43Q4SB5DM8R8KS
	 s7gtXRPciyuONuDPY4HbHFjNv4pUDC4lSt6e0A0rddUQuhyxDJny4R9FvqfTzBBFUI
	 FN1Wg8cG5xqabey9LjzCgWxouyumM5B4qjursw0xxpAOjpHiCYE91LF+HtMQXj9dhS
	 MzxPpm0pT+bjSP/UxP51jsZVQKG0vMzy7g33LD4WTJ0siJMBmpwR+ClV3u6MOLS4+3
	 xRHmXUXGXx7Ig==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 24 Apr 2025 20:19:46 +0200
Subject: [PATCH v6 7/9] lib/group_cpus: honor housekeeping config when
 grouping CPUs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-isolcpus-io-queues-v6-7-9a53a870ca1f@kernel.org>
References: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
In-Reply-To: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, 
 linux-scsi@vger.kernel.org, storagedev@microchip.com, 
 virtualization@lists.linux.dev, GR-QLogic-Storage-Upstream@marvell.com, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_192011_485739_010B2827 
X-CRM114-Status: GOOD (  18.73  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

group_cpus_evenly distributes all present CPUs into groups. This ignores
the isolcpus configuration and assigns isolated CPUs into the groups.

Make group_cpus_evenly aware of isolcpus configuration and use the
housekeeping CPU mask as base for distributing the available CPUs into
groups.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 lib/group_cpus.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 79 insertions(+), 3 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 016c6578a07616959470b47121459a16a1bc99e5..707997bca55344b18f63ccfa539ba77a89d8acb6 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -8,6 +8,7 @@
 #include <linux/cpu.h>
 #include <linux/sort.h>
 #include <linux/group_cpus.h>
+#include <linux/sched/isolation.h>
 
 #ifdef CONFIG_SMP
 
@@ -330,7 +331,7 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 }
 
 /**
- * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
+ * group_possible_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
  * @numgrps: number of groups
  * @nummasks: number of initialized cpumasks
  *
@@ -346,8 +347,8 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
  * We guarantee in the resulted grouping that all CPUs are covered, and
  * no same CPU is assigned to multiple groups
  */
-struct cpumask *group_cpus_evenly(unsigned int numgrps,
-				  unsigned int *nummasks)
+static struct cpumask *group_possible_cpus_evenly(unsigned int numgrps,
+						  unsigned int *nummasks)
 {
 	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
 	cpumask_var_t *node_to_cpumask;
@@ -427,6 +428,81 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps,
 	*nummasks = nr_present + nr_others;
 	return masks;
 }
+
+/**
+ * group_mask_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
+ * @numgrps: number of groups
+ * @cpu_mask: CPU to consider for the grouping
+ * @nummasks: number of initialized cpusmasks
+ *
+ * Return: cpumask array if successful, NULL otherwise. And each element
+ * includes CPUs assigned to this group.
+ *
+ * Try to put close CPUs from viewpoint of CPU and NUMA locality into
+ * same group. Allocate present CPUs on these groups evenly.
+ */
+static struct cpumask *group_mask_cpus_evenly(unsigned int numgrps,
+					      const struct cpumask *cpu_mask,
+					      unsigned int *nummasks)
+{
+	cpumask_var_t *node_to_cpumask;
+	cpumask_var_t nmsk;
+	int ret = -ENOMEM;
+	struct cpumask *masks = NULL;
+
+	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
+		return NULL;
+
+	node_to_cpumask = alloc_node_to_cpumask();
+	if (!node_to_cpumask)
+		goto fail_nmsk;
+
+	masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
+	if (!masks)
+		goto fail_node_to_cpumask;
+
+	build_node_to_cpumask(node_to_cpumask);
+
+	ret = __group_cpus_evenly(0, numgrps, node_to_cpumask, cpu_mask, nmsk,
+				  masks);
+
+fail_node_to_cpumask:
+	free_node_to_cpumask(node_to_cpumask);
+
+fail_nmsk:
+	free_cpumask_var(nmsk);
+	if (ret < 0) {
+		kfree(masks);
+		return NULL;
+	}
+	*nummasks = ret;
+	return masks;
+}
+
+/**
+ * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
+ * @numgrps: number of groups
+ * @nummasks: number of initialized cpusmasks
+ *
+ * Return: cpumask array if successful, NULL otherwise.
+ *
+ * group_possible_cpus_evently() is used for distributing the cpus on all
+ * possible cpus in absence of isolcpus command line argument.
+ * group_mask_cpu_evenly() is used when the isolcpus command line
+ * argument is used with managed_irq option. In this case only the
+ * housekeeping CPUs are considered.
+ */
+struct cpumask *group_cpus_evenly(unsigned int numgrps,
+				  unsigned int *nummasks)
+{
+	if (housekeeping_enabled(HK_TYPE_IO_QUEUE)) {
+		return group_mask_cpus_evenly(numgrps,
+				housekeeping_cpumask(HK_TYPE_IO_QUEUE),
+				nummasks);
+	}
+
+	return group_possible_cpus_evenly(numgrps, nummasks);
+}
 #else /* CONFIG_SMP */
 struct cpumask *group_cpus_evenly(unsigned int numgrps,
 				  unsigned int *nummasks)

-- 
2.49.0


