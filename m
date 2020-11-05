Return-Path: <SRS0=H+rW=EL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60697C4742C
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 23:29:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D707820719
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 23:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P4p2Byqf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="au3259QY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D707820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=t5AW/wj1SJkwgQ+QjqgmodvJQ7XhdNzkuuVdJY7XDFA=; b=P4p2Byqf3kFHbBl3wCdflx4Dy
	/slWp6HDR7iLaOF0h8xp8od21hKHD33orMxnp028ry/y9XIkpRu8HfmhpbKjAsmGV6i62NEv2ZTU/
	CT9fN+XjiAsnXIme4I4h/bzLr9OwMnZ5LkgPjDjuQMw9dgePk92Bdp7nUgRorLA18IpmwZTB2xem7
	z3Rd9wTcCjY1mWZ/HEmm8DvYjK8UsUrjRePZG53wYCvhrsggo+Z2i7/PKiIJPIK7W3QcDfQGkdRF2
	RrHCh8XZ6GjKwUQh9tmbcf70sJltgHltk8DCLOgrDBea3Vt0yg35ZRstWd1SNFVRojSjNTDfQe32P
	y4xVXT2hg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaogm-0000B4-PH; Thu, 05 Nov 2020 23:29:08 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaogk-000082-Oq
 for linux-nvme@lists.infradead.org; Thu, 05 Nov 2020 23:29:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604618946; x=1636154946;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ie7eJ1tMOz7KZsu8zeDmGBmKWztyKSJ+Ft7TpcQ8cvk=;
 b=au3259QYwTvH2KxJI9G8duuJkmhzjdL5C24cAGeiurJ+usNhHK78a0at
 gmDGpWirzQAAv2+JtZBR5R449O2ukSmZqvQJ2pd5CHWIsYKd0VP6g5f8n
 6zy2PRuvKrc3Y3pk0G5GmN98wV7giXCmajG9EzOcfufwB0B2F5lZckgwZ
 ujVqB/FFs8TWitbflQOxLZ0NIKZPj7mgQcfZcIjTEOJ15HKMywjMXF7as
 SMic8ej4gpCUivK3PXJssp5/Pl/r3dtqLZ2X0NSGeH3Z8rpG+LXDHCsqg
 gjzePXRwTMclHUplcJgbYfTcecgBZ6IlxkKrOLF7h7ipZjjATwA/pBn4F w==;
IronPort-SDR: PLqULqGvtnHcKkZD1633aDKhxlgygGvTFQfhlFv3C7ADIGBUS9WsLD88BL5XBiG5F8elPW+p1/
 jkNFstOj8vD8D+IhAZOAVLj8kggTzQXSeVZZCsKFv7QnOeOXdmWZaOtfVwJ848gBc7mRKAOSOC
 WILRhGYmNfpPEDx0YxqbarIcfYM+wi55LfUS4k5EohigoBe/xlWzrJnbCd85fC+rgo2JrFhG8n
 u57rZJ6w1TMse9S0YARgJRvzuFiRcjEP9QVvqjqc9nhi5Gr+q5w1plPQdo+zeUNZN16KcHaOWx
 TU0=
X-IronPort-AV: E=Sophos;i="5.77,454,1596470400"; d="scan'208";a="261967947"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2020 07:29:06 +0800
IronPort-SDR: JcOrTJ4/hQ5HnIvK3eyxsPd24+1k0Me3WMsMXLJBJwd95nKu0UJf+I4ZIy8Vs4jr1FIDdPAQPM
 w5M0/mi/UQeDrnvtKYz5c6gA3IQZOBLikMTMbb16qibjgAigowFsZFAdYOUL8MRmDPKJ1kgUtr
 Vygy0O1XIdATyQlti7RnsMwRndNg+L+Tu37Qf6iTyq86Pqp5/dedOfSdnuH7frAW7nr7lhb8fc
 VLwxBDO3/1eiMrDTCW8Edng5xAu398O7XUL/I5JcdzB+kmKkPGFnJc3VY5XzNYVHyv23f6tbV7
 /dp5DbUKzrLI7mcyqXC8xebY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2020 15:15:12 -0800
IronPort-SDR: MHNK2cC04iaMpTj5e2UkXgfSIz/F/4QUqXhC6Y0vMz+nwHiZsenizEVQwCap4tfLI0YgUCbU1K
 0TwY0LoqZ8I//NMDQxYhw8/jB2WuxOgCoEETi3c79LHoR0Ec1M+aJUn30N3s2+h4T7eRwX2ErS
 Qb1Yd1zC7lFT9eWcGe1hwaKkwKp1t+WtfZujQsfu9/60wLf9LVwX795FYllbXISrJwiQ3ZnXpy
 Lnp/PkcL1DKihpb47eGGwzQBk4IXu8j7vBItAwLNbObbxfhmHAsMgFbxUGcRGCYrh76nZUZ3vC
 QS4=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 05 Nov 2020 15:29:06 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V7 4/4] nvme: use consistent macro name for timeout
Date: Thu,  5 Nov 2020 15:28:32 -0800
Message-Id: <20201105232832.21216-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201105232832.21216-1-chaitanya.kulkarni@wdc.com>
References: <20201105232832.21216-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201105_182907_045590_3D32C268 
X-CRM114-Status: GOOD (  15.04  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c   | 5 +++--
 drivers/nvme/host/fc.c     | 2 +-
 drivers/nvme/host/nvme.h   | 2 +-
 drivers/nvme/host/pci.c    | 4 ++--
 drivers/nvme/host/rdma.c   | 2 +-
 drivers/nvme/host/tcp.c    | 2 +-
 drivers/nvme/target/loop.c | 2 +-
 7 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e6195f50a265..68e07242a4c3 100644
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
@@ -2269,7 +2269,8 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
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
