Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C577C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 18:45:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CF5D64ECF
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 18:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF5D64ECF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=e04jzhD1Wtqa7haVQ8VFIzRsURC4daWnXRaH8eMptnE=; b=HT3fLUfGPOut+QrlJHVJALnY4
	KAaXS6GBt/dWA/aczM+juluvbCXgDRDwtnjXOehKXS/wxgHPJYxxK/0x4eFxWRKdL5ztKnIhH9fBx
	Hha4M7uXh22cEDycSszCBnrKw4jdvoNmQJCgv5cgtFdJCvstiA2wk7M4pzVm35O2FGWY7K2M6kZmU
	QAIQmt0NqITkHZn/k1tsDLTOeMVPLQgdNN8UQwROhIDcz8q4XZdrED/t1Do3lzyQBJEE1/QjjVnlM
	h2o6vxhX2Id/GqQ93YdgNqhXqHSjdLEIBlxSiZGdrb494n+Z9BkJiXNYvwGhpyXAVftkhR3C+tHMD
	HUJ0RxeGw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHWUj-0064lL-Sb; Wed, 03 Mar 2021 18:45:14 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHT1O-005HLE-Ke
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 15:02:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=DaLnzHjE1NHn6E7YzCubnnV9ziQru2K+0ZXWsg1QHn0=; b=vIEQk8WvdBg6nV6UGehFFfmLbA
 Q4NdEaN8JuyBWWTp3GXDQZQoQswtXnV2Y3LclegGjNNNuTZR3XHsAaCM6RZikFSRdbSR3Lrt8t/pS
 mZxzDcwfFhNxd3EVQl4yZuPTyD1pFcxx19ygEPNCDZPyXGq0gQo69Vohkrt3OoP2HpYAevTx4wgpI
 3rQgFMNgwVyucnm2Le1JqROgPm6CP3P5NPahf1Ht40hvJFDQmi6+aWoslWg6FhucTSaoQu/n88hMm
 sqL0LWUvwSa8BmdGtdAuftpAPqIru0EKxqqyyOqRurYECJkd1Y3sN3E3ZqANwxMkk06UlqjUE3GCY
 VCyhv+KA==;
Received: from [2001:4bb8:180:9884:624:26dd:6387:40e9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lHR0N-002cNy-Kt; Wed, 03 Mar 2021 12:53:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] nvme: merge nvme_keep_alive into nvme_keep_alive_work
Date: Wed,  3 Mar 2021 13:53:03 +0100
Message-Id: <20210303125304.1200789-3-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210303125304.1200789-1-hch@lst.de>
References: <20210303125304.1200789-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Merge nvme_keep_alive into its only caller to prepare for additional
changes to this code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e68a8c4ac5a6ea..bdeb3feae61899 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1225,28 +1225,12 @@ static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 		queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
 }
 
-static int nvme_keep_alive(struct nvme_ctrl *ctrl)
-{
-	struct request *rq;
-
-	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd,
-			BLK_MQ_REQ_RESERVED);
-	if (IS_ERR(rq))
-		return PTR_ERR(rq);
-
-	rq->timeout = ctrl->kato * HZ;
-	rq->end_io_data = ctrl;
-
-	blk_execute_rq_nowait(NULL, rq, 0, nvme_keep_alive_end_io);
-
-	return 0;
-}
-
 static void nvme_keep_alive_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
 			struct nvme_ctrl, ka_work);
 	bool comp_seen = ctrl->comp_seen;
+	struct request *rq;
 
 	if ((ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) && comp_seen) {
 		dev_dbg(ctrl->device,
@@ -1256,12 +1240,18 @@ static void nvme_keep_alive_work(struct work_struct *work)
 		return;
 	}
 
-	if (nvme_keep_alive(ctrl)) {
+	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd,
+				BLK_MQ_REQ_RESERVED);
+	if (IS_ERR(rq)) {
 		/* allocation failure, reset the controller */
 		dev_err(ctrl->device, "keep-alive failed\n");
 		nvme_reset_ctrl(ctrl);
 		return;
 	}
+
+	rq->timeout = ctrl->kato * HZ;
+	rq->end_io_data = ctrl;
+	blk_execute_rq_nowait(NULL, rq, 0, nvme_keep_alive_end_io);
 }
 
 static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
