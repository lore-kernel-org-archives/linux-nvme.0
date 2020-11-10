Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5B6C2D0A3
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 00:34:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA02206D8
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 00:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WDCZZd+a";
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="McaleckS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA02206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aGVWscAscLCPvgqRbIkzZesgOeYrMEAp86zfc1oyX+w=; b=WDCZZd+aEwTC/g2BiCfGxOzN0
	dgiYWJCX3uX6mqInWRrqRiWt/irTI0vyG/V/e/Dae4X6e+aegOsyeRdF2gcGOr62Yfgq1lQlzqFCT
	r7ACiWFyhrpqQPNhyzq0RlaEIGEWcxVBi2Ar/R/k7/x7+RoVIY1xMc/APHrYpC4Pgmi0/YCy//d2o
	C1B3nV50b+/sVMK0cX7BX8uUPMwE8F4vCGbJ/BzfmEEYbOWvVUfJLjtmU6QMHCY9P7u59aw6yqVbK
	SNThdzhmoMgEmA/zCaSdXaj8hhEE2kYOi4bkhVP+JwXJwxrM7egmczaeCUurDRxWwHBaKtFegO4Cm
	i+TBOoHFw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcHc1-00022J-W1; Tue, 10 Nov 2020 00:34:18 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcHby-00021e-V5
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 00:34:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604969422; x=1636505422;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=woQRnSqJ0AM2fc1Lku/p1NXHdi6+WogZmL45t3LSWsk=;
 b=McaleckSNWRilMRslUEN0Gq1N63fZNOfPLwep7HL871RbZV91UMT85nx
 +s5413hd666bwUTRhDENhMmt31b4wZxCFoBHhRbN2dG/QMtKGHtytAlOm
 dGJCLmzsKSb8x9MqdNvEHQBpIj0k9d8eY/PruCF4W49NoG39ywdLoK2vF
 x1GXMEMOe0MWhOHn/X3upU2j9rVsYBj1XZdxlUOWFFSJ3Wo2aCR8DvIIC
 aZTNqpCtP3Djp+8SKCUJ1JgTtkCqR1ZHCAx00kBAT4h5oJ28lz0YNyvFJ
 2mGUYbxEQb7A04YFlrZx0WYokQ/prucKzcXw235/ghmGkHgj2VvTQKtS+ A==;
IronPort-SDR: U0HQCtrxeid0ZFrImb2N57WUYra25cHoyQoIDdPFDMmUKbUG0YmDouaPwReYLTxPOdpBH01mVL
 y4oY/O+kCYJtxDPnkODjGViRYi3TL+QZshJuFG9Ud+3k9y5NkPcZYCu3NZxp/0WQWp+cqnzxOi
 sla3clYhRuX2mxnQfjq4dckzvOyTu3d8A115oxRWFk7pGAPlUjd9QbXBXslUPkqCLVf6kwzhQJ
 ftxXq3ucO6vV9FWiqZUsV35KfqP+FRsaOYCh5/8FTiASFd3AosftalEGJm4gkIIBbaMHmowKWW
 q7k=
X-IronPort-AV: E=Sophos;i="5.77,464,1596470400"; d="scan'208";a="255788759"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 08:50:20 +0800
IronPort-SDR: XkirYzzhZbXwxG8zTy+wjswgyPhi2sgyi5iAyF1m/NISYn9Mgm7LjsuR/PdeNx3EgNoii8YZne
 fNwKrsCYeLq0pdtuoMdcECSevKw+d74N4dGqSPK63eXr3AndjNa4PEFV1/rkK2PNXxKSis3xuq
 p3672qwsLMO8WtifTWuvj6V+RrxUOcoSPYdhKhM5RMdxyyaDV7E+1vW/F2tFZxAjIz5gyhQkZ5
 5uHyEpMjc7zOByCGbTO9YeEM9fuIeNCNRJ4WCvJWL4O6a5AVU/FYOeZvIgYpdvyVhb+87Iulbe
 6cG4CnFkZ7YPUCiuqzkFWw4V
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2020 16:20:14 -0800
IronPort-SDR: wNrWos45T30x+FiI/+sb11u9o/VVexoJVuEeRYT3383tlqZ35sFFFTMFur4XIRi2mADegvWNSG
 WyX49ZG3nT6qsJZJrRihTYUrEQMm68aulCNDtnaOsii7GsHBrG395+Ddahj2YiVa/6xoLqikv8
 yxrQc5oFmPyw1rQrJnNym0/66vRN1xfFnqGIZlwRf0nzRYjsrQe/tlwD/LTrHCKF7kF9rmGKP3
 MOJ1raMm3pAjYi+JzCjCimvM0kieKW5xJFiq+1JM+cQErbBCHgwNGXvnnqWUopryYSTevJqCiW
 3VE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 16:34:12 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V8 4/4] nvme: use consistent macro name for timeout
