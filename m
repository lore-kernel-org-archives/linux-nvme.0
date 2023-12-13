Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15428C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 05:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hyM6BNM/SvERv07EeW30KKvBL4fFifwbE3obfUtRdKg=; b=IzYVZ2nF6V+mlMr1rDofsbHWms
	8Pn04P4H9cQ2YmUFWfwJnF4NVvU00KSrm0fb3Gfe76IjY/LFIDlO3D5lPP7mVI38ALX+2N2ylgGku
	ptRRdghdpoJ034wLczLZrBqkDMc6cO19O0RVLqwSD8UVdu/v1Gwm7LnQn838IbDqPrDkOz2bu59X3
	R3JRAFamUWNPkqQ9iMV8MEpIEL9WIYcRylc/aysv2TqamtDpp0Q/X404DoF9OS3OlyWj6eaeEjJGE
	frbult+TkofPsvdiezy5DUoagodAeDoWBfPJt0GdBp15FDT4cvOeanbHn3MDsneDpknLwsyWTVx2B
	l7NS+FHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDHcQ-00Ddx2-2s;
	Wed, 13 Dec 2023 05:17:14 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDHcN-00Ddw7-2Q
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 05:17:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702444632; x=1733980632;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Gopr7akOGrTxYtpaVQ783/eJI4JDwqf1Np+vycVzqfk=;
  b=GJvUgGGy6Wqjqj/bGBoOAV1Dfn/7Bk1RWushTddLO2n0yfYcNPdbXq2t
   s/Wgm7I0jyXON9QQJXVXbltKsyBHa54TmB1SzchIAPP8wgdnlK5skUTVl
   XaNn6aJfyDyYZvVyQqKwGVtVsPLq0gCRCxYpPMOmj1KO6YUf0851xH5Hy
   p0OlGDQrjcEECAR2IkzYvO6C/BDZe7wWeqKdyfaxLh4AaX2OFVIJT5she
   t9upn2sp6Qsg71zjrus9bOlW8DxcYaJ1cdmcSQ7Xll5/LqKcEVShaCcPL
   VMMPf23VS9G4Zjj4uTJbB2c/e40jM6TBQQ1F6AescdTXqsRy24d0c4q3D
   g==;
X-CSE-ConnectionGUID: UHNPmqFpRViV7XX4JzjYVA==
X-CSE-MsgGUID: MmsJxj7IQ+me2FpTI3kPkA==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4699060"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 13:17:06 +0800
IronPort-SDR: yUyH7+yIYFN3USEWKGPvAktt76eCn7p2B4DCmTsRB36vjHCpT2dHqB7hr/K/Hj/SboZVJogzqO
 YeQ0p9nJ1CZg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 20:22:18 -0800
IronPort-SDR: wdK0IWpQPpWjncC835b36g2Ly40M3KHbne/LPuhYPjzW/0DJMaAYXBpjWu/nF6PtdB6jSyV9TX
 FRzs6RNrLljQ==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2023 21:17:05 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH RFC] nvme: avoid deadlock warning in sync_io_queues() path
Date: Wed, 13 Dec 2023 14:17:04 +0900
Message-ID: <20231213051704.783490-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_211711_808516_33FA18CA 
X-CRM114-Status: GOOD (  27.03  )
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

