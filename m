Return-Path: <SRS0=fGVD=A7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E302C433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 03:32:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0214C207EA
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 03:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eUCLh+rK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Svvg5uq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0214C207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GRkJH5AoCQHA8CrcKxdqrd4XLRoIubtqck+gCFWOUfU=; b=eUCLh+rK6+9v0toNSWmj346W7
	X4EvE31ZMbbE6DM886fCntYncN9KH5EElilMD3Cv/uRSw0tR7k1Ew+uZey7k2YTc4sJS3Vf6LU5qd
	ZlA5RTC7JLjJDmE/sRg1ujpLlnM/1gs1oeRcmXRFYYdGqBAuc2Xe/JttyMfPEYF1AxzEcfCPt+3K0
	134iZe7EYk/oMft3Z34DDF8ACBcx/0tAVOpUvtTM/OutPL2g2JtBpDf2a8az4HQl+H+aCFNffaUOQ
	QNsLHbiQsN8ozy0SAUp4X9tV3PsLywwOdGU7yOiJEszGo4thJzH7owXv69P7atj0uAZTHQmG4Cbus
	csae1qrVw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxMXb-0002dc-D8; Mon, 20 Jul 2020 03:32:35 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxMXX-0002cx-Vh
 for linux-nvme@lists.infradead.org; Mon, 20 Jul 2020 03:32:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1595215952; x=1626751952;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+8OVNZDzQr+h1C71w9olZsaXiXNdPUTf795F0Xz4EcE=;
 b=Svvg5uq851m7v/1YVQmRYqbYkOv2rUHLH5P/74CL+IlNo1D5ssEc0czz
 NuK8xrT/UBvGngAlPb6R1ssFSXCN75GRUh90F3+In55ZgXswKgsWgyy4V
 6yGgKsLioVPuv0fP6GFfYfn4gaQn4kY++xMXBOqKDWEkAMuB0Pffpk8Eg
 IIrx2C/Itu2NuFLhP0LaqCmbrBgtbSojFIedh1AdpZVoPIKq8LhUDKVxg
 yflpZGYARTWKxcM0DVglH1a/7mG3TI3Dv14a2jiQcmlhuKn38KSJ6XnHk
 GnOACXMWKVdC5vyBCdKGgD6d7Fp0Ci7xmAB/Z1hJ/ha1yIYl5PqC2vl2p Q==;
IronPort-SDR: 2LKPmph05nd0gyxn9wo3XRvYiwFd5JylYijVtTuS6pGklY0YfbL3319/PxuuS4gBDHkQDIzOJn
 YdASH+TB0LiyFsjPrFuak0+Obx1PrkDulc8bfKzBdEXVJtiKcL30wrjZEO9PbZ/FEMkW49LOTg
 edfQE9xRckV9GmyPhJS9gb6D1Q5GuoE8YOqelH7XGvz/KUVkeujXpxH/jG59n1qyN7uDR4BV16
 vs6ZWgM/qR6F6yVCab49jx2yXI2EKef12T8oj1Q/oN0cZZ2sHM3HkBCPBgrjZVf4VZDnjIkKEg
 YsQ=
X-IronPort-AV: E=Sophos;i="5.75,373,1589212800"; d="scan'208";a="142880922"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 11:32:30 +0800
IronPort-SDR: whFtMJmjHwzEX5wCcjiDs0R5mZsLORzK+ONkOlbMtuHWlhLgnZ9y9+R71AZyitrq6iBi00kLeW
 ahfdzfF5HWBUKkwrHA7RwD+AJPtrWFFXk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2020 20:20:15 -0700
IronPort-SDR: UpBvdEuoF1ilowoTICFx01q3L6BtkoFye1GVBL/Ns5j8iV2owjyRL38kNajEQFDI5dmnuF77jm
 oGbLXLOSJY8Q==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jul 2020 20:32:30 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH V4 2/2] nvme-core: use xarray for ctrl ns tracking
