Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAD4D462AC
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 14:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VCwYGDc/Wg4DdIQH19ttOc+zbyRO9guoUElUaS1z5N8=; b=NU+Xe47gDU2ws0wHIDMJsMFCUT
	IfzRJ070NPh+jW428nVLitdfhkjJvraKVtN9iRW6bs3CYfs0hrsCW1QoXMuAUm7Y7xY6S4nUulSn+
	coyLCDYltz6gkAvb8YYRIRMcEJkPxqu5eLb8OLqwgpF5QF4FPjm9JiepTQ8Zs0lB3a84WvrsrMYU7
	JzrxvXqfpDtXdAyaNNDUo28xghVkj6UYuzk2YSsEIW+X14CMBOfi+3CVdttFSRfABLeAr0dyxiROP
	Lh72xezA3DuaTFKIs3u22wNb0MIw5+RbJMCRxTydjjXhXjjGfx6tkXeWL9AaHmBPYNZws85J7kqii
	iRo7P5rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBEKc-0000000784z-43wM;
	Wed, 13 Nov 2024 14:26:54 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBEKW-000000077z1-1c9Z
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 14:26:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 46F6D5C4BDF;
	Wed, 13 Nov 2024 14:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6DCC4CEC3;
	Wed, 13 Nov 2024 14:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731508007;
	bh=SpNSH5ZDRrOAxRiK/olTF7iQajBiX0Xq/z1Pk/ry918=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PrUHBpZyfuiOxauRWic7uNSBd0YcOsQkPsaAQLQVOpmaUWq4oX6rVpQKr4NHcM0gu
	 Fmsl93jYMFkjDH8QJUmB/65Whp1YMFGRbKqb51U7hgi08YJq2Lo7B+FSucy8Myd/Wc
	 m37m34alBNH7ca5GMjbNeqdhjqcbzN8c5hjl0ybkfWlx0OOQ9StXfzMC/QYMMB2w3N
	 TW6Akra+rAyT1Ox1+6iQ2JDrzdw6mBeeulr/L/PlTwXRyZpDlT23iUUIDipmVNfGf6
	 WpRPWcCetr6Dsy04BMWVvkGWm6SE8w03UiwxHEG5HMWUHGoX9w0FyyjPoZRim4y1V4
	 4TIU+FkaVXcZw==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 13 Nov 2024 15:26:21 +0100
Subject: [PATCH v4 07/10] scsi: hisi_sas: use blk_mq_hctx_map_queues to map
 queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-refactor-blk-affinity-helpers-v4-7-dd3baa1e267f@kernel.org>
References: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
In-Reply-To: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, John Garry <john.g.garry@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_062648_635697_D4BE1F33 
X-CRM114-Status: GOOD (  15.99  )
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

The PCI struct bus_type irq_get_affinity callback can't be used here as
hisi_sas v2 implements its own irq affinity code. Thus install a driver
specific irq_get_affinity callback. With this in place it's possible to
replace the open coded queue mapping with blk_mq_hctx_map_queues
function.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 342d75f12051d28fb1a0692b45ff568dd5b6f814..faa85fbf3e267cf883568d1808207e9a56c70674 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3372,7 +3372,7 @@ static int interrupt_init_v2_hw(struct hisi_hba *hisi_hba)
 	for (queue_no = 0; queue_no < hisi_hba->cq_nvecs; queue_no++) {
 		struct hisi_sas_cq *cq = &hisi_hba->cq[queue_no];
 
-		cq->irq_no = hisi_hba->irq_map[queue_no + 96];
+		cq->irq_no = hisi_hba->irq_map[queue_no + COQ_IRQ_INDEX];
 		rc = devm_request_threaded_irq(dev, cq->irq_no,
 					       cq_interrupt_v2_hw,
 					       cq_thread_v2_hw, IRQF_ONESHOT,
@@ -3389,6 +3389,14 @@ static int interrupt_init_v2_hw(struct hisi_hba *hisi_hba)
 	return rc;
 }
 
+static const struct cpumask *hisi_sas_v2_irq_get_affinity(struct device *dev,
+							  unsigned int irq_vec)
+{
+	struct hisi_hba *hisi_hba = dev->driver_data;
+
+	return irq_get_affinity_mask(hisi_hba->irq_map[irq_vec]);
+}
+
 static int hisi_sas_v2_init(struct hisi_hba *hisi_hba)
 {
 	int rc;
@@ -3553,17 +3561,8 @@ static void map_queues_v2_hw(struct Scsi_Host *shost)
 {
 	struct hisi_hba *hisi_hba = shost_priv(shost);
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
-	const struct cpumask *mask;
-	unsigned int queue, cpu;
 
-	for (queue = 0; queue < qmap->nr_queues; queue++) {
-		mask = irq_get_affinity_mask(hisi_hba->irq_map[96 + queue]);
-		if (!mask)
-			continue;
-
-		for_each_cpu(cpu, mask)
-			qmap->mq_map[cpu] = qmap->queue_offset + queue;
-	}
+	blk_mq_hctx_map_queues(qmap, hisi_hba->dev, CQ0_IRQ_INDEX);
 }
 
 static const struct scsi_host_template sht_v2_hw = {
@@ -3636,6 +3635,7 @@ static struct platform_driver hisi_sas_v2_driver = {
 		.name = DRV_NAME,
 		.of_match_table = sas_v2_of_match,
 		.acpi_match_table = ACPI_PTR(sas_v2_acpi_match),
+		.irq_get_affinity = hisi_sas_v2_irq_get_affinity,
 	},
 };
 

-- 
2.47.0


