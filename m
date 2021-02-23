Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04512C433E9
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 12:07:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C9864E21
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 12:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C9864E21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rr8/7lsFQDTT+qrazIui2v0eIDltPxhnlhhuIdL84Ns=; b=XKncui3smeUB1K//HgJpIpxxV
	0lA5iv/tEXZgKIt+PdMxLcup/5bFijef1W2ytpACF/0i7m8s5BXnmU2ypyOboQg3+qrzMuScOzAeX
	SKmty/MPRDl4kU9Jn92/HKNKa1luWLYdPXUM/UflC9f1oKayj/GViEHjyEiZlx1drSLce2nZdyv+z
	ZHoqdlGnDHRgDcun+t9qRNH3Gx/XWwS2E4mmMr89YrWV8HXmnBOW/zMh+tFjgGszXW/EVzIgEQCzL
	pjK24CLvOqgZrThHfKaxBMPaEWMoTi6plrR0Gg4XaBJOUDCc/PHMN2bgFBKIJtB4U3wrnil7vR7qY
	fBLSajslA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEWTX-000065-33; Tue, 23 Feb 2021 12:07:35 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEWTT-0008Vy-Dc
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 12:07:33 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 69BCCAC69;
 Tue, 23 Feb 2021 12:07:30 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] nvme: fixup kato deadlock
Date: Tue, 23 Feb 2021 13:07:27 +0100
Message-Id: <20210223120728.104699-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210223120728.104699-1-hare@suse.de>
References: <20210223120728.104699-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_070731_683402_9CB8F732 
X-CRM114-Status: GOOD (  19.29  )
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
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A customer of ours has run into this deadlock with RDMA:
- The ka_work workqueue item is executed
- A new ka_work workqueue item is scheduled just after that.
- Now both, the kato request timeout _and_ the workqueue delay
  will execute at roughly the same time
- If the timing is correct the workqueue executes _before_
  the kato request timeout triggers
- Kato request timeout triggers, and starts error recovery
- error recovery deadlocks, as it needs to flush the kato
  workqueue item; this is stuck in nvme_alloc_request() as all
  reserved tags are in use.

The reserved tags would have been freed up later when cancelling all
outstanding requests in the queue:

	nvme_stop_keep_alive(&ctrl->ctrl);
	nvme_rdma_teardown_io_queues(ctrl, false);
	nvme_start_queues(&ctrl->ctrl);
	nvme_rdma_teardown_admin_queue(ctrl, false);
	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);

but as we're stuck in nvme_stop_keep_alive() we'll never get this far.

To fix this a new controller flag 'NVME_CTRL_KATO_RUNNING' is added
which will short-circuit the nvme_keep_alive() function if one
keep-alive command is already running.

Cc: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 8 +++++++-
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ea40a3c511da..9b8596eb4047 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1211,6 +1211,7 @@ static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 	bool startka = false;
 
 	blk_mq_free_request(rq);
+	clear_bit(NVME_CTRL_KATO_RUNNING, &ctrl->flags);
 
 	if (status) {
 		dev_err(ctrl->device,
@@ -1233,10 +1234,15 @@ static int nvme_keep_alive(struct nvme_ctrl *ctrl)
 {
 	struct request *rq;
 
+	if (test_and_set_bit(NVME_CTRL_KATO_RUNNING, &ctrl->flags))
+		return 0;
+
 	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd,
 			BLK_MQ_REQ_RESERVED);
-	if (IS_ERR(rq))
+	if (IS_ERR(rq)) {
+		clear_bit(NVME_CTRL_KATO_RUNNING, &ctrl->flags);
 		return PTR_ERR(rq);
+	}
 
 	rq->timeout = ctrl->kato * HZ;
 	rq->end_io_data = ctrl;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e6efa085f08a..e00e3400c8b6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -344,6 +344,7 @@ struct nvme_ctrl {
 	int nr_reconnects;
 	unsigned long flags;
 #define NVME_CTRL_FAILFAST_EXPIRED	0
+#define NVME_CTRL_KATO_RUNNING		1
 	struct nvmf_ctrl_options *opts;
 
 	struct page *discard_page;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
