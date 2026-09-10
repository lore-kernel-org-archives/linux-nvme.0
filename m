Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1460C88E42
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 20:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=45lPbm0J/mESc8mxYG8Q+81MuxbcOW2zJuqMUPNJZwM=; b=ojWmALhR/QZ+d2O650yI9xFg7Q
	lQiaq3UwGkQ1ykmx9OBGf1AEEcnPPGOM9X6HvYiPLo4ha9PoeTUGmmXroGVwB3p9lmCoAUHdKbDcv
	yf2AT434ToHJlwXRSVsAvxXqqRcQvSVfsn+/BYOfD1s1vSxyJB+8/QtXK3+KE9G1vrbDn2DPbW97e
	ndBLcBxf5VujvphMBjsQPC6NhV0AvtsJTwGSXNls0vfDwlljClzbsDcj/64QV5Y33ZwFrToUyFR7h
	b6NnmWyhVwlJSai0NALoNweqwJX54s2csCtorp9Uz8Eo24ncXvTUjwh/iGeeiEcxKRlFEADxBrEcj
	reF6wXTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4lOR-0000000FKop-1Lgj;
	Thu, 10 Sep 2026 20:29:11 +0000
Received: from mail-ua1-x964.google.com ([2607:f8b0:4864:20::964])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4lOO-0000000FKmr-06F9
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 20:29:09 +0000
Received: by mail-ua1-x964.google.com with SMTP id a1e0cc1a2514c-97e9fb0fc58so122597241.1
        for <linux-nvme@lists.infradead.org>; Thu, 10 Sep 2026 13:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789072147; x=1789676947; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=45lPbm0J/mESc8mxYG8Q+81MuxbcOW2zJuqMUPNJZwM=;
        b=cF4tW6vj7OpK3l/hyZ5o0ldl240mZPkCLuGNOP66W5Yz6E2mQ8Ng1KY09ROBqOif20
         2igjloTMXn1BY2r5BVJxZQO/tMnluSNCoNe1uJAIhdLpaWalX+houWwFN1+dox2REX2x
         yJAlFyWHJBTX7d7x8Wshlwgj0qI+Y6hCLURg3ds1wqV0Gan5w+BYNL0x+JYX1LwOdjI0
         TA9HdwGpyPWicoLAUINPC7D+y2hK5hJhHR64r8URS07zYwYCzu3fz6StGbfBwXu0bp2C
         HY+vuWnDAlDWwQnpZEla8OiN8yYEXVX1pW/tUbpq+hEFZv3FeHDPgwBbdExMRyHPewO3
         Ba9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789072147; x=1789676947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=45lPbm0J/mESc8mxYG8Q+81MuxbcOW2zJuqMUPNJZwM=;
        b=p2IosG0SQCmDI8aa8syR3/udFYQse2Xm3ItAHTKwgwI3gHpYRaMJmdEFdniQ51KEOq
         NlU2bjOqLK7QDEvuZgasQP+uDt0qWahGoVF4/Ll+JWUeDWhQHiSWaAibM9yIDsfqXoI7
         Uiy7w51GEJ1v/Y0wGdjtorcBDgG+jUiJ5BoL4vVsLKHDMZSe6ANRVSt1b0C+4hgGF2nX
         ot0AIwuUOrVGQCbAwWpmqpmZzDJ4RQIwGWkLux9dLWLUl4sH4UHaCMX0e0dml4RyiOZD
         ko6JSZ7gfTlQptx1vPUV+4gvozULJDqRVL07PywkLYkuAdNJzEYKusU3fXuwLmvm6hsu
         z/Kg==
X-Forwarded-Encrypted: i=1; AKwUvBwc3bkxpymUGc9drdupJeGjJT2B1uJ++AiYkzSjQ2Hk6CpYmQQddLMZ1Bd87F4vQluH8+SkCECPeFP+@lists.infradead.org
X-Gm-Message-State: AFuF++kks/emyVS82jlLBYVxh/5nU4I4NS1swQqZDg1SzIGdRNyCVlYa
	UVtkEYPkLtTblTP3VXaIQ8jomUbLGykMWVTwDAv+Oa2dYErSw01rJhqpuMNTcp/ZJix32OqlkeN
	ERcu4pGwM2o0luS7XvERYIuYtqa2O0tBYI/n2ik9BQJgulJ2/Xl6v
