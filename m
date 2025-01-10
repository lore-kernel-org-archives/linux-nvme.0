Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9C1E7719D
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 16:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G4e36JRA7Bb6NdtrF/BTnNPGVBP4jdrdeR+NgOpWS70=; b=fBUYxRJ5NKf2JKXg+CBnxkTZOD
	bC6YNB9nZrmjid2Sn0E43mA/nkbDhZJS7i4mrZgYAxsoSCxZoxrhy+IZj3XehA9s8sgv7CQpFcYhT
	Sg0ymd9h63zTSIcf07SCrssN7uDl/W0RawGnOyId4KW5r0ukPe01RqUA/eKOcKXS/1VWM/3PPw1ZH
	MnoX1E61kPeUPvF4yn9H6t13/XMvj38Kb6dfR2TgXdtE0TAMOhe3hEFGRnHYNLASysGbAfqkKU3jw
	ihmVlMSnpijh2SCQ2A4vbZdBHSYzlHqJMMFIJkUE8NFlC+YD13cE3tu2ewMCZgZD58TlbxdOtVudZ
	DsWe21AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHv3-0000000GGcx-0YEE;
	Fri, 10 Jan 2025 16:31:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHqT-0000000GEtU-27x2
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 16:26:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D7FBE5C47D6;
	Fri, 10 Jan 2025 16:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DBFC4CED6;
	Fri, 10 Jan 2025 16:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736526408;
	bh=2QlSRxWs/elhgqriGrrcLTL8l5gVPM+GPSu5vog+ndE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J0LyphEcTT2dtqLr/I2zTqssQLGVB8RPIjRzMx9HKxRhCEsKEpRuOGRxZl1dE5vgH
	 Go3EDTxQRm8ip63xxIylah/Yz3O0t5hUXYyMQvm7D6RKl/PuWbyJUeS8AMUbdNFm4f
	 tzfh/d17n1VbVtbWGFaremV9OTyHJ9zbTsFJvjYsUtqUOVaAZlG/dE8miELPFHD3MF
	 CcwhVomaAbd1+S6vfOHUD2oX2RKogpvM2ON4OuuJUPVcJv91rJdlir97WNeeMMNua2
	 zESOJzWifvvCN8hs2L5RdHWG80/u3AWpyVoQR4pOcda/8ZU0y9sOzRl+J1chTVu8rC
	 9TAilm8+wD9Qg==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 10 Jan 2025 17:26:39 +0100
Subject: [PATCH v5 1/9] lib/group_cpus: let group_cpu_evenly return number
 initialized masks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-isolcpus-io-queues-v5-1-0e4f118680b0@kernel.org>
References: <20250110-isolcpus-io-queues-v5-0-0e4f118680b0@kernel.org>
In-Reply-To: <20250110-isolcpus-io-queues-v5-0-0e4f118680b0@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, 
 linux-scsi@vger.kernel.org, storagedev@microchip.com, 
 virtualization@lists.linux.dev, GR-QLogic-Storage-Upstream@marvell.com, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_082649_640049_DF974383 
