Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A65EC98302
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 20:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jKj3QXNJc64ZYZOzUkze7Bi+QP/5m/9g84NFc6owjQw=; b=005JUt7HCTypULzTtEFMzJQ9HP
	PaEUM0vKwCXaYf8a5qSArM2UM2QFmngwn/+Ix8c3d+B+k2sJytbgNKgA9iMQLxhn9NKRmqoz2pxgw
	Npt2dOsK+DlPAVOOydYa+3VugZ0udw+0NZaYsDpmXfQbfXM5hA1tS34RH1FIXcGWKZx4d6IYIj6pZ
	vKrDovOACPA2f0WAjykjoF+bg/dfUwe0p6DxOU+zUa4U3cCZoHNR4/TGeNtN5H0xGAw1nDQDSRoNu
	a/BPijZEZlJDjI7jGXiMLLiSDbc3Z7MOHRLSHg+yBdWYN7UHqhyDpsXUnmH3NwvlXamuMrEbYHhyB
	vS3SLAMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x96mO-00000006Vf9-3P51;
	Tue, 22 Sep 2026 20:07:52 +0000
Received: from mail-pl1-x661.google.com ([2607:f8b0:4864:20::661])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x96mM-00000006Vdf-0lrC
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 20:07:51 +0000
Received: by mail-pl1-x661.google.com with SMTP id d9443c01a7336-2dd9ec41bc4so837665ad.2
        for <linux-nvme@lists.infradead.org>; Tue, 22 Sep 2026 13:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1790107669; x=1790712469; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jKj3QXNJc64ZYZOzUkze7Bi+QP/5m/9g84NFc6owjQw=;
        b=LG3o5HFlyk9ijJj67k0s487Zh+qHw80WXlTxuYGUUyscoDpzLd6tL+rAn2bqLxugoI
         n3/y0nmMoI1BSEOtriUnUrGU6p4COrFNBhfA+MhvDTLJH7Ypf5cMkmAQJHJbfjAaZy+u
         cQ+gdeHzvOId0oZff8gborLs77xxKRGfsZHYsfCJSgvG/mFkGEVM9rbVln6Ayx2tfc8Q
         1U7KKCGldbCAxZQoJUJkDVzDvn+Zm43ryGBgdf+VbkPRs3XOpCGHdoh9QgBHiPyUZHE9
         KinQPM5xRmpaU5F2fA7WmfcnVqJ8cFv2JqMF7mck+M13tK8s+PhK3p4risI7YQkonjJS
         wEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107669; x=1790712469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jKj3QXNJc64ZYZOzUkze7Bi+QP/5m/9g84NFc6owjQw=;
        b=N2EBsrUf+YUVF7nYzLcPeVVqQ3a/zG9lRXXz16+yPK0ywjq5MbXJyh64x/g5U55z79
         pTyOPTXc9GDaZp4YccyJnUos21eBAjpr+l8F+w4DnuXT0ukG6xaTdN8BDdzCrfpH6bQQ
         ljlrBHOfpWEH2XgAeOHma/nhaGuU6gK/CVv4NbP1Jq+O0el4J1KbfGvjmM64zH3kidSg
         +SkAk06Xl0MhxSF4d9ZubsXWSXTQ9c25aK0abv2AEEn1YjFIMVj2vRMPIi8lJYMp9Gvg
         YsdgGGt/FLsIP77DrJmZYhgKvseT+ggQaApzRjiuK7+mzWR1o+rmlBNNbuUQRHwCZdVg
         sRpg==
X-Gm-Message-State: AFuF++lRYbXxJ+s4Fh4PDMzsZorCDu4EveNq7mfQQ4/ODKIDpwryh/AU
	qvLb9s/jgnZfasOb5rl5mp7YsHIJ8icBO4MMCkbSdRpH3DV0dPBeroVdV0TO6iGqHQk0LDePxN2
	ue4NXx+O8dH229fAMzSPb9ImVC1QipPPpTqNtUopNXPmum1Hzs7tH
