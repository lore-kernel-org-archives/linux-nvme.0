Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5966AC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 10:56:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1FE264EF5
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 10:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FE264EF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/U6biALVn5xCLWOKyJBR3aSoyLp4HxiOWwv3d2KtlRo=; b=1cD//KWgxARSfM/vpdlaT9JmD
	UiLVGO0ZRMGlu38BmcxfOqRGIevC/3+Q9gpDz/ulGJfnjjnBSSLGdFe1tijqZc/kdm31tqz0hiMUU
	TJBaEZNu/dAxKZSWGcDofATpeszl0+gL+5yWjqi7+g0mitfgGIqc/2sbSeDFrT1iz3Z4le1yFA8II
	AdyDQDv2PHrULX0YbSc+pbX7RqDibSWzrKLKZ4Ya6styOwSiDWdAG3vwc7Q3BSwS95aCGE0zxsc1G
	qAt8cxuzKJJgj45dIzZPRnGHDHNDvVk+P//PgVwqV/QP55XU+9gPEHbjDCQQxRSZUJ53XcbKDjw8C
	KCvpwBWNA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFEJG-0005Nv-Gc; Thu, 25 Feb 2021 10:55:54 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFEJ6-0005L3-HI
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 10:55:46 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0597BADDD;
 Thu, 25 Feb 2021 10:55:41 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/6] nvme: return -ETIMEDOUT in nvme_submit_sync_cmd()
Date: Thu, 25 Feb 2021 11:55:27 +0100
Message-Id: <20210225105527.75277-7-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210225105527.75277-1-hare@suse.de>
References: <20210225105527.75277-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_055544_738294_7D5520CF 
X-CRM114-Status: GOOD (  15.60  )
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
index 624531a6b7c6..5c1ec3bfb9d3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1004,6 +1004,8 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
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
index 07b34175c6ce..02aa4ba665c0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -173,6 +173,7 @@ struct nvme_request {
 enum {
 	NVME_REQ_CANCELLED		= (1 << 0),
 	NVME_REQ_USERCMD		= (1 << 1),
+	NVME_REQ_TIMEOUT		= (1 << 2),
 };
 
 static inline struct nvme_request *nvme_req(struct request *req)
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 53ac4d7442ba..99ad2e10b295 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1990,6 +1990,7 @@ static void nvme_rdma_complete_timed_out(struct request *rq)
 	nvme_rdma_stop_queue(queue);
 	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
 		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
+		nvme_req(rq)->flags |= NVME_REQ_TIMEOUT;
 		blk_mq_complete_request(rq);
 	}
 }
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 69f59d2c5799..64aab742c84d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2189,6 +2189,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
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
