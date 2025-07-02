Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328DCC83F03
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 17:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JTmdM6Ks6oRiXBiTbtMzPkG1Lm5pwCjQSqNx40R7i9Q=; b=bQOfJN7/ueofnx9rHRPhPvlXQo
	MvaLOeVyM+xymWWSXVX76M/tTpy4NvLZolBpY/pk0L1r49NfCzLri+5/017x4rt2Rpxhhga5Kz+LA
	W+XD7CcCpYilYWIY4xSO+g92ylHR2BpobgjV4cWPQeuyLyUf7oUpCIHN7KPj+q0Fss8U+csHvUk5Y
	xi7umNb9yCAtIlivXe8Mef1e2Ij7TibsU3UQ/w168mGw7kjY7KjetE/Y5YIvDTKRexwo1+ibnScSS
	rYfgXhiX5FcI6sVEYz2uh6/m65sKCP2fkpMoC4nLpu5Be+2S60D6NcfvE3BJ5daZXPHnu+YmLMj31
	NICMdHeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX0x1-000000094Po-1ogd;
	Wed, 02 Jul 2025 17:08:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX0PS-00000008xYe-1R1C
	for linux-nvme@lists.infradead.org;
	Wed, 02 Jul 2025 16:34:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4B54D46279;
	Wed,  2 Jul 2025 16:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68ABEC4CEE7;
	Wed,  2 Jul 2025 16:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751474049;
	bh=ZJx70kiDsgC+DvPstRSCuB+T5Sr+VGqtX8Iu26ORUf8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ICpwtqzl0H5YlFQTUe36id493BGzReA0DPBU1bxUBrIDqDXwaAlLo92n44OT6Zler
	 KhfrCeRp3HvRO2RJQwNvYhrYEfnWGT2VCKvpzLY6A4ZtoNY1mSX+jdozTocO3FRPZM
	 FvKLyzF0cNVAMy5lhvuJo72qzRdUFxWnx1THFXezmEjXmUcEFbWSFJxrBGHhElmsAz
	 uihOfk5bRc1/VeoISbrEbnAVaDSZKjP0Jq27//6Vee2juMDbbpJnKA/PdhpQUXvRtV
	 hDUmpi/G7ZoHCwnL67KznpKYmVkclKw78f7U5HmE5UlecNWCC5M2ZL2ezop0D+DPJ/
	 AQFZlcaSSonYQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 02 Jul 2025 18:33:52 +0200
Subject: [PATCH v7 02/10] genirq/affinity: Add cpumask to struct
 irq_affinity
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-isolcpus-io-queues-v7-2-557aa7eacce4@kernel.org>
References: <20250702-isolcpus-io-queues-v7-0-557aa7eacce4@kernel.org>
In-Reply-To: <20250702-isolcpus-io-queues-v7-0-557aa7eacce4@kernel.org>
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
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, 
 linux-scsi@vger.kernel.org, storagedev@microchip.com, 
 virtualization@lists.linux.dev, GR-QLogic-Storage-Upstream@marvell.com, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_093410_422818_F1D68D50 
X-CRM114-Status: GOOD (  19.65  )
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
2.50.0


