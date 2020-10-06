Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0077C4363D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:32:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A052087E
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PwBBDZMO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CYEb/Oto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A052087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lgGz5CLBilsQCrRiTCZDjzR1c6/EYVzh4v9CgnAH5qw=; b=PwBBDZMOPY6IVKykZ/st1fKyA
	KTwUhi/fa9tqNjIT3VLqKabq25ozZUqYtTOEAVXPFZyMfCnwyFdhLEWjlN5DlL/IGbFoGSM300Ngs
	Gtn9YRj8p2jSld9OrNZZZFTU6AdxV40kyU30b3d5usgod/5qV8pt8tvvIU2kc15bdm1HY1qe0xEmQ
	PE47rdnpkuqECVDrtxlf+r8bKgB0WEFPFbMPUoUBE1Xac98f6kDWLRt7DTplCpJVW1ofVStnMeSJe
	KEGYnxL8Ne8wQZR3X6g6HAU2RPwDbj9VCHlKrlIwh2O/Tn0kP9I1oE9kGKrQ/gRxP6UjS6a6KMLyR
	gEv+BKI1g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPwR4-0006Qg-Ba; Tue, 06 Oct 2020 23:31:58 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPwR1-0006PW-ER
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 23:31:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602027116; x=1633563116;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BtPmUsyRH7qHjK+i96f2GVD8p0c3lcyHKpw8a9V8Q30=;
 b=CYEb/OtoW+OtG15wroJ+IbhO2E4yUMQqvFDdVWtx6himA4ZPmc1dUMVb
 T18rQ8afedgkU6HKz2RjwRoSt7GrkIGxDy9uWtX2n2rUECCyFi2ldLYAb
 /ybQBf7h0Lv6O36Fh1DA6IMWIzxMdEpCn1gPMKcP85hJpcXdGGBlUfwsY
 pQdMyfTpY2e2ISk/hdJH8MojDAUIqrpOiwNV6gulhKEPj597naWEa7kyq
 +nFvLexPrmeHJO/TVVdLAZ1NotSJKX3u3WeTNjxNFVNMchb6DOYTf+B0r
 JY0RA93iJ74SXeKGjb1D7qTVlRoDd1M/OVEy4wVq2uq+ZnPa6ZKTZ5VYD g==;
IronPort-SDR: 0qQx2OEEOLDLotoqB5mtYLnYC5aWDRj5hWjXgYwUeFn7Wtl92O6SYcQqiOEhvqgtCp21QRY6+X
 O+Z4rh6fzCpT2tAGxx+YfARcU9VkuWPWEJzwfg1gGFSgImYvmMPInoa5d+Rp/tmYi+4vGktuVk
 UGHO+D0sha6oXNu3vbL+5vxQTzyO17ddKTV1XUOE+bSP9xePAcDAUTDfXeUVvwyOGujdysnAdl
 MnBBPpa10o06oZzo5qFZu0ZJZhxeRTr3AxlmUI/fALXO5LTiJOto5zGfPNH9vJpjz4nVj7szGn
 j4c=
X-IronPort-AV: E=Sophos;i="5.77,344,1596470400"; d="scan'208";a="150425532"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 07:31:54 +0800
IronPort-SDR: qO5BiFKpGkzOGoYFx2Ivpu3b1R9x2mdEG32FBFExYjB0ZgsAyPfk/W01eW0Q0c45IX45GsP8Bc
 FR+3gX2IhWww==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2020 16:18:38 -0700
IronPort-SDR: ZOaK5RizfU1ASE5R3BKW5NpJ4U/ypZRceSautuNtB/cpmhZ0JTr4BD8yn4siNDJpuGcf/PIEkp
 TMRwhzHpW5mw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 Oct 2020 16:31:54 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V4 7/7] nvme: use consistent macro name for timeout
Date: Tue,  6 Oct 2020 16:30:49 -0700
Message-Id: <20201006233049.55458-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201006233049.55458-1-chaitanya.kulkarni@wdc.com>
References: <20201006233049.55458-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_193155_631113_1E55F9D6 
X-CRM114-Status: GOOD (  16.91  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
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
index f97003e54db8..e0629861aa31 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2263,7 +2263,8 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 	cmd.common.cdw11 = cpu_to_le32(len);
 
 	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
-				      ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0, false);
+				      NVME_ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0,
+				      false);
 }
 EXPORT_SYMBOL_GPL(nvme_sec_submit);
 #endif /* CONFIG_BLK_SED_OPAL */
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e2e09e25c056..8198b062e1eb 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3480,7 +3480,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 			    ctrl->lport->ops->fcprqst_priv_sz);
 	ctrl->admin_tag_set.driver_data = ctrl;
 	ctrl->admin_tag_set.nr_hw_queues = 1;
-	ctrl->admin_tag_set.timeout = ADMIN_TIMEOUT;
+	ctrl->admin_tag_set.timeout = NVME_ADMIN_TIMEOUT;
 	ctrl->admin_tag_set.flags = BLK_MQ_F_NO_SCHED;
 
 	ret = blk_mq_alloc_tag_set(&ctrl->admin_tag_set);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 3106d6133c8c..28efca2d7171 100644
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
index e5b02242f3ca..5bb93b687641 100644
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
index 9e378d0a0c01..de36ec783527 100644
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
index 8f4f29f18b8c..9aae5af37df6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1570,7 +1570,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
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
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 2039ad7cbbab..728d79e5dabc 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -544,7 +544,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
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