X-Gm-Gg: AYBFou3B2PyzeOKPa1LldxMPDspL0Ppwc5b1IwJDLqbY+2y1Y1/qiTp8AsfZw0Bwjoq
	Vyjbsjzb2HKz1iCnKqgbBvEXrQwOVP0roe3tgUEpUKhcU5Izbe5Knw6TYAzK4WpMHJXKTEr16Hw
	rzu7znR6Mu5MBr/3hkRurMqQXavk8RWZAIpn9M1aRv8fLjwNv0fDFSEQH+5ug47FmJlR3Tbx3p3
	oWUqP2qDlXUP4EqTcq150NEHQ4Ge6OYaEN22Tkts6y67Wo3To+M6Mp4IVrUVqgLNN1pDhPrRG4E
	x8VP646vCBSMQH93j0bOYe98fayV/5oua1fv4vo+xZ3SxXLWW+jVzka2HJ5aYIjHy7XEvohGtPN
	mqYFwxv3Z7iSI3qg=
X-Received: by 2002:a17:90b:2e83:b0:3a0:348a:5118 with SMTP id 98e67ed59e1d1-3a07e7555c3mr451315a91.47.1790107669177;
        Tue, 22 Sep 2026 13:07:49 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a07dd381f4sm306951a91.7.2026.09.22.13.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:07:49 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (bond0.slc5-n22m24-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:429])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id F0E694014B;
	Tue, 22 Sep 2026 14:07:47 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id EE52B3F9F5; Tue, 22 Sep 2026 14:07:47 -0600 (MDT)
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
	Surabhi Gogte <sgogte@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH v4 3/3] nvme-tcp: parallelize I/O queue allocation and startup
Date: Tue, 22 Sep 2026 14:07:18 -0600
Message-ID: <20260922200718.3941465-4-sgogte@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922200718.3941465-1-sgogte@purestorage.com>
References: <20260922200718.3941465-1-sgogte@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_130750_236113_FE772237 
X-CRM114-Status: GOOD (  28.16  )
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
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 119 ++++++++++++++++++++++++++--------------
 1 file changed, 77 insertions(+), 42 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9308feba8a74..ec678ed07af8 100644
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
@@ -1731,9 +1739,10 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 		goto out;
 
 	/* Search for the least used cpu from the mq_map */
+	spin_lock(&nvme_tcp_cpu_queues_lock);
 	io_cpu = WORK_CPU_UNBOUND;
 	for_each_online_cpu(cpu) {
-		int num_queues = atomic_read(&nvme_tcp_cpu_queues[cpu]);
+		int num_queues = nvme_tcp_cpu_queues[cpu];
 
 		if (mq_map[cpu] != qid)
 			continue;
@@ -1744,9 +1753,10 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
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
@@ -2023,8 +2033,11 @@ static void nvme_tcp_stop_queue_nowait(struct nvme_ctrl *nctrl, int qid)
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
@@ -2131,25 +2144,6 @@ static void nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl)
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
@@ -2210,22 +2204,67 @@ static int nvme_tcp_tls_check_psk(struct nvme_ctrl *ctrl)
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
+	if (first >= last)
+		return 0;
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
@@ -2267,10 +2306,6 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 	if (ret)
 		return ret;
 
-	ret = __nvme_tcp_alloc_io_queues(ctrl);
-	if (ret)
-		return ret;
-
 	if (new) {
 		ret = nvme_alloc_io_tag_set(ctrl, &to_tcp_ctrl(ctrl)->tag_set,
 				&nvme_tcp_mq_ops,
@@ -2281,12 +2316,12 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
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
 
@@ -2310,9 +2345,9 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 
 	/*
 	 * If the number of queues has increased (reconnect case)
-	 * start all new queues now.
+	 * setup all new queues now.
 	 */
-	ret = nvme_tcp_start_io_queues(ctrl, nr_queues,
+	ret = nvme_tcp_setup_io_queues(ctrl, nr_queues,
 				       ctrl->tagset->nr_hw_queues + 1);
 	if (ret)
 		goto out_wait_freeze_timed_out;
@@ -3157,7 +3192,7 @@ static int __init nvme_tcp_init_module(void)
 		return -ENOMEM;
 
 	for_each_possible_cpu(cpu)
-		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
+		nvme_tcp_cpu_queues[cpu] = 0;
 
 	nvmf_register_transport(&nvme_tcp_transport);
 	return 0;
-- 
2.55.0


