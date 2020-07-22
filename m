Return-Path: <SRS0=li1X=BB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC47FC433E4
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 23:32:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D886206E3
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 23:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VjMIF4iO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D886206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=83ZeVia/m3v9OYGUcDahQFCC3xvW2L86oBj/LPc7smw=; b=VjMIF4iO22beZKwp6GCnHcvx4
	GclNCD704EieUWxDOVY/qQZtIfaQBFgqC0ce3IkTSI/42UbF4RteI18P+02IsHzoeHMAV1sSP6RIs
	1GG6IaG4juQhLtczpsp5BC5dO9hRdNSiq40bl0yLIJW3rGS/PXLx+6iPslxp10y2E/2NNo9yQ/iFD
	n5bQS6SRWRY+BZJ2PqMTmB7BOg+xmmm3PdZJj/i6Xgr3/LVREfh+wC8Y1Py05iYn1ID7hUjh9eH7V
	mj7nTuV+cbxIiA4dWyZiw2iYDUidj8E+auYHyUT04ola6W50lYQ9CWOVvWJf5UvtmQ8DhE/KsEiX6
	EP9/9rfPw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyOEB-0005HQ-8p; Wed, 22 Jul 2020 23:32:47 +0000
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyOE9-0005Gg-2Y
 for linux-nvme@lists.infradead.org; Wed, 22 Jul 2020 23:32:46 +0000
Received: by mail-wm1-f67.google.com with SMTP id a6so5326210wmm.0
 for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2020 16:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Em6zx0xvFgtnV+AxOs3fM0qiBCu+CreacEsYMD68yXw=;
 b=EIMGAqy5SRy1TW3iCixT1N9vUIMUX3LleJsDdeFTEj52jjTvi0mYGkZ2mIP/bYQU0M
 dkjMN0KInLJTNk/Uh+heIhmFDG4s9wsRlHCaW7a8NXvPmvhSUGCgfsvlrPlwYZGOn7Ac
 vTh5RYt0xtbbtAbs5waqB+afQnoGrJ6wZ92XPDajDwf/M2oCxXhflOOFv4xqrNRbAVbG
 TdS79Qkm2Ymlo4OiWwlgiReHUB9kEZqAYTjHOOgpsQkRdA9mzV9LnBSI5xb3euD3z47M
 5f+SJe0lI9xfcp4tpJaBI5wpnam8FKGx/ua1Klwci1d641cy2lmQBjzomHQc5BrNPD7K
 yK8g==
X-Gm-Message-State: AOAM533B+ZR4GdHNISfOOBiNOqXBmvfc+VzF2iKjFe7VBtvfwaPgZ5Kv
 QZww4FCM38rF7DaW7Tj9CEqX2Rll
X-Google-Smtp-Source: ABdhPJyh3vNLW8KSo3xDokICm3EEMwY3lsSReRyW0QFKXRAHQdOSZN4pHWqokz0GA8mVZ/2JDzRbTw==
X-Received: by 2002:a1c:2d0c:: with SMTP id t12mr1571617wmt.43.1595460763295; 
 Wed, 22 Jul 2020 16:32:43 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:45ba:2951:1398:d100])
 by smtp.gmail.com with ESMTPSA id p29sm1309108wmi.43.2020.07.22.16.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 16:32:42 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH v3 2/2] nvme-core: fix deadlock in disconnect during scan_work
 and/or ana_work
Date: Wed, 22 Jul 2020 16:32:19 -0700
Message-Id: <20200722233219.117326-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722233219.117326-1-sagi@grimberg.me>
References: <20200722233219.117326-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200722_193245_168326_B66B80DB 
X-CRM114-Status: GOOD (  23.84  )
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
Cc: Anton Eidelman <anton@lightbitslabs.com>,
 James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

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

Fix this by introducing a new state: NVME_CTRL_DELETE_NOIO, which will
indicate the phase of controller deletion where I/O cannot be allowed
to access the namespace. NVME_CTRL_DELETING still allows mpath I/O to
be issued to the bottom device, and only after we flush the ana_work
and scan_work (after nvme_stop_ctrl and nvme_prep_remove_namespaces)
we change the state to NVME_CTRL_DELETING_NOIO. Also we prevent ana_work
from re-firing by aborting early if we are not LIVE, so we should be safe
here.

In addition, change the transport drivers to follow the updated state
machine.

Fixes: 0d0b660f214d ("nvme: add ANA support")
Reported-by: Anton Eidelman <anton@lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c      | 15 +++++++++++++++
 drivers/nvme/host/fc.c        |  1 +
 drivers/nvme/host/multipath.c | 18 +++++++++++++++---
 drivers/nvme/host/nvme.h      |  6 ++++++
 drivers/nvme/host/rdma.c      | 10 ++++++----
 drivers/nvme/host/tcp.c       | 15 +++++++++------
 6 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1d7c7afb1348..c16bfdff2953 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -366,6 +366,16 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 			break;
 		}
 		break;
