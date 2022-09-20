Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12478C6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 17:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JDwrSlrC8szOWeEtDkH9gr3J7WfUZvm/R+1BZ5T3tZY=; b=OLWOSzwHjX8jUXpd8pFQMZPRXF
	03f24ee4scLgSim3OQY0O1qctkmmg43tnMZWGv6GPqeX37Fosljg82qeq8G8U9JSRsyYGsXPTk9HQ
	H4bMTk4hhMWTAPt4SNu03v5+phMmzB1wdJac/D0gg+HitYMmRMpSyOyIx6aSSWLsbElJaO3QDoOn0
	zOj+o0HranUXojy381DiJxeaLUWMbqlfH2ERXxunqZ+gXUNIGi0sWDIe5lkCirtDAQYrs4eezq40m
	ELdI+f/E7Sr2vPZR7s7JctAu+zhTauFc4TsXoYO69ywwFFvSNh1feZ9XEvcEOe03RQc655wA4IZMl
	wMg+6ZYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagrL-005LYY-2f; Tue, 20 Sep 2022 17:16:35 +0000
Received: from [77.247.85.102] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagr8-005LTA-Fv; Tue, 20 Sep 2022 17:16:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 02/13] nvme-tcp: remove the unused queue_size member in nvme_tcp_queue
Date: Tue, 20 Sep 2022 19:16:00 +0200
Message-Id: <20220920171611.1289361-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220920171611.1289361-1-hch@lst.de>
References: <20220920171611.1289361-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

->nvme_tcp_queue is not used anywhere, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/tcp.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b5f22ceaae823..8a749ef63afee 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -134,7 +134,6 @@ struct nvme_tcp_queue {
 	/* send state */
 	struct nvme_tcp_request *request;
 
-	int			queue_size;
 	u32			maxh2cdata;
 	size_t			cmnd_capsule_len;
 	struct nvme_tcp_ctrl	*ctrl;
@@ -1479,8 +1478,7 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
 }
 
-static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
-		int qid, size_t queue_size)
+static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
@@ -1492,7 +1490,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	INIT_LIST_HEAD(&queue->send_list);
 	mutex_init(&queue->send_mutex);
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
-	queue->queue_size = queue_size;
 
 	if (qid > 0)
 		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
@@ -1785,7 +1782,7 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 {
 	int ret;
 
-	ret = nvme_tcp_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
+	ret = nvme_tcp_alloc_queue(ctrl, 0);
 	if (ret)
 		return ret;
 
@@ -1805,7 +1802,7 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 	int i, ret;
 
 	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = nvme_tcp_alloc_queue(ctrl, i, ctrl->sqsize + 1);
+		ret = nvme_tcp_alloc_queue(ctrl, i);
 		if (ret)
 			goto out_free_queues;
 	}
-- 
2.30.2


