Return-Path: <SRS0=60sM=IA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD00C433E9
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Mar 2021 09:27:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD39364F09
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Mar 2021 09:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD39364F09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=acy690/CLGBJiSPTEBfMQAE8Xr/Aikp2dsHPkhleQuY=; b=qN3tnOOdiJIdZVSIw1sX97TIZ
	liAAaDE3sxTdGvd9GggVq09yCsgsA7JRjOjYKmRXCZas1k1Qh0x2wJ9ANaZjkIhAdcmECRayhko2B
	5ylRKiXH6K0WKy5C24vkQrQTShixENVTq6KpJKliCmlXkhKGkpCWSvz//+D/Bu+fqVGxEWkY67ixD
	XFaYmpTIdVTpMfA7iXD/z65b3ctQ0oHBZctp2IL70PRTD96Av9BKUSmmlpGUr9EV2cb2tkZnYux8K
	jTysU7+pbKQ5Hz6v37K9rLbEfSuf4J05ZygUpupI3F1LawehF/lAoEylmFBJ14J9M/nCGDlOffgsa
	FgKsdqsKg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lH1Iq-00023X-1u; Tue, 02 Mar 2021 09:26:52 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lH1Il-000225-0y
 for linux-nvme@lists.infradead.org; Tue, 02 Mar 2021 09:26:48 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 02C89AFCE;
 Tue,  2 Mar 2021 09:26:46 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/3] nvme: fixup kato deadlock
Date: Tue,  2 Mar 2021 10:26:42 +0100
Message-Id: <20210302092644.80701-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210302092644.80701-1-hare@suse.de>
References: <20210302092644.80701-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210302_042647_216007_BA481454 
X-CRM114-Status: GOOD (  20.30  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>
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
Additionally we should be allocating the KATO request with
BLK_MQ_REQ_NOWAIT as we must not block on request allocation; if we
cannot get a request we cannot determine if the connection is healthy,
and need to reset it anyway.

Cc: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 10 ++++++++--
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 587f8395435b..f890b310499e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1207,6 +1207,7 @@ static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 	bool startka = false;
 
 	blk_mq_free_request(rq);
+	clear_bit(NVME_CTRL_KATO_RUNNING, &ctrl->flags);
 
 	if (status) {
 		dev_err(ctrl->device,
@@ -1229,10 +1230,15 @@ static int nvme_keep_alive(struct nvme_ctrl *ctrl)
 {
 	struct request *rq;
 
+	if (test_and_set_bit(NVME_CTRL_KATO_RUNNING, &ctrl->flags))
+		return 0;
+
 	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd,
-			BLK_MQ_REQ_RESERVED);
-	if (IS_ERR(rq))
+			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+	if (IS_ERR(rq)) {
+		clear_bit(NVME_CTRL_KATO_RUNNING, &ctrl->flags);
 		return PTR_ERR(rq);
+	}
 
 	rq->timeout = ctrl->kato * HZ;
 	rq->end_io_data = ctrl;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 07b34175c6ce..23711f6b7d13 100644
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