The commit c0feea594e05 ("workqueue: don't skip lockdep work dependency
in cancel_work_sync()") restored a lockdep check and it triggered
deadlock warning in sync_io_queues() path. This function locks
namespaces_rwsem for read to traverse the namespace list and calls
blk_sync_queue() for each namespace. blk_sync_queue() calls
cancel_work_sync() to wait for nvme_timeout() completion which has paths
to lock the namespaces_rwsem again for read. These two locks are both
for read, but it can cause deadlock when another task has a lock for
write. Hence, the deadlock warning was reported.

To avoid the deadlock warning, guard the namespace list by SRCU in place
of the namespaces_rwsem. This avoids the deadlock by the two read locks
since writes by other tasks do not stop the reads.

Link: https://lore.kernel.org/linux-block/20220930001943.zdbvolc3gkekfmcv@shindev/
Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
This is another attempt to avoid the lockdep WARN observed with blktests
test case block/011 in Sep/2022 (See Link). Per discussion in LSF 2023, this
WARN should be fixed. In the hallway talk, Keith advised that RCU will avoid the
WARN. I made this patch based on that suggestion. The patch can be applied on
top of v6.7-rc5 kernel. Reviews and comments will be appreciated.

 drivers/nvme/host/core.c      | 118 +++++++++++++++++++++-------------
 drivers/nvme/host/ioctl.c     |  24 +++++--
 drivers/nvme/host/multipath.c |  24 ++++---
 drivers/nvme/host/nvme.h      |   3 +-
 4 files changed, 107 insertions(+), 62 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8ebdfd623e0f..1d341b17b532 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3569,9 +3569,11 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns, *ret = NULL;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	srcu_idx = srcu_read_lock(&ctrl->namespaces_srcu);
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+		srcu_read_lock_held(&ctrl->namespaces_srcu)) {
 		if (ns->head->ns_id == nsid) {
 			if (!nvme_get_ns(ns))
 				continue;
@@ -3581,25 +3583,27 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		if (ns->head->ns_id > nsid)
 			break;
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->namespaces_srcu, srcu_idx);
 	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(nvme_find_get_ns, NVME_TARGET_PASSTHRU);
 
 /*
  * Add the namespace to the controller list while keeping the list ordered.
+ * Caller must hold ctrl->namespaces_lock.
  */
 static void nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)
 {
 	struct nvme_ns *tmp;
+	struct list_head *head = NULL;
 
-	list_for_each_entry_reverse(tmp, &ns->ctrl->namespaces, list) {
-		if (tmp->head->ns_id < ns->head->ns_id) {
-			list_add(&ns->list, &tmp->list);
-			return;
-		}
+	list_for_each_entry(tmp, &ns->ctrl->namespaces, list) {
+		if (tmp->head->ns_id < ns->head->ns_id)
+			head = &tmp->list;
 	}
-	list_add(&ns->list, &ns->ctrl->namespaces);
+	if (!head)
+		head = &ns->ctrl->namespaces;
+	list_add_rcu(&ns->list, head);
 }
 
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
@@ -3661,17 +3665,17 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (nvme_update_ns_info(ns, info))
 		goto out_unlink_ns;
 
-	down_write(&ctrl->namespaces_rwsem);
+	spin_lock(&ctrl->namespaces_lock);
 	/*
 	 * Ensure that no namespaces are added to the ctrl list after the queues
 	 * are frozen, thereby avoiding a deadlock between scan and reset.
 	 */
 	if (test_bit(NVME_CTRL_FROZEN, &ctrl->flags)) {
-		up_write(&ctrl->namespaces_rwsem);
+		spin_unlock(&ctrl->namespaces_lock);
 		goto out_unlink_ns;
 	}
 	nvme_ns_add_to_ctrl_list(ns);
-	up_write(&ctrl->namespaces_rwsem);
+	spin_unlock(&ctrl->namespaces_lock);
 	nvme_get_ctrl(ctrl);
 
 	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups))
@@ -3687,9 +3691,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 
  out_cleanup_ns_from_list:
 	nvme_put_ctrl(ctrl);
-	down_write(&ctrl->namespaces_rwsem);
-	list_del_init(&ns->list);
-	up_write(&ctrl->namespaces_rwsem);
+	spin_lock(&ctrl->namespaces_lock);
+	list_del_rcu(&ns->list);
+	spin_unlock(&ctrl->namespaces_lock);
+	synchronize_srcu(&ctrl->namespaces_srcu);
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
@@ -3739,9 +3744,10 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
 	del_gendisk(ns->disk);
 
-	down_write(&ns->ctrl->namespaces_rwsem);
-	list_del_init(&ns->list);
-	up_write(&ns->ctrl->namespaces_rwsem);
+	spin_lock(&ns->ctrl->namespaces_lock);
+	list_del_rcu(&ns->list);
+	spin_unlock(&ns->ctrl->namespaces_lock);
+	synchronize_srcu(&ns->ctrl->namespaces_srcu);
 
 	if (last_path)
 		nvme_mpath_shutdown_disk(ns->head);
@@ -3831,16 +3837,18 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 	struct nvme_ns *ns, *next;
 	LIST_HEAD(rm_list);
 
