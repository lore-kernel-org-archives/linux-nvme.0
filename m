Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BE8CD6E6E
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2026 19:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=m2imutk0xngwG04CZ2xivc/DWXVoGd2Q3kkDp+9sgkE=; b=V5m0qgCrihkNf1G2AeII6wKegI
	9WvcSoMbxQBQGisLCJ/IylXJwX0xOrmLvakRBl/UXaj7qOmxaFqdV1DsgCvLuugy6/khWGHdU94Hk
	svltWvblyNiE49ehwxlHr+I3zE/CmASg9w875QskAYfEfFmWOC9tsT5PoPLd/Be7aEMo21of2BXj4
	PvhFTLBViqCbF7nH6QENxrWfiVZP3xKHUc7kanF/HL0IRnerHbE9VUu+7MyViQ9o4h1QfFC7YZ5IE
	0frz5v9Hko7OwGNgUaPPg9lQRA5zuQsqGTyrM9geSyHI9n/WYL5wZqNTNIp1UVqTO/FaJw3JKJZdf
	zE44c8Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVE8t-0000000HELl-2Xnx;
	Thu, 04 Jun 2026 19:54:15 +0000
Received: from mail-pl1-x664.google.com ([2607:f8b0:4864:20::664])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVE8o-0000000HEL5-0t9T
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jun 2026 19:54:14 +0000
Received: by mail-pl1-x664.google.com with SMTP id d9443c01a7336-2c0c3546924so7855245ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 04 Jun 2026 12:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1780602848; x=1781207648; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m2imutk0xngwG04CZ2xivc/DWXVoGd2Q3kkDp+9sgkE=;
        b=RED3WkXybVPN2lZx9JGZnGKFlSKe5Rkkqjjl3t/SlUL/0xLWiyCOGS5zRYu1o9zTJH
         ZHiFvx9krHLZfuwqhQYUC7wNhYxnkfoIJZ1pqS5agn/ZZtppOtAU+Sc+1Oiy51HjHJcd
         vS9HBZIfeNTpGHJoKnNllqBshgfcliefSlpGHMMdMZwiGap7uEoIf7+g/Yg9rg0gNU3h
         WTRXRIKrhvjFrqOWOfbRd+q4LCgVTsjdqW4Ub0QIPnl9EqkKyhPx3xeybTUFBwb4Ho+U
         vvubHgUgGoTAkKuXkDlyUY0RIyW9UNzfQlmFdDybDWcBQnWK1dTN0N6Ybl+fhjSCSFfK
         CyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780602848; x=1781207648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2imutk0xngwG04CZ2xivc/DWXVoGd2Q3kkDp+9sgkE=;
        b=eercBs+41KENDW3jOllBfoGzIehF472mDuRAnGahJvxcq/x1MHyKr8+wJUOFSjRGc3
         dx46Guh2bVg6VbIidL0QBV9Af2WdMnBcGh5T6uyI+ZF861xkeZgJ8icHLYlOl1L7Mxds
         i0/soVQWrRmBhnHReQsR1mg24DJaPg9FhJRy/3nbMv7SG2y/vY/u8Hceit+W+DiLVg9n
         +hQ/7qrcdPmqFQytWqDzT+n4U69OUCY5LVtsJnS16nhc6Rz2skjgBD9wdBAgLJgWxZLr
         tjPXvOiAYN1VqVrxbYBVMwaXedBdSC6UHXvZXyctuX2jp5K0PzvQgaJcSa5dBeF4pwoc
         9uYA==
X-Gm-Message-State: AOJu0Yzbtx+ykeQ8m+aKfKHu4klTd6cBD89yXDnHj8sxkdLJXXg6Gcm3
	OK9rLJHxM2wTXeGla2t1nYsClfnMxe7yQdk+KQkyVHJfVPencMHSlweb02nyr8RD6FNFBYx4Nzr
	4tlamo2g5hOW+q7vS00LJBjXWYbaWSOH3mFQs+knakUOz9qIbsZlF
