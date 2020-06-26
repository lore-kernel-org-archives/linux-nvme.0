Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83983C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 17:47:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 479C7207D8
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 17:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qfLZ5aiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479C7207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Tfpy4QDWKNGJHHWS67mSEI1RsK2/fIZTUxmhBtxbW00=; b=qfLZ5aiRrUUReGKy0/dXQrNXeU
	5S/RUFhZVO5LYutUk3XEGO2ex0JfJynSkYFHt50K5tsJFk+vq4wUTbXYYUpMGxpP+L3YHZQSNcJ8f
	0bjhWDXoqRxgQsXr7UxR4b1Rkn7LOwNCvLH4MGMqu9IgtsdKZHRq8dN0Nj0PfAKSsTL0A+TnLBhVI
	USt5MXkP1WdIYE0JkMi9eo1QnnLchATePkDEtgMcdQJQb10N4BkSg9L6+O95CMCCiZjnwLsA25EvE
	FOmCvvzW91m/y5R484rGIMFHuG/IiCdumnixq/vRwxTywbq6nbyBy1frN5kTaA9J5jq70s4lO5NRN
	S/3Kr1LA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1josRx-0005cu-Ry; Fri, 26 Jun 2020 17:47:41 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1josRu-0005Zk-KP
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 17:47:40 +0000
Received: by mail-pg1-f193.google.com with SMTP id e9so5244367pgo.9
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 10:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cTFOoX+NCNFklH8ggYkW1cjUh+HuTYPDeS3CCzZfqj8=;
 b=mYzTKlT8zXq/j/SilMSkrADIxlR0+aUMua/BzkFZGKuzDC4BzLMuSJAULgKnJ6uGtX
 WixUK9/fvWsLP5xCSB57nve9b/h3I0PbuDJGkjp1md4eEunYOLMnhptDqj9OIPLO/5s+
 NsM5O5pBRa+AZFFiuNPgbd6Xtt4NMdglK2lVHl0Ldrq0L1qa9k6XtxMV380lk2ntDDpR
 crV3Pugote0n9THxov2zUO9Yb4IqpCMsWzsfqzty3pJxhURuPAT7KM/fojjeGbmUs/s5
 xU9Kx/cFgxviBtIwI88IuGkBkdTFyibQ38ex0nyt0M3d8q1cBbeyriIbB6ogWsxEfimy
 MAMQ==
X-Gm-Message-State: AOAM533raAVEO06+TbTwce2A6ZpQFjvycosdJpd8w1BFw9u1PGC0trlv
 0zbIMa9HUx5FXFfm8ZPY9Rktpe8k
X-Google-Smtp-Source: ABdhPJxvaWb6FEdy5YMyB4RuFKpMbt2lK6vzWdpZP62dHJOjMjqMDm6IZjvVxwohnIWANI6JnFBwIg==
X-Received: by 2002:a63:84c3:: with SMTP id k186mr3582184pgd.394.1593193656688; 
 Fri, 26 Jun 2020 10:47:36 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:4c08:474f:e61d:6947])
 by smtp.gmail.com with ESMTPSA id k2sm23288962pgm.11.2020.06.26.10.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 10:47:35 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH RFC for-5.8-rc] nvme-core: fix deadlock in disconnect during
 scan_work and/or ana_work
Date: Fri, 26 Jun 2020 10:47:33 -0700
Message-Id: <20200626174733.116093-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Anton Eidelman <anton@lightbitslabs.com>

A deadlock happens in the following scenario with multipath:
1) scan_work(nvme0) detects a new nsid while nvme0
    is an optimized path to it, path nvme1 happens to be
    inaccessible.

2) Before scan_work is complete nvme0 disconnect is initiated
    nvme_delete_ctrl_sync() sets nvme0 state to NVME_CTRL_DELETING

3) scan_work(1) attempts to submit IO,
    but nvme_path_is_optimized() observes nvme0 is not LIVE.
    Since nvme1 is a possible path IO is requeued and scan_work hangs.

