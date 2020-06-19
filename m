Return-Path: <SRS0=ohfr=AA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C08EC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 23:36:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC5F20656
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 23:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VE7mkzby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC5F20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n8u4GWV5f1Q2TjD76Zd4JWZFlFdhE6NtMGPYICt+vQc=; b=VE7mkzbyFaF8se
	e2ofxxkCCW6qhfANX8u+4UTd5goDs7N0lLNG0cUWvLJEgknRDa7dzBNN6DjPt7yYguGzc9CGeiKHm
	wb0StQQ6d7z8B2ZklxRoAE78C8gakhcxNllRR1rLYGVW0UXVdov8UIe0p3ShoblPUbe7zS49W4t+s
	CbcidkvlTEfS97hS/aJmjozjR/gGIe6gGpzFiwRgIsp/EHoFzSror988dQjpgfxxJ8VIfvdR9FA2e
	udX1wAl0KllPVYCAOgJtBMdjqT1biFOomxHpOvV8j911Sm195j+abINTBR59iTyniiuXmHWtIRMxH
	EkMr0rDxLI5L45y22ysA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jmQY9-0007h8-P2; Fri, 19 Jun 2020 23:35:57 +0000
Received: from [2601:647:4802:9070:4430:34bd:1e1c:d6bc]
 (helo=localhost.localdomain)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jmQXC-0004Qq-VV; Fri, 19 Jun 2020 23:34:59 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH 5/5 RFC] nvme-core: fix deadlock in disconnect during
 scan_work and/or ana_work
Date: Fri, 19 Jun 2020 16:34:56 -0700
Message-Id: <20200619233456.379778-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200619233456.379778-1-sagi@grimberg.me>
References: <20200619233456.379778-1-sagi@grimberg.me>
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
Cc: Anton Eidelman <anton@lightbitslabs.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
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

Fix: disconnect sets ctrl->abort_scan_and_ana that prevents any further
scan_work or ana_work activation and flushes them before setting the ctrl
state to NVME_CTRL_DELETING.

Fixes: 0d0b660f214d ("nvme: add ANA support")
Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c      | 10 ++++++++++
 drivers/nvme/host/multipath.c |  7 +++++++
 drivers/nvme/host/nvme.h      |  1 +
 3 files changed, 18 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 28f4388c1337..85e7c7887ae8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -198,6 +198,9 @@ static void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 	 * since ->delete_ctrl can free the controller.
 	 */
 	nvme_get_ctrl(ctrl);
+	ctrl->abort_scan_and_ana = true;
+	flush_work(&ctrl->scan_work);
+	nvme_mpath_stop(ctrl);
 	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
 		nvme_do_delete_ctrl(ctrl);
 	nvme_put_ctrl(ctrl);
@@ -3865,6 +3868,13 @@ static void nvme_scan_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, scan_work);
 
+	/*
+	 * Controller deletion started, we may issue I/O, block and prevent
+	 * the controller deletion process from completing
+	 */
+	if (ctrl->abort_scan_and_ana)
+		return;
+
 	/* No tagset on a live ctrl means IO queues could not created */
 	if (ctrl->state != NVME_CTRL_LIVE || !ctrl->tagset)
 		return;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 505f5f43cd69..f20271f4a20a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -565,6 +565,13 @@ static void nvme_ana_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, ana_work);
 
+	/*
+	 * Controller deletion started, we may issue I/O, block and prevent
+	 * the controller deletion process from completing
+	 */
+	if (ctrl->abort_scan_and_ana)
+		return;
+
 	nvme_read_ana_log(ctrl);
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index eccafd52b055..8a22726b1945 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -264,6 +264,7 @@ struct nvme_ctrl {
 	struct work_struct fw_act_work;
 	unsigned long events;
 	bool created;
+	bool abort_scan_and_ana;
 
 #ifdef CONFIG_NVME_MULTIPATH
 	/* asymmetric namespace access: */
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
