Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E1DCF45DF
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jan 2026 02:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BeigJ78YY50cw5gKaTQMI61NOMGIOV4qTlEMgEupV7M=; b=DWAi/TjlTp1Af2PNW2Mva6QKil
	uOiVht2KQ7uesCslubRAfTD4OEEcHWNrJNIA7FdycFZjffVeFUm2x3bXxWAI7RWOi7+KiYXYhGdl7
	i/0QlpWyKa1m8nSdbfpnJehWPKGnnvCNVFz3nlKk+6KM1YonevjzrKA3e5zlAsgRlBnjooFGVCN5y
	FwGAM94abmTtnv3rAdwgFZmDGktGyRy1/U6n32oY0Rl5nAU1ZSyq3A0eygYlX4dDISyU8dz0tGznu
	sQNnzGKrswDG/F7OTLeO/k4/lIX+pAnKNjWNdG+bUIWrfQAsfar/5pi4sCaFXZ8i9hKRmo9L4goYK
	CzxlxrmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfUDb-00000006Qcl-2gXy;
	Tue, 13 Jan 2026 02:33:15 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfUDU-00000006Qbp-0YkL
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jan 2026 02:33:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768271588; x=1799807588;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AOuDSE6/eWcFlRb6r186vh6Tjpsg1kdsTdkYdZKJIMo=;
  b=Xj5ZG/uCnmVnZtyytG1CQ0s4Ehc0KI59c8tEMCbGnaXDGNhsfF0NT9WM
   cWE0BrGNycmFqNovOcKkF4vnYf4y1adcKMoGkwVrwhACQx5BIrFWD9w1f
   ycWHVg/pTwGS4PxeOtvR7flqi6vj9FpHyFXoC0E5P0RtQX0qv3PYSJkfw
   tThj4OS96TuHrSyknwCvIOTzkgU5NwB4kAEz1Utd+ZGRK3ZeZAdFAmkRc
   D3wXpe/b1AWol//4//Kwl8tYZ269B9M24W5iwivQUyGMYERNlOTTytqQ1
   rUg6ZH70mb12SDAdLD36K2zE1/MlHhOealFCUHweKl+L7mmLr7AXO03yC
   w==;
X-CSE-ConnectionGUID: pDBTxyRCTNWM6Q6u+Q2C7w==
X-CSE-MsgGUID: 3ekz+v9ESomoZGLvMtyjdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="80916901"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="80916901"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 18:33:02 -0800
X-CSE-ConnectionGUID: DjF4Dm12SIGaeRUUVZU1VA==
X-CSE-MsgGUID: cH5xLomVR4ueF4JafFWPJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="203462074"
Received: from linux-pnp-server-11.sh.intel.com ([10.239.176.178])
  by orviesa010.jf.intel.com with ESMTP; 12 Jan 2026 18:32:59 -0800
From: Wangyang Guo <wangyang.guo@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Radu Rendec <rrendec@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org,
	Wangyang Guo <wangyang.guo@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Dan Liang <dan.liang@intel.com>
Subject: [PATCH v2] lib/group_cpus: make group CPU cluster aware
Date: Tue, 13 Jan 2026 10:29:58 +0800
Message-ID: <20260113022958.3379650-1-wangyang.guo@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260112_183308_221320_E214079F 
X-CRM114-Status: GOOD (  26.53  )
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

As CPU core counts increase, the number of NVMe IRQs may be smaller than
the total number of CPUs. This forces multiple CPUs to share the same
IRQ. If the IRQ affinity and the CPU’s cluster do not align, a
performance penalty can be observed on some platforms.

This patch improves IRQ affinity by grouping CPUs by cluster within each
NUMA domain, ensuring better locality between CPUs and their assigned
NVMe IRQs.

Details:

Intel Xeon E platform packs 4 CPU cores as 1 module (cluster) and share
the L2 cache. Let's say, if there are 40 CPUs in 1 NUMA domain and 11
IRQs to dispatch. The existing algorithm will map first 7 IRQs each with
4 CPUs and remained 4 IRQs each with 3 CPUs. The last 4 IRQs may
have cross cluster issue. For example, the 9th IRQ which pinned to
CPU32, then for CPU31, it will have cross L2 memory access.