Date: Sun, 19 Jul 2020 20:32:03 -0700
Message-Id: <20200720033203.11474-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200720033203.11474-1-chaitanya.kulkarni@wdc.com>
References: <20200720033203.11474-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200719_233232_216994_AB0F6781 
X-CRM114-Status: GOOD (  20.26  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch replaces the ctrl->namespaces tracking from linked list to
xarray and improves the performance. For host even though
nvme_find_get_ns() doesn't fall into the fast path yet it does for
NVMeOF passthru patch-series which is currently under review. This
prepares us to improve performance for future NVMeOF passthru backend
since nvme_find_get_ns() uses same data structure as it does in target
to find namespace in I/O patch from nsid specified in the nvme_rw_cmd.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c      | 184 ++++++++++++++++------------------
 drivers/nvme/host/multipath.c |  15 ++-
 drivers/nvme/host/nvme.h      |   5 +-
 3 files changed, 96 insertions(+), 108 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f49085bcaa42..3f09774d2d54 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1426,9 +1426,9 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 static void nvme_update_formats(struct nvme_ctrl *ctrl, u32 *effects)
 {
 	struct nvme_ns *ns;
+	unsigned long idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	xa_for_each(&ctrl->namespaces, idx, ns)
 		if (_nvme_revalidate_disk(ns->disk))
 			nvme_set_queue_dying(ns);
 		else if (blk_queue_is_zoned(ns->disk->queue)) {
@@ -1440,7 +1440,6 @@ static void nvme_update_formats(struct nvme_ctrl *ctrl, u32 *effects)
 			 */
 			*effects |= NVME_CMD_EFFECTS_NCC;
 		}
-	up_read(&ctrl->namespaces_rwsem);
 }
 
 static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
@@ -3195,34 +3194,33 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
 {
 	struct nvme_ns *ns;
-	int ret;
+	unsigned long idx;
+	int ret = -EINVAL;
+	int count = 0;
 
-	down_read(&ctrl->namespaces_rwsem);
-	if (list_empty(&ctrl->namespaces)) {
+	if (xa_empty(&ctrl->namespaces)) {
 		ret = -ENOTTY;
-		goto out_unlock;
+		goto out;
 	}
-
-	ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
-	if (ns != list_last_entry(&ctrl->namespaces, struct nvme_ns, list)) {
-		dev_warn(ctrl->device,
-			"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
-		ret = -EINVAL;
-		goto out_unlock;
+	xa_for_each(&ctrl->namespaces, idx, ns) {
+		if (count > 0)
+			goto err;
+		count++;
 	}
 
 	dev_warn(ctrl->device,
 		"using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!\n");
 	kref_get(&ns->kref);
-	up_read(&ctrl->namespaces_rwsem);
 
 	ret = nvme_user_cmd(ctrl, ns, argp);
 	nvme_put_ns(ns);
-	return ret;
 
-out_unlock:
-	up_read(&ctrl->namespaces_rwsem);
+out:
 	return ret;
+err:
+	dev_warn(ctrl->device,
+			"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
+	goto out;
 }
 
 static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
@@ -3790,31 +3788,16 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 	return ret;
 }
 
-static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
-{
-	struct nvme_ns *nsa = container_of(a, struct nvme_ns, list);
-	struct nvme_ns *nsb = container_of(b, struct nvme_ns, list);
-
-	return nsa->head->ns_id - nsb->head->ns_id;
-}
-
 static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
-	struct nvme_ns *ns, *ret = NULL;
+	struct nvme_ns *ns;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		if (ns->head->ns_id == nsid) {
-			if (!kref_get_unless_zero(&ns->kref))
-				continue;
-			ret = ns;
-			break;
-		}
-		if (ns->head->ns_id > nsid)
-			break;
-	}
-	up_read(&ctrl->namespaces_rwsem);
-	return ret;
+	rcu_read_lock();
+	ns = xa_load(&ctrl->namespaces, nsid);
+	ns = ns && kref_get_unless_zero(&ns->kref) ? ns : NULL;
+	rcu_read_unlock();
+
+	return ns;
 }
 
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
@@ -3884,9 +3867,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		}
 	}
 
-	down_write(&ctrl->namespaces_rwsem);
-	list_add_tail(&ns->list, &ctrl->namespaces);
-	up_write(&ctrl->namespaces_rwsem);
+	ret = xa_insert(&ctrl->namespaces, nsid, ns, GFP_KERNEL);
+	if (ret)
+		goto out_unregister_nvm;
 
 	nvme_get_ctrl(ctrl);
 
@@ -3897,6 +3880,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	kfree(id);
 
 	return;
+ out_unregister_nvm:
+	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1)
+		nvme_nvm_unregister(ns);
  out_put_disk:
 	/* prevent double queue cleanup */
 	ns->disk->queue = NULL;
@@ -3929,6 +3915,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 		list_del_init(&ns->head->entry);
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
+	xa_erase(&ns->ctrl->namespaces, ns->head->ns_id);
 	synchronize_rcu(); /* guarantee not available in head->list */
 	nvme_mpath_clear_current_path(ns);
 	synchronize_srcu(&ns->head->srcu); /* wait for concurrent submissions */