X-Gm-Gg: Acq92OETmmMNAw9noJLx9SqbyjBrBNoyHpNWI1t4NBWOTyLCEP11HJj5R72IHndgJWP
	icuFMyurh71UehpXPQ3N+UOEOdqeNYLyV5jNfbPnTjEllT+OccDdvcXlwFesZZ31/FshhB8RU3m
	ixcwFghZ/ICj6IcakTljKyBQ0dg/f9U637YkdiFu/4ROLzFuq6nYsi6czAGWFekpOdrDm3Keo8S
	DNUJl5hw7pH7Qf5eoktXDm2u3EKFXH0nGsQ0rplMwEs/U8P8YJxJOyv9YBRGeEvArA/5cn5PAp4
	BW1YVDFkJL9kIACm7Y90KBpetv6sj7TwPGQ8b/+UTMMSIHU53tojgqpKVJ+2X3zbHAgKT+WAuQd
	NMaMQXk4kRGD1WU1rXtL+Ys7D6BGJjeRfs7Mf+YRX4DA/08Vf
X-Received: by 2002:a17:903:37c7:b0:2b9:e82f:bfef with SMTP id d9443c01a7336-2c1e8820055mr114825ad.21.1780602848530;
        Thu, 04 Jun 2026 12:54:08 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c164f88e0csm6202265ad.18.2026.06.04.12.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 12:54:08 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (bond0.slc5-n22m24-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:429])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A7AC23404BC;
	Thu,  4 Jun 2026 13:54:07 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id C7237482EB; Thu,  4 Jun 2026 13:54:07 -0600 (MDT)
From: Surabhi Gogte <sgogte@purestorage.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com,
	randyj@purestorage.com,
	Surabhi Gogte <sgogte@purestorage.com>
Subject: [PATCH v2] nvme-rdma: parallelize I/O queue allocation and startup
Date: Thu,  4 Jun 2026 13:53:21 -0600
Message-ID: <20260604195321.2232838-1-sgogte@purestorage.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_125410_447380_521E5EC5 
X-CRM114-Status: GOOD (  20.95  )
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
- Add qsetup_err atomic to nvme_rdma_ctrl for collecting errors
  across parallel threads.
- Refactor nvme_rdma_alloc_queue() to accept a pre-initialized queue
  pointer instead of (ctrl, idx, queue_size), updating all call sites
  including the admin queue path.
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
Changes since v1:
- Replace dedicated nvme_setup_wq workqueue with async API
  implementation.
---
 drivers/nvme/host/rdma.c | 122 ++++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 54 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f77c960f7632..3b33f7be563b 100644
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
@@ -125,6 +126,7 @@ struct nvme_rdma_ctrl {
 	struct nvme_ctrl	ctrl;
 	bool			use_inline_data;
 	u32			io_queues[HCTX_MAX_TYPES];
+	atomic_t		qsetup_err;
 };
 
 static inline struct nvme_rdma_ctrl *to_rdma_ctrl(struct nvme_ctrl *ctrl)
@@ -566,16 +568,14 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	return ret;
 }
 
-static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
-		int idx, size_t queue_size)
+static int nvme_rdma_alloc_queue(struct nvme_rdma_queue *queue)
 {
-	struct nvme_rdma_queue *queue;
+	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
+	int idx = nvme_rdma_queue_idx(queue);
 	struct sockaddr *src_addr = NULL;
 	int ret;
 
-	queue = &ctrl->queues[idx];
 	mutex_init(&queue->queue_lock);
-	queue->ctrl = ctrl;
 	if (idx && ctrl->ctrl.max_integrity_segments)
 		queue->pi_support = true;
 	else
@@ -587,8 +587,6 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 	else
 		queue->cmnd_capsule_len = sizeof(struct nvme_command);
 
-	queue->queue_size = queue_size;
-
 	queue->cm_id = rdma_create_id(&init_net, nvme_rdma_cm_handler, queue,
 			RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(queue->cm_id)) {
@@ -694,59 +692,57 @@ static int nvme_rdma_start_queue(struct nvme_rdma_ctrl *ctrl, int idx)
 	return ret;
 }
 
-static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl,
-				     int first, int last)
+static void nvme_rdma_setup_queue_async(void *setup_queue, async_cookie_t cookie)
 {
-	int i, ret = 0;
+	struct nvme_rdma_queue *queue = setup_queue;
+	int ret;
 
-	for (i = first; i < last; i++) {
-		ret = nvme_rdma_start_queue(ctrl, i);
-		if (ret)
-			goto out_stop_queues;
-	}
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
+
+out_err:
+	atomic_cmpxchg(&queue->ctrl->qsetup_err, 0, ret);
 }
 
