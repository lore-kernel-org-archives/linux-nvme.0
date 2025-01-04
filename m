Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38C8E77188
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jan 2025 21:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ck2CIPNzGJpOL8PHt6be7M3vNLJ6mt9FbNxFAE57xJc=; b=cpI0vpamcLl1ak
	eXWQ/8GvvHSh22pXEgvqPvV4IBr8qZ6JvKMG3zGxogU1KqLQlnLW5Sk+QFCK8xNO125+iDPRoL7/8
	SSKti+NJ1EKZr0dLwiaVIkLoaair3UtShYeaYyTYliG5/CgJCFiGjpOn/cSUSxusni6Yr7K5H+YWg
	FRRBQJKfg5vhGRD+PTSsUxHXpPa3QLmncEPVjG7f0egfvlP5IOcTr/hjy6n3mYAhEl5wIyeQXtaPX
	Ss+KHWhKhDXk2KGLnvbgcYK6U0ZYABrKsFBp0rH/2w4YHs6bu6UvaSPakP47a+ApxLKRjIX2cqf07
	dFj/BOZKEV3X2iP2KyXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUBfy-0000000Fdo5-3mqp;
	Sat, 04 Jan 2025 21:27:18 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUBfw-0000000Fdnh-26oF
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jan 2025 21:27:18 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38634c35129so10085615f8f.3
        for <linux-nvme@lists.infradead.org>; Sat, 04 Jan 2025 13:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736026034; x=1736630834;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck2CIPNzGJpOL8PHt6be7M3vNLJ6mt9FbNxFAE57xJc=;
        b=a0ZVnl/I/dYrqj6PtvJdp5KM3PoAT9uvDXqPZg/I8g2Aqk8jrtZzxd+ilLkUEpPjOg
         vFHbY3C+aWqhTbZThm5CAB5BoumA/Tj0oCL2zuY5caAp1/x5J5NVEN1ldw41o5luM0N2
         MCKNjJMLeejHnLYa7W8s5a4RpWeW/Gi8ScELtxjIoGZDQOchyaS1gccZ3eo5t6VRQoAn
         TqCmvc+YwNHbGB2HOgwIyLZ+Iva9hlpfznLDfWLGaNQoy+ekpr0pyBALBy89hrGk1xJF
         JyiMn353OG8uGfhE2soFP2Ppo9j3F/oiPPycur5UOjy/ThpqYKKXRe2ltpS0ek+P6qTe
         XZUA==
X-Gm-Message-State: AOJu0YwnsIBtUxpLZmSYYJKMSsLCaFW/J9L3Wsehx45bW1Wsb1kMVxyl
	fFseKnhzXJv8JQ93zo6Iq/vYSGH3El4SqJ4ETOTz2CTskwFyW3dK+VgVRw==
X-Gm-Gg: ASbGnctJVm4k6CL72m9IW9rc4fpgaqE1p6MN7rixHX7lMraQW6YIGd0AYt6BU93jVLW
	KZOC5b49IT8PZ5xgH/CU32+Khr2/nWIq3ctdW4Qa19RwjowVwR+rZ4HyovJ3EuKgSNTtlxB+1Ow
	igG9oMCYRVyiadOpgYmNpOJoQuq7bXoxb+XtqfOW6CbDF/RbyYw3ONy0e5mYOO4wtx2jG+XiG0g
	acBR9hwuus8q+inFXXmbUsh8tT7JdFkfnwIuaaiphNNLk1J1ccb3QQkGPQKb0KQ9rJ3Ta6PFjln
	VpR6H2I4IZkygrcizb9j0PLVrE/jXXEX/eYk
X-Google-Smtp-Source: AGHT+IHNmPLsLY0c/s5mHkZg6lJt4hrhfTAqXpJEo09/0aGxk8+5s8BXuyurUyV3MIG3Gyr9mQqydQ==
X-Received: by 2002:a05:6000:1fae:b0:385:df43:2179 with SMTP id ffacd0b85a97d-38a221eaf62mr45659393f8f.17.1736026033394;
        Sat, 04 Jan 2025 13:27:13 -0800 (PST)
Received: from vastdata-ubuntu2.vstd.int (CBL217-132-142-53.bb.netvision.net.il. [217.132.142.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8472b3sm43907890f8f.58.2025.01.04.13.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 13:27:12 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2] nvme-tcp: Fix I/O queue cpu spreading for multiple controllers
Date: Sat,  4 Jan 2025 23:27:11 +0200
Message-ID: <20250104212711.37779-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250104_132716_666958_450CEF33 
X-CRM114-Status: GOOD (  25.13  )
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

Second, even worse is that we don't take into account multiple
controllers may have assigned queues to a given cpu. As a result we may
simply compund more and more queues on the same set of cpus, which is
suboptimal.

We fix this by introducing global per-cpu counters that tracks the
number of queues assigned to each cpu, and we select the least used cpu
based on the mq_map and the per-cpu counters, and assign it as the queue
io_cpu.

The behavior for a single controller is slightly optimized by selecting
better cpu candidates by consulting with the mq_map, and multiple
controllers are spreading queues among cpu cores much better, resulting
in lower average cpu load, and less likelihood to hit hotspots.

Note that the accounting is not 100% perfect, but we don't need to be,
we're simply putting our best effort to select the best candidate cpu
core that we find at any given point.

Another byproduct is that every controller reset/reconnect may change
the queues io_cpu mapping, based on the current LRU accounting scheme.

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
Changes from v1:
- change log fixes
- add code comment to explain what nvme_tcp_set_queue_io_cpu is
  trying to do

 drivers/nvme/host/tcp.c | 78 +++++++++++++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b127d41dbbfe..0abe39ba0f85 100644
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
@@ -1562,23 +1565,60 @@ static bool nvme_tcp_poll_queue(struct nvme_tcp_queue *queue)
 			  ctrl->io_queues[HCTX_TYPE_POLL];
 }
 
+/**
+ * Track the number of queues assigned to each cpu using a global per-cpu
+ * counter and select the least used cpu from the mq_map. Our goal is to spread
+ * different controllers I/O threads across different cpu cores.
+ *
+ * Note that the accounting is not 100% perfect, but we don't need to be, we're
+ * simply putting our best effort to select the best candidate cpu core that we
+ * find at any given point.
+ */
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
@@ -1722,7 +1762,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	queue->sock->sk->sk_allocation = GFP_ATOMIC;
 	queue->sock->sk->sk_use_task_frag = false;
-	nvme_tcp_set_queue_io_cpu(queue);
+	queue->io_cpu = WORK_CPU_UNBOUND;
 	queue->request = NULL;
 	queue->data_remaining = 0;
 	queue->ddgst_remaining = 0;
@@ -1844,6 +1884,9 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
 		return;
 
+	if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags))
+		atomic_dec(&nvme_tcp_cpu_queues[queue->io_cpu]);
+
 	mutex_lock(&queue->queue_lock);
 	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
 		__nvme_tcp_stop_queue(queue);
@@ -1878,9 +1921,10 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
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
@@ -2845,6 +2889,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 static int __init nvme_tcp_init_module(void)
 {
 	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
+	int cpu;
 
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
@@ -2862,6 +2907,9 @@ static int __init nvme_tcp_init_module(void)
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