--
Workqueue: nvme-wq nvme_scan_work [nvme_core]
kernel: Call Trace:
kernel:  __schedule+0x2b9/0x6c0
kernel:  schedule+0x42/0xb0
kernel:  io_schedule+0x16/0x40
kernel:  do_read_cache_page+0x438/0x830
kernel:  read_cache_page+0x12/0x20
kernel:  read_dev_sector+0x27/0xc0
kernel:  read_lba+0xc1/0x220
kernel:  efi_partition+0x1e6/0x708
kernel:  check_partition+0x154/0x244
kernel:  rescan_partitions+0xae/0x280
kernel:  __blkdev_get+0x40f/0x560
kernel:  blkdev_get+0x3d/0x140
kernel:  __device_add_disk+0x388/0x480
kernel:  device_add_disk+0x13/0x20
kernel:  nvme_mpath_set_live+0x119/0x140 [nvme_core]
kernel:  nvme_update_ns_ana_state+0x5c/0x60 [nvme_core]
kernel:  nvme_set_ns_ana_state+0x1e/0x30 [nvme_core]
kernel:  nvme_parse_ana_log+0xa1/0x180 [nvme_core]
kernel:  nvme_mpath_add_disk+0x47/0x90 [nvme_core]
kernel:  nvme_validate_ns+0x396/0x940 [nvme_core]
kernel:  nvme_scan_work+0x24f/0x380 [nvme_core]
kernel:  process_one_work+0x1db/0x380
kernel:  worker_thread+0x249/0x400
kernel:  kthread+0x104/0x140
--

4) Delete also hangs in flush_work(ctrl->scan_work)
    from nvme_remove_namespaces().

Similiarly a deadlock with ana_work may happen: if ana_work has started
and calls nvme_mpath_set_live and device_add_disk, it will
trigger I/O. When we trigger disconnect I/O will block because
our accessible (optimized) path is disconnecting, but the alternate
path is inaccessible, so I/O blocks. Then disconnect tries to flush
the ana_work and hangs.

[  605.550896] Workqueue: nvme-wq nvme_ana_work [nvme_core]
[  605.552087] Call Trace:
[  605.552683]  __schedule+0x2b9/0x6c0
[  605.553507]  schedule+0x42/0xb0
[  605.554201]  io_schedule+0x16/0x40
[  605.555012]  do_read_cache_page+0x438/0x830
[  605.556925]  read_cache_page+0x12/0x20
[  605.557757]  read_dev_sector+0x27/0xc0
[  605.558587]  amiga_partition+0x4d/0x4c5
[  605.561278]  check_partition+0x154/0x244
[  605.562138]  rescan_partitions+0xae/0x280
[  605.563076]  __blkdev_get+0x40f/0x560
[  605.563830]  blkdev_get+0x3d/0x140
[  605.564500]  __device_add_disk+0x388/0x480
[  605.565316]  device_add_disk+0x13/0x20
[  605.566070]  nvme_mpath_set_live+0x5e/0x130 [nvme_core]
[  605.567114]  nvme_update_ns_ana_state+0x2c/0x30 [nvme_core]
[  605.568197]  nvme_update_ana_state+0xca/0xe0 [nvme_core]
[  605.569360]  nvme_parse_ana_log+0xa1/0x180 [nvme_core]
[  605.571385]  nvme_read_ana_log+0x76/0x100 [nvme_core]
[  605.572376]  nvme_ana_work+0x15/0x20 [nvme_core]
[  605.573330]  process_one_work+0x1db/0x380
[  605.574144]  worker_thread+0x4d/0x400
[  605.574896]  kthread+0x104/0x140
[  605.577205]  ret_from_fork+0x35/0x40
[  605.577955] INFO: task nvme:14044 blocked for more than 120 seconds.
[  605.579239]       Tainted: G           OE     5.3.5-050305-generic #201910071830
[  605.580712] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  605.582320] nvme            D    0 14044  14043 0x00000000
[  605.583424] Call Trace:
[  605.583935]  __schedule+0x2b9/0x6c0
[  605.584625]  schedule+0x42/0xb0
[  605.585290]  schedule_timeout+0x203/0x2f0
[  605.588493]  wait_for_completion+0xb1/0x120
[  605.590066]  __flush_work+0x123/0x1d0
[  605.591758]  __cancel_work_timer+0x10e/0x190
[  605.593542]  cancel_work_sync+0x10/0x20
[  605.594347]  nvme_mpath_stop+0x2f/0x40 [nvme_core]
[  605.595328]  nvme_stop_ctrl+0x12/0x50 [nvme_core]
[  605.596262]  nvme_do_delete_ctrl+0x3f/0x90 [nvme_core]
[  605.597333]  nvme_sysfs_delete+0x5c/0x70 [nvme_core]
[  605.598320]  dev_attr_store+0x17/0x30

Fix this by introducing a new state: NVME_CTRL_DELETE_START, which will
still allow mpath I/O to be issued to the bottom device, and only after
we flush the ana_work and scan_work (after nvme_stop_ctrl and
nvme_remove_namespaces) we change the state to NVME_CTRL_DELETING. Also
we prevent ana_work and scan_work from re-firing by aborting early if
we are already in NVME_CTRL_DELETE_START, so we should be safe here.