X-CRM114-Status: GOOD (  20.97  )
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
 block/blk-mq-cpumap.c        |  6 +++---
 drivers/virtio/virtio_vdpa.c |  9 +++++----
 fs/fuse/virtio_fs.c          |  6 +++---
 include/linux/group_cpus.h   |  3 ++-
 kernel/irq/affinity.c        |  9 +++++----
 lib/group_cpus.c             | 12 +++++++++---
 6 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index ad8d6a363f24ae11968b42f7bcfd6a719a0499b7..7d3dfe885dfac18711ae73eff510efe3877ffcb6 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -19,9 +19,9 @@
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 {
 	const struct cpumask *masks;
-	unsigned int queue, cpu;
+	unsigned int queue, cpu, nr_masks;
 
-	masks = group_cpus_evenly(qmap->nr_queues);
+	masks = group_cpus_evenly(qmap->nr_queues, &nr_masks);
 	if (!masks) {
 		for_each_possible_cpu(cpu)
 			qmap->mq_map[cpu] = qmap->queue_offset;
@@ -29,7 +29,7 @@ void blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 	}
 
 	for (queue = 0; queue < qmap->nr_queues; queue++) {
-		for_each_cpu(cpu, &masks[queue])
+		for_each_cpu(cpu, &masks[queue % nr_masks])
 			qmap->mq_map[cpu] = qmap->queue_offset + queue;
 	}
 	kfree(masks);
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 1f60c9d5cb1810a6f208c24bb2ac640d537391a0..a7b297dae4890c9d6002744b90fc133bbedb7b44 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -329,20 +329,21 @@ create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 
 	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
 		unsigned int this_vecs = affd->set_size[i];
+		unsigned int nr_masks;
 		int j;
-		struct cpumask *result = group_cpus_evenly(this_vecs);
+		struct cpumask *result = group_cpus_evenly(this_vecs, &nr_masks);
 
 		if (!result) {
 			kfree(masks);
 			return NULL;
 		}
 
-		for (j = 0; j < this_vecs; j++)
+		for (j = 0; j < nr_masks; j++)
 			cpumask_copy(&masks[curvec + j], &result[j]);
 		kfree(result);
 
-		curvec += this_vecs;
-		usedvecs += this_vecs;
+		curvec += nr_masks;
+		usedvecs += nr_masks;
 	}
 
 	/* Fill out vectors at the end that don't need affinity */
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 82afe78ec542358e2db6f4d955d521652ae363ec..47412bd40285a28d0dd61e4b3dabc59d5a1ba54e 100644
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
@@ -882,7 +882,7 @@ static void virtio_fs_map_queues(struct virtio_device *vdev, struct virtio_fs *f
 	return;
 fallback:
 	/* Attempt to map evenly in groups over the CPUs */
-	masks = group_cpus_evenly(fs->num_request_queues);
+	masks = group_cpus_evenly(fs->num_request_queues, &nr_masks);
 	/* If even this fails we default to all CPUs use first request queue */
 	if (!masks) {
 		for_each_possible_cpu(cpu)
@@ -891,7 +891,7 @@ static void virtio_fs_map_queues(struct virtio_device *vdev, struct virtio_fs *f
 	}
 
 	for (q = 0; q < fs->num_request_queues; q++) {
-		for_each_cpu(cpu, &masks[q])
+		for_each_cpu(cpu, &masks[q % nr_masks])
 			fs->mq_map[cpu] = q + VQ_REQUEST;
 	}
 	kfree(masks);
diff --git a/include/linux/group_cpus.h b/include/linux/group_cpus.h
index e42807ec61f6e8cf3787af7daa0d8686edfef0a3..bd5dada6e8606fa6cf8f7babf939e39fd7475c8d 100644
--- a/include/linux/group_cpus.h
+++ b/include/linux/group_cpus.h
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/cpu.h>
 
-struct cpumask *group_cpus_evenly(unsigned int numgrps);
+struct cpumask *group_cpus_evenly(unsigned int numgrps,
+				  unsigned int *nummasks);
 
 #endif
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 44a4eba80315cc098ecfa366ca1d88483641b12a..d2aefab5eb2b929877ced43f48b6268098484bd7 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -70,20 +70,21 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 	 */
 	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
 		unsigned int this_vecs = affd->set_size[i];
+		unsigned int nr_masks;
 		int j;
-		struct cpumask *result = group_cpus_evenly(this_vecs);
+		struct cpumask *result = group_cpus_evenly(this_vecs, &nr_masks);
 
 		if (!result) {
 			kfree(masks);
 			return NULL;
 		}
 
-		for (j = 0; j < this_vecs; j++)
+		for (j = 0; j < nr_masks; j++)
 			cpumask_copy(&masks[curvec + j].mask, &result[j]);
 		kfree(result);
 
-		curvec += this_vecs;
-		usedvecs += this_vecs;
+		curvec += nr_masks;
+		usedvecs += nr_masks;
 	}
 
 	/* Fill out vectors at the end that don't need affinity */
diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index ee272c4cefcc13907ce9f211f479615d2e3c9154..016c6578a07616959470b47121459a16a1bc99e5 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -332,9 +332,11 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 /**
  * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
  * @numgrps: number of groups
+ * @nummasks: number of initialized cpumasks
  *
  * Return: cpumask array if successful, NULL otherwise. And each element
- * includes CPUs assigned to this group
+ * includes CPUs assigned to this group. nummasks contains the number
+ * of initialized masks which can be less than numgrps.
  *
  * Try to put close CPUs from viewpoint of CPU and NUMA locality into
  * same group, and run two-stage grouping:
@@ -344,7 +346,8 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
  * We guarantee in the resulted grouping that all CPUs are covered, and
  * no same CPU is assigned to multiple groups
  */
-struct cpumask *group_cpus_evenly(unsigned int numgrps)
+struct cpumask *group_cpus_evenly(unsigned int numgrps,
+				  unsigned int *nummasks)
 {
 	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
 	cpumask_var_t *node_to_cpumask;
@@ -421,10 +424,12 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 		kfree(masks);
 		return NULL;
 	}
+	*nummasks = nr_present + nr_others;
 	return masks;
 }
 #else /* CONFIG_SMP */
-struct cpumask *group_cpus_evenly(unsigned int numgrps)
+struct cpumask *group_cpus_evenly(unsigned int numgrps,
+				  unsigned int *nummasks)
 {
 	struct cpumask *masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
 
@@ -433,6 +438,7 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 
 	/* assign all CPUs(cpu 0) to the 1st group only */
 	cpumask_copy(&masks[0], cpu_possible_mask);
+	*nummasks = 1;
 	return masks;
 }
 #endif /* CONFIG_SMP */

-- 
2.47.1


