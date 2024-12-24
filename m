Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA8AE77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 12:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Gj+smE3CmMtTamKLc5DQkdQAO/UNg3c1r6eWKCZ/TLc=; b=dkoNUwQ3l+IN6f
	xecbOBkqnr2tOO3IgNzYItOz5QcLX07nh/TC2cOC5udvuhwrntHnpqWqmjzN1y11YQuYSCM+3IGFM
	eZLPMXHnGtae1PsDZ8ftw6c5jVwYkwBVjcUkaQ6RWPyS5REb8SUGxn4cNdR8nFjVDWgN891h5Z8sm
	bqXzX2BR+D6paJ4JGs10wprflxTjVGXSfYjP4gRzCIyFV9rBCVkqxJRcnkJpZ7tPmla8t6Z+c/9sk
	gCQNv/yOm7jGWnTO1nBmOu5nDqIujA9D2pAcXWlTylvH4Z/GuQndMQD6yDOXE7FbwsS7N5+vNk7pu
	CZYuvAm9fd+rjY1VSZmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ3ep-0000000BunT-1qzV;
	Tue, 24 Dec 2024 12:05:03 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ3en-0000000Bumn-1P5h
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 12:05:02 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso50062845e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 04:05:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735041899; x=1735646699;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj+smE3CmMtTamKLc5DQkdQAO/UNg3c1r6eWKCZ/TLc=;
        b=S7NL1jqddxjBgfZ+WVbpV0NdwX18RSAQbW5m4xiLJm7az9YbitdcZrnQ/l/ANfLut8
         shRgZ/JMfB7SgoqPnkujweoP/FhxgXajOo0HjZLUsecLPtgDvPbEXGwFmmqNF2KHE4Ox
         3dhAP2TfV2DIWkLSnomGLNqBfCveD722r2W8mFInU2ojiLQOjF43pDXtvj/lm82Ivbvv
         EWT6Gvsf6WcgEqWO468mQiQfOLIaeDQrhHPjNMEV90f46sk30mbxnAvTciM8/x43bC+f
         VsOnlkUN1Fu1+i/8WtG0DBf9Y+JvCKrtZYBAN/NPpvn4wVivnrFLLP9eAhB49q7xWuWA
         Clww==
X-Gm-Message-State: AOJu0Ywiab7jx+HypQUDUFebAri+TVrCLUZVN/5LxV9NSRQpGZMuVPXv
	atn94gn1Sjj5HMDmJ5FSkYsT9gjoVFvcvlaoncTJ6VHGx8FQ3mBX1JJRIw==
X-Gm-Gg: ASbGncvKMW42D9njlFmv+tOJOyo4fclS/aQFUnXr9CCl1z3sx1JaG/mBz9uIWN4Jyj3
	FmqzlAf0i+JQnT9U2v6H48foOBGSY0XW2aOEmecvBQ3/mW5OomoW0cliTosSbZ9wN6b8G/pDY+j
	CnJNKZ3Y0SBXQCmRE18WdbnsHOoTW9tOP6RedTqJfDHwBP5YBf7WgIemEWYv0ERc0W7rRvFrqIX
	H8vOUlXfC+cLU63zIhEifbkPHGK0ufSPcMSLL5IbENAHPxTkjhcETzDQZkUqOzVl56nR/YvLkNy
	C5NQ1OLDqwZ7x9REbU4KSUHBkAYXruUynrzu7nUqmuRQ
X-Google-Smtp-Source: AGHT+IGKP8o2OvxjQrHIEF6arojtKe9KzD1sdnCRQLstuTKfByB/JmfbXsVK/7kJB68IS8QfvVpEdw==
X-Received: by 2002:a05:600c:3b86:b0:435:21a1:b109 with SMTP id 5b1f17b1804b1-43668452e59mr127777895e9.2.1735041899331;
        Tue, 24 Dec 2024 04:04:59 -0800 (PST)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847dabsm13835477f8f.59.2024.12.24.04.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 04:04:58 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme-tcp: Fix I/O queue cpu spreading for multiple controllers
Date: Tue, 24 Dec 2024 14:04:57 +0200
Message-ID: <20241224120457.576100-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_040501_383776_E2AC0FAA 
X-CRM114-Status: GOOD (  24.36  )
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
Reply-To: sagi@grimberg.me
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Since day-1 we are assigning the queue io_cpu very naively. We always
base the queue id (controller scope) and assign it its matching cpu
from the online mask. This works fine when the number of queues match
the number of cpu cores.

The problem starts when we have less queues than cpu cores. First, we
should take into account the mq_map and select a cpu within the cpus
that are assigned to this queue by the mq_map in order to minimize cross
numa cpu bouncing.

Second, even worse is that we don't take into account multiple controllers
may have assigned queues to a given cpu. As a result we may simply compund
more and more queues on the same set of cpus, which is suboptimal.

We fix this by introducing a global per-cpu counters that tracks the number
of queues assigned to each cpu, and we select the least used cpu based
on the mq_map and the per-cpu counters, and assign it as the queue io_cpu.

The behavior for a single controller is slightly optimized by selecting
better cpu candidates by consulting with the mq_map, and multiple controllers
are spreading queues among cpu cores much better, resulting in lower average
cpu load, and less likelihood to hit hotspots.