In addition, change the transport drivers to follow the updated state
machine.

Fixes: 0d0b660f214d ("nvme: add ANA support")
Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c      | 30 ++++++++++++++++++++++++++----
 drivers/nvme/host/fc.c        |  3 ++-
 drivers/nvme/host/multipath.c | 16 +++++++++++++++-
 drivers/nvme/host/nvme.h      |  1 +
 drivers/nvme/host/pci.c       |  8 ++++----
 drivers/nvme/host/rdma.c      | 10 ++++++----
 drivers/nvme/host/tcp.c       | 15 +++++++++------
 7 files changed, 63 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c10e44873e96..2afed32d3892 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -183,7 +183,7 @@ static void nvme_delete_ctrl_work(struct work_struct *work)
 
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl)
 {
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETE_START))
 		return -EBUSY;
 	if (!queue_work(nvme_delete_wq, &ctrl->delete_work))
 		return -EBUSY;
@@ -198,7 +198,7 @@ static void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 	 * since ->delete_ctrl can free the controller.
 	 */
 	nvme_get_ctrl(ctrl);
-	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETE_START))
 		nvme_do_delete_ctrl(ctrl);
 	nvme_put_ctrl(ctrl);
 }
@@ -351,7 +351,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 			break;
 		}
 		break;
-	case NVME_CTRL_DELETING:
+	case NVME_CTRL_DELETE_START:
 		switch (old_state) {
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_RESETTING:
@@ -362,9 +362,19 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 			break;
 		}
 		break;
+	case NVME_CTRL_DELETING:
+		switch (old_state) {
+		case NVME_CTRL_DELETE_START:
+		case NVME_CTRL_DEAD:
+			changed = true;
+			/* FALLTHRU */
+		default:
+			break;
+		}
+		break;
 	case NVME_CTRL_DEAD:
 		switch (old_state) {
-		case NVME_CTRL_DELETING:
+		case NVME_CTRL_DELETE_START:
 			changed = true;
 			/* FALLTHRU */
 		default:
@@ -398,6 +408,7 @@ static bool nvme_state_terminal(struct nvme_ctrl *ctrl)
 	case NVME_CTRL_RESETTING:
 	case NVME_CTRL_CONNECTING:
 		return false;
+	case NVME_CTRL_DELETE_START:
 	case NVME_CTRL_DELETING:
 	case NVME_CTRL_DEAD:
 		return true;
@@ -3345,6 +3356,7 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 		[NVME_CTRL_LIVE]	= "live",
 		[NVME_CTRL_RESETTING]	= "resetting",
 		[NVME_CTRL_CONNECTING]	= "connecting",
+		[NVME_CTRL_DELETE_START]= "delete started",
 		[NVME_CTRL_DELETING]	= "deleting",
 		[NVME_CTRL_DEAD]	= "dead",
 	};
@@ -3865,6 +3877,13 @@ static void nvme_scan_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, scan_work);
 
+	/*
+	 * Controller deletion started, we may issue I/O, block and prevent
+	 * the controller deletion process from completing
+	 */
+	if (ctrl->state == NVME_CTRL_DELETE_START)
+		return;
+
 	/* No tagset on a live ctrl means IO queues could not created */
 	if (ctrl->state != NVME_CTRL_LIVE || !ctrl->tagset)
 		return;
@@ -3913,6 +3932,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	if (ctrl->state == NVME_CTRL_DEAD)
 		nvme_kill_queues(ctrl);
 
+	/* prevent mpath I/O before removing namespaces */
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING);
+
 	down_write(&ctrl->namespaces_rwsem);
 	list_splice_init(&ctrl->namespaces, &ns_list);
 	up_write(&ctrl->namespaces_rwsem);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e999a8c4b7e8..e2f7b1511c02 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -824,6 +824,7 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 		 */
 		break;
 
+	case NVME_CTRL_DELETE_START:
 	case NVME_CTRL_DELETING:
 	default:
 		/* no action to take - let it delete */
@@ -3535,7 +3536,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	return &ctrl->ctrl;
 
 fail_ctrl:
