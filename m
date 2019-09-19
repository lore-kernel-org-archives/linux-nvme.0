Return-Path: <SRS0=DlcY=XO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42CEC3A5A6
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Sep 2019 21:35:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F8C21907
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Sep 2019 21:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WPbvbMQ+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="grV8yayy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F8C21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gk/A8kUzb/9KaTs9DvkdcnZRrBgVvhhU3DB2smj0y8o=; b=WPbvbMQ+KyW1fo
	uF7iPSE07MiT2ALmUnNU2RcNRJpmwiXNNbnezfAs9WF4j9miGrLUnqa5Dx0+Zg0y4S4U3nmy5nTuH
	tckQchyEizDziZ1J4f5Bw07RFwQMBMj5pvZUwbzE2Bseze++4v9z6W5DRXUNqlXxd/x3zh+fFrqTE
	7j2WtILE12AH9wxtrmZCZHcf+Vl2yiQWgKC0eFoV2Cd/1bXvbEjfGmOH/iaPzYUvjLH6FoE/GUfQn
	XWKfs1rSIXPlROV1+9cs+H7CWck5X+SfGUKmXHfHgPZ/qDaEdNGO7Y7VHbm6qGkzvfZbGlkJYN1fA
	lisHMxjwAi25rdSCglgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iB44y-00034Y-1r; Thu, 19 Sep 2019 21:35:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iB44W-0002DU-Jp
 for linux-nvme@lists.infradead.org; Thu, 19 Sep 2019 21:34:42 +0000