-	down_write(&ctrl->namespaces_rwsem);
+	spin_lock(&ctrl->namespaces_lock);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-		if (ns->head->ns_id > nsid)
-			list_move_tail(&ns->list, &rm_list);
+		if (ns->head->ns_id > nsid) {
+			list_del_rcu(&ns->list);
+			list_add_tail(&ns->list, &rm_list);
+		}
 	}
-	up_write(&ctrl->namespaces_rwsem);
+	spin_unlock(&ctrl->namespaces_lock);
+	synchronize_srcu(&ctrl->namespaces_srcu);
 
 	list_for_each_entry_safe(ns, next, &rm_list, list)
 		nvme_ns_remove(ns);
-
 }
 
 static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
@@ -4010,9 +4018,13 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	/* this is a no-op when called from the controller reset handler */
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
 
-	down_write(&ctrl->namespaces_rwsem);
-	list_splice_init(&ctrl->namespaces, &ns_list);
-	up_write(&ctrl->namespaces_rwsem);
+	spin_lock(&ctrl->namespaces_lock);
+	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
+		list_del_rcu(&ns->list);
+		list_add_tail(&ns->list, &ns_list);
+	}
+	spin_unlock(&ctrl->namespaces_lock);
+	synchronize_srcu(&ctrl->namespaces_srcu);
 
 	list_for_each_entry_safe(ns, next, &ns_list, list)
 		nvme_ns_remove(ns);
@@ -4465,6 +4477,8 @@ static void nvme_free_ctrl(struct device *dev)
 		mutex_unlock(&nvme_subsystems_lock);
 	}
 
+	cleanup_srcu_struct(&ctrl->namespaces_srcu);
+
 	ctrl->ops->free_ctrl(ctrl);
 
 	if (subsys)
@@ -4486,8 +4500,9 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
+	init_srcu_struct(&ctrl->namespaces_srcu);
+	spin_lock_init(&ctrl->namespaces_lock);
 	xa_init(&ctrl->cels);
-	init_rwsem(&ctrl->namespaces_rwsem);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
 	ctrl->quirks = quirks;
@@ -4567,6 +4582,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 out:
 	if (ctrl->discard_page)
 		__free_page(ctrl->discard_page);
+	cleanup_srcu_struct(&ctrl->namespaces_srcu);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
@@ -4575,22 +4591,26 @@ EXPORT_SYMBOL_GPL(nvme_init_ctrl);
 void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	srcu_idx = srcu_read_lock(&ctrl->namespaces_srcu);
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+		srcu_read_lock_held(&ctrl->namespaces_srcu))
 		blk_mark_disk_dead(ns->disk);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->namespaces_srcu, srcu_idx);
 }
 EXPORT_SYMBOL_GPL(nvme_mark_namespaces_dead);
 
 void nvme_unfreeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	srcu_idx = srcu_read_lock(&ctrl->namespaces_srcu);
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+		srcu_read_lock_held(&ctrl->namespaces_srcu))
 		blk_mq_unfreeze_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->namespaces_srcu, srcu_idx);
 	clear_bit(NVME_CTRL_FROZEN, &ctrl->flags);
 }
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
@@ -4598,14 +4618,16 @@ EXPORT_SYMBOL_GPL(nvme_unfreeze);
 int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	srcu_idx = srcu_read_lock(&ctrl->namespaces_srcu);
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+		srcu_read_lock_held(&ctrl->namespaces_srcu)) {
 		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
 		if (timeout <= 0)
 			break;
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->namespaces_srcu, srcu_idx);
 	return timeout;
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze_timeout);
@@ -4613,23 +4635,27 @@ EXPORT_SYMBOL_GPL(nvme_wait_freeze_timeout);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	srcu_idx = srcu_read_lock(&ctrl->namespaces_srcu);
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+		srcu_read_lock_held(&ctrl->namespaces_srcu))
 		blk_mq_freeze_queue_wait(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->namespaces_srcu, srcu_idx);
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze);
 
 void nvme_start_freeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
 	set_bit(NVME_CTRL_FROZEN, &ctrl->flags);
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	srcu_idx = srcu_read_lock(&ctrl->namespaces_srcu);
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+		srcu_read_lock_held(&ctrl->namespaces_srcu))
 		blk_freeze_queue_start(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->namespaces_srcu, srcu_idx);
 }
 EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
