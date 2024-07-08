Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A76C41513
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jul 2024 07:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kIrdB9DDPA54Bynj5jtpDbNGQS6YvsJHZyu5rhp+3Gk=; b=LJyHGjnmuqGkRngsIRYCorkXAp
	X/ndj+TPXhUvMHUs516VWBgKgOb66J4ivTjT/pdvkXAgiYcy94Snk+PewkEXs6Yiat6qlP1o3i6a+
	QLWv1uBfgl1GgQukG7kWeWs7nCKfhYSM1fkxHEo761ADyeWPIB7swU2RuOAY4MaehsDEdVBx/r3W3
	sRmHOdUjukLC5ERQvLP083+lMxqyTtsxxczrvK5Y4As1tvNZethsz/2Nqe+J6Xp6MJhD1nKX4jpxT
	Yv9PbBNwUzS6yO/rV99nb9g7Zrv7PFiHbLpbHFkt/IPTE7J3NzOCyCjiU+8z6bTlNaLo6pVRu6UNX
	QvJ3J3vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQiW8-00000002z7Z-3d1b;
	Mon, 08 Jul 2024 07:10:32 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQiW1-00000002z5X-1iT5
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jul 2024 07:10:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DAA4860ACB;
	Mon,  8 Jul 2024 07:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B498C4AF0A;
	Mon,  8 Jul 2024 07:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720422624;
	bh=Y0zW/R979dcHoYZk67wydEjjjbbTg5TUe2R4dMAD/sU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dZQaJBAbDomi0n+QsdhKf1cd/44PDAvDBhmmi0E6TjHqOTo3KbWqi2x2fweLh5MLV
	 OIo47jniu+3IdT+DP8WixwQV27oeZFCKWoK7q5hfgmyPEOdqJM3ijudtwIX6KlI1TM
	 Tr4fDJA1Kk1p8OKMyUUzZNg0eU0GM4wEAxWGqxuNj2LLSRq+3hBDV2Mb/26rLiH7vf
	 Ukb4qN5Dj0IqrFSNSVO2jKlE1i8TJqq6i4+CCX8OG7gqemyQ6A7nB5L81LEJUOi6ol
	 vKAXubTzLiR49IsGCwnIFt7oeueCG+gbhAwA96vQtx4nkxQKajuSWM8G+KCftEbdHv
	 OkxG2jb2lipdg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/3] nvme-tcp: per-controller I/O workqueues
Date: Mon,  8 Jul 2024 09:10:13 +0200
Message-Id: <20240708071013.69984-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240708071013.69984-1-hare@kernel.org>
References: <20240708071013.69984-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_001025_576938_ABF053B5 
X-CRM114-Status: GOOD (  15.20  )
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

From: Hannes Reinecke <hare@suse.de>

Implement per-controller I/O workqueues to reduce workqueue contention
during I/O and improve I/O performance.

Performance comparison:
               baseline rx/tx    blk-mq   multiple workqueues
4k seq write:  449MiB/s 480MiB/s 524MiB/s 540MiB/s
4k rand write: 410MiB/s 481MiB/s 524MiB/s 539MiB/s
4k seq read:   478MiB/s 481MiB/s 566MiB/s 582MiB/s
4k rand read:  547MiB/s 480MiB/s 511MiB/s 633MiB/s

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a5c42a7b4bee..fc8f682f686d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -194,6 +194,7 @@ struct nvme_tcp_ctrl {
 	struct sockaddr_storage src_addr;
 	struct nvme_ctrl	ctrl;
 
+	struct workqueue_struct	*io_wq;
 	struct work_struct	err_work;
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
@@ -202,7 +203,6 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
-static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
@@ -410,7 +410,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 	}
 
 	if (last && nvme_tcp_queue_has_pending(queue))
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		queue_work_on(queue->io_cpu, queue->ctrl->io_wq, &queue->io_work);
 }
 
 static void nvme_tcp_process_req_list(struct nvme_tcp_queue *queue)
@@ -987,7 +987,7 @@ static void nvme_tcp_data_ready(struct sock *sk)
 	queue = sk->sk_user_data;
 	if (likely(queue && queue->rd_enabled) &&
 	    !test_bit(NVME_TCP_Q_POLLING, &queue->flags))
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		queue_work_on(queue->io_cpu, queue->ctrl->io_wq, &queue->io_work);
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
@@ -999,7 +999,7 @@ static void nvme_tcp_write_space(struct sock *sk)
 	queue = sk->sk_user_data;
 	if (likely(queue && sk_stream_is_writeable(sk))) {
 		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		queue_work_on(queue->io_cpu, queue->ctrl->io_wq, &queue->io_work);
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
 }
@@ -1325,7 +1325,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		dev_dbg(queue->ctrl->ctrl.device, "queue %d: queue stall (%u msecs)\n",
 			nvme_tcp_queue_id(queue), jiffies_to_msecs(overrun));
 
-	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+	queue_work_on(queue->io_cpu, queue->ctrl->io_wq, &queue->io_work);
 }
 
 static void nvme_tcp_free_crypto(struct nvme_tcp_queue *queue)
@@ -2486,6 +2486,8 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 
 	nvmf_free_options(nctrl->opts);
 free_ctrl:
+	destroy_workqueue(ctrl->io_wq);
+
 	kfree(ctrl->queues);
 	kfree(ctrl);
 }
@@ -2676,7 +2678,7 @@ static void nvme_tcp_commit_rqs(struct blk_mq_hw_ctx *hctx)
 	struct nvme_tcp_queue *queue = hctx->driver_data;
 
 	if (!llist_empty(&queue->req_list))
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		queue_work_on(queue->io_cpu, queue->ctrl->io_wq, &queue->io_work);
 }
 
 static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
@@ -2812,6 +2814,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
 	struct nvme_tcp_ctrl *ctrl;
+	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
 	int ret;
 
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
@@ -2883,6 +2886,15 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	if (ret)
 		goto out_kfree_queues;
 
+	if (wq_unbound)
+		wq_flags |= WQ_UNBOUND;
+	ctrl->io_wq = alloc_workqueue("nvme_tcp_wq_%d", wq_flags, 0,
+				      ctrl->ctrl.instance);
+	if (!ctrl->io_wq) {
+		nvme_put_ctrl(&ctrl->ctrl);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	return ctrl;
 out_kfree_queues:
 	kfree(ctrl->queues);
@@ -2948,7 +2960,6 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 
 static int __init nvme_tcp_init_module(void)
 {
-	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
 	int cpu;
 
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
@@ -2960,13 +2971,6 @@ static int __init nvme_tcp_init_module(void)
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_icresp_pdu) != 128);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_term_pdu) != 24);
 
-	if (wq_unbound)
-		wq_flags |= WQ_UNBOUND;
-
-	nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq", wq_flags, 0);
-	if (!nvme_tcp_wq)
-		return -ENOMEM;
-
 	for_each_possible_cpu(cpu)
 		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
 
@@ -2985,8 +2989,6 @@ static void __exit nvme_tcp_cleanup_module(void)
 		nvme_delete_ctrl(&ctrl->ctrl);
 	mutex_unlock(&nvme_tcp_ctrl_mutex);
 	flush_workqueue(nvme_delete_wq);
-
-	destroy_workqueue(nvme_tcp_wq);
 }
 
 module_init(nvme_tcp_init_module);
-- 
2.35.3


