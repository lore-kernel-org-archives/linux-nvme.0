Return-Path: <SRS0=H+rW=EL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649A7C4741F
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 03:42:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000292072E
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 03:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zkp9i4i6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nkuC3VBR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qPOIP92w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000292072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kfmmt8EhHBNOoE/Jf4pgEnHq6+GYNsTvOkzG+Uzy3ic=; b=zkp9i4i62nYL1vNH1Y2vzBW0b
	vQJlXXpbCxPcT6hKOWS5fFYMGBEBkBrcp10dNjd0ab+4/AlAt0vRiOzE7wZ7wXpfOtn8dUHn4ypGh
	jXZ42iNGGN2+l3k6E97vVPX6turixwDJD66eab+8A/qkGEUcbN5IzZsAHBmT7n/00wHHNVfBJpZu7
	xgHhD7MD9SVtuViFs9CfqD3pZ2M9B3jnH+KznSlWZZJWX/TAodi4H2Q+bk71T1nvlDvrZFiZNF4n6
	9JqEzaijuH4tzKVfEQoM6P7rhViXzUGnc0kYGFPt4TC67eXC3he7ivnvPqXP0Hn9+6u9n0RqXWu2E
	bqlJvo4Hg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaWAa-0003lg-9A; Thu, 05 Nov 2020 03:42:40 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaW9S-0002bw-5y
 for linux-nvme@merlin.infradead.org; Thu, 05 Nov 2020 03:41:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=wXzgz4WpazKpSHBv73Ezq6owwulMEhP8y/fFyCzGZCs=; b=nkuC3VBRmzMUJrmd0pNLlaEFre
 nupvsM/Uh9FcMlKX1/ZLADooID+XobaP2H+lTzKnJN4WKSK73d0couX6hbj+rsawAfKa63a7HXOjq
 nAP3kf0IuoStuoN2oxN2AsrleTHQdDNzcpLamcEuX7WWaAhlmuJdz17VCWPBAIo79WhGMr645OboF
 GYdSzko3ZLmzJ+AyRzWe/aEJI5ipWRUp4hdTKMexz7Npbfly8tHZ4UdbDt+44uMEsq798f6o2sjeo
 L5khJEH3Fc4WymhvyoMpDb7lTJn+ylPWFR2KA2yxTGq/uyIPs0quMviszGfl/cA7Fku4PYzH9UvSz
 cJam8PRA==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaPYg-0005h9-5J
 for linux-nvme@lists.infradead.org; Wed, 04 Nov 2020 20:39:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604522346; x=1636058346;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+2/dwMeaO6inuNhLAoo4B3fZBQs1/CTwUDchauXiqk0=;
 b=qPOIP92w1bC340tLA90vX1/5p1x8qPZJ+45H3cvCIrzhuErE1kh+qGzk
 9JjYYdt07LrPdxiJv+6GNiy1/qVwG6SYUvXHRoC10GX9pHdmn6+YOkULr
 i+25f05DqKtrzHF8htM+7CKMbZfCRo1PAvwRkAgnncqbhCjKLSoRpgMq0
 FXtkKcl6mvWO+PVIccCyRUWZOBvJKrg3lxVT3HmrQrp8gAd9bdY8ADWDz
 /0HLZKHGEKYvI0P+tqNGRoz+aarPBtn3HN3qX1cqBMjTm2Fz9dulgNfpL
 p+j+nlR1r7pe56lCJUlzPXEwhb3o5LSI7XXKByAEZw+EtbCZFOpoR74uT Q==;
IronPort-SDR: YLbq//wT5iI5UOA3JQ3lPChrgd1RCYK9q8fTTdrywrNY6AVtH+fYG0dy2ACLZ+GSgtV4Ka48ZH
 U7m0PLhR4pLCUOYKTVuQL+l+al5V67baxbaUk7mr1FzwhgQ7XJYcg08rVFeqpHYVmOPRKzYBVM
 GPbgPjJ2SE8r+RucYEY+dZK4vZHdvBurUlLZYgWSuSM+wuLKPbWRi4Lfq0jjKw9DRQJF8rbbbD
 SvA7D/sdzuDNUoqu56X2zn+CjKma11F5uDMd6ffSebNwOuQKiYk4WJfYuCU+BOv2jJClCIg9F3
 KV8=
