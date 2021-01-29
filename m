Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2349C4332B
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 15:38:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB66464E29
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 15:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB66464E29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rXnoDPJ2NbU18IvWpbIj875PMJ2yzLfvMU566Bi4tH4=; b=PUfup5OUsGbd2Ik4IdwpqtTzd
	vYnBWQaj3cnPlN0T8kkMlvPTkwRnk7XFvs6R9q/op+5h8TSMQK/lG3S0kfdtxVz3EAPRhqNhxO4W7
	GJUL09JF6vjTh2f1S+OkBN4D1+/IQ3E/5z50dInQpGuFqEUA1rAIvqOSu7dnXIKdGQ8Ph6bKFMYiP
	Kca/vuVUUhcpA3tBY0X0IFRSZNlmy3K8f0cShiPAgJLXltZVXzCI+8UMFqVCUOweSie26XdHJWRI6
	i1TR7JqwKGeI7t+a6n0WB0aXJZ1ZeuNcjvIjkACeh8RuAR9nUYFANJf4metmtk07fLiXKDws/Aj9z
	xkcaGNKZA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5VqN-0006WO-Bb; Fri, 29 Jan 2021 15:37:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5VqC-0006Rv-5p
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 15:37:45 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE46464E1D;
 Fri, 29 Jan 2021 15:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611934663;
 bh=idGAlalkqTYFp6DFW1RaNPoHIRFjJdyiWCJPr/r4RtY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hM9x9FcJj13lAA2FZbeiaK0bRzfJAt7crK67HErrvrOykMG5ZIld/9r5i09aTyzLp
 valvkE5lcn7hFSJ/+B3xAFa11BuZFKWJBhptgufR+uA+8BdIid3knEUp2ZPu7HkD1G
 Fe+znqejcCnbblNkp9LpY62ZApuTxeWHDahsXN50XApd7G8R8Y6e4w2sKqSv1r1iOA
 0BCrzNdJ/MLGWzSh19gtgWz7+2iwb+Uw3X5si/w1yWjPr4cLrhH3u8ZShX7FVx//b0
 At72TbyuQ3ddhuMZ5WkmbM/b9CW1OKbUM5A9hM5ka5F+C5nMGuza5mlkOzBM0J5DzW
 T7x54vVv4843Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 24/41] nvme-tcp: avoid request double completion
 for concurrent nvme_tcp_timeout
Date: Fri, 29 Jan 2021 10:36:55 -0500
Message-Id: <20210129153713.1592185-24-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210129153713.1592185-1-sashal@kernel.org>
References: <20210129153713.1592185-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_103744_980881_5F38B801 
X-CRM114-Status: GOOD (  14.47  )
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
Cc: Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Chao Leng <lengchao@huawei.com>

[ Upstream commit 9ebbfe495ecd2e51bc92ac21ed5817c3b9e223ce ]

Each name space has a request queue, if complete request long time,
multi request queues may have time out requests at the same time,
nvme_tcp_timeout will execute concurrently. Multi requests in different
request queues may be queued in the same tcp queue, multi
nvme_tcp_timeout may call nvme_tcp_stop_queue at the same time.
The first nvme_tcp_stop_queue will clear NVME_TCP_Q_LIVE and continue
stopping the tcp queue(cancel io_work), but the others check
NVME_TCP_Q_LIVE is already cleared, and then directly complete the
requests, complete request before the io work is completely canceled may
lead to a use-after-free condition.
Add a multex lock to serialize nvme_tcp_stop_queue.

Signed-off-by: Chao Leng <lengchao@huawei.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 81db2331f6d78..6487b7897d1fb 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -76,6 +76,7 @@ struct nvme_tcp_queue {
 	struct work_struct	io_work;
 	int			io_cpu;
 
+	struct mutex		queue_lock;
 	struct mutex		send_mutex;
 	struct llist_head	req_list;
 	struct list_head	send_list;
@@ -1219,6 +1220,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 
 	sock_release(queue->sock);
 	kfree(queue->pdu);
+	mutex_destroy(&queue->queue_lock);
 }
 
 static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
@@ -1380,6 +1382,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 	int ret, rcv_pdu_size;
 
+	mutex_init(&queue->queue_lock);
 	queue->ctrl = ctrl;
 	init_llist_head(&queue->req_list);
 	INIT_LIST_HEAD(&queue->send_list);
@@ -1398,7 +1401,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	if (ret) {
 		dev_err(nctrl->device,
 			"failed to create socket: %d\n", ret);
-		return ret;
+		goto err_destroy_mutex;
 	}
 
 	/* Single syn retry */
@@ -1507,6 +1510,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 err_sock:
 	sock_release(queue->sock);
 	queue->sock = NULL;
+err_destroy_mutex:
+	mutex_destroy(&queue->queue_lock);
 	return ret;
 }
 
@@ -1534,9 +1539,10 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 
-	if (!test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
-		return;
-	__nvme_tcp_stop_queue(queue);
+	mutex_lock(&queue->queue_lock);
+	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
+		__nvme_tcp_stop_queue(queue);
+	mutex_unlock(&queue->queue_lock);
 }
 
 static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
