Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A570DC27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 12:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yop8iVcfd5P7P3dcEYJ/3YcwO98nak5KpmSUpyS68Vg=; b=PrXZShn1zMa5I8YjtdTaRmkVtj
	Al9npExJmYrLbAXhBz+wXPF/c88hZ0WRJM0F0N97s+Oinc30G81dA9FifGDy29TjgPf7yMYIuYnkw
	nAKLGD9KTnaazOsBrBmw2wMMP/PHo8OoZ8MZTD971RSYTpg5fnezd//Qonhoip2VN3QLXlFOX8rpU
	09K6Cd9nQvtjA8Yqv0eJLRF68cC5jCPUkEw0W/F+6aAWnyWxMe7cgCcPJG5gfZGSD8h8caY59kPJa
	51Eu1bFRJL0xJ79Imaqfwf+iqQ+6gV2QadiPyuR3ZHcJ6FfIrSNJaY7WsB3PzTR+M0OFGEjW89ZQC
	0pFtxk4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMRXQ-00000006hYg-0KL2;
	Wed, 26 Jun 2024 12:14:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMRXI-00000006hUL-0DKS
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 12:14:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7E7B660AB1;
	Wed, 26 Jun 2024 12:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE06C2BD10;
	Wed, 26 Jun 2024 12:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719404043;
	bh=dA0GWOKAN2yyo2KzaJ0RdNto77Rlq0EGc57WSoINYLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwOw/kZMQNdEqgV7G25GXtH+I4FjS0FfNmv0NYw+CaEvR36sDI7/zctQ7Ngpv+hG3
	 nCLMTunmoSKRo2h4pixb8lLMFB68r27wPVMfsBeJb5oIh7rmK1v6n7VULCxBA1ANsy
	 0CQwaEmcYTo/fm2lSKm5H5NoeDv4EuEn7sVo6ZeuWPiYdW6Bu0WfPLhBzSyq5Ptkyz
	 4J1cfnVU0DnOvn16Mh64YQxgBw9W7qW4Gpt6X73MJ10gQwLKWqrqoEaXE2QFaZWssf
	 QcAJQqDuQde09ioL+vbGNwGZ4vfdGT0zFP1NlKt+gNv8+FQnnwEMdignKUGx07/6+S
	 aB5BHNkatPhCA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 5/7] nvmet-tcp: add wq_unbound module parameter
Date: Wed, 26 Jun 2024 14:13:45 +0200
Message-Id: <20240626121347.1116-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240626121347.1116-1-hare@kernel.org>
References: <20240626121347.1116-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_051404_242189_E4AC927C 
X-CRM114-Status: GOOD (  15.57  )
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

For high loads the default scheme of queueing work on the receiving
cpu might lead to cpu starvation and 'CPU hogged' messages.
This patch provides an 'wq_unbound' module parameter to let the
workqueue mechanism do scheduling decisions.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/tcp.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index d305d7162dde..572e4f474c68 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -73,6 +73,14 @@ device_param_cb(idle_poll_period_usecs, &set_param_ops,
 MODULE_PARM_DESC(idle_poll_period_usecs,
 		"nvmet tcp io_work poll till idle time period in usecs: Default 0");
 
+/*
+ * Use the unbound workqueue for nvme_tcp_wq, then we can set the cpu affinity
+ * from sysfs.
+ */
+static bool wq_unbound;
+module_param(wq_unbound, bool, 0644);
+MODULE_PARM_DESC(wq_unbound, "Use unbound workqueue for nvme-tcp IO context (default false)");
+
 #ifdef CONFIG_NVME_TARGET_TCP_TLS
 /*
  * TLS handshake timeout
@@ -566,6 +574,15 @@ static struct nvmet_tcp_cmd *nvmet_tcp_fetch_cmd(struct nvmet_tcp_queue *queue)
 	return queue->snd_cmd;
 }
 
+static void nvmet_tcp_queue_work(struct nvmet_tcp_queue *queue)
+{
+	if (wq_unbound)
+		queue_work(nvmet_tcp_wq, &queue->io_work);
+	else
+		queue_work_on(queue_cpu(queue), nvmet_tcp_wq,
+			      &queue->io_work);
+}
+
 static void nvmet_tcp_queue_response(struct nvmet_req *req)
 {
 	struct nvmet_tcp_cmd *cmd =
@@ -590,7 +607,7 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 	}
 
 	llist_add(&cmd->lentry, &queue->resp_list);
-	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &cmd->queue->io_work);
+	nvmet_tcp_queue_work(queue);
 }
 
 static void nvmet_tcp_execute_request(struct nvmet_tcp_cmd *cmd)
@@ -1452,7 +1469,7 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 	 * ops activity was recorded during the do-while loop above.
 	 */
 	if (nvmet_tcp_check_queue_deadline(queue, ops) || pending)
-		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
+		nvmet_tcp_queue_work(queue);
 }
 
 static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
@@ -1628,8 +1645,7 @@ static void nvmet_tcp_data_ready(struct sock *sk)
 		if (queue->data_ready)
 			queue->data_ready(sk);
 		if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)
-			queue_work_on(queue_cpu(queue), nvmet_tcp_wq,
-				      &queue->io_work);
+			nvmet_tcp_queue_work(queue);
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
 }
@@ -1650,7 +1666,7 @@ static void nvmet_tcp_write_space(struct sock *sk)
 
 	if (sk_stream_is_writeable(sk)) {
 		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
-		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
+		nvmet_tcp_queue_work(queue);
 	}
 out:
 	read_unlock_bh(&sk->sk_callback_lock);
@@ -1731,7 +1747,7 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 		sock->sk->sk_write_space = nvmet_tcp_write_space;
 		if (idle_poll_period_usecs)
 			nvmet_tcp_arm_queue_deadline(queue);
-		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
+		nvmet_tcp_queue_work(queue);
 	}
 	write_unlock_bh(&sock->sk->sk_callback_lock);
 
@@ -2182,9 +2198,11 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 static int __init nvmet_tcp_init(void)
 {
 	int ret;
+	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
 
-	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq",
-				WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+	if (wq_unbound)
+		wq_flags |= WQ_UNBOUND;
+	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq", wq_flags, 0);
 	if (!nvmet_tcp_wq)
 		return -ENOMEM;
 
-- 
2.35.3