+	case NVME_CTRL_DELETING_NOIO:
+		switch (old_state) {
+		case NVME_CTRL_DELETING:
+		case NVME_CTRL_DEAD:
+			changed = true;
+			/* FALLTHRU */
+		default:
+			break;
+		}
+		break;
 	case NVME_CTRL_DEAD:
 		switch (old_state) {
 		case NVME_CTRL_DELETING:
@@ -403,6 +413,7 @@ static bool nvme_state_terminal(struct nvme_ctrl *ctrl)
 	case NVME_CTRL_CONNECTING:
 		return false;
 	case NVME_CTRL_DELETING:
+	case NVME_CTRL_DELETING_NOIO:
 	case NVME_CTRL_DEAD:
 		return true;
 	default:
@@ -3476,6 +3487,7 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 		[NVME_CTRL_RESETTING]	= "resetting",
 		[NVME_CTRL_CONNECTING]	= "connecting",
 		[NVME_CTRL_DELETING]	= "deleting",
+		[NVME_CTRL_DELETING_NOIO]= "deleting (no IO)",
 		[NVME_CTRL_DEAD]	= "dead",
 	};
 
@@ -4112,6 +4124,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	if (ctrl->state == NVME_CTRL_DEAD)
 		nvme_kill_queues(ctrl);
 
+	/* this is a no-op when called from the controller reset handler */
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
+
 	down_write(&ctrl->namespaces_rwsem);
 	list_splice_init(&ctrl->namespaces, &ns_list);
 	up_write(&ctrl->namespaces_rwsem);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 6aa30bb5a762..b27c54dc6683 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -826,6 +826,7 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 		break;
 
 	case NVME_CTRL_DELETING:
+	case NVME_CTRL_DELETING_NOIO:
 	default:
 		/* no action to take - let it delete */
 		break;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 74bad4e3d377..900b35d47ec7 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -167,9 +167,18 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 
 static bool nvme_path_is_disabled(struct nvme_ns *ns)
 {
-	return ns->ctrl->state != NVME_CTRL_LIVE ||
-		test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
-		test_bit(NVME_NS_REMOVING, &ns->flags);
+	/*
+	 * We don't treat NVME_CTRL_DELETING as a disabled path as I/O should
+	 * still be able to complete assuming that the controller is connected.
+	 * Otherwise it will fail immediately and return to the requeue list.
+	 */
+	if (ns->ctrl->state != NVME_CTRL_LIVE &&
+	    ns->ctrl->state != NVME_CTRL_DELETING)
+		return true;
+	if (test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
+	    test_bit(NVME_NS_REMOVING, &ns->flags))
+		return true;
+	return false;
 }
 
 static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
@@ -563,6 +572,9 @@ static void nvme_ana_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, ana_work);
 
+	if (ctrl->state != NVME_CTRL_LIVE)
+		return;
+
 	nvme_read_ana_log(ctrl);
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 92629758b77c..1609267a1f0e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -190,6 +190,11 @@ static inline u16 nvme_req_qid(struct request *req)
  * @NVME_CTRL_CONNECTING:	Controller is disconnected, now connecting the
  *				transport
  * @NVME_CTRL_DELETING:		Controller is deleting (or scheduled deletion)
+ * @NVME_CTRL_DELETING_NOIO:	Controller is deleting and I/O is not
+ *				disabled/failed immediately. This state comes
+ * 				after all async event processing took place and
+ * 				before ns removal and the controller deletion
+ * 				progress
  * @NVME_CTRL_DEAD:		Controller is non-present/unresponsive during
  *				shutdown or removal. In this case we forcibly
  *				kill all inflight I/O as they have no chance to
@@ -201,6 +206,7 @@ enum nvme_ctrl_state {
 	NVME_CTRL_RESETTING,
 	NVME_CTRL_CONNECTING,
 	NVME_CTRL_DELETING,
+	NVME_CTRL_DELETING_NOIO,
 	NVME_CTRL_DEAD,
 };
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 467da08db309..5c3848974ccb 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1102,11 +1102,12 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
 	if (!changed) {
 		/*
-		 * state change failure is ok if we're in DELETING state,
+		 * state change failure is ok if we started ctrl delete,
 		 * unless we're during creation of a new controller to
 		 * avoid races with teardown flow.
 		 */
-		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING);
+		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING &&
+			     ctrl->ctrl.state != NVME_CTRL_DELETING_NOIO);
 		WARN_ON_ONCE(new);
 		ret = -EINVAL;
 		goto destroy_io;
@@ -1159,8 +1160,9 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
-		/* state change failure is ok if we're in DELETING state */
-		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING);
+		/* state change failure is ok if we started ctrl delete */
+		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING &&
+			     ctrl->ctrl.state != NVME_CTRL_DELETING_NOIO);
 		return;
 	}
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b2e73e19ef01..8c8fb65ca928 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1950,11 +1950,12 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE)) {
 		/*
-		 * state change failure is ok if we're in DELETING state,
+		 * state change failure is ok if we started ctrl delete,
 		 * unless we're during creation of a new controller to
 		 * avoid races with teardown flow.
 		 */
-		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING);
+		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
+			     ctrl->state != NVME_CTRL_DELETING_NOIO);
 		WARN_ON_ONCE(new);
 		ret = -EINVAL;
 		goto destroy_io;
@@ -2010,8 +2011,9 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	blk_mq_unquiesce_queue(ctrl->admin_q);
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
-		/* state change failure is ok if we're in DELETING state */
-		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING);
+		/* state change failure is ok if we started ctrl delete */
+		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
+			     ctrl->state != NVME_CTRL_DELETING_NOIO);
 		return;
 	}
 
@@ -2046,8 +2048,9 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 	nvme_tcp_teardown_ctrl(ctrl, false);
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
-		/* state change failure is ok if we're in DELETING state */
-		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING);
+		/* state change failure is ok if we started ctrl delete */
+		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
+			     ctrl->state != NVME_CTRL_DELETING_NOIO);
 		return;
 	}
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