X-IronPort-AV: E=Sophos;i="5.77,451,1596470400"; d="scan'208";a="153042302"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 04:38:15 +0800
IronPort-SDR: a4XjhLSwHIlg8x3j9E1tdzumMQtJEcw4GHrjhV4q5SGPitGuyChhwgSd07c3BPEglk/6P2+Hi0
 nCK887hC9HYH0SyV/Zkt9Vk8qiZT9WRlNb8YQLLEi8TgJifMLoBoDOlzwJxGCL/qbcVWJzRydK
 JloVgu9z3wVttkBSbWTYXRNScXlaOaV9aQQhpJ1qxFF2OtjdEADBA4xZaxMy5y81Z8Cdjawboy
 dAt29ZdVijVhcSwISQFyHrMH7tbJe8wbtErAf03kEN//UwgNH7hTGCGA6iHB0c+1+dXVJoGhm0
 eBotQpuzCppLQ1haZNi71Wcj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2020 12:23:12 -0800
IronPort-SDR: tiasSIU4M8IRB84SYT5g/GcwNPj4vwHeyPc+rLKxbuyOU/dC7ms80UPfdAw+R8kGX3jkMgyaJn
 WQJPkqfiZQ1K9Y4MWTr6j2ASv5y6zuxposYLLEV8MM85tVIKS27kWzMkZLqRP6NpemvhEcbhRC
 gANL6VhDTH5XcTaFzBzXro6/kmI7ThkgZzw0tx+l7rNBpvB97PZ3OvPRgOMJg00ds9uffbbx5s
 39NGno0F0J/FyCj2mabZbcXNY5ByTO0lJi4pwI4KO3ChvMx/CktFA8JpjnvOSw8kr1WsPsMboJ
 e80=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2020 12:38:15 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V6 4/5] nvme: use consistent macro name for timeout
Date: Wed,  4 Nov 2020 12:37:35 -0800
Message-Id: <20201104203736.62745-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201104203736.62745-1-chaitanya.kulkarni@wdc.com>
References: <20201104203736.62745-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201104_203906_928836_FB987AD4 
X-CRM114-Status: GOOD (  15.84  )
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
 drivers/nvme/host/core.c   | 5 +++--
 drivers/nvme/host/fc.c     | 2 +-
 drivers/nvme/host/nvme.h   | 2 +-
 drivers/nvme/host/pci.c    | 8 ++++----
 drivers/nvme/host/rdma.c   | 2 +-
 drivers/nvme/host/tcp.c    | 2 +-
 drivers/nvme/target/loop.c | 2 +-
 7 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 045ac445aee7..29d9b5bb29b2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -523,7 +523,7 @@ static inline void nvme_req_set_default_timeout(struct request *req)
 	if (req->q->queuedata)
 		req->timeout = NVME_IO_TIMEOUT;
 	else /* no queuedata implies admin queue */
-		req->timeout = ADMIN_TIMEOUT;
+		req->timeout = NVME_ADMIN_TIMEOUT;
 }
 
 struct request *nvme_alloc_request(struct request_queue *q,
@@ -2274,7 +2274,8 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 	cmd.common.cdw11 = cpu_to_le32(len);
 
 	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
-				      ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0, false);
+				      NVME_ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0,
+				      false);
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
index f2b1a18d8bd7..78f0ac0fb39b 100644
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
index 923ca1d47031..6089660b2a24 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1304,7 +1304,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		 req->tag, nvmeq->qid);
 
 	abort_req = nvme_alloc_request(dev->ctrl.admin_q, &cmd,
-			BLK_MQ_REQ_NOWAIT, NVME_QID_ANY, ADMIN_TIMEOUT);
+			BLK_MQ_REQ_NOWAIT, NVME_QID_ANY, NVME_ADMIN_TIMEOUT);
 	if (IS_ERR(abort_req)) {
 		atomic_inc(&dev->ctrl.abort_limit);
 		return BLK_EH_RESET_TIMER;
@@ -1606,7 +1606,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->admin_tagset.nr_hw_queues = 1;
 
 		dev->admin_tagset.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
+		dev->admin_tagset.timeout = NVME_ADMIN_TIMEOUT;
 		dev->admin_tagset.numa_node = dev->ctrl.numa_node;
 		dev->admin_tagset.cmd_size = sizeof(struct nvme_iod);
 		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
@@ -2219,7 +2219,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	cmd.delete_queue.qid = cpu_to_le16(nvmeq->qid);
 
 	req = nvme_alloc_request(q, &cmd, BLK_MQ_REQ_NOWAIT, NVME_QID_ANY,
-				 ADMIN_TIMEOUT);
+				 NVME_ADMIN_TIMEOUT);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
@@ -2238,7 +2238,7 @@ static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 	unsigned long timeout;
 
  retry:
-	timeout = ADMIN_TIMEOUT;
+	timeout = NVME_ADMIN_TIMEOUT;
 	while (nr_queues > 0) {
 		if (nvme_delete_queue(&dev->queues[nr_queues], opcode))
 			break;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 75d071d34319..d3a4e8629485 100644
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
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
