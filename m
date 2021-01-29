Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80BFC4332D
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 15:37:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04EF64E2C
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 15:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04EF64E2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=onH6tWRYVc5N+fhsQtNEiVmIvHxeLhsMVjTOChDJFFA=; b=3GXprZvTRRwSVKXKQrRg8NJLo
	n0/iSnS6+dfKzHOMHFVfRURx2pZtQlP7kQoAd2GwKVbAOfQwFhQhd62hsTDKO6D9YtrF2QLruYgwG
	r7WG7zJ7ijskI785etkoSDRFR7lZ6DqiCFahEvx31tR1js5GkEzDVxxXHvTdiwtqY+mC0K4/3IvrJ
	yypoNaEKljDHlausg2AQ59pVKM2y3MKngl4jQOJ9/f1rKy6BvKNoTNJNmMRtC9Wrzbs1KOh/Ti5Fk
	4yHBWjR9LXAPlT/Gpdoojsz3RFnXgEc37UMhmd+/c7VnWDV3Y74xim8oCkDyCF4KruZGuYZvFN026
	goO/jOqkw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5VqG-0006Tw-JS; Fri, 29 Jan 2021 15:37:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5VqB-0006RA-0M
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 15:37:44 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7465264E1A;
 Fri, 29 Jan 2021 15:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611934662;
 bh=Ixe1IrcUEoJM1p5rTzlKBeGcxGEEU9dOYQvJdnCib4Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PYEHZ1r4cAndGRfUt+Z4r0pqy90L11KMRU+TkNgiyuGiZwrOkT2pCB3AYaGhWvQwQ
 0vuTs+MrJ6vOGQ4yicePzdixFmC8JUavsZTs29/5qntEUMgYXYTd7PXMalgLeD9I+x
 GmyICZCdo6pE6tgtiBGW3rFuKjX2pBxmjs4jYjc8Y7ut628Eg/dcfHX8DBduioAjJT
 K/BQng47hsLgEbgItu0hVZUkReX22alGRbVHp7Hiu0oYIlYTparCUsKNY2a2VXWpTL
 esPYn1tfSEzBSWOOzwrz/3g0nMi9jAc0Mo2J6j57YE/uXPOz0SMkrXdrhmOlSGcBsk
 iGOLAKa+PTaWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 23/41] nvme-rdma: avoid request double completion
 for concurrent nvme_rdma_timeout
Date: Fri, 29 Jan 2021 10:36:54 -0500
Message-Id: <20210129153713.1592185-23-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210129153713.1592185-1-sashal@kernel.org>
References: <20210129153713.1592185-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_103743_220330_C91DB3B5 
X-CRM114-Status: GOOD (  14.20  )
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
Cc: Israel Rukshin <israelr@nvidia.com>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Chao Leng <lengchao@huawei.com>

[ Upstream commit 7674073b2ed35ac951a49c425dec6b39d5a57140 ]

A crash happens when inject completing request long time(nearly 30s).
Each name space has a request queue, when inject completing request long
time, multi request queues may have time out requests at the same time,
nvme_rdma_timeout will execute concurrently. Multi requests in different
request queues may be queued in the same rdma queue, multi
nvme_rdma_timeout may call nvme_rdma_stop_queue at the same time.
The first nvme_rdma_timeout will clear NVME_RDMA_Q_LIVE and continue
stopping the rdma queue(drain qp), but the others check NVME_RDMA_Q_LIVE
is already cleared, and then directly complete the requests, complete
request before the qp is fully drained may lead to a use-after-free
condition.

Add a multex lock to serialize nvme_rdma_stop_queue.

Signed-off-by: Chao Leng <lengchao@huawei.com>
Tested-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/rdma.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 65e3d0ef36e1a..493ed7ba86ed2 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -97,6 +97,7 @@ struct nvme_rdma_queue {
 	struct completion	cm_done;
 	bool			pi_support;
 	int			cq_size;
+	struct mutex		queue_lock;
 };
 
 struct nvme_rdma_ctrl {
@@ -579,6 +580,7 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 	int ret;
 
 	queue = &ctrl->queues[idx];
+	mutex_init(&queue->queue_lock);
 	queue->ctrl = ctrl;
 	if (idx && ctrl->ctrl.max_integrity_segments)
 		queue->pi_support = true;
@@ -598,7 +600,8 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 	if (IS_ERR(queue->cm_id)) {
 		dev_info(ctrl->ctrl.device,
 			"failed to create CM ID: %ld\n", PTR_ERR(queue->cm_id));
-		return PTR_ERR(queue->cm_id);
+		ret = PTR_ERR(queue->cm_id);
+		goto out_destroy_mutex;
 	}
 
 	if (ctrl->ctrl.opts->mask & NVMF_OPT_HOST_TRADDR)
@@ -628,6 +631,8 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 out_destroy_cm_id:
 	rdma_destroy_id(queue->cm_id);
 	nvme_rdma_destroy_queue_ib(queue);
+out_destroy_mutex:
+	mutex_destroy(&queue->queue_lock);
 	return ret;
 }
 
@@ -639,9 +644,10 @@ static void __nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 
 static void nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 {
-	if (!test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags))
-		return;
-	__nvme_rdma_stop_queue(queue);
+	mutex_lock(&queue->queue_lock);
+	if (test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags))
+		__nvme_rdma_stop_queue(queue);
+	mutex_unlock(&queue->queue_lock);
 }
 
 static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
@@ -651,6 +657,7 @@ static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
 
 	nvme_rdma_destroy_queue_ib(queue);
 	rdma_destroy_id(queue->cm_id);
+	mutex_destroy(&queue->queue_lock);
 }
 
 static void nvme_rdma_free_io_queues(struct nvme_rdma_ctrl *ctrl)
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
