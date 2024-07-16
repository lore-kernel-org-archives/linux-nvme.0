Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FB1C3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jul 2024 07:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ui8QxtDEir7w1oXKgkKThvVLf5pFPAQJ5jpVtqdJo10=; b=M1EwX4nBP8E/e99zEBQSXaJqA1
	x67jd7LNdyGyZeEuu71L7iBBaYGcuTSkHKNgL+s3lNe/FxEAqYguQHBb2AgECyhc8CtLZy99s6MDu
	+fwAcO38XO15jDKIZBCE6f+7YlrdNxpp6hc9I/rhElv0CSLfTxw5Ctttb8U6US0+/WOrNBHfi+jZi
	JH6PTwyPCe1EnjKPZmPo2dpnYACi1mkwhw8w2kBd/uRgoD9APbjq7peItnngAdvJCzFygaU0eUQYV
	VlA2j0L8eCYTq/DNepqMjP//XpbVtF8TCBYvPY/Beg5/K8hqQbXzX8p7BXweGwB8y6gDW2hP1DtCd
	r9nhahSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTck8-00000009cAV-1Hci;
	Tue, 16 Jul 2024 07:37:00 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTcjw-00000009bxw-1MqI
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jul 2024 07:36:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 89C2FCE1049;
	Tue, 16 Jul 2024 07:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE437C4AF0B;
	Tue, 16 Jul 2024 07:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721115406;
	bh=bedHyAjeTB44KGBBDAOItbMc+FGFdh6YdvIp3H667w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JzRJO/UrZ0G0yjK1iimkAtCnNq2yZc40bNvd2or3/w3tYAUWkuZROx2Bk0ZeQn2xF
	 q8YKqmUz9iSza6xUFd4ecGTercvoEycPa4o1DQOVlWWQXCClr/75ke3ic9XerXcJxA
	 EQiywDVXDRcUXxjdZEqNVl5YnbN5/sAihUxQLdaKwE5JiS6sNN/94vXpMDWW1GtOKX
	 vLB+mdFsmS8OpMhjG77jn0a5DDS6dET9ceqgJH5oE9kE+p00CokDJZ8QfYY4C+wM3S
	 4O4vCiN4bctFHahogyVTrHv7jkUPkQIpta+S48APB5diA9y++3CGLEzCXV53wS0a0L
	 V0Q6NbvbYWh8w==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 8/8] nvme-tcp: align I/O cpu with blk-mq mapping
Date: Tue, 16 Jul 2024 09:36:16 +0200
Message-Id: <20240716073616.84417-9-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240716073616.84417-1-hare@kernel.org>
References: <20240716073616.84417-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_003648_907347_D59A00A6 
X-CRM114-Status: GOOD (  18.46  )
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

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 65 +++++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index f3a94168b2c3..a391a3f7c4d7 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -28,6 +28,8 @@
 
 struct nvme_tcp_queue;
 
+static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
+
 /* Define the socket priority to use for connections were it is desirable
  * that the NIC consider performing optimized packet processing or filtering.
  * A non-zero value being sufficient to indicate general consideration of any
@@ -1799,20 +1801,42 @@ static bool nvme_tcp_poll_queue(struct nvme_tcp_queue *queue)
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
@@ -1957,7 +1981,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	queue->sock->sk->sk_allocation = GFP_ATOMIC;
 	queue->sock->sk->sk_use_task_frag = false;
-	nvme_tcp_set_queue_io_cpu(queue);
+	queue->io_cpu = WORK_CPU_UNBOUND;
 	queue->request = NULL;
 	queue->data_remaining = 0;
 	queue->ddgst_remaining = 0;
@@ -2088,6 +2112,10 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	nvme_tcp_restore_sock_ops(queue);
 	cancel_work_sync(&queue->io_work);
+	if (queue->io_cpu != WORK_CPU_UNBOUND) {
+		atomic_dec(&nvme_tcp_cpu_queues[queue->io_cpu]);
+		queue->io_cpu = WORK_CPU_UNBOUND;
+	}
 }
 
 static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
@@ -2133,9 +2161,10 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
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
@@ -3179,6 +3208,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 static int __init nvme_tcp_init_module(void)
 {
 	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
+	int cpu;
 
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
@@ -3200,6 +3230,9 @@ static int __init nvme_tcp_init_module(void)
 	if (!nvme_tcp_debugfs)
 		return -ENOMEM;
 
+	for_each_possible_cpu(cpu)
+		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
+
 	nvmf_register_transport(&nvme_tcp_transport);
 	return 0;
 }
-- 
2.35.3


