Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE7BC433E2
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 21:52:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD01921D7F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 21:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EoygWwCv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OwPAdwtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD01921D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WTBXXOFbZRYsvHLyip/xDyqYQ7HO78m0bKMnDLnI5YI=; b=EoygWwCvdyS4VdLH4xJNUEB+H
	E0eDlSrqTffRxixV+Wa/kOQZd7bjxVfIDj27smEKn7Wr7dpjPzoss1LYcQ33VIuPvJRh9c4rCrpCH
	0GTBlwAt/ZBSSrsEZ2/PmpsptjpI6vg+X6X2hEBhpd+gjQ1xdoRQ7tUO62VwyHCuZmXXt5PfRVwRl
	hwHtPVZtg6qW5tCHTFd39AnvFwZ8JS+Fphx9CBmbbGPUfOrJSYnkyZa7uxAQE7Tfhqkq7dtnzXVkB
	XS+ams67WoyakCi4YVSy1YqIpflxIOak9P9TY3SEwwizamtIxgERl0kYgd+Z2bEQHFuD5Ru0F4/ah
	4GkyGASYA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIIs7-0001jC-Dn; Tue, 15 Sep 2020 21:52:19 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIIs4-0001hm-C3
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 21:52:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600206737; x=1631742737;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3Hq56xdqk0sXWCk5yJfpkD/N18s6OGIONwqk1zH9DbU=;
 b=OwPAdwtADmTG3OfUwnr2+EFE4bzjSa5uvZZtTiX296Ao1fo05I/XD9S6
 CxzET1bgTPXOInNConxoEAU8lVlG1vEKwuMydOEkNWzde6uSy9P+4zjzg
 hOywADqLHdaBemnoQMP66fUqyQN1jUbwRdOavbC4Eob9j8pqU4A0wt5qa
 ZL00G0Bmi02YnXj1KwfBjea072bRfNCTKMfpcVVVZDWItqfYsE+qe4FON
 XQP0BfYWGEiOkAhNL4mqvteBlvXAqn/ssPXKrzoevLscjqWkd27OsL4YA
 7KN//rz3EjHQoHn/GKkqEIqEQvjebVW4VMrlb+Ir3/ctcdqHsIsJFUCPW w==;
IronPort-SDR: ZB3X9Yxl3vm4ENjq9eyvQKQfIveUCHhJdRdiYn46haIBHsJnA26PyRvthQgsG8RSGMlg2pzznQ
 WFOUXqlaYLdwU71SRmtrOtR7BfjwMaf7BWlON6QJnlv4CjbYJyZXc/scx89tR/n1YUgvUD3dYQ
 eE6nu+WF3ShsZGby4UwsfUK0gNVGD8HWYDinwkJeL3cToNNi5K3MtYGCQblj3GtbJxWv/tYfC2
 W5eYn4YM/BfCl+RlpYTqXBo+A/zhnnQcAbTbigE8M9JAbLvxOLCvsOYXCbqlaUJy5HVF017xuo
 qXI=
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; d="scan'208";a="148694960"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 05:52:16 +0800
IronPort-SDR: dzY9BJG5vNakb8diMAJIYWEjGtmMJ7SloT8PfAVw55QSm+JAy1iAnc9hdkfZZuhowXXpmno7GR
 tbNYwVDhtFmA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 14:38:31 -0700
IronPort-SDR: mh+t6Anup27hFE8AzucWVakqexf4+6WJ4QIAhY9qN33t3yVORq/exXVDXysb8H3l86pfurlVet
 eKlm+KBYya6g==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Sep 2020 14:52:15 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 7/7] nvme: use consistent macro name for timeout
Date: Tue, 15 Sep 2020 14:51:18 -0700
Message-Id: <20200915215118.3934-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
References: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_175216_552136_7237C387 
X-CRM114-Status: GOOD (  16.93  )
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
 drivers/nvme/host/core.c       | 2 +-
 drivers/nvme/host/fc.c         | 2 +-
 drivers/nvme/host/nvme.h       | 4 ++--
 drivers/nvme/host/pci.c        | 8 ++++----
 drivers/nvme/host/rdma.c       | 2 +-
 drivers/nvme/host/tcp.c        | 2 +-
 drivers/nvme/target/loop.c     | 2 +-
 drivers/nvme/target/passthru.c | 2 +-
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 41177a181c8b..b86f13c137a2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2327,7 +2327,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 	cmd.common.cdw11 = cpu_to_le32(len);
 
 	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
-				      ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0, false);
+				      NVME_ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0, false);
 }
 EXPORT_SYMBOL_GPL(nvme_sec_submit);
 #endif /* CONFIG_BLK_SED_OPAL */
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e8ef42b9d50c..7ad3fbebab95 100644
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
index 78dc422ee42c..e198fb37bcb6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -24,7 +24,7 @@ extern unsigned int nvme_io_timeout;
 #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
 
 extern unsigned int admin_timeout;
-#define ADMIN_TIMEOUT	(admin_timeout * HZ)
+#define NVME_ADMIN_TIMEOUT	(admin_timeout * HZ)
 
 #define NVME_DEFAULT_KATO	5
 #define NVME_KATO_GRACE		10
@@ -648,7 +648,7 @@ static inline void nvme_default_timeout(struct request *req,
 	 * changes it should reflect here.
 	 */
 	if (!timeout)
-		timeout = queuedata ? NVME_IO_TIMEOUT : ADMIN_TIMEOUT;
+		timeout = queuedata ? NVME_IO_TIMEOUT : NVME_ADMIN_TIMEOUT;
 
 	req->timeout = timeout;
 }
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
index 3247d4ee46b1..4899aa75937a 100644
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
index 245a73d0a1ca..f86f2ec5734e 100644
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