Note that the accounting is not 100% perfect, but we don't need to be, we
are simply putting our best effort to select the best cpu candidate that
we find at any given point.

Another byproduct is that every controller reset/reconnect may change the
queues io_cpu mapping, based on the current LRU accounting scheme.

Here is the baseline queue io_cpu assignment for 4 controllers, 2 queues
per controller, and 4 cpus on the host:
nvme1: queue 0: using cpu 0
nvme1: queue 1: using cpu 1
nvme2: queue 0: using cpu 0
nvme2: queue 1: using cpu 1
nvme3: queue 0: using cpu 0
nvme3: queue 1: using cpu 1
nvme4: queue 0: using cpu 0
nvme4: queue 1: using cpu 1

And this is the fixed io_cpu assignment:
nvme1: queue 0: using cpu 0
nvme1: queue 1: using cpu 2
nvme2: queue 0: using cpu 1
nvme2: queue 1: using cpu 3
nvme3: queue 0: using cpu 0
nvme3: queue 1: using cpu 2
nvme4: queue 0: using cpu 1
nvme4: queue 1: using cpu 3

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Suggested-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 69 ++++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 28c76a3e1bd2..06ffee8cbf51 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -54,6 +54,8 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 		 "nvme TLS handshake timeout in seconds (default 10)");
 #endif
 
+static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /* lockdep can detect a circular dependency of the form
  *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
@@ -127,6 +129,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_ALLOCATED	= 0,
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
+	NVME_TCP_Q_IO_CPU_SET	= 3,
 };
 
 enum nvme_tcp_recv_state {
@@ -1565,20 +1568,48 @@ static bool nvme_tcp_poll_queue(struct nvme_tcp_queue *queue)
 static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
-	int qid = nvme_tcp_queue_id(queue);
-	int n = 0;
+	struct blk_mq_tag_set *set = &ctrl->tag_set;
+	int qid = nvme_tcp_queue_id(queue) - 1;
+	unsigned int *mq_map;
+	int cpu, n = 0, min_queues = INT_MAX, io_cpu;
 
-	if (nvme_tcp_default_queue(queue))
-		n = qid - 1;
-	else if (nvme_tcp_read_queue(queue))
-		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] - 1;
-	else if (nvme_tcp_poll_queue(queue))
-		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
-				ctrl->io_queues[HCTX_TYPE_READ] - 1;
 	if (wq_unbound)
-		queue->io_cpu = WORK_CPU_UNBOUND;
-	else
-		queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
+		goto out;
+
+	if (nvme_tcp_default_queue(queue)) {
+		mq_map = set->map[HCTX_TYPE_DEFAULT].mq_map;
+		n = qid;
+	} else if (nvme_tcp_read_queue(queue)) {
+		mq_map = set->map[HCTX_TYPE_READ].mq_map;
+		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT];
+	} else if (nvme_tcp_poll_queue(queue)) {
+		mq_map = set->map[HCTX_TYPE_POLL].mq_map;
+		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
+				ctrl->io_queues[HCTX_TYPE_READ];
+	}
+	if (WARN_ON(!mq_map))
+		goto out;
+
+	/* Search for the least used cpu from the mq_map */
+	io_cpu = WORK_CPU_UNBOUND;
+	for_each_online_cpu(cpu) {
+		int num_queues = atomic_read(&nvme_tcp_cpu_queues[cpu]);
+
+		if (mq_map[cpu] != qid)
+			continue;
+		if (num_queues < min_queues) {
+			io_cpu = cpu;
+			min_queues = num_queues;
+		}
+	}
+	if (io_cpu != WORK_CPU_UNBOUND) {
+		queue->io_cpu = io_cpu;
+		atomic_inc(&nvme_tcp_cpu_queues[io_cpu]);
+		set_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags);
+	}
+out:
+	dev_dbg(ctrl->ctrl.device, "queue %d: using cpu %d\n",
+		qid, queue->io_cpu);
 }
 
 static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
@@ -1722,7 +1753,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	queue->sock->sk->sk_allocation = GFP_ATOMIC;
 	queue->sock->sk->sk_use_task_frag = false;
-	nvme_tcp_set_queue_io_cpu(queue);
+	queue->io_cpu = WORK_CPU_UNBOUND;
 	queue->request = NULL;
 	queue->data_remaining = 0;
 	queue->ddgst_remaining = 0;
@@ -1844,6 +1875,9 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
 		return;
 
+	if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags))
+		atomic_dec(&nvme_tcp_cpu_queues[queue->io_cpu]);
+
 	mutex_lock(&queue->queue_lock);
 	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
 		__nvme_tcp_stop_queue(queue);
@@ -1878,9 +1912,10 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
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
@@ -2849,6 +2884,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 static int __init nvme_tcp_init_module(void)
 {
 	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
+	int cpu;
 
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
@@ -2866,6 +2902,9 @@ static int __init nvme_tcp_init_module(void)
 	if (!nvme_tcp_wq)
 		return -ENOMEM;
 
+	for_each_possible_cpu(cpu)
+		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
+
 	nvmf_register_transport(&nvme_tcp_transport);
 	return 0;
 }
-- 
2.43.0


