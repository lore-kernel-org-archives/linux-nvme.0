Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56743C43461
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 00:17:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A1B72075D
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 00:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0cWnm+TV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T8bRI8dB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1B72075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RAzXd1rt1o7txS3URNlddLEVBah9SyK6YrMJCoe2Uvs=; b=0cWnm+TVjSM6rQyymdqiJ5BuP
	V/gF+PeRvbHamIL3JGrRYGjQDKomQAR3tp9o/q1KXTBpkb1k9Or+5obx1hCbwaYwu45u6/FIlXfvO
	0hgSGqXNuJqPlTRdPDIgnP8rqjP2MPTSaECHvWtTfeh3gXG6gjVO595nzx/9lj/YroMeZQPylqbqy
	d38l6vyPlzYb96nvO2GjyT+HtM6Ufu1fze7m0tFrq+4m4ZmNK2ncU7m3a/bVoGoHpOmeDEA0AimSv
	Exl4hfRamn7PO2x6PiFIH1+aw6FKEfmtLS+XuimobNK0GIOAxmeoOE8NmkACy10/Zxo7YkuIWix9k
	jDb6kxgig==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDzPr-00042O-6l; Fri, 04 Sep 2020 00:17:19 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDzPo-0003v6-FV
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 00:17:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599178637; x=1630714637;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QGLKpkS/qw16abTBUbeiJPeEZTVQ/L0xbWw2TqbouHE=;
 b=T8bRI8dBVN5tmGaW0eSdK+yEsU8/13oFN/1ey6u4vjYCDTM5c5p+/L8O
 Kwhzb9wD2bEMMs3WMUzPrhHmuwsPZ+2T5iCi7OLtSvy5UKEH5YMN+wTCM
 ic95S8DhKIWlqxO9h4BMDqWIKAXyedzIe50fAbBF2U1x6KRXzlzAor0QK
 wB7sIIvy2XtoAk9ICjO0uiD8GEYPjWH/dDvu5SyBWys8OdQVbrMHDR783
 +geBZkAYAyl6w+rXTTnVDyNWDIoa8JY2C475tmkV7jnGjPTTodOh2iuI3
 hBW7Dp0nEFm7r6hPsV0X8Y8Ohj4jDz4BgBX2t0OfYbiIveW7tVPyLl4FT w==;
IronPort-SDR: 7moio0HUAKnk5GZhz8FJApRPMabJxPGvft4Fuw6aEitqBlxgdPPSjtIy2cSr/X6tYhmn4Mv310
 OsjXjW5lYLzf2uygfufmIs6BcwYxzLSoc0J4UOI2zDIOFQYpkTQS6MuAfiAtcBWOxSZm0YUC6k
 UTmkPiFdGHi2usOugcxgh5z9ZIfWaG+jnN9o+hZ9f1TXdXHR4NgHONPVIXeOJh1SzdxH+2ckdO
 3Ywr2//nLCtP77uHAYCODolIN8//mpMEmBV5/WgYaYsz9KpJzoMpJLZIE8hmu4d070n2JcBUjM
 v0g=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; d="scan'208";a="146532596"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 08:17:17 +0800
IronPort-SDR: LesPwrcW+VbzDiWXMi27mjCXcMGZYGp3XAztIWeBIW/WvYhzW1Yv05RKdhlxI4pk+9TehzYPSD
 jQLhSaav5Fsw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 17:03:49 -0700
IronPort-SDR: VhLu7gVWni3Vb2Nz0OxdoSQKfLCyMKnbiT7Q3AMy02ZKPfb0sy15WuCLGUpH1CiLk3hz0sJD9V
 hjN4mEMDmQnA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Sep 2020 17:17:16 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 6/6] nvme: use consistent macro name for timeout
Date: Thu,  3 Sep 2020 17:16:26 -0700
Message-Id: <20200904001626.5694-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200904001626.5694-1-chaitanya.kulkarni@wdc.com>
References: <20200904001626.5694-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_201716_975610_6B170668 
X-CRM114-Status: GOOD (  15.48  )
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
Cc: keith.busch@intel.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is purely a clenaup patch, add prefix NVME to the ADMIN_TIMEOUT to
make consistent with NVME_IO_TIMEOUT.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c       | 6 +++---
 drivers/nvme/host/fc.c         | 2 +-
 drivers/nvme/host/lightnvm.c   | 2 +-
 drivers/nvme/host/nvme.h       | 2 +-
 drivers/nvme/host/pci.c        | 8 ++++----
 drivers/nvme/host/rdma.c       | 2 +-
 drivers/nvme/host/tcp.c        | 2 +-
 drivers/nvme/target/loop.c     | 2 +-
 drivers/nvme/target/passthru.c | 2 +-
 9 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a2ef4249ce6a..4e83add712ad 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -889,7 +889,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	 * changes it should reflect here.
 	 */
 	if (!req->timeout)
-		req->timeout = q->queuedata ? NVME_IO_TIMEOUT : ADMIN_TIMEOUT;
+		req->timeout = q->queuedata ? NVME_IO_TIMEOUT : NVME_ADMIN_TIMEOUT;
 
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
@@ -1092,7 +1092,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	 * changes it should reflect here.
 	 */
 	if (!req->timeout)
-		req->timeout = q->queuedata ? NVME_IO_TIMEOUT : ADMIN_TIMEOUT;
+		req->timeout = q->queuedata ? NVME_IO_TIMEOUT : NVME_ADMIN_TIMEOUT;
 
 	nvme_req(req)->flags |= NVME_REQ_USERCMD;
 
@@ -2338,7 +2338,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 	cmd.common.cdw11 = cpu_to_le32(len);
 
 	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
-				      ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0, false);
+				      NVME_ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0, false);
 }
 EXPORT_SYMBOL_GPL(nvme_sec_submit);
 #endif /* CONFIG_BLK_SED_OPAL */
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a7f474ddfff7..bb069e945683 100644
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
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 8e562d0f2c30..555e45e43d1c 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -774,7 +774,7 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 		goto err_cmd;
 	}
 
-	rq->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	rq->timeout = timeout ? timeout : NVME_ADMIN_TIMEOUT;
 
 	if (ppa_buf && ppa_len) {
 		ppa_list = dma_pool_alloc(dev->dma_pool, GFP_KERNEL, &ppa_dma);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2910f6caab7d..3f12892667c5 100644
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
index 5e07d5628864..e3386423d823 100644
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
@@ -2210,7 +2210,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = ADMIN_TIMEOUT;
+	req->timeout = NVME_ADMIN_TIMEOUT;
 	req->end_io_data = nvmeq;
 
 	init_completion(&nvmeq->delete_done);
@@ -2226,7 +2226,7 @@ static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 	unsigned long timeout;
 
  retry:
-	timeout = ADMIN_TIMEOUT;
+	timeout = NVME_ADMIN_TIMEOUT;
 	while (nr_queues > 0) {
 		if (nvme_delete_queue(&dev->queues[nr_queues], opcode))
 			break;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 1d8ea5305d60..e85d95c98ad9 100644
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
index 873d6afcbc9e..9583fe5eb2f1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1571,7 +1571,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->cmd_size = sizeof(struct nvme_tcp_request);
 		set->driver_data = ctrl;
 		set->nr_hw_queues = 1;
-		set->timeout = ADMIN_TIMEOUT;
+		set->timeout = NVME_ADMIN_TIMEOUT;
 	} else {
 		set = &ctrl->tag_set;
 		memset(set, 0, sizeof(*set));
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 0d6008cf66a2..b8c611eafd68 100644
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
index 2564b6769b9e..55e645163162 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -522,7 +522,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
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