@@ -4672,11 +4698,13 @@ EXPORT_SYMBOL_GPL(nvme_unquiesce_admin_queue);
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	srcu_idx = srcu_read_lock(&ctrl->namespaces_srcu);
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+		srcu_read_lock_held(&ctrl->namespaces_srcu))
 		blk_sync_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->namespaces_srcu, srcu_idx);
 }
 EXPORT_SYMBOL_GPL(nvme_sync_io_queues);
 
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 4939ed35638f..d6c5346afb5b 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -920,17 +920,27 @@ int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
 static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
 		bool open_for_write)
 {
-	struct nvme_ns *ns;
+	struct nvme_ns *ns = NULL;
+	struct nvme_ns *n;
+	struct nvme_ns *last;
 	int ret;
+	int srcu_idx;
+
+	srcu_idx = srcu_read_lock(&ctrl->namespaces_srcu);
 
-	down_read(&ctrl->namespaces_rwsem);
-	if (list_empty(&ctrl->namespaces)) {
+	list_for_each_entry_srcu(n, &ctrl->namespaces, list,
+		srcu_read_lock_held(&ctrl->namespaces_srcu)) {
+		if (ns == NULL)
+			ns = n;
+		last = n;
+	}
+
+	if (!ns) {
 		ret = -ENOTTY;
 		goto out_unlock;
 	}
 
-	ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
-	if (ns != list_last_entry(&ctrl->namespaces, struct nvme_ns, list)) {
+	if (ns != last) {
 		dev_warn(ctrl->device,
 			"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
 		ret = -EINVAL;
@@ -940,14 +950,14 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
 	dev_warn(ctrl->device,
 		"using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!\n");
 	kref_get(&ns->kref);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->namespaces_srcu, srcu_idx);
 
 	ret = nvme_user_cmd(ctrl, ns, argp, 0, open_for_write);
 	nvme_put_ns(ns);
 	return ret;
 
 out_unlock:
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->namespaces_srcu, srcu_idx);
 	return ret;
 }
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0a88d7bdc5e3..c23252872332 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -150,16 +150,18 @@ void nvme_mpath_end_request(struct request *rq)
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	srcu_idx = srcu_read_lock(&ctrl->namespaces_srcu);
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+		srcu_read_lock_held(&ctrl->namespaces_srcu)) {
 		if (!ns->head->disk)
 			continue;
 		kblockd_schedule_work(&ns->head->requeue_work);
 		if (ctrl->state == NVME_CTRL_LIVE)
 			disk_uevent(ns->head->disk, KOBJ_CHANGE);
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->namespaces_srcu, srcu_idx);
 }
 
 static const char *nvme_ana_state_names[] = {
@@ -193,13 +195,15 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	srcu_idx = srcu_read_lock(&ctrl->namespaces_srcu);
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+		srcu_read_lock_held(&ctrl->namespaces_srcu)) {
 		nvme_mpath_clear_current_path(ns);
 		kblockd_schedule_work(&ns->head->requeue_work);
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->namespaces_srcu, srcu_idx);
 }
 
 void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
@@ -677,6 +681,7 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	u32 nr_nsids = le32_to_cpu(desc->nnsids), n = 0;
 	unsigned *nr_change_groups = data;
 	struct nvme_ns *ns;
+	int srcu_idx;
 
 	dev_dbg(ctrl->device, "ANA group %d: %s.\n",
 			le32_to_cpu(desc->grpid),
@@ -688,8 +693,9 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	if (!nr_nsids)
 		return 0;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	srcu_idx = srcu_read_lock(&ctrl->namespaces_srcu);
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+		srcu_read_lock_held(&ctrl->namespaces_srcu)) {
 		unsigned nsid;
 again:
 		nsid = le32_to_cpu(desc->nsids[n]);
@@ -702,7 +708,7 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 		if (ns->head->ns_id > nsid)
 			goto again;
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->namespaces_srcu, srcu_idx);
 	return 0;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e7411dac00f7..7543cb393d62 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -275,7 +275,8 @@ struct nvme_ctrl {
 	struct blk_mq_tag_set *tagset;
 	struct blk_mq_tag_set *admin_tagset;
 	struct list_head namespaces;
-	struct rw_semaphore namespaces_rwsem;
+	struct srcu_struct namespaces_srcu;
+	spinlock_t namespaces_lock;
 	struct device ctrl_device;
 	struct device *device;	/* char device */
 #ifdef CONFIG_NVME_HWMON
-- 
2.43.0