@@ -3940,10 +3927,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 			blk_integrity_unregister(ns->disk);
 	}
 
-	down_write(&ns->ctrl->namespaces_rwsem);
-	list_del_init(&ns->list);
-	up_write(&ns->ctrl->namespaces_rwsem);
-
 	nvme_mpath_check_last_path(ns);
 	nvme_put_ns(ns);
 }
@@ -3974,19 +3957,31 @@ static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					unsigned nsid)
 {
-	struct nvme_ns *ns, *next;
-	LIST_HEAD(rm_list);
+	struct xarray rm_array;
+	unsigned long tnsid;
+	struct nvme_ns *ns;
+	unsigned long idx;
+	int ret;
 
-	down_write(&ctrl->namespaces_rwsem);
-	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-		if (ns->head->ns_id > nsid || test_bit(NVME_NS_DEAD, &ns->flags))
-			list_move_tail(&ns->list, &rm_list);
+	xa_init(&rm_array);
+
+	xa_lock(&ctrl->namespaces);
+	xa_for_each(&ctrl->namespaces, idx, ns) {
+		tnsid = ns->head->ns_id;
+		if (tnsid > nsid || test_bit(NVME_NS_DEAD, &ns->flags)) {
+			__xa_erase(&ctrl->namespaces, tnsid);
+			xa_unlock(&ctrl->namespaces);
+			/* Even if insert fails keep going */
+			ret = xa_insert(&rm_array, nsid, ns, GFP_KERNEL);
+			if (ret)
+				pr_err("xa_insert %d\n", ret);
+			xa_lock(&ctrl->namespaces);
+		}
 	}
-	up_write(&ctrl->namespaces_rwsem);
+	xa_unlock(&ctrl->namespaces);
 
-	list_for_each_entry_safe(ns, next, &rm_list, list)
+	xa_for_each(&rm_array, idx, ns)
 		nvme_ns_remove(ns);
-
 }
 
 static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
@@ -4084,10 +4079,6 @@ static void nvme_scan_work(struct work_struct *work)
 	if (nvme_scan_ns_list(ctrl) != 0)
 		nvme_scan_ns_sequential(ctrl);
 	mutex_unlock(&ctrl->scan_lock);
