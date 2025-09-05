Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A847ECA0FED
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 19:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jk0FyT8WL1yaJvKQJYreZpD41x0kNbKTFvDhlyr1luk=; b=prRCOBlwEWkTdj+NS2gQNxgRCz
	Q9XyZGAgkU5T9dv0GFEBdsNpysOXgWWeUzp0Hh+hbHsEgCj+KoR757gGOBufI0TTIMsKT4Buq5iLq
	XX/1PWbhygqEXC5+Sp5/QB0H7QTtxzKvVj2xe8smLVFRbZegtuLuPFkVKLTDuLFUMzsBNHNqfUULx
	hx1cYXTzs704ej9enMJq0/VZBJ0iogfxtqSFGDEggP8vshwNgJoSfmlOLdqdQ0audUSE2BCVlwwti
	vCjJgj+k+bjX7PGNty6wbcSRSENEn9eQg3KjwU31ukDueBBTfwqB/x887RaPld9lnDoWHZ8Y2hr13
	yMxmlRAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuc5B-00000004710-47OU;
	Fri, 05 Sep 2025 19:26:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuXv3-00000002YpM-0uHk
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 15:00:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EBC8544081;
	Fri,  5 Sep 2025 15:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A785C4CEF1;
	Fri,  5 Sep 2025 15:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757084404;
	bh=jU42e5Y5gvp+U15EG/b+XZTCq5m+OBb1QHB6UT1r4bM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RxgBkbORY9v1Mj7909jeoQWdwzPsLaYcYfMy020TXs4p8LhpzqyWte1CEYxfoF78S
	 u0ItW+YQUCBDynkI9jGjBl3/KK9CpqTWfuehbNqElvSGtDLKOA9IV7PPlX3laO58Dy
	 JEeaLFs0uiclL7Vn6OgJzfxfnalx5UGYuJou9jrOW6nkHB9dpJQvohMNtYmzIBpcZF
	 O2W/TIGx0KRI9Ve/OM7qWESVI5vkAhhYi/V1c9QKkkpIJ+LFVK2giDPEB1EZ4CKWoq
	 aF1eWla9lV5dPCqYhBbfYGXaJOa+3sbEfK8LnjMkUA6QGKx6aN/rTg4xCrT8IJn6u8
	 8Z+gyG1CqNpCg==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 05 Sep 2025 16:59:50 +0200
Subject: [PATCH v8 04/12] genirq/affinity: Add cpumask to struct
 irq_affinity
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-isolcpus-io-queues-v8-4-885984c5daca@kernel.org>
References: <20250905-isolcpus-io-queues-v8-0-885984c5daca@kernel.org>
In-Reply-To: <20250905-isolcpus-io-queues-v8-0-885984c5daca@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
 storagedev@microchip.com, virtualization@lists.linux.dev, 
 GR-QLogic-Storage-Upstream@marvell.com, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_080005_308883_D698BDDD 
X-CRM114-Status: GOOD (  19.43  )
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

Pass a cpumask to irq_create_affinity_masks as an additional constraint
to consider when creating the affinity masks. This allows the caller to
exclude specific CPUs, e.g., isolated CPUs (see the 'isolcpus' kernel
command-line parameter).

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 include/linux/interrupt.h | 16 ++++++++++------
 kernel/irq/affinity.c     | 12 ++++++++++--
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 51b6484c049345c75816c4a63b4efa813f42f27b..b1a230953514da57e30e601727cd0e94796153d3 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -284,18 +284,22 @@ struct irq_affinity_notify {
  * @nr_sets:		The number of interrupt sets for which affinity
  *			spreading is required
  * @set_size:		Array holding the size of each interrupt set
+ * @mask:		cpumask that constrains which CPUs to consider when
+ *			calculating the number and size of the interrupt sets
  * @calc_sets:		Callback for calculating the number and size
  *			of interrupt sets
  * @priv:		Private data for usage by @calc_sets, usually a
  *			pointer to driver/device specific data.
  */
 struct irq_affinity {
-	unsigned int	pre_vectors;
-	unsigned int	post_vectors;
-	unsigned int	nr_sets;
-	unsigned int	set_size[IRQ_AFFINITY_MAX_SETS];
-	void		(*calc_sets)(struct irq_affinity *, unsigned int nvecs);
-	void		*priv;
+	unsigned int		pre_vectors;
+	unsigned int		post_vectors;
+	unsigned int		nr_sets;
+	unsigned int		set_size[IRQ_AFFINITY_MAX_SETS];
+	const struct cpumask	*mask;
+	void			(*calc_sets)(struct irq_affinity *,
+					     unsigned int nvecs);
+	void			*priv;
 };
 
 /**
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 4013e6ad2b2f1cb91de12bb428b3281105f7d23b..c68156f7847a7920103e39124676d06191304ef6 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -70,7 +70,13 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 	 */
 	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
 		unsigned int nr_masks, this_vecs = affd->set_size[i];
-		struct cpumask *result = group_cpus_evenly(this_vecs, &nr_masks);
+		struct cpumask *result;
+
+		if (affd->mask)
+			result = group_mask_cpus_evenly(this_vecs, affd->mask,
+							&nr_masks);
+		else
+			result = group_cpus_evenly(this_vecs, &nr_masks);
 
 		if (!result) {
 			kfree(masks);
@@ -115,7 +121,9 @@ unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
 	if (resv > minvec)
 		return 0;
 
-	if (affd->calc_sets) {
+	if (affd->mask) {
+		set_vecs = cpumask_weight(affd->mask);
+	} else if (affd->calc_sets) {
 		set_vecs = maxvec - resv;
 	} else {
 		cpus_read_lock();

-- 
2.51.0


