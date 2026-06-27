Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283B6C43327
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jun 2026 04:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PaVrMx15yJC3UQAct8EhgWFhwmFAMOShPun1TdcWdQM=; b=cBUb65DUZ4S5dLcCnJRxK9Fhz6
	GFSGqMW5llJVSRAd8xU2ZWLlHj5sxU2lvg5j1mg6OcEa3Mno8gRiEgKXQ1xNZXHML2EtMEc+s5T5X
	ADWKer9J32Q5lWcPUE5vh2RMifnegB2fVDkdsSVhABUV0xDt+YuMAgyvt3xRQZ0yzjsFU1Wh8SgXk
	5kl19xG4M+pxF6iQRzK5q/jxVW4YBX7XMY/AIFuS4vDxRjwHCB9YUWsHPaRGErr7t3Eb4bqA5MIZO
	JQZVmoEp0ZI41TdmmRb+i0DXUf10Z/FQqcyR6Y/AXfANL3wxghcJ7PNH9KDUEB/A85rcNZmhc1PYY
	4DEts5oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdKTU-0000000C7y3-3UWT;
	Sat, 27 Jun 2026 04:17:00 +0000
Received: from mail-dy1-x1361.google.com ([2607:f8b0:4864:20::1361])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdKTS-0000000C7xE-22Fl
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jun 2026 04:16:59 +0000
Received: by mail-dy1-x1361.google.com with SMTP id 5a478bee46e88-30b6dad2382so3367425eec.0
        for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2026 21:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782533817; x=1783138617; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaVrMx15yJC3UQAct8EhgWFhwmFAMOShPun1TdcWdQM=;
        b=b1v/FTpH/G83BDwMX72Lxbd1IF28ss4RDZHBLa1fmBYZQqY2BLsr75xneFNZdUJ+Ew
         /U8VfhKXK8lsl386HgNhj5mc6ygnmlBugeWXeAseeQUDJWfznx6BmPkMAiL/l8cvfJRP
         87GnU1JbXUtaicgW71PG5wSmikp/H9p1ucH0oZPoAWx7MOQQ8SNjPuqpzl6t94pTJr4r
         M3UqkmHKJT0Xvnin3v8GZOj0aFZCyMAq0xQJNLcBY7u0XaO74OJFPc6ExbWSyww8z77D
         kX2LQTvaxcBGud8vegBDB84KQIayfOlG9NfCwp26AX/A04q/ouvcU4da0/456UGj/Uqe
         SCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782533817; x=1783138617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PaVrMx15yJC3UQAct8EhgWFhwmFAMOShPun1TdcWdQM=;
        b=ewYnbVrSY3BvtXAkxiVyVWelHc49Z44YbGLI7ahAakjaLOFsZ9Vq9XO4ZJoB42Zk7r
         EditvtorLffuYxafZkdaajHNizjOeVpDb/U6XAmUlvztY36oykAWqrXBzPUMEE/ogLso
         DBsGNd/wSZ99+msP1TKEWnOsiqKkffU5yRPKY/8najwQ9e0YTZpff+/z99sgvr1oDl46
         oBPlkq7F/MtYO9RF6+EsS484pMXYhHFUT90srQtmzs+qpNs8jbN/rhjG0HOqPV6NbIJN
         yorttdsHwtSbarAnoQlRxi6H+/KPLoaE7noO1wsqqf89I+g7k1J1lLJcM+tz64Yppas5
         1hUA==
X-Gm-Message-State: AOJu0YzONBgg91vePPmPoeYosfOcbOu6ZOSU7JL4ey+9G2rHSH7d5VtQ
	vf4pmVx/f8O3OrN8sMOK+EAKeEhLrrJdVsCmFAbjIDXH39CF8TwbkZo/s94MsYLUD+mlVhxd1/v
	FtJWs5aOkOV1Xx5TbaLeBb3Pyce2HcpeWIwdr
X-Gm-Gg: AfdE7cmHsinLiWysVeXinOjVanWytXj6TBT37R17TG2OihaEEvcUCzv/1zrzpFEba8Z
	lh5boJKib1v/Ouxy7QALsEcL9b6PSGh/BqvR2xZPjcYypGO3BfA3V0p98IZa0tFTijn7j0T8hN4
	c6BNkLtmIwLgbILDIm3ZmgG8YwlB9LryT82j7bon7CUGGxChnKas7bCqtsmg6ZBp2tHK4naOZW+
	JBT7BY0ItH+zY1R+UihaW93vMxwLubR5cvttR8YYG8gUZIAWDfyx6Cp0KtWaDdAUn8SbGXN4Sjq
	tCxT8ZHLFdrhjZ6YS/gByqyjgaTLgpn8+vC3gMllMS8TlbKT0KkAVp6A2ChyUxpGEktborNNOEt
	vpweFWb7iaPtfGrSsQlYCMKHxXaW+RDs6OEnuDljSVg==
