Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15353E7718B
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Dec 2024 15:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o8g4oLXYjxl4OlpypOEYQv87XI0guZf6Ek1E0sYQelY=; b=13rnW2YfhJxVx44AMnI+nCwHpD
	xto8Pk4U4TB272Fc5aZLUkzYFzRmOe1LaDMUTgTxaDL7QvKXCHusXEcCjisSmFeXM0VSCwWAmgjIY
	LHMQXRH5Sn9drUxl/xY+F3H9Mlo+6RksAggSwpdLlk7Cbq58uS2o6WSzZ7UIlP63uHSMArlfv1ufn
	ruI6pgp788IvXfOS8Klt41NbM3bHajmYX+eCQWh7r3ptQzZYpKXQukAuexk9zi/hVEO60ocW8jLE/
	aSJNPmINOWKerRvCiVCZ91iaBNOgeICGI1KAFt4UUcPR7tqlxO1dv6PTF4P/EyscX356mCugz48hU
	uxz/PsGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOItc-00000002EAu-3DX5;
	Thu, 19 Dec 2024 15:57:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNcKJ-0000000EXnR-3ANy
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 18:29:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A04015C2DE2;
	Tue, 17 Dec 2024 18:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDC7C4CEDD;
	Tue, 17 Dec 2024 18:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734460186;
	bh=GK5KtME/hF0aSpOZVjtVt+PZSF6LX1XTvt/7AaCW82Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BeLQJ9mm2uFWrsTpWNRjjW7uEntUaU0PFv9nGaIG9BrhXK5aMfQAit/7HgXd8TU3L
	 3G53FG+ePxNtXXNPUf+NoCHde/ChjtQHWAwkYgnUcuRRv4Mo+AQ7XU6vhZOlcLzG39
	 XC+cartsLKGgQY/94FHd7/sgnlqqymFdzLTpc4Lq3qxVHlJlYu5oqsZ7XUYwq+7tsH
	 5RHY2tp5zoTH8k6TW7YVtRsThmSVwl6dDyiON6IPJha6H9LS8XaCQ6uopqIC5W/qKT
	 7ycHrotYixRpiCyIN3R/fGp8m5KNl0tegw6iXFrZRR7GM7NTrxYtlhNLrHAs3hiCME
	 nTrjJSBEbgHEA==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 17 Dec 2024 19:29:35 +0100
Subject: [PATCH v4 1/9] lib/group_cpus: let group_cpu_evenly return number
 of groups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-isolcpus-io-queues-v4-1-5d355fbb1e14@kernel.org>
References: <20241217-isolcpus-io-queues-v4-0-5d355fbb1e14@kernel.org>
In-Reply-To: <20241217-isolcpus-io-queues-v4-0-5d355fbb1e14@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Kashyap Desai <kashyap.desai@broadcom.com>, 
 Sumit Saxena <sumit.saxena@broadcom.com>, 
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>, 
 Chandrakanth patil <chandrakanth.patil@broadcom.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Nilesh Javali <njavali@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com, 
 Don Brace <don.brace@microchip.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: Costa Shulyupin <costa.shul@redhat.com>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, 
 Hannes Reinecke <hare@suse.de>, 
 Sridhar Balaraman <sbalaraman@parallelwireless.com>, 
 "brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
 storagedev@microchip.com, virtualization@lists.linux.dev, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_102947_904337_E7E2DBCA 
X-CRM114-Status: GOOD (  20.20  )
X-Mailman-Approved-At: Thu, 19 Dec 2024 07:56:32 -0800
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

group_cpu_evenly might allocated less groups then the requested:

group_cpu_evenly
  __group_cpus_evenly
    alloc_nodes_groups
      # allocated total groups may be less than numgrps when
      # active total CPU number is less then numgrps

In this case, the caller will do an out of bound access because the
caller assumes the masks returned has numgrps.

