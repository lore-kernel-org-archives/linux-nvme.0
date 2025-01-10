Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5554C02181
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 16:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=COOFLuHWs6EFHBkf+qkZ1QANfg5eWDE6zOoA02KVjF4=; b=FvIKa1uQG2idjaDoTYWsDIXry4
	JpcbYRc80uIWet1mQYLso5z+uV14IP8DBIV+DAiiXVUDAVXp1ux5bpIN3DcOpzEF5PUL2wSjFkIVR
	cAbXGGK2rO9hVzFEIDzsn6z7M9yx3H9fZ4nVaQAIae3UrsCXRE6teBRRIsU3We3LWOZkfsPlcLU6Z
	7MOF0tBfmpjyJV27hsWAMeYHBAr1IlS0g1UNROo8cC1iStjQHJD8FLQ9yVmv1BYNjensJp1x4h8t7
	xfMmg21nb7wxw05mrsFKo0DIMWx8OvtK0fi4GtbuVaqpZJxm5LIGfvkXl6QWO6ShX0+FaPbDO7ehz
	iTdPH7ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHv4-0000000GGeR-4ByR;
	Fri, 10 Jan 2025 16:31:35 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHqb-0000000GEwe-1CbD
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 16:26:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 13AE7A426B4;
	Fri, 10 Jan 2025 16:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86B1C4CED6;
	Fri, 10 Jan 2025 16:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736526416;
	bh=0ycW44IR1uqmQrDJLN8IiSf67ET1Zi70MGLU1ocQlSU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tE61rrMhwqmAQPxSwk5UrlzHUuve4bybQGl0HMGMlefY5rtcLGXwBkhUrhdiEFon7
	 pHeQSQRJqM9TfQeVSj9VryFQ02c2eIPchC/7OIoXlwYENopkVUdZNQQZYIFHvCK4K6
	 DrgGkfGTQbDEPKeSVxIEmoZf/rfyoo9WZ2F7DIviDLZZV0vNK/uLA3Wn0FTL4UBzqz
	 fq6bpIvVgVXPBAl2Apr/RqVHBlJhfl5yAn1nTnuzlAFiS8Ht7JHi8fleLFTO9jxtzF
	 cn4FaYgWsSehERVeL3HbipC8BdD8iSlmIDNjVsnwfGD6WFD20ko6EZr9tR/AornfNe
	 uPI8F6zu0XfBQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 10 Jan 2025 17:26:42 +0100
Subject: [PATCH v5 4/9] scsi: use block layer helpers to calculate num of
 queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-isolcpus-io-queues-v5-4-0e4f118680b0@kernel.org>
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
X-CRM114-CacheID: sfid-20250110_082657_465065_AE9A4282 
X-CRM114-Status: GOOD (  16.44  )
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
when isolcpus=managed_irq is set. This avoids that the isolated CPUs get
disturbed with OS workload.

Use helpers which calculates the correct number of queues which should
be used when isolcpus is used.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 15 +++++++++------
 drivers/scsi/qla2xxx/qla_isr.c            | 10 +++++-----
 drivers/scsi/smartpqi/smartpqi_init.c     |  5 ++---
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 49abd7dd75a7b7c1ddcfac41acecbbcf7de8f5a4..59d385e5a917979ae2f61f5db2c3355b9cab7e08 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5962,7 +5962,8 @@ megasas_alloc_irq_vectors(struct megasas_instance *instance)
 		else
 			instance->iopoll_q_count = 0;
 
-		num_msix_req = num_online_cpus() + instance->low_latency_index_start;
+		num_msix_req = blk_mq_num_online_queues(0) +
+			instance->low_latency_index_start;
 		instance->msix_vectors = min(num_msix_req,
 				instance->msix_vectors);
 
@@ -5978,7 +5979,8 @@ megasas_alloc_irq_vectors(struct megasas_instance *instance)
 		/* Disable Balanced IOPS mode and try realloc vectors */
 		instance->perf_mode = MR_LATENCY_PERF_MODE;
 		instance->low_latency_index_start = 1;
-		num_msix_req = num_online_cpus() + instance->low_latency_index_start;
+		num_msix_req = blk_mq_num_online_queues(0) +
+			instance->low_latency_index_start;
 
 		instance->msix_vectors = min(num_msix_req,
 				instance->msix_vectors);
@@ -6234,7 +6236,7 @@ static int megasas_init_fw(struct megasas_instance *instance)
 		intr_coalescing = (scratch_pad_1 & MR_INTR_COALESCING_SUPPORT_OFFSET) ?
 								true : false;
 		if (intr_coalescing &&
-			(num_online_cpus() >= MR_HIGH_IOPS_QUEUE_COUNT) &&
+			(blk_mq_num_online_queues(0) >= MR_HIGH_IOPS_QUEUE_COUNT) &&
 			(instance->msix_vectors == MEGASAS_MAX_MSIX_QUEUES))
 			instance->perf_mode = MR_BALANCED_PERF_MODE;
 		else
@@ -6278,7 +6280,8 @@ static int megasas_init_fw(struct megasas_instance *instance)
 		else
 			instance->low_latency_index_start = 1;
 
-		num_msix_req = num_online_cpus() + instance->low_latency_index_start;
+		num_msix_req = blk_mq_num_online_queues(0) +
+			instance->low_latency_index_start;
 
 		instance->msix_vectors = min(num_msix_req,
 				instance->msix_vectors);
@@ -6310,8 +6313,8 @@ static int megasas_init_fw(struct megasas_instance *instance)
 	megasas_setup_reply_map(instance);
 
 	dev_info(&instance->pdev->dev,
-		"current msix/online cpus\t: (%d/%d)\n",
-		instance->msix_vectors, (unsigned int)num_online_cpus());
+		"current msix/max num queues\t: (%d/%u)\n",
+		instance->msix_vectors, blk_mq_num_online_queues(0));
 	dev_info(&instance->pdev->dev,
 		"RDPQ mode\t: (%s)\n", instance->is_rdpq ? "enabled" : "disabled");
 
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index fe98c76e9be32ff03a1960f366f0d700d1168383..c4c6b5c6658c0734f7ff68bcc31b33dde87296dd 100644
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
index 04fb24d77e9b5c0137f26bc41f17191cc4c49728..7636c8d1c9f14a0d887c1d517c3664f0d0df7e6e 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -5278,15 +5278,14 @@ static void pqi_calculate_queue_resources(struct pqi_ctrl_info *ctrl_info)
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
2.47.1