CPU |28 29 30 31|32 33 34 35|36 ...
     -------- -------- --------
IRQ      8        9       10

If this patch applied, then first 2 IRQs each mapped with 2 CPUs and
rest 9 IRQs each mapped with 4 CPUs, which avoids the cross cluster
memory access.

CPU |00 01 02 03|04 05 06 07|08 09 10 11| ...
     ----- ----- ----------- -----------
IRQ  1      2        3           4

As a result, 15%+ performance difference is observed in FIO
libaio/randread/bs=8k.

Changes since V1:
- Add more performance details in commit messages.
- Fix endless loop when topology_cluster_cpumask return invalid mask.

History:
  v1: https://lore.kernel.org/all/20251024023038.872616-1-wangyang.guo@intel.com/
  v1 [RESEND]: https://lore.kernel.org/all/20251111020608.1501543-1-wangyang.guo@intel.com/

Reviewed-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Tested-by: Dan Liang <dan.liang@intel.com>
Signed-off-by: Wangyang Guo <wangyang.guo@intel.com>
---
 lib/group_cpus.c | 271 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 206 insertions(+), 65 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 6d08ac05f371..a93df70919df 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -114,48 +114,15 @@ static int ncpus_cmp_func(const void *l, const void *r)
 	return ln->ncpus - rn->ncpus;
 }
 