X-Gm-Gg: AYBFou22VBBe0WopGViQc7hZmZoIFnKgw79JskUyVm4T3D0H/jPZOoehbYYawDuU0Hn
	jmhIQPOG2SDfAblzV0SDLI2Q+pVBaDO0jF3HnRxGie/j4WwxY8bIG/c4DYSsXYT+emK/DcirNnz
	azhkDHcFYLzSdBksmPc+oO8WXpRDaMjNBbMVGEVtYLHsWZmrKZlQhOX91UkvZas9iCEco34I7Gj
	VZY0Lo32xfnwB4cJKroP3siuqY7KiTAfxUfFuJ1LxoCMT0LhP+exjeP7yIaiKETBnyi8rrMEyiV
	QGLfFDvPweczUthL4AK/YNG+X3xF5LZkQe7CxT9Q6rGFX/FBdtIDDt2gRC/A3pOJWHlZcuShtag
	IKVpIw0gtp5TxXgiI
X-Received: by 2002:a05:6102:61cd:20b0:780:c715:292a with SMTP id ada2fe7eead31-792aaa6154cmr1361188137.13.1789072146598;
        Thu, 10 Sep 2026 13:29:06 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-982b9c9e3cesm142178241.6.2026.09.10.13.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:29:06 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (dev-sgogte.dev.purestorage.com [10.112.19.91])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 1D799400F1;
	Thu, 10 Sep 2026 14:29:06 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id 1A11E51EC2; Thu, 10 Sep 2026 14:29:06 -0600 (MDT)
From: Surabhi Gogte <sgogte@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Solganik Alexander <sashas@lightbitslabs.com>,
	Roy Shterman <roys@lightbitslabs.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com,
	randyj@purestorage.com,
	adailey@purestorage.com,
	Surabhi Gogte <sgogte@purestorage.com>
Subject: [PATCH v3 3/3] nvme-tcp: parallelize I/O queue allocation and startup
Date: Thu, 10 Sep 2026 14:28:12 -0600
Message-ID: <20260910202812.1642832-4-sgogte@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910202812.1642832-1-sgogte@purestorage.com>
References: <20260910202812.1642832-1-sgogte@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_132908_097658_EE32EBBD 
X-CRM114-Status: GOOD (  27.78  )
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

Similar to commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue
allocation and startup"), refactor nvme tcp I/O queue setup to use async
API, combining allocation and startup into a single parallel operation
per queue. This reduces connection and reconnection setup time when
there are delays in establishing connections, which is especially
important for high-core-count hosts.

Key changes:
- Use async API to facilitate parallel calls for io queue setup.
- Add nvme_tcp_queue_setup_ctx for propagating errors from async
  workers.
- Remove nvme_tcp_start_io_queues() and __nvme_tcp_alloc_io_queues();
  their logic is folded into nvme_tcp_setup_io_queues() and
  nvme_tcp_configure_io_queues().
- Allocate the io tag set before the queues so that the queue range is
  known, and only set up the reconnect grow case if the queue count
  actually increased.
- Serialize the cpu scan and claim in nvme_tcp_set_queue_io_cpu() with a
  spinlock, as concurrent callers would otherwise select the same cpu.
  The per-cpu counters no longer need to be atomics.

Testing on a 64-core host with 64 IO-queues shows nvme-tcp connection
time reduced from 61ms to 11ms.

Signed-off-by: Surabhi Gogte <sgogte@purestorage.com>
---
 drivers/nvme/host/tcp.c | 124 +++++++++++++++++++++++++---------------
 1 file changed, 79 insertions(+), 45 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index fe0e581608b4..0fc244e676f9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/async.h>
 #include <linux/err.h>
 #include <linux/crc32.h>
 #include <linux/nvme-tcp.h>