-
-	down_write(&ctrl->namespaces_rwsem);
-	list_sort(NULL, &ctrl->namespaces, ns_cmp);
-	up_write(&ctrl->namespaces_rwsem);
 }
 
 /*
@@ -4097,8 +4088,12 @@ static void nvme_scan_work(struct work_struct *work)
  */
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns, *next;
-	LIST_HEAD(ns_list);
+	struct xarray rm_array;
+	struct nvme_ns *ns;
+	unsigned long idx;
+	int ret;
+
+	xa_init(&rm_array);
 
 	/*
 	 * make sure to requeue I/O to all namespaces as these
@@ -4119,11 +4114,18 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	if (ctrl->state == NVME_CTRL_DEAD)
 		nvme_kill_queues(ctrl);
 
-	down_write(&ctrl->namespaces_rwsem);
-	list_splice_init(&ctrl->namespaces, &ns_list);
-	up_write(&ctrl->namespaces_rwsem);
+	xa_lock(&ctrl->namespaces);
+	xa_for_each(&ctrl->namespaces, idx, ns) {
+		__xa_erase(&ctrl->namespaces, ns->head->ns_id);
+		xa_unlock(&ctrl->namespaces);
+		ret = xa_insert(&rm_array, ns->head->ns_id, ns, GFP_KERNEL);
+		if (ret)
+			pr_err("xa_insert %d\n", ret);
+		xa_lock(&ctrl->namespaces);
+	}
+	xa_unlock(&ctrl->namespaces);
 
-	list_for_each_entry_safe(ns, next, &ns_list, list)
+	xa_for_each(&rm_array, idx, ns)
 		nvme_ns_remove(ns);
 }
 EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
@@ -4344,6 +4346,10 @@ static void nvme_free_ctrl(struct device *dev)
 	if (subsys && ctrl->instance != subsys->instance)
 		ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 
+	WARN_ON_ONCE(!xa_empty(&ctrl->namespaces));
+
+	xa_destroy(&ctrl->namespaces);
+
 	list_for_each_entry_safe(cel, next, &ctrl->cels, entry) {
 		list_del(&cel->entry);
 		kfree(cel);
@@ -4378,9 +4384,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->state = NVME_CTRL_NEW;
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
-	INIT_LIST_HEAD(&ctrl->namespaces);
 	INIT_LIST_HEAD(&ctrl->cels);
-	init_rwsem(&ctrl->namespaces_rwsem);
+	xa_init(&ctrl->namespaces);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
 	ctrl->quirks = quirks;
@@ -4460,98 +4465,87 @@ EXPORT_SYMBOL_GPL(nvme_init_ctrl);
 void nvme_kill_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
-
-	down_read(&ctrl->namespaces_rwsem);
+	unsigned long idx;
 
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
 	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
 		blk_mq_unquiesce_queue(ctrl->admin_q);
 
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	xa_for_each(&ctrl->namespaces, idx, ns)
 		nvme_set_queue_dying(ns);
-
-	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_kill_queues);
 
 void nvme_unfreeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	unsigned long idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	xa_for_each(&ctrl->namespaces, idx, ns)
 		blk_mq_unfreeze_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
 
 void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 {
 	struct nvme_ns *ns;
+	unsigned long idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	xa_for_each(&ctrl->namespaces, idx, ns) {
 		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
 		if (timeout <= 0)
 			break;
 	}
-	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze_timeout);
 
 void nvme_wait_freeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	unsigned long idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	xa_for_each(&ctrl->namespaces, idx, ns)
 		blk_mq_freeze_queue_wait(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze);
 
 void nvme_start_freeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	unsigned long idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	xa_for_each(&ctrl->namespaces, idx, ns)
 		blk_freeze_queue_start(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	unsigned long idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	xa_for_each(&ctrl->namespaces, idx, ns)
 		blk_mq_quiesce_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
 void nvme_start_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	unsigned long idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	xa_for_each(&ctrl->namespaces, idx, ns)
 		blk_mq_unquiesce_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
-
 void nvme_sync_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	unsigned long idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	xa_for_each(&ctrl->namespaces, idx, ns)
 		blk_sync_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
 
 	if (ctrl->admin_q)
 		blk_sync_queue(ctrl->admin_q);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 74bad4e3d377..af486864a1dc 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -115,13 +115,12 @@ bool nvme_failover_req(struct request *req)
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	unsigned long idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	xa_for_each(&ctrl->namespaces, idx, ns) {
 		if (ns->head->disk)
 			kblockd_schedule_work(&ns->head->requeue_work);
 	}
-	up_read(&ctrl->namespaces_rwsem);
 }
 
 static const char *nvme_ana_state_names[] = {
@@ -155,13 +154,12 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	unsigned long idx;
 
 	mutex_lock(&ctrl->scan_lock);
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	xa_for_each(&ctrl->namespaces, idx, ns)
 		if (nvme_mpath_clear_current_path(ns))
 			kblockd_schedule_work(&ns->head->requeue_work);
-	up_read(&ctrl->namespaces_rwsem);
 	mutex_unlock(&ctrl->scan_lock);
 }
 
@@ -495,6 +493,7 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	u32 nr_nsids = le32_to_cpu(desc->nnsids), n = 0;
 	unsigned *nr_change_groups = data;
 	struct nvme_ns *ns;
+	unsigned long idx;
 
 	dev_dbg(ctrl->device, "ANA group %d: %s.\n",
 			le32_to_cpu(desc->grpid),
@@ -506,8 +505,7 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	if (!nr_nsids)
 		return 0;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	xa_for_each(&ctrl->namespaces, idx, ns) {
 		unsigned nsid = le32_to_cpu(desc->nsids[n]);
 
 		if (ns->head->ns_id < nsid)
@@ -517,7 +515,6 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 		if (++n == nr_nsids)
 			break;
 	}
-	up_read(&ctrl->namespaces_rwsem);
 	return 0;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 13ca90bcd352..d1b9761aff9c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -212,8 +212,7 @@ struct nvme_ctrl {
 	int numa_node;
 	struct blk_mq_tag_set *tagset;
 	struct blk_mq_tag_set *admin_tagset;
-	struct list_head namespaces;
-	struct rw_semaphore namespaces_rwsem;
+	struct xarray namespaces;
 	struct device ctrl_device;
 	struct device *device;	/* char device */
 	struct cdev cdev;
@@ -388,8 +387,6 @@ enum nvme_ns_features {
 };
 
 struct nvme_ns {
-	struct list_head list;
-
 	struct nvme_ctrl *ctrl;
 	struct request_queue *queue;
 	struct gendisk *disk;
-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
