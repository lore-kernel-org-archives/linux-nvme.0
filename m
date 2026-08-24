Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A174C61CE2
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 22:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Flt4AJoH53V7PC18cjrTqknEHBQul3chjMHlAVE9x8=; b=FH4nPFbLrUlaqt97MNlo6qSnR/
	5VoaZVxcT0h9QrvkkV9g7TDprD2aPNnN4grlcND3SDaG1fYviafKd6+bFMxWgn5XCW+qoqI1v4Wj+
	ANQjAhPBdrzekHt/iSr9I3dELDzR4OqSuSHOHWRHaiE2/gU6B4ukIx9SwsXCkGGXszLvcVXQ8KmHn
	aHWgZsf11Fwj81lewxLqemlPOjWYNgFN1lXvOh4KVSrGzpzr+AFkgriCW7SiDpkyqAfPuTo4pmJHv
	ulXT+McilSBy9mIbyZ6EwHToHzvmW2ii98MW38FcacBzqVoipue0ANyc30G4CBW2MzDytIcmywAs5
	v6dywYJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wydB5-0000000HSD6-32Tc;
	Mon, 24 Aug 2026 22:30:03 +0000
Received: from mail-pj1-x1062.google.com ([2607:f8b0:4864:20::1062])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wydB3-0000000HSBd-37AB
	for linux-nvme@lists.infradead.org;
	Mon, 24 Aug 2026 22:30:02 +0000
Received: by mail-pj1-x1062.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso83485a91.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Aug 2026 15:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787610601; x=1788215401; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Flt4AJoH53V7PC18cjrTqknEHBQul3chjMHlAVE9x8=;
        b=Lxp+HdlDQZTihEqPhfJUc0xE9npu4Hws1psZd49PrxFjvESNolcnu93IzQPPXlZu5a
         tyn8rZNzJilb8NaddGikWoKBw3gqoTsvFy0xKXOtUp3RHuyDj0n3dGfuH789Cu22UG8a
         KzKn8K7dt8osIkwYa8iAQcTHExpcLEXnOLVTZr4azFnMgB7BcFPkemQ5mM59vE81Zxrk
         jWO8ZXxs4wOsr6075gJumQisuNUfzo1O0oRuZiahC8p4bpwFURLuu0f8eui4XA2j8aBt
         5yAHY9f3TJFjbyscWesn1t282CtGCN0p6OWsYQaoOZZqa0ys6Ylj6ZWSEXCYqBe4UdaD
         mjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787610601; x=1788215401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Flt4AJoH53V7PC18cjrTqknEHBQul3chjMHlAVE9x8=;
        b=OI5srLbqxmh4lX88Lj4UYHQUnKz8WfYzfJqexbsfOoYS7Zs0Wea+SMef3XT6fkuvkb
         oubDyTl/HY35Hrt834slqkR+5FvjQqtyygmRDq9wPRqBq+YukGp7Gx+F4M5FhdkvxEdJ
         uqTVkUMhQqycTF5R1oaSEzIIZiGpAkdAhSHu1Y/BF5Hi84ysl0HbeUpUjpMGwaSfGq0r
         fNycDC3zVG+BYp6mPukqOcQjt4pZ+2t4mG0O1JrM2tIcJpNTODaYvcjNwW/hcMOGiv/1
         hMmIWr6XvuRuiNFgO93gszRMRYDZoVvS/dWUYH+qmr1cmSCZJqSSEJsvyKPGcOFp6xxh
         tYnA==
X-Gm-Message-State: AFuF++nO8PxcpadkLB4RpnIOLnY3AcUhsZEkh/yRvUfQtU/oMQbPItQj
	BzbrZ5DCImsMK1Bu+AmaZLP4IDoLO6j75u3qhBFG44H9aHoFkDiHBzvqUEilvXLfsCLoNWv9M3q
	CI8MuVi96lbVEsEbsW+zS8DliUDZcRw0CGaii+6HztiTwZnomjVAC
X-Gm-Gg: AR+sD12vvk76xv9bmOpo3cGLKy3uC49llWW1H6CBXvFm7k7Cgrml0s50sHziwAUfLKl
	4Ll00erDAUWoL25q8304AH8Wffhw8RuLrk/S/1e8pHlZclrwE/Hc6W96Vf9hlDPvp31Bo8x02nK
	sKFNmul9PhBpIhmBTs3S5RftnfAcoNIFhvOI/PYb9O9CvFf+7D5wbJRF6MEBX9z5L2u1A2EtmxG
	jnjup8Ms/d0cI76unxHAglIeO7zi2Da5yUCJkHr7p/jVlzQ9pHiykfQpVnzeo2VAupQwODIlhTq
	ZTfjKdUXqDkl8qiGU406f0dJUXM6ZXieXK8ggHb1WJBWimuTm2SPm6DJ0rRRWq9nmATo7PwImFl
	setM562qyzBeCY2cL