Date: Mon,  9 Nov 2020 16:33:45 -0800
Message-Id: <20201110003345.8191-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201110003345.8191-1-chaitanya.kulkarni@wdc.com>
References: <20201110003345.8191-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_193415_138881_7A9E7A5D 
X-CRM114-Status: GOOD (  14.66  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is purely a clenaup patch, add prefix NVME to the ADMIN_TIMEOUT to
make consistent with NVME_IO_TIMEOUT.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c   | 6 +++---
 drivers/nvme/host/fc.c     | 2 +-
 drivers/nvme/host/nvme.h   | 2 +-
 drivers/nvme/host/pci.c    | 4 ++--
 drivers/nvme/host/rdma.c   | 2 +-
 drivers/nvme/host/tcp.c    | 2 +-
 drivers/nvme/target/loop.c | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 97348b1ecfd6..98bea150e5dc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -536,7 +536,7 @@ struct request *nvme_alloc_request(struct request_queue *q,
 	if (req->q->queuedata)
 		req->timeout = NVME_IO_TIMEOUT;
 	else /* no queuedata implies admin queue */
-		req->timeout = ADMIN_TIMEOUT;
+		req->timeout = NVME_ADMIN_TIMEOUT;
 
 	req->cmd_flags |= REQ_FAILFAST_DRIVER;
 	nvme_clear_nvme_request(req);
@@ -2268,8 +2268,8 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 	cmd.common.cdw10 = cpu_to_le32(((u32)secp) << 24 | ((u32)spsp) << 8);
 	cmd.common.cdw11 = cpu_to_le32(len);
 
-	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
-				      ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0, false);
+	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len, 0,
+			NVME_QID_ANY, 1, 0, false);
 }
 EXPORT_SYMBOL_GPL(nvme_sec_submit);
 #endif /* CONFIG_BLK_SED_OPAL */
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index f4c246462658..38373a0e86ef 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3479,7 +3479,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 			    ctrl->lport->ops->fcprqst_priv_sz);
 	ctrl->admin_tag_set.driver_data = ctrl;
 	ctrl->admin_tag_set.nr_hw_queues = 1;
-	ctrl->admin_tag_set.timeout = ADMIN_TIMEOUT;
+	ctrl->admin_tag_set.timeout = NVME_ADMIN_TIMEOUT;
 	ctrl->admin_tag_set.flags = BLK_MQ_F_NO_SCHED;
 
 	ret = blk_mq_alloc_tag_set(&ctrl->admin_tag_set);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bc330bf0d3bd..53783358d62b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -24,7 +24,7 @@ extern unsigned int nvme_io_timeout;
 #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
 
 extern unsigned int admin_timeout;
-#define ADMIN_TIMEOUT	(admin_timeout * HZ)
+#define NVME_ADMIN_TIMEOUT	(admin_timeout * HZ)
 
 #define NVME_DEFAULT_KATO	5
 #define NVME_KATO_GRACE		10
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 76465d335924..6123040ff872 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1606,7 +1606,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->admin_tagset.nr_hw_queues = 1;
 
 		dev->admin_tagset.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
+		dev->admin_tagset.timeout = NVME_ADMIN_TIMEOUT;
 		dev->admin_tagset.numa_node = dev->ctrl.numa_node;
 		dev->admin_tagset.cmd_size = sizeof(struct nvme_iod);
 		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
@@ -2237,7 +2237,7 @@ static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 	unsigned long timeout;
 
  retry:
-	timeout = ADMIN_TIMEOUT;
+	timeout = NVME_ADMIN_TIMEOUT;
 	while (nr_queues > 0) {
 		if (nvme_delete_queue(&dev->queues[nr_queues], opcode))
 			break;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 65e3d0ef36e1..df9f6f4549f1 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -797,7 +797,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 				NVME_RDMA_DATA_SGL_SIZE;
 		set->driver_data = ctrl;
 		set->nr_hw_queues = 1;
-		set->timeout = ADMIN_TIMEOUT;
+		set->timeout = NVME_ADMIN_TIMEOUT;
 		set->flags = BLK_MQ_F_NO_SCHED;
 	} else {
 		set = &ctrl->tag_set;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c0c33320fe65..1ba659927442 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1568,7 +1568,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->cmd_size = sizeof(struct nvme_tcp_request);
 		set->driver_data = ctrl;
 		set->nr_hw_queues = 1;
-		set->timeout = ADMIN_TIMEOUT;
+		set->timeout = NVME_ADMIN_TIMEOUT;
 	} else {
 		set = &ctrl->tag_set;
 		memset(set, 0, sizeof(*set));
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index f6d81239be21..76d8c0a9a87d 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -345,7 +345,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 		NVME_INLINE_SG_CNT * sizeof(struct scatterlist);
 	ctrl->admin_tag_set.driver_data = ctrl;
 	ctrl->admin_tag_set.nr_hw_queues = 1;
-	ctrl->admin_tag_set.timeout = ADMIN_TIMEOUT;
+	ctrl->admin_tag_set.timeout = NVME_ADMIN_TIMEOUT;
 	ctrl->admin_tag_set.flags = BLK_MQ_F_NO_SCHED;
 
 	ctrl->queues[0].ctrl = ctrl;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
