Return-Path: <SRS0=pD35=EE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C62C2D0A3
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 23:48:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF4F620720
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 23:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="3MEOaK+Q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qE4MsZmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4F620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vEHtS9pCxBviCCP6oPD6WOcyH2zuIb+ekYjhfyGWpzQ=; b=3MEOaK+QpAqpppOPmTiY7TUZB
	U3/jr9xjsvC8iO4/TPVIns2olOqoGLDYac3otEM5p8MXJCMllWZKx/5mgB+5Z4xJA8urGaVNfbPOR
	R4qN7wBKZyz7E43GncuAA0vcM2yMoIrNZ2Vegysz95V3ceGKQYDHCcYY5tB/fWUugrfeRCXiZQaCk
	dLLu9zycFlzSkre1XMkaYVgGboXLl3ofA/yAdb0pfTaODPcXzW1gz5cnRqmZwhPcWhiipXgrkfJV1
	ZUlMskDsvJbifWBWXSpKCpcrtIHbTfylekk4I0zt8LW7NGH8tQjvaTFovFPxOF6zzLNP/wGcTGOmg
	bF6nWflZQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kYHeh-0000Lv-Ln; Thu, 29 Oct 2020 23:48:31 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kYHef-0000KV-6f
 for linux-nvme@lists.infradead.org; Thu, 29 Oct 2020 23:48:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604015309; x=1635551309;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IkEeFmaeSyTYMV6P5EPySuMkgdj4k9GYjSFq31DxmJc=;
 b=qE4MsZmCyyTzQJUznZTCBalNiCJF/z9kkhjRbOWiea9dJV9xiTG/7FJN
 rqZ2KJYwtmhg2M85ukaSC2qPgrxaXmkqtx9bfOCll7sQhZhi0kOYS3Xwc
 OYbXuvHng8gAfS1QoYwJjKldhdjsvt/y+T/vUA7ms7MtPzdFGOLl6lFiy
 WZa8cS80okLV+ORQ7HLlMI/q4UvWTjeo4N8trokPCj7HfUo7MfUI4M6Ih
 hSx49rPiSfBw8NyniJpYg3QJmJHJpdM/0QSLLuPvXT5GXND5QB/jricmc
 6z44dN2QiFePCUa2CcAfIDPcR61PCSIqDaIg81egJSdMMvOYEQtpl3Lvz A==;
IronPort-SDR: 7teTWXlVHOwpBEy5BiNvol65+FhmwuIJhngBeGcu1lWSMQRZE9ui0+8O0eux3l/236l1yhOFlK
 /o4VDupt61S0vGZY0/jyiON56VYqo4FVxpxoT56VJxnKMULernTVLaCVrK3A9iQFCVe6ynvcMK
 j80UIeCZIUnL19fsmDGNoqAVuc8u0keaFJCr9mUflQOXwjqqt1PRbdgnzPIXMxg3npPI1n4ITj
 LpjHFSpq8soRZNDNHQByEN7QqvrF8CAufmowPbiBs0hmlzgL/V2LDdZa2AoV7RwbY+Dh1TF0gm
 V5k=
X-IronPort-AV: E=Sophos;i="5.77,431,1596470400"; d="scan'208";a="151368503"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 07:48:27 +0800
IronPort-SDR: HPQ0DR9ij0H8Rt6/yrdWlwmOXd82v56Af8E6MVAe60DB5f2ZpaCCNC/LKgxk0YJ/A3Ti4rSVtz
 Gc2b26uUM3BaHS+Mj3jFl8Om9XraVYES131dtndAe3Xja+OegL9mgJfxVs8Nmz3yKC5sUzCQml
 PbMXkRfGvTM55v/MHvA/C6Zfi2d+Z5J5aSwGDTxUbh6FzE0sMIDysl3w5lqkNP2vSpgVh1ruSH
 VAqf8LTwBjYEw5ePlqIEP1cdeSj6FiRkBchsuA0xaHeAXAqnA5myAPP20onjofqKaqzmjmClAD
 BwGPEYkK6E8D+ck/Ft5gKotW
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 16:34:42 -0700
IronPort-SDR: ADQax7MDOhpe+bOMDjLJ2sFiukYNaWpBSd+JT7cCoPOqWP7R4mKOwTvlkJhN3CgcjDuST2spkE
 M5s46SJwwxqrcKsZTDlvQgqDiRnWM76fHMfo+QbmPqmqGP1Mjta0ebw+3OxN/BpTppF5AKJBUU
 jv9KKruRuMdGkhL+kTV467e/R65cCibAarOfQEhpuWfEaxYPC0TxZaO+jWO5aYZ7uSBmd1Z1sr
 99yVfWuSC84kMy+SMHZzezGp4rELU3ryryctBX134ppWiv/V9ITdXPe4QG+wtInCIXyMgiZ7P8
 URk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 16:48:27 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V5 7/7] nvme: use consistent macro name for timeout
Date: Thu, 29 Oct 2020 16:47:39 -0700
Message-Id: <20201029234739.21266-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201029234739.21266-1-chaitanya.kulkarni@wdc.com>
References: <20201029234739.21266-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201029_194829_510791_0E23F6A2 
X-CRM114-Status: GOOD (  15.88  )
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