X-Received: by 2002:a17:90a:e70f:b0:381:a766:efcc with SMTP id 98e67ed59e1d1-395df3c6026mr42310272a91.14.1787610600667;
        Mon, 24 Aug 2026 15:30:00 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39645abf830sm386992a91.6.2026.08.24.15.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 15:30:00 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (bond0.slc5-n22m24-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:429])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id F023D402B2;
	Mon, 24 Aug 2026 16:29:59 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id ED70D51D15; Mon, 24 Aug 2026 16:29:59 -0600 (MDT)
From: Surabhi Gogte <sgogte@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com,
	randyj@purestorage.com,
	adailey@purestorage.com,
	Surabhi Gogte <sgogte@purestorage.com>
Subject: [PATCH] nvme-tcp: parallelize I/O queue allocation and startup
Date: Mon, 24 Aug 2026 16:29:39 -0600
Message-ID: <20260824222939.301887-3-sgogte@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824222939.301887-1-sgogte@purestorage.com>
References: <20260824222939.301887-1-sgogte@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_153001_796165_72BF855B 
X-CRM114-Status: GOOD (  28.15  )
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
- Add nvme_tcp_setup_ctx for propagating errors from async workers.
- Remove nvme_tcp_start_io_queues() and __nvme_tcp_alloc_io_queues();
  their logic is folded into nvme_tcp_setup_io_queues() and
  nvme_tcp_configure_io_queues().
- Allocate the io tag set before the queues so that the queue range is
  known, and only set up the reconnect grow case if the queue count
  actually increased.
- Serialize the cpu scan and claim in nvme_tcp_set_queue_io_cpu() with a
  spinlock, as concurrent callers would otherwise select the same cpu.
  The per-cpu counters no longer need to be atomics.
- Use init_net in nvme_tcp_alloc_queue() instead of the namespace of
  current, which is no longer the connecting task once the allocation
  runs from a worker. A controller is not guaranteed to be tied to a
  namespace, as the reconnect and error recovery paths already run from
  a workqueue in init_net.

Testing on a 64-core host with 64 IO-queues shows nvme-tcp connection
time reduced from 61ms to 11ms.

Signed-off-by: Surabhi Gogte <sgogte@purestorage.com>
---
 drivers/nvme/host/tcp.c | 126 +++++++++++++++++++++++++---------------
 1 file changed, 80 insertions(+), 46 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 354668ad29ac..30fe4c5abe0b 100644
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
 
+struct nvme_tcp_setup_ctx {
+	struct nvme_ctrl	*ctrl;
+	int			qid;
+	int			*err;
+};
+
 struct nvme_tcp_ctrl {
 	/* read only in the hot path */
 	struct nvme_tcp_queue	*queues;
@@ -1718,9 +1726,10 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 		goto out;
 
 	/* Search for the least used cpu from the mq_map */
+	spin_lock(&nvme_tcp_cpu_queues_lock);
 	io_cpu = WORK_CPU_UNBOUND;
 	for_each_online_cpu(cpu) {
-		int num_queues = atomic_read(&nvme_tcp_cpu_queues[cpu]);
+		int num_queues = nvme_tcp_cpu_queues[cpu];
 
 		if (mq_map[cpu] != qid)
 			continue;
@@ -1731,9 +1740,10 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
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
@@ -1846,7 +1856,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		queue->cmnd_capsule_len = sizeof(struct nvme_command) +
 						NVME_TCP_ADMIN_CCSZ;
 
-	ret = sock_create_kern(current->nsproxy->net_ns,
+	ret = sock_create_kern(&init_net,
 			ctrl->addr.ss_family, SOCK_STREAM,
 			IPPROTO_TCP, &queue->sock);
 	if (ret) {
@@ -2010,8 +2020,11 @@ static void nvme_tcp_stop_queue_nowait(struct nvme_ctrl *nctrl, int qid)
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
@@ -2118,25 +2131,6 @@ static void nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl)
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
@@ -2197,22 +2191,64 @@ static int nvme_tcp_tls_check_psk(struct nvme_ctrl *ctrl)
 	return 0;
 }
 
-static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
+static void nvme_tcp_setup_queue_async(void *data, async_cookie_t cookie)
 {
-	int i, ret;
+	struct nvme_tcp_setup_ctx *ctx = data;
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
+	struct nvme_tcp_setup_ctx *ctxs;
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
@@ -2254,10 +2290,6 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 	if (ret)
 		return ret;
 
-	ret = __nvme_tcp_alloc_io_queues(ctrl);
-	if (ret)
-		return ret;
-
 	if (new) {
 		ret = nvme_alloc_io_tag_set(ctrl, &to_tcp_ctrl(ctrl)->tag_set,
 				&nvme_tcp_mq_ops,
@@ -2268,12 +2300,12 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
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
 
@@ -2297,12 +2329,14 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 
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
 
@@ -3140,7 +3174,7 @@ static int __init nvme_tcp_init_module(void)
 		return -ENOMEM;
 
 	for_each_possible_cpu(cpu)
-		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
+		nvme_tcp_cpu_queues[cpu] = 0;
 
 	nvmf_register_transport(&nvme_tcp_transport);
 	return 0;
-- 
2.55.0