@@ -54,7 +55,8 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 		 "nvme TLS handshake timeout in seconds (default 10)");
 #endif
 
-static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
+static int nvme_tcp_cpu_queues[NR_CPUS];
+static DEFINE_SPINLOCK(nvme_tcp_cpu_queues_lock);
 
 enum nvme_tcp_send_state {
 	NVME_TCP_SEND_CMD_PDU = 0,
@@ -154,6 +156,12 @@ struct nvme_tcp_queue {
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
 static LIST_HEAD_GUARDED(nvme_tcp_ctrl_list, nvme_tcp_ctrl_mutex);
 
+struct nvme_tcp_queue_setup_ctx {
+	struct nvme_ctrl	*ctrl;
+	int			qid;
+	int			*err;
+};
+
 struct nvme_tcp_ctrl {
 	/* read only in the hot path */
 	struct nvme_tcp_queue	*queues;
@@ -1719,9 +1727,10 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 		goto out;
 
 	/* Search for the least used cpu from the mq_map */
+	spin_lock(&nvme_tcp_cpu_queues_lock);
 	io_cpu = WORK_CPU_UNBOUND;
 	for_each_online_cpu(cpu) {
-		int num_queues = atomic_read(&nvme_tcp_cpu_queues[cpu]);
+		int num_queues = nvme_tcp_cpu_queues[cpu];
 
 		if (mq_map[cpu] != qid)
 			continue;
@@ -1732,9 +1741,10 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	}
 	if (io_cpu != WORK_CPU_UNBOUND) {
 		queue->io_cpu = io_cpu;
-		atomic_inc(&nvme_tcp_cpu_queues[io_cpu]);
+		nvme_tcp_cpu_queues[io_cpu]++;
 		set_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags);
 	}
+	spin_unlock(&nvme_tcp_cpu_queues_lock);
 out:
 	dev_dbg(ctrl->ctrl.device, "queue %d: using cpu %d\n",
 		qid, queue->io_cpu);
@@ -2011,8 +2021,11 @@ static void nvme_tcp_stop_queue_nowait(struct nvme_ctrl *nctrl, int qid)
 	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
 		return;
 
-	if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags))
-		atomic_dec(&nvme_tcp_cpu_queues[queue->io_cpu]);
+	if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags)) {
+		spin_lock(&nvme_tcp_cpu_queues_lock);
+		nvme_tcp_cpu_queues[queue->io_cpu]--;
+		spin_unlock(&nvme_tcp_cpu_queues_lock);
+	}
 
 	mutex_lock(&queue->queue_lock);
 	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
@@ -2119,25 +2132,6 @@ static void nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl)
 		nvme_tcp_wait_queue(ctrl, i);
 }
 
-static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl,
-				    int first, int last)
-{
-	int i, ret;
-
-	for (i = first; i < last; i++) {
-		ret = nvme_tcp_start_queue(ctrl, i);
-		if (ret)
-			goto out_stop_queues;
-	}
-
-	return 0;
-
-out_stop_queues:
-	for (i--; i >= first; i--)
-		nvme_tcp_stop_queue(ctrl, i);
-	return ret;
-}
-
 static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 {
 	int ret;
@@ -2198,22 +2192,64 @@ static int nvme_tcp_tls_check_psk(struct nvme_ctrl *ctrl)
 	return 0;
 }
 