Return the number of groups created so the caller can limit the access
range accordingly.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq-cpumap.c        |  7 ++++---
 drivers/virtio/virtio_vdpa.c |  2 +-
 fs/fuse/virtio_fs.c          |  7 ++++---
 include/linux/group_cpus.h   |  2 +-
 kernel/irq/affinity.c        |  2 +-
 lib/group_cpus.c             | 23 +++++++++++++----------
 6 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index ad8d6a363f24ae11968b42f7bcfd6a719a0499b7..85c0a7073bd8bff5d34aad1729d45d89da4c4bd1 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -19,9 +19,10 @@
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 {
 	const struct cpumask *masks;
-	unsigned int queue, cpu;
+	unsigned int queue, cpu, nr_masks;
 
-	masks = group_cpus_evenly(qmap->nr_queues);
+	nr_masks = qmap->nr_queues;
+	masks = group_cpus_evenly(&nr_masks);
 	if (!masks) {
 		for_each_possible_cpu(cpu)
 			qmap->mq_map[cpu] = qmap->queue_offset;
@@ -29,7 +30,7 @@ void blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 	}
 
 	for (queue = 0; queue < qmap->nr_queues; queue++) {
-		for_each_cpu(cpu, &masks[queue])
+		for_each_cpu(cpu, &masks[queue % nr_masks])
 			qmap->mq_map[cpu] = qmap->queue_offset + queue;
 	}
 	kfree(masks);
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 1f60c9d5cb1810a6f208c24bb2ac640d537391a0..c478cccf5fd68b9c9c01332046c24316573d97cd 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -330,7 +330,7 @@ create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
 		unsigned int this_vecs = affd->set_size[i];
 		int j;
-		struct cpumask *result = group_cpus_evenly(this_vecs);
+		struct cpumask *result = group_cpus_evenly(&this_vecs);
 
 		if (!result) {
 			kfree(masks);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 82afe78ec542358e2db6f4d955d521652ae363ec..5acd875f1e9c9840dd9d2f3245665c91230f57a8 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -862,7 +862,7 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 static void virtio_fs_map_queues(struct virtio_device *vdev, struct virtio_fs *fs)
 {
 	const struct cpumask *mask, *masks;
-	unsigned int q, cpu;
+	unsigned int q, cpu, nr_masks;
 
 	/* First attempt to map using existing transport layer affinities
 	 * e.g. PCIe MSI-X
@@ -882,7 +882,8 @@ static void virtio_fs_map_queues(struct virtio_device *vdev, struct virtio_fs *f
 	return;
 fallback:
 	/* Attempt to map evenly in groups over the CPUs */
-	masks = group_cpus_evenly(fs->num_request_queues);
+	nr_masks = fs->num_request_queues;
+	masks = group_cpus_evenly(&nr_masks);
 	/* If even this fails we default to all CPUs use first request queue */
 	if (!masks) {
 		for_each_possible_cpu(cpu)
@@ -891,7 +892,7 @@ static void virtio_fs_map_queues(struct virtio_device *vdev, struct virtio_fs *f
 	}
 
 	for (q = 0; q < fs->num_request_queues; q++) {
-		for_each_cpu(cpu, &masks[q])
+		for_each_cpu(cpu, &masks[q % nr_masks])
 			fs->mq_map[cpu] = q + VQ_REQUEST;
 	}
 	kfree(masks);
diff --git a/include/linux/group_cpus.h b/include/linux/group_cpus.h
index e42807ec61f6e8cf3787af7daa0d8686edfef0a3..8659534a3423e92746738ac57e713b7416e05271 100644
--- a/include/linux/group_cpus.h
+++ b/include/linux/group_cpus.h
@@ -9,6 +9,6 @@
 #include <linux/kernel.h>
 #include <linux/cpu.h>
 
-struct cpumask *group_cpus_evenly(unsigned int numgrps);
+struct cpumask *group_cpus_evenly(unsigned int *numgrps);
 
 #endif
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 44a4eba80315cc098ecfa366ca1d88483641b12a..0188e133f1a508a623e33f08a0fca2e1f2cbf4e4 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -71,7 +71,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
 		unsigned int this_vecs = affd->set_size[i];
 		int j;
-		struct cpumask *result = group_cpus_evenly(this_vecs);
+		struct cpumask *result = group_cpus_evenly(&this_vecs);
 
 		if (!result) {
 			kfree(masks);
diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index ee272c4cefcc13907ce9f211f479615d2e3c9154..73da83ca2c45347a3a443d42d4f16801a47effd5 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -334,7 +334,8 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
  * @numgrps: number of groups
  *
  * Return: cpumask array if successful, NULL otherwise. And each element
- * includes CPUs assigned to this group
+ * includes CPUs assigned to this group. numgrps will be updated to the
+ * actuall allocated number of masks.
  *
  * Try to put close CPUs from viewpoint of CPU and NUMA locality into
  * same group, and run two-stage grouping:
@@ -344,9 +345,9 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
  * We guarantee in the resulted grouping that all CPUs are covered, and
  * no same CPU is assigned to multiple groups
  */
-struct cpumask *group_cpus_evenly(unsigned int numgrps)
+struct cpumask *group_cpus_evenly(unsigned int *numgrps)
 {
-	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
+	unsigned int curgrp = 0, nr_present = 0, nr_others = 0, nr_grps;
 	cpumask_var_t *node_to_cpumask;
 	cpumask_var_t nmsk, npresmsk;
 	int ret = -ENOMEM;
@@ -362,7 +363,8 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	if (!node_to_cpumask)
 		goto fail_npresmsk;
 
-	masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
+	nr_grps = *numgrps;
+	masks = kcalloc(nr_grps, sizeof(*masks), GFP_KERNEL);
 	if (!masks)
 		goto fail_node_to_cpumask;
 
@@ -383,7 +385,7 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	cpumask_copy(npresmsk, data_race(cpu_present_mask));
 
 	/* grouping present CPUs first */
-	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
+	ret = __group_cpus_evenly(curgrp, nr_grps, node_to_cpumask,
 				  npresmsk, nmsk, masks);
 	if (ret < 0)
 		goto fail_build_affinity;
@@ -395,19 +397,19 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	 * group space, assign the non present CPUs to the already
 	 * allocated out groups.
 	 */
-	if (nr_present >= numgrps)
+	if (nr_present >= nr_grps)
 		curgrp = 0;
 	else
 		curgrp = nr_present;
 	cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk);
-	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
+	ret = __group_cpus_evenly(curgrp, nr_grps, node_to_cpumask,
 				  npresmsk, nmsk, masks);
 	if (ret >= 0)
 		nr_others = ret;
 
  fail_build_affinity:
 	if (ret >= 0)
-		WARN_ON(nr_present + nr_others < numgrps);
+		WARN_ON(nr_present + nr_others < nr_grps);
 
  fail_node_to_cpumask:
 	free_node_to_cpumask(node_to_cpumask);
@@ -421,12 +423,13 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 		kfree(masks);
 		return NULL;
 	}
+	*numgrps = nr_present + nr_others;
 	return masks;
 }
 #else /* CONFIG_SMP */
-struct cpumask *group_cpus_evenly(unsigned int numgrps)
+struct cpumask *group_cpus_evenly(unsigned int *numgrps)
 {
-	struct cpumask *masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
+	struct cpumask *masks = kcalloc(*numgrps, sizeof(*masks), GFP_KERNEL);
 
 	if (!masks)
 		return NULL;

-- 
2.47.1