X-Received: by 2002:a05:7301:7bc2:b0:30c:ab4d:da43 with SMTP id 5a478bee46e88-30cab4ddbdemr2560368eec.39.1782533817219;
        Fri, 26 Jun 2026 21:16:57 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-30c7c443596sm617443eec.4.2026.06.26.21.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 21:16:57 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (bond0.slc5-n22m24-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:429])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 4DCD840146;
	Fri, 26 Jun 2026 22:16:56 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id 45C8C51219; Fri, 26 Jun 2026 22:16:56 -0600 (MDT)
From: Surabhi Gogte <sgogte@purestorage.com>
To: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com,
	randyj@purestorage.com,
	adailey@purestorage.com,
	Surabhi Gogte <sgogte@purestorage.com>
Subject: [PATCH v4 2/2] nvme-rdma: parallelize I/O queue allocation and startup
Date: Fri, 26 Jun 2026 22:15:51 -0600
Message-ID: <20260627041551.1981256-3-sgogte@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260627041551.1981256-1-sgogte@purestorage.com>
References: <20260627041551.1981256-1-sgogte@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_211658_530385_A3CD2D76 
X-CRM114-Status: GOOD (  23.44  )
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

Refactor nvme rdma I/O queue setup to use async API, combining
allocation and startup into a single parallel operation per queue. This
reduces connection and reconnection setup time when there are delays in
establishing connections, which is especially important for
high-core-count hosts.

Key changes:
- Use async API to facilitate parallel calls for io queue setup.
- Add nvme_rdma_setup_ctx for propagating errors from async workers.
- Remove nvme_rdma_alloc_io_queues() and nvme_rdma_start_io_queues();
  their logic is folded into nvme_rdma_setup_io_queues() and
  nvme_rdma_configure_io_queues().
- Move queue count negotiation (nvme_set_queue_count,
  nvmf_set_io_queues) from the removed nvme_rdma_alloc_io_queues()
  into nvme_rdma_configure_io_queues().

Testing on a 64-core host with 64 IO-queues shows
nvme-rdma connection time reduced from ~1.4s to 416ms.

Signed-off-by: Surabhi Gogte <sgogte@purestorage.com>
---
 drivers/nvme/host/rdma.c | 124 ++++++++++++++++++++++++---------------
 1 file changed, 77 insertions(+), 47 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6b0b0a3dea62..52933d11ea03 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/async.h>
 #include <linux/scatterlist.h>
 #include <linux/nvme.h>
 #include <linux/unaligned.h>
@@ -100,6 +101,11 @@ struct nvme_rdma_queue {
 	struct mutex		queue_lock;
 };
 
+struct nvme_rdma_setup_ctx {
+	struct nvme_rdma_queue	*queue;
+	int			*err;
+};
+
 struct nvme_rdma_ctrl {
 	/* read only in the hot path */
 	struct nvme_rdma_queue	*queues;
@@ -690,60 +696,68 @@ static int nvme_rdma_start_queue(struct nvme_rdma_ctrl *ctrl, int idx)
 	return ret;
 }
 
-static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl,
-				     int first, int last)
+static void nvme_rdma_setup_queue_async(void *data, async_cookie_t cookie)
 {
-	int i, ret = 0;
+	struct nvme_rdma_setup_ctx *ctx = data;
+	struct nvme_rdma_queue *queue;
+	int ret;
 
-	for (i = first; i < last; i++) {
-		ret = nvme_rdma_start_queue(ctrl, i);
-		if (ret)
-			goto out_stop_queues;
-	}
+	queue = ctx->queue;
+	ret = nvme_rdma_alloc_queue(queue);
+	if (ret)
+		goto out_err;
 
-	return 0;
+	ret = nvme_rdma_start_queue(queue->ctrl, nvme_rdma_queue_idx(queue));
+	if (ret)
+		goto out_err;
 
-out_stop_queues:
-	for (i--; i >= first; i--)
-		nvme_rdma_stop_queue(&ctrl->queues[i]);
-	return ret;
+	return;
+out_err:
+	WRITE_ONCE(*ctx->err, ret);
 }
 
