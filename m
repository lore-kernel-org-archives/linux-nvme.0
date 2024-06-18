Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EC2C27C4F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jun 2024 12:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Z6xiFJc8gcYKbyB/aPlnkkFEnzrQoGxW9M+QeiZ6XpI=; b=vg8mI+u7iKMvx87MFTXwR8wajn
	6tuPrgkgF99DvKcOE7Tb7RfouIwh884TsVHaSuzWVQTDHFikcWPv1djnTc9yGclnf2cO5g6YSE01+
	RrWRB2FoLZ7xnfxyET0j4PbkmuFl3ukduIAHWLqpHFB2NGXS0WWO/x1d/Cj6wG/OxhirFfubFpbX8
	sw5pE1zC0lYLurXP0ULYWmkuRMEQHvLyXRZwZ+msTLNr/Ad/NF+uV8S1D3lwo0Fj+8kEUWacIXJkc
	9PJsRxVPDlGn872UQUsVpf5pyl70iUmE9ivhGVJsNp6gIu8Unrhnu9hAq+9wuve2GLuqIRmiyb9gG
	U/oeoG9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJXZ6-0000000Em0o-32Nw;
	Tue, 18 Jun 2024 12:03:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJXZ3-0000000Elzh-2kUs
	for linux-nvme@lists.infradead.org;
	Tue, 18 Jun 2024 12:03:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 69B956187F;
	Tue, 18 Jun 2024 12:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4964C32786;
	Tue, 18 Jun 2024 12:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718712232;
	bh=+6XyIIgzMgWAy6N4Q77wh6i1EFG7QfAuhaQQrfX2KPk=;
	h=From:To:Cc:Subject:Date:From;
	b=ICntu7/aya/I6+EJxIp629eFMXN/Z9yJCOJKS3EJBPHTbo0+izDwRu+pnfTz8dpHE
	 K7WNYp1QinMB+qBqjFk7v2JBpH0HOnxFnSLaMHCCfQqA8dM6E9gkLqsCfDARu6g+i2
	 9V52okVxv24I4Kj5hZ0/30UCoBNyUAIOghl0JCKiNTOCgG0xROj9NqiZ0cLwH8j4Mm
	 Gxndd427e3p9S8x6unqfFAM5k/0VigpbXrzLGuXxhEdEZ4nzSF5E08yxAsTbnKqDze
	 ljB5QWyGZwG+oIaMfU6/KFJ4vFVYbwe8fnHMSbYQ9aFMnjQ7oNjP8cVPCGJ4QcOtac
	 id9jwfub8WIoQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] nvme-tcp: align I/O cpu with blk-mq mapping
Date: Tue, 18 Jun 2024 14:03:45 +0200
Message-Id: <20240618120345.64761-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240618_050353_813877_D504A767 
X-CRM114-Status: GOOD (  15.17  )
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

Add a new module parameter 'wq_affinity' to spread the I/O
over all cpus within the blk-mq hctx mapping for the queue.
This avoids bouncing I/O between cpus when we have less
hardware queues than cpus.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 57 ++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3be67c98c906..8c675ee50ccf 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -44,6 +44,13 @@ static bool wq_unbound;
 module_param(wq_unbound, bool, 0644);
 MODULE_PARM_DESC(wq_unbound, "Use unbound workqueue for nvme-tcp IO context (default false)");
 
+/*
+ * Balance workqueues across all CPUs in the set for a given queue
+ */
+static bool wq_affinity;
+module_param(wq_affinity, bool, 0644);
+MODULE_PARM_DESC(wq_affinity, "Match workqueues to blk-mq cpumask for nvme-tcp IO context (default false)");
+
 /*
  * TLS handshake timeout
  */
@@ -1550,20 +1557,40 @@ static bool nvme_tcp_poll_queue(struct nvme_tcp_queue *queue)
 static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
-	int qid = nvme_tcp_queue_id(queue);
+	struct blk_mq_tag_set *set = &ctrl->tag_set;
+	int qid = nvme_tcp_queue_id(queue) - 1;
+	unsigned int *mq_map;
 	int n = 0;
 
-	if (nvme_tcp_default_queue(queue))
-		n = qid - 1;
-	else if (nvme_tcp_read_queue(queue))
-		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] - 1;
-	else if (nvme_tcp_poll_queue(queue))
+	if (nvme_tcp_default_queue(queue)) {
+		mq_map = set->map[HCTX_TYPE_DEFAULT].mq_map;
+		n = qid;
+	} else if (nvme_tcp_read_queue(queue)) {
+		mq_map = set->map[HCTX_TYPE_READ].mq_map;
+		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT];
+	} else if (nvme_tcp_poll_queue(queue)) {
+		mq_map = set->map[HCTX_TYPE_POLL].mq_map;
 		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
-				ctrl->io_queues[HCTX_TYPE_READ] - 1;
+				ctrl->io_queues[HCTX_TYPE_READ];
+	}
 	if (wq_unbound)
 		queue->io_cpu = WORK_CPU_UNBOUND;
-	else
+	else if (wq_affinity) {
+		int i;
+
+		if (WARN_ON(!mq_map))
+			return;
+		for_each_cpu(i, cpu_online_mask) {
+			if (mq_map[i] == qid) {
+				queue->io_cpu = i;
+				break;
+			}
+		}
+	} else
 		queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
+
+	dev_dbg(ctrl->ctrl.device, "queue %d: using cpu %d\n",
+		qid, queue->io_cpu);
 }
 
 static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
@@ -1704,7 +1731,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	queue->sock->sk->sk_allocation = GFP_ATOMIC;
 	queue->sock->sk->sk_use_task_frag = false;
-	nvme_tcp_set_queue_io_cpu(queue);
+	queue->io_cpu = WORK_CPU_UNBOUND;
 	queue->request = NULL;
 	queue->data_remaining = 0;
 	queue->ddgst_remaining = 0;
@@ -1858,9 +1885,10 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	nvme_tcp_init_recv_ctx(queue);
 	nvme_tcp_setup_sock_ops(queue);
 
-	if (idx)
+	if (idx) {
+		nvme_tcp_set_queue_io_cpu(queue);
 		ret = nvmf_connect_io_queue(nctrl, idx);
-	else
+	} else
 		ret = nvmf_connect_admin_queue(nctrl);
 
 	if (!ret) {
@@ -2837,8 +2865,13 @@ static int __init nvme_tcp_init_module(void)
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_icresp_pdu) != 128);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_term_pdu) != 24);
 
-	if (wq_unbound)
+	if (wq_unbound) {
+		if (wq_affinity) {
+			pr_err("cannot specify both 'wq_unbound' and 'wq_affinity'\n");
+			return -EINVAL;
+		}
 		wq_flags |= WQ_UNBOUND;
+	}
 
 	nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq", wq_flags, 0);
 	if (!nvme_tcp_wq)
-- 
2.35.3