-static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
+static int nvme_rdma_setup_io_queues(struct nvme_rdma_ctrl *ctrl, int first,
+				     int last, size_t queue_size)
 {
-	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
-	unsigned int nr_io_queues;
+	int nr_queues = last - first;
 	int i, ret;
+	ASYNC_DOMAIN_EXCLUSIVE(setup_queue_domain);
 
-	nr_io_queues = nvmf_nr_io_queues(opts);
-	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
-	if (ret)
-		return ret;
-
-	if (nr_io_queues == 0) {
-		dev_err(ctrl->ctrl.device,
-			"unable to set any I/O queues\n");
-		return -ENOMEM;
-	}
+	atomic_set(&ctrl->qsetup_err, 0);
 
-	ctrl->ctrl.queue_count = nr_io_queues + 1;
-	dev_info(ctrl->ctrl.device,
-		"creating %d I/O queues.\n", nr_io_queues);
+	for (i = 0; i < nr_queues; i++) {
+		struct nvme_rdma_queue *queue = &ctrl->queues[first + i];
 
-	nvmf_set_io_queues(opts, nr_io_queues, ctrl->io_queues);
-	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
-		ret = nvme_rdma_alloc_queue(ctrl, i,
-				ctrl->ctrl.sqsize + 1);
-		if (ret)
-			goto out_free_queues;
+		queue->ctrl = ctrl;
+		queue->queue_size = queue_size;
+		async_schedule_domain(nvme_rdma_setup_queue_async, queue,
+				      &setup_queue_domain);
 	}
 
-	return 0;
+	async_synchronize_full_domain(&setup_queue_domain);
 
-out_free_queues:
-	for (i--; i >= 1; i--)
-		nvme_rdma_free_queue(&ctrl->queues[i]);
+	ret = atomic_read(&ctrl->qsetup_err);
+	if (ret) {
+		for (i = 0; i < nr_queues; i++) {
+			struct nvme_rdma_queue *queue =
+				&ctrl->queues[first + i];
+
+			if (test_bit(NVME_RDMA_Q_LIVE, &queue->flags))
+				nvme_rdma_stop_queue(queue);
+			if (test_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
+				nvme_rdma_free_queue(queue);
+		}
+	}
 
 	return ret;
 }
@@ -783,7 +779,9 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	bool pi_capable = false;
 	int error;
 
-	error = nvme_rdma_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
+	ctrl->queues[0].ctrl = ctrl;
+	ctrl->queues[0].queue_size = NVME_AQ_DEPTH;
+	error = nvme_rdma_alloc_queue(&ctrl->queues[0]);
 	if (error)
 		return error;
 
@@ -864,11 +862,22 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 {
 	int ret, nr_queues;
+	unsigned int nr_io_queues;
 
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
@@ -881,7 +890,9 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 	 * queue number might have changed.
 	 */
 	nr_queues = min(ctrl->tag_set.nr_hw_queues + 1, ctrl->ctrl.queue_count);
-	ret = nvme_rdma_start_io_queues(ctrl, 1, nr_queues);
+	ret = nvme_rdma_setup_io_queues(ctrl, 1, nr_queues,
+					ctrl->ctrl.sqsize + 1);
+
 	if (ret)
 		goto out_cleanup_tagset;
 
@@ -905,12 +916,15 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
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
+						ctrl->tag_set.nr_hw_queues + 1,
+						ctrl->ctrl.sqsize + 1);
+		if (ret)
+			goto out_wait_freeze_timed_out;
+	}
 
 	return 0;
 
-- 
2.54.0


