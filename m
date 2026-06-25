Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D8DCDE010
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2026 21:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y4b2dFsTucb4aU0SZUuf4AYL/tgS35O39eqo6KSrHbE=; b=ESE6YzOZZl3Is7JV0kJ5+CxPrX
	ep/j8SYWiBzL9PtcZgW/bCaGjOPph+zY+nP3Uu5Y7ucNsYDOmcT7TfE/ETVa3i278+kBLi7rP1Ytd
	avkaj0y9RJQiGus/kSBcGexgzIiOmhvGjgQfiO+bi/2wEakFstMtVEN0qqPrHc2hYVq0qb0CqDGIe
	mEMct0aY9l3AiuHfp26dUdRanzTKri99GncRVq6k7AQKAGJDS8kqc042iGSr8t2Zbb1udHkTrmNOQ
	UmCuEKepJ/oM8S8VNW0Kxtgir/NpiV+07qXW5jT1n28WrAI7DVjX8CKVm4W8o5UZeC/5YM+54nZCN
	D5kaMIJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcrby-00000009s8o-2ZFD;
	Thu, 25 Jun 2026 21:27:50 +0000
Received: from mail-vs1-xe62.google.com ([2607:f8b0:4864:20::e62])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcrbv-00000009s7g-3Fen
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jun 2026 21:27:49 +0000
Received: by mail-vs1-xe62.google.com with SMTP id ada2fe7eead31-734653f9899so131344137.3
        for <linux-nvme@lists.infradead.org>; Thu, 25 Jun 2026 14:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782422866; x=1783027666; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4b2dFsTucb4aU0SZUuf4AYL/tgS35O39eqo6KSrHbE=;
        b=U2sxZfB707s2Y3fIaYPdF2+NOhxCEkwlBJtcB7CRlTyRDSkrrmMKftbdeZbfCSpbBA
         wV5IzpghJ1bK2B/vKGVuyOhjyt0fbYAjr2GxqfRYqkNrc0jj1VGj1QvlDUJwRocYlnEV
         w9V/6iO1Ryx4Ry/VjszoGnGZagrVOlW0pRMDqH/wkWgdmqOLAK2nnnADd2PRwQdhr7YT
         wqpM+cBEQMHVEI0J+yVE/qLYiy+1B/VNwI+k6yZBazW31THlX+Vvrr/dxqI90CRi26T9
         01blLWrf+rAZSPCRIVOGZas0XjLl5BPy2ywEklowDOUiqlit7I6JH2d3N9SK+cojpy15
         Fe5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782422866; x=1783027666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y4b2dFsTucb4aU0SZUuf4AYL/tgS35O39eqo6KSrHbE=;
        b=ao67eskGdPPpZceA5oXjzobdYZo1I9aJ5R1PN+t0fSaJ3559O3HZhqFOPExgW48/QG
         UkkpRj/A6UJwTlSKW5E6oAUCcI64zwjup9+7WNCKSHH+F+sjOCwSog/jFgUMqm9ePhJ4
         boD5MjGdT+OX+LpmunBTJMzS+nnTGfoFK2mwPTMDXMf2NWY+md86DfA8fyR6ehhbmvSV
         L371GJUvv+jHDVuWpiesdwhuqSIDE8VGKGu7/ZJQK05YNhL3zjMH0xADtlfZXHxLTsiJ
         jRwkt1SvI2+PL2tM2pwytWpSmhSx0ml7X/jsi83vHaLQGLNCCJEC3cMf1AhJV36y8JRI
         gCxw==
X-Gm-Message-State: AOJu0YxDmyB/bBYI4tEo8UrVCiKZKHRno3KAgeCYAtr+5pgYj55IV98g
	vA0PlmmKspGLEbjSb8AVpv4HRWLuZDbfoBYNxKqWll1DZ0TYKvMyBAOqNTlmjp0T4UwA4RqWdKH
	pT+ypK4JlXlkMHxgwYAxOv6+1U3VuFIzRT0Az
X-Gm-Gg: AfdE7ckGIMIQxIKlwH89V7r4cM7GuQN6kMCIEFYNDbUr0RzElNZ5jubZpNeYKPxcgI9
	VGTDAjWlXqMbUsTilfRrCggaLN8ipDGignAq5zg5XU9JcWPA4LXSvcFeNuWfeXaTfEKDWGwP7fx
	NS1LCKuZznEK+CBdLhR55jMSvSTfqm8+rWdo43XPmjfSuFtDb+qGh2bQ0+PGET6UodZxzfa/X2a
	sFnXQwiLXfbW0q9yutLN160vBHT36oj0pIqVRIRYe2YU4QcfyM2EHSjrml8tb+d7wjlYcHWQZ+A
	GZWrfjLK4RAiiLSaiXed4M7uwT5yQkJ6QO/C4Hqg+K11VgDKBcsm3JeCyMn2NsFYcNc2S8AGdxp
	7wPEQjwJfjj7TzK7wFGrCu2EquYx04cis6b2jxAbodA==
X-Received: by 2002:a05:6102:c8a:b0:6c6:74d:e090 with SMTP id ada2fe7eead31-734349573a6mr2562285137.9.1782422864391;
        Thu, 25 Jun 2026 14:27:44 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-7356689f0aasm18944137.5.2026.06.25.14.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 14:27:44 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (bond0.slc5-n22m24-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:429])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id C320F401FD;
	Thu, 25 Jun 2026 15:27:43 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id C0B8751222; Thu, 25 Jun 2026 15:27:43 -0600 (MDT)
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
Subject: [PATCH v3 2/2] nvme-rdma: parallelize I/O queue allocation and startup
Date: Thu, 25 Jun 2026 15:27:22 -0600
Message-ID: <20260625212722.1302344-3-sgogte@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625212722.1302344-1-sgogte@purestorage.com>
References: <20260625212722.1302344-1-sgogte@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_142747_832585_725EA25D 
X-CRM114-Status: GOOD (  23.95  )
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
index 6b0b0a3dea62..45d0ef8c4dd3 100644
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
+static int nvme_rdma_setup_io_queues(struct nvme_rdma_ctrl *ctrl, unsigned int first,
+		unsigned int last, size_t queue_size)
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
+	ctxs = kmalloc_array(nr_queues, sizeof(*ctxs), GFP_KERNEL);
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