Received: from washi1.fujisawa.hgst.com (unknown [199.255.47.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8C66121927;
 Thu, 19 Sep 2019 21:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1568928880;
 bh=0O1w7QHoYtDIldPDesuCxxBTClWE2JiHQCKp7ZHzNHQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=grV8yayyMLjgpimZE88XNoRq+xUPWRSBbXEHJxqpI/GZbIjPNnlHHRLGORSj5fGW7
 6ncajK0i7viVRShsA/aT0pNFbqtKSNWmI4V8FjHUuozdeTaeivu2cNAWYLLgvcZ9rV
 H4+C4itftfjcjPwy+5shS3u+Ku4oUs7/7uIhb7aA=
From: kbusch@kernel.org
To: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCHv2 2/6] nvme: Remove ADMIN_ONLY state
Date: Fri, 20 Sep 2019 06:34:27 +0900
Message-Id: <20190919213431.7864-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190919213431.7864-1-kbusch@kernel.org>
References: <20190919213431.7864-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190919_143440_688779_F05AD5DF 
X-CRM114-Status: GOOD (  16.66  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Edmund Nadolski <edmund.nadolski@intel.com>,
 James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Keith Busch <kbusch@kernel.org>

The admin only state was intended to fence off actions that don't
apply to a non-IO capable controller. The only actual user of this is
the scan_work, and pci was the only transport to ever set this state.
The consequence of having this state is placing an additional burden on
every other action that applies to both live and admin only controllers.

Remove the admin only state and place the admin only burden on the only
place that actually cares: scan_work.

This also prepares to make it easier to temporarily pause a LIVE state
so that we don't need to remember which state the controller had been in
prior to the pause.

Reviewed-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c    | 22 +++-------------------
 drivers/nvme/host/fabrics.h |  3 +--
 drivers/nvme/host/nvme.h    |  1 -
 drivers/nvme/host/pci.c     | 21 ++++++---------------
 4 files changed, 10 insertions(+), 37 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 108f60b46804..e03b1765fc01 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -113,7 +113,7 @@ static void nvme_queue_scan(struct nvme_ctrl *ctrl)
 	/*
 	 * Only new queue scan work when admin and IO queues are both alive
 	 */
-	if (ctrl->state == NVME_CTRL_LIVE)
+	if (ctrl->state == NVME_CTRL_LIVE && ctrl->tagset)
 		queue_work(nvme_wq, &ctrl->scan_work);
 }
 
@@ -134,8 +134,7 @@ int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
 	ret = nvme_reset_ctrl(ctrl);
 	if (!ret) {
 		flush_work(&ctrl->reset_work);
-		if (ctrl->state != NVME_CTRL_LIVE &&
-		    ctrl->state != NVME_CTRL_ADMIN_ONLY)
+		if (ctrl->state != NVME_CTRL_LIVE)
 			ret = -ENETRESET;
 	}
 
@@ -312,15 +311,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 
 	old_state = ctrl->state;
 	switch (new_state) {
-	case NVME_CTRL_ADMIN_ONLY:
-		switch (old_state) {
-		case NVME_CTRL_CONNECTING:
-			changed = true;
-			/* FALLTHRU */
-		default:
-			break;
-		}
-		break;
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
 		case NVME_CTRL_NEW:
@@ -336,7 +326,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		switch (old_state) {
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
-		case NVME_CTRL_ADMIN_ONLY:
 			changed = true;
 			/* FALLTHRU */
 		default:
@@ -356,7 +345,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	case NVME_CTRL_DELETING:
 		switch (old_state) {
 		case NVME_CTRL_LIVE:
-		case NVME_CTRL_ADMIN_ONLY:
 		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
 			changed = true;
@@ -2786,7 +2774,6 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 
 	switch (ctrl->state) {
 	case NVME_CTRL_LIVE:
-	case NVME_CTRL_ADMIN_ONLY:
 		break;
 	default:
 		return -EWOULDBLOCK;
@@ -3076,7 +3063,6 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 	static const char *const state_name[] = {
 		[NVME_CTRL_NEW]		= "new",
 		[NVME_CTRL_LIVE]	= "live",
-		[NVME_CTRL_ADMIN_ONLY]	= "only-admin",
 		[NVME_CTRL_RESETTING]	= "resetting",
 		[NVME_CTRL_CONNECTING]	= "connecting",
 		[NVME_CTRL_DELETING]	= "deleting",
@@ -3585,11 +3571,9 @@ static void nvme_scan_work(struct work_struct *work)
 	struct nvme_id_ctrl *id;
 	unsigned nn;
 
-	if (ctrl->state != NVME_CTRL_LIVE)
+	if (ctrl->state != NVME_CTRL_LIVE || !ctrl->tagset)
 		return;
 
-	WARN_ON_ONCE(!ctrl->tagset);
-
 	if (test_and_clear_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events)) {
 		dev_info(ctrl->device, "rescanning namespaces.\n");
 		nvme_clear_changed_ns_log(ctrl);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 93f08d77c896..a0ec40ab62ee 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -182,8 +182,7 @@ bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 static inline bool nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 		bool queue_live)
 {
-	if (likely(ctrl->state == NVME_CTRL_LIVE ||
-		   ctrl->state == NVME_CTRL_ADMIN_ONLY))
+	if (likely(ctrl->state == NVME_CTRL_LIVE))
 		return true;
 	return __nvmf_check_ready(ctrl, rq, queue_live);
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b5013c101b35..55ffae820c8f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -161,7 +161,6 @@ static inline u16 nvme_req_qid(struct request *req)
 enum nvme_ctrl_state {
 	NVME_CTRL_NEW,
 	NVME_CTRL_LIVE,
-	NVME_CTRL_ADMIN_ONLY,    /* Only admin queue live */
 	NVME_CTRL_RESETTING,
 	NVME_CTRL_CONNECTING,
 	NVME_CTRL_DELETING,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9c7bc7311817..9a9e90efcc95 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2261,10 +2261,7 @@ static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 	return true;
 }
 
-/*
- * return error value only when tagset allocation failed
- */
-static int nvme_dev_add(struct nvme_dev *dev)
+static void nvme_dev_add(struct nvme_dev *dev)
 {
 	int ret;
 
@@ -2294,7 +2291,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		if (ret) {
 			dev_warn(dev->ctrl.device,
 				"IO queues tagset allocation failed %d\n", ret);
-			return ret;
+			return;
 		}
 		dev->ctrl.tagset = &dev->tagset;
 	} else {
@@ -2305,7 +2302,6 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	}
 
 	nvme_dbbuf_set(dev);
-	return 0;
 }
 
 static int nvme_pci_enable(struct nvme_dev *dev)
@@ -2525,7 +2521,6 @@ static void nvme_reset_work(struct work_struct *work)
 		container_of(work, struct nvme_dev, ctrl.reset_work);
 	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result;
-	enum nvme_ctrl_state new_state = NVME_CTRL_LIVE;
 
 	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING)) {
 		result = -ENODEV;
@@ -2619,14 +2614,11 @@ static void nvme_reset_work(struct work_struct *work)
 		dev_warn(dev->ctrl.device, "IO queues not created\n");
 		nvme_kill_queues(&dev->ctrl);
 		nvme_remove_namespaces(&dev->ctrl);
-		new_state = NVME_CTRL_ADMIN_ONLY;
 		nvme_free_tagset(dev);
 	} else {
 		nvme_start_queues(&dev->ctrl);
 		nvme_wait_freeze(&dev->ctrl);
-		/* hit this only when allocate tagset fails */
-		if (nvme_dev_add(dev))
-			new_state = NVME_CTRL_ADMIN_ONLY;
+		nvme_dev_add(dev);
 		nvme_unfreeze(&dev->ctrl);
 	}
 
@@ -2634,9 +2626,9 @@ static void nvme_reset_work(struct work_struct *work)
 	 * If only admin queue live, keep it to do further investigation or
 	 * recovery.
 	 */
-	if (!nvme_change_ctrl_state(&dev->ctrl, new_state)) {
+	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_LIVE)) {
 		dev_warn(dev->ctrl.device,
-			"failed to mark controller state %d\n", new_state);
+			"failed to mark controller live state\n");
 		result = -ENODEV;
 		goto out;
 	}
@@ -2943,8 +2935,7 @@ static int nvme_suspend(struct device *dev)
 	nvme_wait_freeze(ctrl);
 	nvme_sync_queues(ctrl);
 
-	if (ctrl->state != NVME_CTRL_LIVE &&
-	    ctrl->state != NVME_CTRL_ADMIN_ONLY)
+	if (ctrl->state != NVME_CTRL_LIVE)
 		goto unfreeze;
 
 	ret = nvme_get_power_state(ctrl, &ndev->last_ps);
-- 
2.21.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