-static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
+static void nvme_tcp_setup_queue_async(void *data, async_cookie_t cookie)
 {
-	int i, ret;
+	struct nvme_tcp_queue_setup_ctx *ctx = data;
+	struct nvme_ctrl *ctrl = ctx->ctrl;
+	int ret;
 
-	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = nvme_tcp_alloc_queue(ctrl, i,
-				ctrl->tls_pskid);
-		if (ret)
-			goto out_free_queues;
+	ret = nvme_tcp_alloc_queue(ctrl, ctx->qid, ctrl->tls_pskid);
+	if (ret)
+		goto out_err;
+
+	ret = nvme_tcp_start_queue(ctrl, ctx->qid);
+	if (ret)
+		goto out_err;
+
+	return;
+
+out_err:
+	WRITE_ONCE(*ctx->err, ret);
+}
+
+static int nvme_tcp_setup_io_queues(struct nvme_ctrl *ctrl, unsigned int first,
+		unsigned int last)
+{
+	ASYNC_DOMAIN_EXCLUSIVE(queue_domain);
+	struct nvme_tcp_queue_setup_ctx *ctxs;
+	int nr_queues = last - first;
+	int err = 0, i, ret;
+
+	ctxs = kmalloc_objs(*ctxs, nr_queues);
+	if (!ctxs)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_queues; i++) {
+		ctxs[i].ctrl = ctrl;
+		ctxs[i].qid = first + i;
+		ctxs[i].err = &err;
+		async_schedule_domain(nvme_tcp_setup_queue_async, &ctxs[i],
+				&queue_domain);
 	}
 
+	async_synchronize_full_domain(&queue_domain);
+	kfree(ctxs);
+
+	ret = READ_ONCE(err);
+	if (ret)
+		goto out_free_queues;
+
 	return 0;
 
 out_free_queues:
-	for (i--; i >= 1; i--)
-		nvme_tcp_free_queue(ctrl, i);
+	for (i = first; i < last; i++) {
+		struct nvme_tcp_queue *queue = &to_tcp_ctrl(ctrl)->queues[i];
+
+		if (test_bit(NVME_TCP_Q_LIVE, &queue->flags))
+			nvme_tcp_stop_queue(ctrl, i);
+		if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+			nvme_tcp_free_queue(ctrl, i);
+	}
 
 	return ret;
 }
@@ -2255,10 +2291,6 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 	if (ret)
 		return ret;
 
-	ret = __nvme_tcp_alloc_io_queues(ctrl);
-	if (ret)
-		return ret;
-
 	if (new) {
 		ret = nvme_alloc_io_tag_set(ctrl, &to_tcp_ctrl(ctrl)->tag_set,
 				&nvme_tcp_mq_ops,
@@ -2269,12 +2301,12 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 	}
 
 	/*
-	 * Only start IO queues for which we have allocated the tagset
+	 * Only setup IO queues for which we have allocated the tagset
 	 * and limited it to the available queues. On reconnects, the
 	 * queue number might have changed.
 	 */
 	nr_queues = min(ctrl->tagset->nr_hw_queues + 1, ctrl->queue_count);
-	ret = nvme_tcp_start_io_queues(ctrl, 1, nr_queues);
+	ret = nvme_tcp_setup_io_queues(ctrl, 1, nr_queues);
 	if (ret)
 		goto out_cleanup_connect_q;
 
@@ -2298,12 +2330,14 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 
 	/*
 	 * If the number of queues has increased (reconnect case)
-	 * start all new queues now.
+	 * setup all new queues now.
 	 */
-	ret = nvme_tcp_start_io_queues(ctrl, nr_queues,
-				       ctrl->tagset->nr_hw_queues + 1);
-	if (ret)
-		goto out_wait_freeze_timed_out;
+	if (ctrl->tagset->nr_hw_queues + 1 > nr_queues) {
+		ret = nvme_tcp_setup_io_queues(ctrl, nr_queues,
+				ctrl->tagset->nr_hw_queues + 1);
+		if (ret)
+			goto out_wait_freeze_timed_out;
+	}
 
 	return 0;
 
@@ -3145,7 +3179,7 @@ static int __init nvme_tcp_init_module(void)
 		return -ENOMEM;
 
 	for_each_possible_cpu(cpu)
-		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
+		nvme_tcp_cpu_queues[cpu] = 0;
 
 	nvmf_register_transport(&nvme_tcp_transport);
 	return 0;
-- 
2.55.0


