Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B168C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 10:34:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17F120731
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 10:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17F120731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vDJHIIYltxxoWurxfh7VpW27CvE31CEOZrL9qldFVD4=; b=1mUjQhhhFKijVR/ual3Y4dxME
	+wXafrf5s9Ygvp6PFvv+1m7K4AmK7ocyXdHtVDzT3y0ORiUZgKWIudxOa76UgBGsh97RGwnmfy3EG
	zkuEtvLWjnddGf+Upcd41p8/xENAZBWYYFXV+FwKrC1RrRaBnW5YIks2D88+ID2wmHRrOcpunIsXt
	4ROf8xtCKpC4RavhegnSBthH7mBb9MxuU9i74QYqpTDEmJ50X+yVnOnIAnSusEvBf5l48h1rDwJ7r
	uy2bbGH2r6UO7xQFQ0nI2HHQX2PCzHtdy/ANRMqzKAMDoHlhNRRzFS5JwazUjNRsgmQQ2RN8TAs7j
	X/hZfl8pg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4i8x-0000Dz-Tp; Wed, 27 Jan 2021 10:33:47 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4i8l-00009G-F6
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 10:33:38 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 736DCAF47;
 Wed, 27 Jan 2021 10:33:34 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/5] nvme: return -ETIMEDOUT in nvme_submit_sync_cmd()
Date: Wed, 27 Jan 2021 11:33:26 +0100
Message-Id: <20210127103326.16191-6-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210127103326.16191-1-hare@suse.de>
References: <20210127103326.16191-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_053335_690396_33C17EA9 
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
Cc: Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When a command times out we should be returning -ETIMEDOUT in
nvme_submit_sync_cmd(), and not requiring the caller to guess whether
a specific NVMe status should be interpreted as a timeout.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 2 ++
 drivers/nvme/host/fc.c   | 1 +
 drivers/nvme/host/nvme.h | 1 +
 drivers/nvme/host/rdma.c | 1 +
 drivers/nvme/host/tcp.c  | 1 +
 5 files changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1f723b7e9efb..8376f65d52ca 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -969,6 +969,8 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		*result = nvme_req(req)->result;
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
+	else if (nvme_req(req)->flags & NVME_REQ_TIMEOUT)
+		ret = -ETIMEDOUT;
 	else
 		ret = nvme_req(req)->status;
  out:
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 86395b66310d..bcc086fcbe61 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2551,6 +2551,7 @@ nvme_fc_timeout(struct request *rq, bool reserved)
 		"x%08x/x%08x\n",
 		ctrl->cnum, op->queue->qnum, sqe->common.opcode,
 		sqe->connect.fctype, sqe->common.cdw10, sqe->common.cdw11);
+	op->nreq.flags |= NVME_REQ_TIMEOUT;
 	if (__nvme_fc_abort_op(ctrl, op))
 		nvme_fc_error_recovery(ctrl, "io timeout abort failed");
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 88a6b97247f5..b0254692dc2a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -167,6 +167,7 @@ struct nvme_request {
 enum {
 	NVME_REQ_CANCELLED		= (1 << 0),
 	NVME_REQ_USERCMD		= (1 << 1),
+	NVME_REQ_TIMEOUT		= (1 << 2),
 };
 
 static inline struct nvme_request *nvme_req(struct request *req)
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index b7ce4f221d99..634ed5f5f778 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1984,6 +1984,7 @@ static void nvme_rdma_complete_timed_out(struct request *rq)
 	nvme_rdma_stop_queue(queue);
 	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
 		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
+		nvme_req(rq)->flags |= NVME_REQ_TIMEOUT;
 		blk_mq_complete_request(rq);
 	}
 }
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4c13c7110dbe..eee9470bb1bd 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2183,6 +2183,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
 	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
 		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
+		nvme_req(rq)->flags |= NVME_REQ_TIMEOUT;
 		blk_mq_complete_request(rq);
 	}
 }
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