This is purely a clenaup patch, add prefix NVME to the ADMIN_TIMEOUT
to make consistent with NVME_IO_TIMEOUT.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c       | 3 ++-
 drivers/nvme/host/fc.c         | 2 +-
 drivers/nvme/host/nvme.h       | 4 ++--
 drivers/nvme/host/pci.c        | 8 ++++----
 drivers/nvme/host/rdma.c       | 2 +-
 drivers/nvme/host/tcp.c        | 2 +-
 drivers/nvme/target/loop.c     | 2 +-
 drivers/nvme/target/passthru.c | 2 +-
 8 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5feb2331df6f..6d50f7cbcfa2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2267,7 +2267,8 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 	cmd.common.cdw11 = cpu_to_le32(len);
 
 	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
-				      ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0, false);
+				      NVME_ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0,
+				      false);
 }
 EXPORT_SYMBOL_GPL(nvme_sec_submit);
 #endif /* CONFIG_BLK_SED_OPAL */
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 3c002bdcace3..a0be43edfb3c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3530,7 +3530,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 			    ctrl->lport->ops->fcprqst_priv_sz);
 	ctrl->admin_tag_set.driver_data = ctrl;
 	ctrl->admin_tag_set.nr_hw_queues = 1;
-	ctrl->admin_tag_set.timeout = ADMIN_TIMEOUT;
+	ctrl->admin_tag_set.timeout = NVME_ADMIN_TIMEOUT;
 	ctrl->admin_tag_set.flags = BLK_MQ_F_NO_SCHED;
 
 	ret = blk_mq_alloc_tag_set(&ctrl->admin_tag_set);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9eb75731c6d7..37244d376855 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -24,7 +24,7 @@ extern unsigned int nvme_io_timeout;
 #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
 
 extern unsigned int admin_timeout;
-#define ADMIN_TIMEOUT	(admin_timeout * HZ)
+#define NVME_ADMIN_TIMEOUT	(admin_timeout * HZ)
 
 #define NVME_DEFAULT_KATO	5
 #define NVME_KATO_GRACE		10
@@ -643,7 +643,7 @@ static inline void nvme_req_set_default_timeout(struct request *req)
 	if (req->q->queuedata)
 		req->timeout = NVME_IO_TIMEOUT;
 	else /* no queuedata implies admin queue */
-		req->timeout = ADMIN_TIMEOUT;
+		req->timeout = NVME_ADMIN_TIMEOUT;
 }
 
 extern const struct attribute_group *nvme_ns_id_attr_groups[];
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index df8f3612107f..ce882d996e15 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1296,7 +1296,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		return BLK_EH_RESET_TIMER;
 	}
 
-	abort_req->timeout = ADMIN_TIMEOUT;
+	abort_req->timeout = NVME_ADMIN_TIMEOUT;
 	abort_req->end_io_data = NULL;
 	blk_execute_rq_nowait(abort_req->q, NULL, abort_req, 0, abort_endio);
 
@@ -1592,7 +1592,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->admin_tagset.nr_hw_queues = 1;
 
 		dev->admin_tagset.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
+		dev->admin_tagset.timeout = NVME_ADMIN_TIMEOUT;
 		dev->admin_tagset.numa_node = dev->ctrl.numa_node;
 		dev->admin_tagset.cmd_size = sizeof(struct nvme_iod);
 		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
@@ -2208,7 +2208,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = ADMIN_TIMEOUT;
+	req->timeout = NVME_ADMIN_TIMEOUT;
 	req->end_io_data = nvmeq;
 
 	init_completion(&nvmeq->delete_done);
@@ -2224,7 +2224,7 @@ static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 	unsigned long timeout;
 
  retry:
-	timeout = ADMIN_TIMEOUT;
+	timeout = NVME_ADMIN_TIMEOUT;
 	while (nr_queues > 0) {
 		if (nvme_delete_queue(&dev->queues[nr_queues], opcode))
 			break;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index aad829a2b50d..0bb55d667af6 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -798,7 +798,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 				NVME_RDMA_DATA_SGL_SIZE;
 		set->driver_data = ctrl;
 		set->nr_hw_queues = 1;
-		set->timeout = ADMIN_TIMEOUT;
+		set->timeout = NVME_ADMIN_TIMEOUT;
 		set->flags = BLK_MQ_F_NO_SCHED;
 	} else {
 		set = &ctrl->tag_set;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d6a3e1487354..6680e5342fd1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1569,7 +1569,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->cmd_size = sizeof(struct nvme_tcp_request);
 		set->driver_data = ctrl;
 		set->nr_hw_queues = 1;
-		set->timeout = ADMIN_TIMEOUT;
+		set->timeout = NVME_ADMIN_TIMEOUT;
 	} else {
 		set = &ctrl->tag_set;
 		memset(set, 0, sizeof(*set));
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 5ab46d3130e7..979dfeb39d9b 100644
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
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 177ea23561e4..09b03c422ed9 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -552,7 +552,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 	}
 
 	if (!subsys->admin_timeout)
-		subsys->admin_timeout = ADMIN_TIMEOUT;
+		subsys->admin_timeout = NVME_ADMIN_TIMEOUT;
 
 	if (!subsys->io_timeout)
 		subsys->io_timeout = NVME_IO_TIMEOUT;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