-/*
- * Allocate group number for each node, so that for each node:
- *
- * 1) the allocated number is >= 1
- *
- * 2) the allocated number is <= active CPU number of this node
- *
- * The actual allocated total groups may be less than @numgrps when
- * active total CPU number is less than @numgrps.
- *
- * Active CPUs means the CPUs in '@cpu_mask AND @node_to_cpumask[]'
- * for each node.
- */
-static void alloc_nodes_groups(unsigned int numgrps,
-			       cpumask_var_t *node_to_cpumask,
-			       const struct cpumask *cpu_mask,
-			       const nodemask_t nodemsk,
-			       struct cpumask *nmsk,
-			       struct node_groups *node_groups)
+static void alloc_groups_to_nodes(unsigned int numgrps,
+				  unsigned int numcpus,
+				  struct node_groups *node_groups,
+				  unsigned int num_nodes)
 {
-	unsigned n, remaining_ncpus = 0;
-
-	for (n = 0; n < nr_node_ids; n++) {
-		node_groups[n].id = n;
-		node_groups[n].ncpus = UINT_MAX;
-	}
-
-	for_each_node_mask(n, nodemsk) {
-		unsigned ncpus;
-
-		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
-		ncpus = cpumask_weight(nmsk);
-
-		if (!ncpus)
-			continue;
-		remaining_ncpus += ncpus;
-		node_groups[n].ncpus = ncpus;
-	}
+	unsigned int n, remaining_ncpus = numcpus;
+	unsigned int  ngroups, ncpus;
 
-	numgrps = min_t(unsigned, remaining_ncpus, numgrps);
-
-	sort(node_groups, nr_node_ids, sizeof(node_groups[0]),
+	sort(node_groups, num_nodes, sizeof(node_groups[0]),
 	     ncpus_cmp_func, NULL);
 
 	/*
@@ -226,9 +193,8 @@ static void alloc_nodes_groups(unsigned int numgrps,
 	 * finally for each node X: grps(X) <= ncpu(X).
 	 *
 	 */
-	for (n = 0; n < nr_node_ids; n++) {
-		unsigned ngroups, ncpus;
 
+	for (n = 0; n < num_nodes; n++) {
 		if (node_groups[n].ncpus == UINT_MAX)
 			continue;
 
@@ -246,12 +212,201 @@ static void alloc_nodes_groups(unsigned int numgrps,
 	}
 }
 
+/*
+ * Allocate group number for each node, so that for each node:
+ *
+ * 1) the allocated number is >= 1
+ *
+ * 2) the allocated number is <= active CPU number of this node
+ *
+ * The actual allocated total groups may be less than @numgrps when
+ * active total CPU number is less than @numgrps.
+ *
+ * Active CPUs means the CPUs in '@cpu_mask AND @node_to_cpumask[]'
+ * for each node.
+ */
+static void alloc_nodes_groups(unsigned int numgrps,
+			       cpumask_var_t *node_to_cpumask,
+			       const struct cpumask *cpu_mask,
+			       const nodemask_t nodemsk,
+			       struct cpumask *nmsk,
+			       struct node_groups *node_groups)
+{
+	unsigned int n, numcpus = 0;
+
+	for (n = 0; n < nr_node_ids; n++) {
+		node_groups[n].id = n;
+		node_groups[n].ncpus = UINT_MAX;
+	}
+
+	for_each_node_mask(n, nodemsk) {
+		unsigned int ncpus;
+
+		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
+		ncpus = cpumask_weight(nmsk);
+
+		if (!ncpus)
+			continue;
+		numcpus += ncpus;
+		node_groups[n].ncpus = ncpus;
+	}
+
+	numgrps = min_t(unsigned int, numcpus, numgrps);
+	alloc_groups_to_nodes(numgrps, numcpus, node_groups, nr_node_ids);
+}
+
+static void assign_cpus_to_groups(unsigned int ncpus,
+				  struct cpumask *nmsk,
+				  struct node_groups *nv,
+				  struct cpumask *masks,
+				  unsigned int *curgrp,
+				  unsigned int last_grp)
+{
+	unsigned int v, cpus_per_grp, extra_grps;
+	/* Account for rounding errors */
+	extra_grps = ncpus - nv->ngroups * (ncpus / nv->ngroups);
+
+	/* Spread allocated groups on CPUs of the current node */
+	for (v = 0; v < nv->ngroups; v++, *curgrp += 1) {
+		cpus_per_grp = ncpus / nv->ngroups;
+
+		/* Account for extra groups to compensate rounding errors */
+		if (extra_grps) {
+			cpus_per_grp++;
+			--extra_grps;
+		}
+
+		/*
+		 * wrapping has to be considered given 'startgrp'
+		 * may start anywhere
+		 */
+		if (*curgrp >= last_grp)
+			*curgrp = 0;
+		grp_spread_init_one(&masks[*curgrp], nmsk, cpus_per_grp);
+	}
+}
+
+static int alloc_cluster_groups(unsigned int ncpus,
+				unsigned int ngroups,
+				struct cpumask *node_cpumask,
+				cpumask_var_t msk,
+				const struct cpumask ***clusters_ptr,
+				struct node_groups **cluster_groups_ptr)
+{
+	unsigned int ncluster = 0;
+	unsigned int cpu, nc, n;
+	const struct cpumask *cluster_mask;
+	const struct cpumask **clusters;
+	struct node_groups *cluster_groups;
+
+	cpumask_copy(msk, node_cpumask);
+
+	/* Probe how many clusters in this node. */
+	while (1) {
+		cpu = cpumask_first(msk);
+		if (cpu >= nr_cpu_ids)
+			break;
+
+		cluster_mask = topology_cluster_cpumask(cpu);
+		if (!cpumask_weight(cluster_mask))
+			goto no_cluster;
+		/* Clean out CPUs on the same cluster. */
+		cpumask_andnot(msk, msk, cluster_mask);
+		ncluster++;
+	}
+
+	/* If ngroups < ncluster, cross cluster is inevitable, skip. */
+	if (ncluster == 0 || ncluster > ngroups)
+		goto no_cluster;
+
+	/* Allocate memory based on cluster number. */
+	clusters = kcalloc(ncluster, sizeof(struct cpumask *), GFP_KERNEL);
+	if (!clusters)
+		goto no_cluster;
+	cluster_groups = kcalloc(ncluster, sizeof(struct node_groups), GFP_KERNEL);
+	if (!cluster_groups)
+		goto fail_cluster_groups;
+
+	/* Filling cluster info for later process. */
+	cpumask_copy(msk, node_cpumask);
+	for (n = 0; n < ncluster; n++) {
+		cpu = cpumask_first(msk);
+		cluster_mask = topology_cluster_cpumask(cpu);
+		nc = cpumask_weight_and(cluster_mask, node_cpumask);
+		clusters[n] = cluster_mask;
+		cluster_groups[n].id = n;
+		cluster_groups[n].ncpus = nc;
+		cpumask_andnot(msk, msk, cluster_mask);
+	}
+
+	alloc_groups_to_nodes(ngroups, ncpus, cluster_groups, ncluster);
+
+	*clusters_ptr = clusters;
+	*cluster_groups_ptr = cluster_groups;
+	return ncluster;
+
+ fail_cluster_groups:
+	kfree(clusters);
+ no_cluster:
+	return 0;
+}
+
+/*
+ * Try group CPUs evenly for cluster locality within a NUMA node.
+ *
+ * Return: true if success, false otherwise.
+ */
+static bool __try_group_cluster_cpus(unsigned int ncpus,
+				     unsigned int ngroups,
+				     struct cpumask *node_cpumask,
+				     struct cpumask *masks,
+				     unsigned int *curgrp,
+				     unsigned int last_grp)
+{
+	struct node_groups *cluster_groups;
+	const struct cpumask **clusters;
+	unsigned int ncluster;
+	bool ret = false;
+	cpumask_var_t nmsk;
+	unsigned int i, nc;
+
+	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
+		goto fail_nmsk_alloc;
+
+	ncluster = alloc_cluster_groups(ncpus, ngroups, node_cpumask, nmsk,
+					&clusters, &cluster_groups);
+
+	if (ncluster == 0)
+		goto fail_no_clusters;
+
+	for (i = 0; i < ncluster; i++) {
+		struct node_groups *nv = &cluster_groups[i];
+
+		/* Get the cpus on this cluster. */
+		cpumask_and(nmsk, node_cpumask, clusters[nv->id]);
+		nc = cpumask_weight(nmsk);
+		if (!nc)
+			continue;
+		WARN_ON_ONCE(nv->ngroups > nc);
+
+		assign_cpus_to_groups(nc, nmsk, nv, masks, curgrp, last_grp);
+	}
+
+	ret = true;
+	kfree(cluster_groups);
+	kfree(clusters);
+ fail_no_clusters:
+	free_cpumask_var(nmsk);
+ fail_nmsk_alloc:
+	return ret;
+}
+
 static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 			       cpumask_var_t *node_to_cpumask,
 			       const struct cpumask *cpu_mask,
 			       struct cpumask *nmsk, struct cpumask *masks)
 {
-	unsigned int i, n, nodes, cpus_per_grp, extra_grps, done = 0;
+	unsigned int i, n, nodes, done = 0;
 	unsigned int last_grp = numgrps;
 	unsigned int curgrp = startgrp;
 	nodemask_t nodemsk = NODE_MASK_NONE;
@@ -287,7 +442,7 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 	alloc_nodes_groups(numgrps, node_to_cpumask, cpu_mask,
 			   nodemsk, nmsk, node_groups);
 	for (i = 0; i < nr_node_ids; i++) {
-		unsigned int ncpus, v;
+		unsigned int ncpus;
 		struct node_groups *nv = &node_groups[i];
 
 		if (nv->ngroups == UINT_MAX)
@@ -301,28 +456,14 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 
 		WARN_ON_ONCE(nv->ngroups > ncpus);
 
-		/* Account for rounding errors */
-		extra_grps = ncpus - nv->ngroups * (ncpus / nv->ngroups);
-
-		/* Spread allocated groups on CPUs of the current node */
-		for (v = 0; v < nv->ngroups; v++, curgrp++) {
-			cpus_per_grp = ncpus / nv->ngroups;
-
-			/* Account for extra groups to compensate rounding errors */
-			if (extra_grps) {
-				cpus_per_grp++;
-				--extra_grps;
-			}
-
-			/*
-			 * wrapping has to be considered given 'startgrp'
-			 * may start anywhere
-			 */
-			if (curgrp >= last_grp)
-				curgrp = 0;
-			grp_spread_init_one(&masks[curgrp], nmsk,
-						cpus_per_grp);
+		if (__try_group_cluster_cpus(ncpus, nv->ngroups, nmsk,
+					     masks, &curgrp, last_grp)) {
+			done += nv->ngroups;
+			continue;
 		}
+
+		assign_cpus_to_groups(ncpus, nmsk, nv, masks, &curgrp,
+				      last_grp);
 		done += nv->ngroups;
 	}
 	kfree(node_groups);
-- 
2.47.3


