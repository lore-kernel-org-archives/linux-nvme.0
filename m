Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E849C10F14
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 16:05:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D72B621835
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 16:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gOL5OGQ6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1Og/i/KP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72B621835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9vEYvkz7Rxr/yUQqFl8n5UNli2jkKaCV9L95NNgsnKA=; b=gOL5OGQ6XMB5ZX
	zaYhekyyzTYNwfPoeinSDPVTKaoSlDZK+SML9nEVrzTeKGlqbzYIND8fsbhdd+sv3bFIziFxGhHqZ
	E1qDQiyWedERWBXtcl7jwSZOKOiuTu0tw0hCIgGnbyG1nG/hbGcbyEI+HdME2Gpk8/zOvJpB1aKWB
	41Gf79pIXIFvn21/8nCPNmPPZQZErGxf8Q9nix+p6sOibN9birJ1vGhZCRJWKJQ4UkwSnQFbJ29GK
	hBW2bQNKb/98mldQgolefjtwuZWPdM2VSLDr5UD7b2QxcbaQNgqK7A+FfurLc75mTd79SHOEQ47vn
	7W5Oht6YE7UmZlt3vn1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIawt-0002Fs-8e; Thu, 10 Oct 2019 16:05:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIawY-0001xE-Jq
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 16:05:36 +0000
Received: from washi1.fujisawa.hgst.com (unknown [199.255.47.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7384921929;
 Thu, 10 Oct 2019 16:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570723534;
 bh=QAqR2nE8uPhF+OFtl/bH3J95WtPgqqLqrWv31gloulA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=1Og/i/KPREikGY+kjYzHWpxcgbbAQ3LITpBwjmWhad+hqTqrfjfUswl00W18T/taK
 PM0yrrqiebhpESpMjiZlNTPrHWXv5326L2Q0Dwy+5A7W4ymc9zyXrZ+JIamfIulQXK
 MTlc02ZnSBRKUkqUg6C0IHHdaJoOvcL/Qg8LpnyY=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCHv3 2/5] nvme: Remove ADMIN_ONLY state
Date: Fri, 11 Oct 2019 01:05:24 +0900
Message-Id: <20191010160527.22376-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010160527.22376-1-kbusch@kernel.org>
References: <20191010160527.22376-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_090534_686342_A7B17E19 
X-CRM114-Status: GOOD (  17.74  )
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
Cc: Keith Busch <kbusch@kernel.org>, Judy Brock <judy.brock@samsung.com>,
 Edmund Nadolski <edmund.nadolski@intel.com>,
 James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c    | 23 ++++-------------------
 drivers/nvme/host/fabrics.h |  3 +--
 drivers/nvme/host/nvme.h    |  1 -
 drivers/nvme/host/pci.c     | 21 ++++++---------------
 4 files changed, 11 insertions(+), 37 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fd7dea36c3b6..7a164b708863 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -116,7 +116,7 @@ static void nvme_queue_scan(struct nvme_ctrl *ctrl)
 	/*
 	 * Only new queue scan work when admin and IO queues are both alive
 	 */
-	if (ctrl->state == NVME_CTRL_LIVE)
+	if (ctrl->state == NVME_CTRL_LIVE && ctrl->tagset)
 		queue_work(nvme_wq, &ctrl->scan_work);
 }
 
@@ -137,8 +137,7 @@ int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
 	ret = nvme_reset_ctrl(ctrl);
 	if (!ret) {
 		flush_work(&ctrl->reset_work);
-		if (ctrl->state != NVME_CTRL_LIVE &&
-		    ctrl->state != NVME_CTRL_ADMIN_ONLY)
+		if (ctrl->state != NVME_CTRL_LIVE)
 			ret = -ENETRESET;
 	}
 
@@ -315,15 +314,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 
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
@@ -339,7 +329,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		switch (old_state) {
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
-		case NVME_CTRL_ADMIN_ONLY:
 			changed = true;
 			/* FALLTHRU */
 		default:
@@ -359,7 +348,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	case NVME_CTRL_DELETING:
 		switch (old_state) {
 		case NVME_CTRL_LIVE:
-		case NVME_CTRL_ADMIN_ONLY:
 		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
 			changed = true;
@@ -2874,7 +2862,6 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 
 	switch (ctrl->state) {
 	case NVME_CTRL_LIVE:
-	case NVME_CTRL_ADMIN_ONLY:
 		break;
 	default:
 		return -EWOULDBLOCK;
@@ -3168,7 +3155,6 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 	static const char *const state_name[] = {
 		[NVME_CTRL_NEW]		= "new",
 		[NVME_CTRL_LIVE]	= "live",
-		[NVME_CTRL_ADMIN_ONLY]	= "only-admin",
 		[NVME_CTRL_RESETTING]	= "resetting",
 		[NVME_CTRL_CONNECTING]	= "connecting",
 		[NVME_CTRL_DELETING]	= "deleting",
@@ -3679,11 +3665,10 @@ static void nvme_scan_work(struct work_struct *work)
 	struct nvme_id_ctrl *id;
 	unsigned nn;
 
-	if (ctrl->state != NVME_CTRL_LIVE)
+	/* No tagset on a live ctrl means IO queues could not created */
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
index 38a83ef5bcd3..2ba577271ada 100644
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
index fe24a02aa213..7d0de87d733d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2263,10 +2263,7 @@ static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 	return true;
 }
 
-/*
- * return error value only when tagset allocation failed
- */
-static int nvme_dev_add(struct nvme_dev *dev)
+static void nvme_dev_add(struct nvme_dev *dev)
 {
 	int ret;
 
@@ -2296,7 +2293,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		if (ret) {
 			dev_warn(dev->ctrl.device,
 				"IO queues tagset allocation failed %d\n", ret);
-			return ret;
+			return;
 		}
 		dev->ctrl.tagset = &dev->tagset;
 	} else {
@@ -2307,7 +2304,6 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	}
 
 	nvme_dbbuf_set(dev);
-	return 0;
 }
 
 static int nvme_pci_enable(struct nvme_dev *dev)
@@ -2527,7 +2523,6 @@ static void nvme_reset_work(struct work_struct *work)
 		container_of(work, struct nvme_dev, ctrl.reset_work);
 	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result;
-	enum nvme_ctrl_state new_state = NVME_CTRL_LIVE;
 
 	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING)) {
 		result = -ENODEV;
@@ -2621,14 +2616,11 @@ static void nvme_reset_work(struct work_struct *work)
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
 
@@ -2636,9 +2628,9 @@ static void nvme_reset_work(struct work_struct *work)
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
@@ -2945,8 +2937,7 @@ static int nvme_suspend(struct device *dev)
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
