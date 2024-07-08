Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8B9C3271E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jul 2024 07:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ky272Mu6APIVU7p6StDak0WAT46BAjM8edLu3zp/u2A=; b=oHuVFykQ+WKmqfc6Rqn4ssrPxB
	pj1TypcOt/TVzgPeBY29EztmLp7k4Xs8UvwovPBWRJyEpFua3KQrWZ6g1Px+tQpjMoh6K4sdpb82v
	R9HfEH/VBsY6tpccC0wdHNnRnnvyB87mMY1EzPJW3QSdUyJndudjyD6pGDLRKn3xH4wQBKa/LPPvX
	MzOJoLQFN1NRT/hJyvGT3CLOq0BT0FDlcWpMKDwEVNdJbc6x+CLIwKD4k9UVxfkXD3Ypl92d0b8dJ
	6zG7XfbvyOpbe60cjh1YsSBQzvRGGV2AGMNnfE8MEtpTcqFNDkzedq/wt6qVEAkh9OAB93HJMkW1m
	YbAJBUaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQiW8-00000002z7M-0xL5;
	Mon, 08 Jul 2024 07:10:32 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQiW0-00000002z54-2FZM
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jul 2024 07:10:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0797B60A4A;
	Mon,  8 Jul 2024 07:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DE3C116B1;
	Mon,  8 Jul 2024 07:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720422622;
	bh=v5NVuCxZi6V7OINDgwT3akpSlLZqQkn2Bn26p3884Bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r257pfA9qmidLvdXoH86zv+utrl5tOPxHFeox7ZfVgUNHhK+5IU5yc+C8A9gWB1it
	 GsgO71D4jMjjKYZKM899TNrbDYSt/s8Nsh8MftF9x22UldhdUfKr/iOgfOoZbnyxWM
	 3sLsuRRqaZC0TS+JjNZE7Mnu68hw/5+iJKMsubywboWXTD/UEjF6Nzky+uVoIDpZQz
	 plOJu7B2jkyYOH7BaQrRmYJ7Nso/IqDIUDDqXVSu65aAY2gBTD2euTnPiSekLxdMK1
	 RYg3a6haCO3ZKY6hRzrQEwO3HzepArhVF/M2xukVS0+BDGkIpsVgp1bfrKMaNG5Cmq
	 4vAxULKqP5Hvg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/3] nvme-tcp: align I/O cpu with blk-mq mapping
Date: Mon,  8 Jul 2024 09:10:12 +0200
Message-Id: <20240708071013.69984-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240708071013.69984-1-hare@kernel.org>
References: <20240708071013.69984-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_001024_732930_8CEFBC37 
X-CRM114-Status: GOOD (  19.09  )
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

We should align the 'io_cpu' setting with the blk-mq
cpu mapping to ensure that we're not bouncing threads
when doing I/O. To avoid cpu contention this patch also
adds an atomic counter for the number of queues on each
cpu to distribute the load across all CPUs in the blk-mq cpu set.
Additionally we should always set the 'io_cpu' value, as
in the WQ_UNBOUND case it'll be treated as a hint anyway.

Performance comparison:
               baseline rx/tx    blk-mq align
4k seq write:  449MiB/s 480MiB/s 524MiB/s
4k rand write: 410MiB/s 481MiB/s 524MiB/s
4k seq read:   478MiB/s 481MiB/s 566MiB/s
4k rand read:  547MiB/s 480MiB/s 511MiB/s

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 65 +++++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index f621d3ba89b2..a5c42a7b4bee 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -26,6 +26,8 @@
 
 struct nvme_tcp_queue;
 
+static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
+
 /* Define the socket priority to use for connections were it is desirable
  * that the NIC consider performing optimized packet processing or filtering.
  * A non-zero value being sufficient to indicate general consideration of any
@@ -1578,20 +1580,42 @@ static bool nvme_tcp_poll_queue(struct nvme_tcp_queue *queue)
 static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
-	int qid = nvme_tcp_queue_id(queue);
-	int n = 0;
-
-	if (nvme_tcp_default_queue(queue))
-		n = qid - 1;
-	else if (nvme_tcp_read_queue(queue))
-		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] - 1;
-	else if (nvme_tcp_poll_queue(queue))
+	struct blk_mq_tag_set *set = &ctrl->tag_set;
+	int qid = nvme_tcp_queue_id(queue) - 1;
+	unsigned int *mq_map = NULL;;
+	int n = 0, cpu, io_cpu, min_queues = WORK_CPU_UNBOUND;
+
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
-	if (wq_unbound)
-		queue->io_cpu = WORK_CPU_UNBOUND;
-	else
-		queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
+				ctrl->io_queues[HCTX_TYPE_READ];
+	}
+
+	if (WARN_ON(!mq_map))
+		return;
+	for_each_online_cpu(cpu) {
+		int num_queues;
+
+		if (mq_map[cpu] != qid)
+			continue;
+		num_queues = atomic_read(&nvme_tcp_cpu_queues[cpu]);
+		if (num_queues < min_queues) {
+			min_queues = num_queues;
+			io_cpu = cpu;
+		}
+	}
+	if (io_cpu != queue->io_cpu) {
+		queue->io_cpu = io_cpu;
+		atomic_inc(&nvme_tcp_cpu_queues[io_cpu]);
+	}
+	dev_dbg(ctrl->ctrl.device, "queue %d: using cpu %d\n",
+		qid, queue->io_cpu);
 }
 
 static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
@@ -1735,7 +1759,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	queue->sock->sk->sk_allocation = GFP_ATOMIC;
 	queue->sock->sk->sk_use_task_frag = false;
-	nvme_tcp_set_queue_io_cpu(queue);
+	queue->io_cpu = WORK_CPU_UNBOUND;
 	queue->request = NULL;
 	queue->data_remaining = 0;
 	queue->ddgst_remaining = 0;
@@ -1847,6 +1871,10 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	nvme_tcp_restore_sock_ops(queue);
 	cancel_work_sync(&queue->io_work);
+	if (queue->io_cpu != WORK_CPU_UNBOUND) {
+		atomic_dec(&nvme_tcp_cpu_queues[queue->io_cpu]);
+		queue->io_cpu = WORK_CPU_UNBOUND;
+	}
 }
 
 static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
@@ -1891,9 +1919,10 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
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
@@ -2920,6 +2949,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 static int __init nvme_tcp_init_module(void)
 {
 	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
+	int cpu;
 
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
@@ -2937,6 +2967,9 @@ static int __init nvme_tcp_init_module(void)
 	if (!nvme_tcp_wq)
 		return -ENOMEM;
 
+	for_each_possible_cpu(cpu)
+		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
+
 	nvmf_register_transport(&nvme_tcp_transport);
 	return 0;
 }
-- 
2.35.3


