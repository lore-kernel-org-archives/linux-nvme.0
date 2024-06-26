Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C49C27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 12:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Y6PJXsHjAgf3VgetdOdi+gMrUBpc208hYhK71lONak=; b=D+QilmBJtbgoU/if+H8gEtO3ZZ
	W0NEpg1lYQAu3Xw9PnUSMm39M46GOaaqJ/TrLoxmUgXuj5RsyOFVZ7lHs+B14DvHYDjNkl0o6mUPw
	zi4Wt7XeYKwgykIpeVzvOAUg0tI7QvJ2rn4UfVpw7H0RLfgeVURDXGf5kDd3aW8JS3NXex6mxycU6
	A9aP1Of2ecjybC0ZZ6oYTW0+oTWjgYDqp/BNHvV9sE5ay+3isSUwFZqTWUBU9+vbc+k+NAO12gAYW
	lQFoFfAbBP+iB1PyiLov6jZrTwyrlfO7d8LElHBJ7VpZIJvPtNvswlt4N7l7JqXRO/r79aY848/tf
	/B2M0X0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMRXS-00000006haC-3jUx;
	Wed, 26 Jun 2024 12:14:14 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMRXL-00000006hVc-1T1e
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 12:14:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A23FDCE21C1;
	Wed, 26 Jun 2024 12:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98087C4AF0A;
	Wed, 26 Jun 2024 12:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719404044;
	bh=zVSnsLJP6lJm/gfDaARD3U8MGArMXttbJm5I+EYCclg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TO9D4IV68n4ATC0OW0RYiRrQ14R11PsJogKgjEaNXe3LSPi7OQVNlndlpsWxVfdQl
	 s35B5TrUGR/cDY2Qj+raKZVmKcZqfqzIGR4xKcD0ZGftXiOpxtJEKUIO0sQ/ImTBiL
	 x9juOaN9TngDEr+QL/PEt11u+zxha72DZWTfXjF31Uf7AshS6gBAsar6xC0sB06SWS
	 NbW9WFbjDjjgfOl7PnBfGPx35rHOS8EcCjli9c4h9oXZ8YU3SogW1aLNCvxEwD4q3y
	 H5rUkGeE2tXzRAokqZ74M+ciSG1w+t0oTRa6WSm2dlY4bey0ljUkN90rmUYEz1fS7B
	 EdW8dFE8auteA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 6/7] nvme-tcp: SOCK_NOSPACE handling
Date: Wed, 26 Jun 2024 14:13:46 +0200
Message-Id: <20240626121347.1116-7-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240626121347.1116-1-hare@kernel.org>
References: <20240626121347.1116-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_051407_931145_83075575 
X-CRM114-Status: GOOD (  14.92  )
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

When there is no write space on the socket we shouldn't try to
push more data onto it; it'll stall anyway and leads to higher CPU
utilisation. So check for sock_wspace() before queueing new
requests and let the sock write_space() handler restart the
submission.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 599d4ebf888f..d78cca2f05d4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -147,6 +147,7 @@ enum nvme_tcp_recv_state {
 struct nvme_tcp_ctrl;
 struct nvme_tcp_queue {
 	struct socket		*sock;
+	struct blk_mq_hw_ctx	*hctx;
 	struct work_struct	io_work;
 	int			io_cpu;
 
@@ -381,6 +382,15 @@ static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
 		nvme_tcp_queue_has_pending(queue);
 }
 
+static inline void nvme_tcp_queue_work(struct nvme_tcp_queue *queue)
+{
+	set_bit(SOCK_NOSPACE, &queue->sock->flags);
+	if (!sock_wspace(queue->sock->sk))
+		return;
+	clear_bit(SOCK_NOSPACE, &queue->sock->flags);
+	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+}
+
 static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 		bool sync, bool last)
 {
@@ -402,7 +412,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 	}
 
 	if (last && nvme_tcp_queue_has_pending(queue))
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		nvme_tcp_queue_work(queue);
 }
 
 static void nvme_tcp_process_req_list(struct nvme_tcp_queue *queue)
@@ -550,6 +560,7 @@ static int nvme_tcp_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 	struct nvme_tcp_queue *queue = &ctrl->queues[hctx_idx + 1];
 
 	hctx->driver_data = queue;
+	queue->hctx = hctx;
 	return 0;
 }
 
@@ -1004,7 +1015,10 @@ static void nvme_tcp_write_space(struct sock *sk)
 	queue = sk->sk_user_data;
 	if (likely(queue && sk_stream_is_writeable(sk))) {
 		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		if (sock_wspace(sk))
+			queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		if (queue->hctx)
+			blk_mq_start_hw_queue(queue->hctx);
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
 }
@@ -1317,7 +1331,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
 
 	} while (!time_after(jiffies, deadline)); /* quota is exhausted */
 
-	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+	nvme_tcp_queue_work(queue);
 }
 
 static void nvme_tcp_free_crypto(struct nvme_tcp_queue *queue)
@@ -1863,6 +1877,7 @@ static void nvme_tcp_restore_sock_ops(struct nvme_tcp_queue *queue)
 
 static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 {
+	queue->hctx = NULL;
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	nvme_tcp_restore_sock_ops(queue);
 	cancel_work_sync(&queue->io_work);
@@ -2614,7 +2629,7 @@ static void nvme_tcp_commit_rqs(struct blk_mq_hw_ctx *hctx)
 	struct nvme_tcp_queue *queue = hctx->driver_data;
 
 	if (!llist_empty(&queue->req_list))
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		nvme_tcp_queue_work(queue);
 }
 
 static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
@@ -2630,6 +2645,13 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (!nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
 		return nvme_fail_nonready_command(&queue->ctrl->ctrl, rq);
 
+	set_bit(SOCK_NOSPACE, &queue->sock->flags);
+	if (!sock_wspace(queue->sock->sk)) {
+		blk_mq_stop_hw_queue(hctx);
+		return BLK_STS_DEV_RESOURCE;
+	}
+	clear_bit(SOCK_NOSPACE, &queue->sock->flags);
+
 	ret = nvme_tcp_setup_cmd_pdu(ns, rq);
 	if (unlikely(ret))
 		return ret;
-- 
2.35.3


