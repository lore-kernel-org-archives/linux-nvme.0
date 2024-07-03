Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D07EC2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 13:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NyzSISpBgptnarvAEl6+V/Mng+Eiq7rAiirrqE1DHE0=; b=nLN8amt46PwDueuvIvgkul1nSq
	ChzW95UrsB+ZfCcxjBjyJ1Dd75mPt48UiaUeB9umLk9h0xeo9OmhFqEacFo1mfQAg74CU3UUbvuaL
	2l62quq9+BsTZjSHLBuuNydPA3fjvNgSBGWNDdYwBJf6NRiuwcpeGsT/lE10ZtjnY7NLodG8Tuzrx
	QnIRFd9Y71GjONtQNUqXaRi5mXVMHuDGnpS3R21vjMjgbLbLuL+tPSn6zpyWhYmUOcZMVTV4AYH9b
	dwyg5zpYlFw7u/c3r6XgXeY9JQGFSYgEFCFc2WXhuRryojJRH/OPgM2EAh+F193vsz8i7k+ZLJVVN
	2ymnpfag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0NX-0000000AM4S-2Usn;
	Wed, 03 Jul 2024 13:50:35 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0NU-0000000AM2R-1UGy
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 13:50:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id BA86ACE2AFC;
	Wed,  3 Jul 2024 13:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD44CC4AF07;
	Wed,  3 Jul 2024 13:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720014629;
	bh=iVmmJi63nCHgg2koVCH0A84FYGO3ujMoLTmleHyRErU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DMLbLn1zmFikmhlrMmea49954ZQC6GfagJI1gSDWLcH13Vt0KW1wbeZC+kRoWafti
	 ithGWY+4Kgp+8rS9NurxOUFX1EHs5wBIbzKn2RitEoUJN/3jzP+f7EUiFkiqo63HQT
	 Ip8apwRwhpIE8d1O4l6PpsLTSVA7b9KxsZP0Bi6QHazW08v3fJ5SdBcD9RRLBX6/kZ
	 z8rEF18TYOBF0Rnpyp5uw7jqGhMUy0TWuzDNDjFaYMvn8XbOuNLgRWlpi66DM+f8gz
	 Pm/Q1QTIi7uytQ5k0QXf9qCn1ITmxg28MTd7+1H+Sbho0K/uWnQ6b2ODM/0KbKSPYl
	 AeFWxx2mhiF5A==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/4] nvme-tcp: per-controller I/O workqueues
Date: Wed,  3 Jul 2024 15:50:18 +0200
Message-Id: <20240703135021.34143-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240703135021.34143-1-hare@kernel.org>
References: <20240703135021.34143-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_065032_775954_F2F0864B 
X-CRM114-Status: GOOD (  16.32  )
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

Implement per-controller I/O workqueues to reduce workqueue contention
during I/O.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 5885aa452aa1..d43099c562fc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -191,6 +191,7 @@ struct nvme_tcp_ctrl {
 	struct sockaddr_storage src_addr;
 	struct nvme_ctrl	ctrl;
 
+	struct workqueue_struct	*io_wq;
 	struct work_struct	err_work;
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
@@ -199,7 +200,6 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
-static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
@@ -402,7 +402,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 	}
 
 	if (last && nvme_tcp_queue_has_pending(queue))
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		queue_work_on(queue->io_cpu, queue->ctrl->io_wq, &queue->io_work);
 }
 
 static void nvme_tcp_process_req_list(struct nvme_tcp_queue *queue)
@@ -974,7 +974,7 @@ static void nvme_tcp_data_ready(struct sock *sk)
 	queue = sk->sk_user_data;
 	if (likely(queue && queue->rd_enabled) &&
 	    !test_bit(NVME_TCP_Q_POLLING, &queue->flags))
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		queue_work_on(queue->io_cpu, queue->ctrl->io_wq, &queue->io_work);
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
@@ -986,7 +986,7 @@ static void nvme_tcp_write_space(struct sock *sk)
 	queue = sk->sk_user_data;
 	if (likely(queue && sk_stream_is_writeable(sk))) {
 		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		queue_work_on(queue->io_cpu, queue->ctrl->io_wq, &queue->io_work);
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
 }
@@ -1304,7 +1304,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
 
 	} while (!time_after(jiffies, deadline)); /* quota is exhausted */
 
-	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+	queue_work_on(queue->io_cpu, queue->ctrl->io_wq, &queue->io_work);
 }
 
 static void nvme_tcp_free_crypto(struct nvme_tcp_queue *queue)
@@ -2390,6 +2390,8 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 
 	nvmf_free_options(nctrl->opts);
 free_ctrl:
+	destroy_workqueue(ctrl->io_wq);
+
 	kfree(ctrl->queues);
 	kfree(ctrl);
 }
@@ -2580,7 +2582,7 @@ static void nvme_tcp_commit_rqs(struct blk_mq_hw_ctx *hctx)
 	struct nvme_tcp_queue *queue = hctx->driver_data;
 
 	if (!llist_empty(&queue->req_list))
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		queue_work_on(queue->io_cpu, queue->ctrl->io_wq, &queue->io_work);
 }
 
 static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
@@ -2712,6 +2714,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
 	struct nvme_tcp_ctrl *ctrl;
+	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
 	int ret;
 
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
@@ -2783,6 +2786,15 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
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
@@ -2848,8 +2860,6 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 
 static int __init nvme_tcp_init_module(void)
 {
-	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
-
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
@@ -2859,13 +2869,6 @@ static int __init nvme_tcp_init_module(void)
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_icresp_pdu) != 128);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_term_pdu) != 24);
 
-	if (wq_unbound)
-		wq_flags |= WQ_UNBOUND;
-
-	nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq", wq_flags, 0);
-	if (!nvme_tcp_wq)
-		return -ENOMEM;
-
 	nvmf_register_transport(&nvme_tcp_transport);
 	return 0;
 }
@@ -2881,8 +2884,6 @@ static void __exit nvme_tcp_cleanup_module(void)
 		nvme_delete_ctrl(&ctrl->ctrl);
 	mutex_unlock(&nvme_tcp_ctrl_mutex);
 	flush_workqueue(nvme_delete_wq);
-
-	destroy_workqueue(nvme_tcp_wq);
 }
 
 module_init(nvme_tcp_init_module);
-- 
2.35.3