-	nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
+	nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETE_START);
 	cancel_work_sync(&ctrl->ctrl.reset_work);
 	cancel_work_sync(&ctrl->err_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 18d084ed497e..ab1b95e9c46a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -167,7 +167,14 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 
 static bool nvme_path_is_disabled(struct nvme_ns *ns)
 {
-	return ns->ctrl->state != NVME_CTRL_LIVE ||
+	/*
+	 * We don't treat NVME_CTRL_DELETE_START as a disabled path
+	 * as we I/O should still be able to complete assuming that
+	 * the controller is connected, otherwize it'll fail
+	 * immediately and return to the requeue list.
+	 */
+	return (ns->ctrl->state != NVME_CTRL_LIVE &&
+		ns->ctrl->state != NVME_CTRL_DELETE_START) ||
 		test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
 		test_bit(NVME_NS_REMOVING, &ns->flags);
 }
@@ -565,6 +572,13 @@ static void nvme_ana_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, ana_work);
 
+	/*
+	 * Controller deletion started, we may issue I/O, block and prevent
+	 * the controller deletion process from completing
+	 */
+	if (ctrl->state == NVME_CTRL_DELETE_START)
+		return;
+
 	nvme_read_ana_log(ctrl);
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2ef8d501e2a8..07e35b619b6c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -178,6 +178,7 @@ enum nvme_ctrl_state {
 	NVME_CTRL_LIVE,
 	NVME_CTRL_RESETTING,
 	NVME_CTRL_CONNECTING,
+	NVME_CTRL_DELETE_START,
 	NVME_CTRL_DELETING,
 	NVME_CTRL_DEAD,
 };
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c283e8dbfb86..90a65a28365d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1244,9 +1244,9 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	 */
 	switch (dev->ctrl.state) {
 	case NVME_CTRL_CONNECTING:
-		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
+		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETE_START);
 		/* fall through */
-	case NVME_CTRL_DELETING:
+	case NVME_CTRL_DELETE_START:
 		dev_warn_ratelimited(dev->ctrl.device,
 			 "I/O %d QID %d timeout, disable controller\n",
 			 req->tag, nvmeq->qid);
@@ -2508,7 +2508,7 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
 	 * Set state to deleting now to avoid blocking nvme_wait_reset(), which
 	 * may be holding this pci_dev's device lock.
 	 */
-	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
+	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETE_START);
 	nvme_get_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, false);
 	nvme_kill_queues(&dev->ctrl);
@@ -2887,7 +2887,7 @@ static void nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
-	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
+	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETE_START);
 	pci_set_drvdata(pdev, NULL);
 
 	if (!pci_device_is_present(pdev)) {
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 13506a87a444..9eab149a0832 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1076,11 +1076,12 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
 	if (!changed) {
 		/*
-		 * state change failure is ok if we're in DELETING state,
+		 * state change failure is ok if we started ctrl delete,
 		 * unless we're during creation of a new controller to
 		 * avoid races with teardown flow.
 		 */
-		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING);
+		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETE_START &&
+			     ctrl->ctrl.state != NVME_CTRL_DELETING);
 		WARN_ON_ONCE(new);
 		ret = -EINVAL;
 		goto destroy_io;
@@ -1133,8 +1134,9 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
-		/* state change failure is ok if we're in DELETING state */
-		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING);
+		/* state change failure is ok if we started ctrl delete */
+		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETE_START &&
+			     ctrl->ctrl.state != NVME_CTRL_DELETING);
 		return;
 	}
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 860d7ddc2eee..9838ce9a19f4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1948,11 +1948,12 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE)) {
 		/*
-		 * state change failure is ok if we're in DELETING state,
+		 * state change failure is ok if we started ctrl delete,
 		 * unless we're during creation of a new controller to
 		 * avoid races with teardown flow.
 		 */
-		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING);
+		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETE_START &&
+			     ctrl->state != NVME_CTRL_DELETING);
 		WARN_ON_ONCE(new);
 		ret = -EINVAL;
 		goto destroy_io;
@@ -2008,8 +2009,9 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	blk_mq_unquiesce_queue(ctrl->admin_q);
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
-		/* state change failure is ok if we're in DELETING state */
-		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING);
+		/* state change failure is ok if we started ctrl delete */
+		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETE_START &&
+			     ctrl->state != NVME_CTRL_DELETING);
 		return;
 	}
 
@@ -2044,8 +2046,9 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 	nvme_tcp_teardown_ctrl(ctrl, false);
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
-		/* state change failure is ok if we're in DELETING state */
-		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING);
+		/* state change failure is ok if we started ctrl delete */
+		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETE_START &&
+			     ctrl->state != NVME_CTRL_DELETING);
 		return;
 	}
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
