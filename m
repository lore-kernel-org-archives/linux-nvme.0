Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FD4C49EA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 14:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pl/sLXhPjSdozSC6CzNS3XBtS+poy/4xCdFTh2N/iYI=; b=K6HzmFNoTW+DgtniPzjm/Os7k/
	OlxZop7a9387AkaaK92q6yT34+QHwigkhRbdXN0E6u5TB7LRBCm0aSBb1lXYJRB17LmDopVW9wKUP
	NA4vzJcWT2J1YrxyRvkdMWkXAhLl38BFkGOV3HYbXODxCIGerBr+vZO25QSl755+ajb06oMHVc+l/
	sW9Yfgn0mDvWAiNJIUO3TrmbEUnfG68zNL0yXPv2hVDwocsjy+xphoCmbjAGXJhp9gd6Cq9ZZrMOb
	e684eRC76N9pHueWkxNeN1tyfMGIMbVwQdGqUMvM/zcdHvqZOkA/OIpMFuRGhQgb6DQ52161WOBxK
	gyTbYZ2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbLXr-000000023OL-33a3;
	Tue, 06 Aug 2024 14:52:15 +0000
Received: from mail.nearlyone.de ([49.12.199.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIyZ-00000001R7l-1Nn2
	for linux-nvme@lists.infradead.org;
	Tue, 06 Aug 2024 12:07:41 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB3ADDAE22;
	Tue,  6 Aug 2024 14:07:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1722946057; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pl/sLXhPjSdozSC6CzNS3XBtS+poy/4xCdFTh2N/iYI=;
	b=SyDtHztfZogC6F3whyinrU6GYIwLRO+sBOjW8ehLox8bpA8STGRUEsRodIDK3l0X84VoGV
	IVFgWts+ug75HXUyczpYvPBCuoWRCSn6MfLCg9ZNWKfHq42fJyUrQSOw2QZ6NEtXfgE2zl
	7XV4HfBH62w3S2ewW6l9aOts2ROkpo24m/V6AqqxeJaDScwRrqbDKQzj+aSjtxsqy/Snd4
	uWRNIKhjs6/A6dTAD3uOnly6tTCKbEWJVjcDSTRR6ELccHQG/RQt7Clnz3DGYjZWjoBqpl
	dzvWWAptGSGye+HGNdwWhaJ0fwQlgULWulBaM3R1K2qtYGrGCcmLTCEOctQgHA==
From: Daniel Wagner <dwagner@suse.de>
Date: Tue, 06 Aug 2024 14:06:44 +0200
Subject: [PATCH v3 12/15] scsi: use block layer helpers to calculate num of
 queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-isolcpus-io-queues-v3-12-da0eecfeaf8b@suse.de>
References: <20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de>
In-Reply-To: <20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
 Christoph Hellwig <hch@lst.de>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 John Garry <john.g.garry@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Kashyap Desai <kashyap.desai@broadcom.com>, 
 Sumit Saxena <sumit.saxena@broadcom.com>, 
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>, 
 Chandrakanth patil <chandrakanth.patil@broadcom.com>, 
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, 
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, 
 Nilesh Javali <njavali@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, 
 Hannes Reinecke <hare@suse.de>, 
 Sridhar Balaraman <sbalaraman@parallelwireless.com>, 
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
 virtualization@lists.linux.dev, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-doc@vger.kernel.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.14.0
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_050739_707696_757F4FA8 
X-CRM114-Status: GOOD (  15.16  )
X-Mailman-Approved-At: Tue, 06 Aug 2024 07:51:53 -0700
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

Multiqueue devices should only allocate queues for the housekeeping CPUs
when isolcpus=io_queue is set. This avoids that the isolated CPUs get
disturbed with OS workload.

Use helpers which calculates the correct number of queues which should
be used when isolcpus is used.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 15 +++++++++------
 drivers/scsi/qla2xxx/qla_isr.c            | 10 +++++-----
 drivers/scsi/smartpqi/smartpqi_init.c     |  5 ++---
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index d026b7513c8d..ddddcdbf71b2 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5964,7 +5964,8 @@ megasas_alloc_irq_vectors(struct megasas_instance *instance)
 		else
 			instance->iopoll_q_count = 0;
 
-		num_msix_req = num_online_cpus() + instance->low_latency_index_start;
+		num_msix_req = blk_mq_num_online_queues(0) +
+			instance->low_latency_index_start;
 		instance->msix_vectors = min(num_msix_req,
 				instance->msix_vectors);
 
@@ -5980,7 +5981,8 @@ megasas_alloc_irq_vectors(struct megasas_instance *instance)
 		/* Disable Balanced IOPS mode and try realloc vectors */
 		instance->perf_mode = MR_LATENCY_PERF_MODE;
 		instance->low_latency_index_start = 1;
-		num_msix_req = num_online_cpus() + instance->low_latency_index_start;
+		num_msix_req = blk_mq_num_online_queues(0) +
+			instance->low_latency_index_start;
 
 		instance->msix_vectors = min(num_msix_req,
 				instance->msix_vectors);
@@ -6236,7 +6238,7 @@ static int megasas_init_fw(struct megasas_instance *instance)
 		intr_coalescing = (scratch_pad_1 & MR_INTR_COALESCING_SUPPORT_OFFSET) ?
 								true : false;
 		if (intr_coalescing &&
-			(num_online_cpus() >= MR_HIGH_IOPS_QUEUE_COUNT) &&
+			(blk_mq_num_online_queues(0) >= MR_HIGH_IOPS_QUEUE_COUNT) &&
 			(instance->msix_vectors == MEGASAS_MAX_MSIX_QUEUES))
 			instance->perf_mode = MR_BALANCED_PERF_MODE;
 		else
@@ -6280,7 +6282,8 @@ static int megasas_init_fw(struct megasas_instance *instance)
 		else
 			instance->low_latency_index_start = 1;
 
-		num_msix_req = num_online_cpus() + instance->low_latency_index_start;
+		num_msix_req = blk_mq_num_online_queues(0) +
+			instance->low_latency_index_start;
 
 		instance->msix_vectors = min(num_msix_req,
 				instance->msix_vectors);
@@ -6312,8 +6315,8 @@ static int megasas_init_fw(struct megasas_instance *instance)
 	megasas_setup_reply_map(instance);
 
 	dev_info(&instance->pdev->dev,
-		"current msix/online cpus\t: (%d/%d)\n",
-		instance->msix_vectors, (unsigned int)num_online_cpus());
+		"current msix/max num queues\t: (%d/%u)\n",
+		instance->msix_vectors, blk_mq_num_online_queues(0));
 	dev_info(&instance->pdev->dev,
 		"RDPQ mode\t: (%s)\n", instance->is_rdpq ? "enabled" : "disabled");
 
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index fe98c76e9be3..c4c6b5c6658c 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -4533,13 +4533,13 @@ qla24xx_enable_msix(struct qla_hw_data *ha, struct rsp_que *rsp)
 	if (USER_CTRL_IRQ(ha) || !ha->mqiobase) {
 		/* user wants to control IRQ setting for target mode */
 		ret = pci_alloc_irq_vectors(ha->pdev, min_vecs,
-		    min((u16)ha->msix_count, (u16)(num_online_cpus() + min_vecs)),
-		    PCI_IRQ_MSIX);
+			blk_mq_num_online_queues(ha->msix_count) + min_vecs,
+			PCI_IRQ_MSIX);
 	} else
 		ret = pci_alloc_irq_vectors_affinity(ha->pdev, min_vecs,
-		    min((u16)ha->msix_count, (u16)(num_online_cpus() + min_vecs)),
-		    PCI_IRQ_MSIX | PCI_IRQ_AFFINITY,
-		    &desc);
+			blk_mq_num_online_queues(ha->msix_count) + min_vecs,
+			PCI_IRQ_MSIX | PCI_IRQ_AFFINITY,
+			&desc);
 
 	if (ret < 0) {
 		ql_log(ql_log_fatal, vha, 0x00c7,
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 1fb13d4e0448..da361602ad7d 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -5264,15 +5264,14 @@ static void pqi_calculate_queue_resources(struct pqi_ctrl_info *ctrl_info)
 	if (reset_devices) {
 		num_queue_groups = 1;
 	} else {
-		int num_cpus;
 		int max_queue_groups;
 
 		max_queue_groups = min(ctrl_info->max_inbound_queues / 2,
 			ctrl_info->max_outbound_queues - 1);
 		max_queue_groups = min(max_queue_groups, PQI_MAX_QUEUE_GROUPS);
 
-		num_cpus = num_online_cpus();
-		num_queue_groups = min(num_cpus, ctrl_info->max_msix_vectors);
+		num_queue_groups =
+			blk_mq_num_online_queues(ctrl_info->max_msix_vectors);
 		num_queue_groups = min(num_queue_groups, max_queue_groups);
 	}
 

-- 
2.46.0