-static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
+static int nvme_rdma_setup_io_queues(struct nvme_rdma_ctrl *ctrl,
+		unsigned int first, unsigned int last, size_t queue_size)
 {
-	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
-	unsigned int nr_io_queues;
-	int i, ret;
-
-	nr_io_queues = nvmf_nr_io_queues(opts);
-	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
-	if (ret)
-		return ret;
+	ASYNC_DOMAIN_EXCLUSIVE(queue_domain);
+	struct nvme_rdma_setup_ctx *ctxs;
+	int nr_queues = last - first;
+	int err = 0, i, ret;
 
-	if (nr_io_queues == 0) {
-		dev_err(ctrl->ctrl.device,
-			"unable to set any I/O queues\n");
+	ctxs = kmalloc_objs(*ctxs, nr_queues);
+	if (!ctxs)
 		return -ENOMEM;
-	}
 
-	ctrl->ctrl.queue_count = nr_io_queues + 1;
-	dev_info(ctrl->ctrl.device,
-		"creating %d I/O queues.\n", nr_io_queues);
-
-	nvmf_set_io_queues(opts, nr_io_queues, ctrl->io_queues);
-	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
-		ctrl->queues[i].ctrl = ctrl;
-		ctrl->queues[i].queue_size = ctrl->ctrl.sqsize + 1;
-		ret = nvme_rdma_alloc_queue(&ctrl->queues[i]);
-		if (ret)
-			goto out_free_queues;
+	for (i = 0; i < nr_queues; i++) {
+		struct nvme_rdma_queue *queue = &ctrl->queues[first + i];
+
+		queue->ctrl = ctrl;
+		queue->queue_size = queue_size;
+
+		ctxs[i].queue = queue;
+		ctxs[i].err = &err;
+		async_schedule_domain(nvme_rdma_setup_queue_async, &ctxs[i],
+				&queue_domain);
 	}
 
-	return 0;
+	async_synchronize_full_domain(&queue_domain);
+	kfree(ctxs);
 
+	ret = READ_ONCE(err);
+	if (ret)
+		goto out_free_queues;
+
+	return 0;
 out_free_queues:
-	for (i--; i >= 1; i--)
-		nvme_rdma_free_queue(&ctrl->queues[i]);
+	for (i = 0; i < nr_queues; i++) {
+		struct nvme_rdma_queue *queue =
+			&ctrl->queues[first + i];
+
+		if (test_bit(NVME_RDMA_Q_LIVE, &queue->flags))
+			nvme_rdma_stop_queue(queue);
+		if (test_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
+			nvme_rdma_free_queue(queue);
+	}
 
 	return ret;
 }
@@ -862,12 +876,23 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
 static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 {
+	unsigned int nr_io_queues;
 	int ret, nr_queues;
 
-	ret = nvme_rdma_alloc_io_queues(ctrl);
+	nr_io_queues = nvmf_nr_io_queues(ctrl->ctrl.opts);
+	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret)
 		return ret;
 
+	if (nr_io_queues == 0) {
+		dev_err(ctrl->ctrl.device, "unable to set any I/O queues\n");
+		return -ENOMEM;
+	}
+
+	ctrl->ctrl.queue_count = nr_io_queues + 1;
+	dev_info(ctrl->ctrl.device, "creating %d I/O queues.\n", nr_io_queues);
+	nvmf_set_io_queues(ctrl->ctrl.opts, nr_io_queues, ctrl->io_queues);
+
 	if (new) {
 		ret = nvme_rdma_alloc_tag_set(&ctrl->ctrl);
 		if (ret)
@@ -880,7 +905,9 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 	 * queue number might have changed.
 	 */
 	nr_queues = min(ctrl->tag_set.nr_hw_queues + 1, ctrl->ctrl.queue_count);
-	ret = nvme_rdma_start_io_queues(ctrl, 1, nr_queues);
+	ret = nvme_rdma_setup_io_queues(ctrl, 1, nr_queues,
+			ctrl->ctrl.sqsize + 1);
+
 	if (ret)
 		goto out_cleanup_tagset;
 
@@ -904,12 +931,15 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 	/*
 	 * If the number of queues has increased (reconnect case)
-	 * start all new queues now.
+	 * setup all new queues now.
 	 */
-	ret = nvme_rdma_start_io_queues(ctrl, nr_queues,
-					ctrl->tag_set.nr_hw_queues + 1);
-	if (ret)
-		goto out_wait_freeze_timed_out;
+	if (ctrl->tag_set.nr_hw_queues + 1 > nr_queues) {
+		ret = nvme_rdma_setup_io_queues(ctrl, nr_queues,
+				ctrl->tag_set.nr_hw_queues + 1,
+				ctrl->ctrl.sqsize + 1);
+		if (ret)
+			goto out_wait_freeze_timed_out;
+	}
 
 	return 0;
 
-- 
2.54.0


