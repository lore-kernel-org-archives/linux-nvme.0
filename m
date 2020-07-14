Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2E3C433E2
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 23:31:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5022065E
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 23:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1OXB1lSO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fLmfY9Lj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5022065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Jw86T39co0TZgFJHLCAG+dHJLf/YV1qznHr3F8ViTog=; b=1OXB1lSON5iVSSvKJMvrCUlY7
	brkQ3gZeTkYYrf1ZBs/hAPZrBYoZuNDY52s2HT1A/nBRUEQaaFmx18w4dPhAEMbGS9UW4GmTFFS0k
	7g5ZMpgRwpR+P1SS6wK0Wx7SZ2mt19wVHZAEyZsm7oWB6R/rHZcH1A7AOJIF5Ii3gSb/wVUOZdKUA
	2Rb+PdnaayjKWfnSWGTmOeoVf6C8A40VuzY9x9T44nsOYgkqOnarDqYXy0FIFUKox2a4W5XPLQTuO
	l795FSlv84duGqWLwjEeSWliUScn1NE71o8Yyo+0ier+hPUtRQ1L2HN7cV7de4z2k0ksggmfteGcC
	UiHJRwazg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvUOh-0005Mh-Hh; Tue, 14 Jul 2020 23:31:39 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvUOe-0005LS-CS
 for linux-nvme@lists.infradead.org; Tue, 14 Jul 2020 23:31:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594769496; x=1626305496;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VTn2wGzScHffFFqf/WYaKGwXwCiwDs8mcgRD4LNnKFg=;
 b=fLmfY9LjD1GYjdvW3bGSUXo6xhdRjl0oGob4iVMsyyJTVf1QP3Kt6yud
 tPt+IeQf4MXZrJMJ9e6BcFOmPNKi0D/oeZAD1vXoSVY+Mgw3df0RpA2ef
 /XWbALAW1PFIpUGFWTU4H+ZBDEIvRY2UKNOloQTOQ2vBiYB+4q/XvgKII
 uJsqV8mBl0qz0Aerzk2cC+nAfzGVuR6iajzZHX+1zjePEkJG5q0i2KlNA
 UI4iYMhyRe7Rs+VhbKvJWoZlOYGNgT5Br3ohK6E/qxgjZISLpofqg4Kp0
 FnXN2bYawAo6zkewsIrEMNl2VyWAv7zHA9p8QjRQmph27thxy2z5aIdIu g==;
IronPort-SDR: 8puaTObNCPxnxiyPXB4IO9Qs2sqWBu9QC8wd0DIyEk+OaB0vjWj4lF4nPRCCm+f6Uh9y4ERrue
 vaKnRLf1mjeMgXIUpUv3x5zvjbpY3JbEVQDXv+q6v5CU4J8OwUI1JWgLo4ijAG6PWyRFTwXeJ5
 aYLjtxs2TS2h+Nh60GANWQBKIom8oXNwTeL20zTyWm8vjBYHSlevFgap/Ym9IQMVYnapMMGWTT
 cWZpSnd9Y5SCQ3agBrAuWsLecHq9SVy2rNTzWXLyJ9xwhF52z8TJAMqtX4l1tys1Y6w3qSspON
 zbU=
X-IronPort-AV: E=Sophos;i="5.75,353,1589212800"; d="scan'208";a="143774904"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2020 07:31:33 +0800
IronPort-SDR: TQvC4mbGzR7xWy9mkuvrvw3PezueyFayhkS8zQmd00u38jWOtgPp+BL/gbGIxetdkvEtEjkIS2
 pD5b/nDFatcS92d6uKRwBlHxlyVUJm/vw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 16:19:26 -0700
IronPort-SDR: b1/UlSVcCFP025PyyJ8LgtvP336J8MdizLlum1J3ikr3NsuXFUMsm7gvysgdIG7QJ4ih0gZ3La
 UWXwCCx/NdCA==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Jul 2020 16:31:33 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	willy@infradead.org
Subject: [PATCH V3 02/10] nvme-core: use xarray for ctrl ns tracking
Date: Tue, 14 Jul 2020 16:30:49 -0700
Message-Id: <20200714233057.10915-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
References: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_193136_660179_E9ACDD5B 
X-CRM114-Status: GOOD (  21.68  )
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
 drivers/nvme/host/core.c      | 188 ++++++++++++++++------------------
 drivers/nvme/host/multipath.c |  15 ++-
 drivers/nvme/host/nvme.h      |   5 +-
 3 files changed, 98 insertions(+), 110 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b9b4aa7b53ce..297835bda996 100644
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
@@ -3188,34 +3187,33 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
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
@@ -3783,31 +3781,16 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
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
+	ns = __xa_load(&ctrl->namespaces, nsid);
+	ns = ns && kref_get_unless_zero(&ns->kref) ? ns : NULL;
+	rcu_read_unlock();
+
+	return ns;
 }
 
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
@@ -3877,9 +3860,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		}
 	}
 
-	down_write(&ctrl->namespaces_rwsem);
-	list_add_tail(&ns->list, &ctrl->namespaces);
-	up_write(&ctrl->namespaces_rwsem);
+	ret = xa_insert(&ctrl->namespaces, nsid, ns, GFP_KERNEL);
+	if (ret)
+		goto out_put_disk;
 
 	nvme_get_ctrl(ctrl);
 
@@ -3911,6 +3894,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 static void nvme_ns_remove(struct nvme_ns *ns)
 {
+	struct xarray *xa = &ns->ctrl->namespaces;
+
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
@@ -3933,9 +3918,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 			blk_integrity_unregister(ns->disk);
 	}
 
-	down_write(&ns->ctrl->namespaces_rwsem);
-	list_del_init(&ns->list);
-	up_write(&ns->ctrl->namespaces_rwsem);
+	xa_erase(xa, ns->head->ns_id);
 
 	nvme_mpath_check_last_path(ns);
 	nvme_put_ns(ns);
@@ -3967,19 +3950,32 @@ static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					unsigned nsid)
 {
-	struct nvme_ns *ns, *next;
-	LIST_HEAD(rm_list);
+	struct xarray *namespaces = &ctrl->namespaces;
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
+	xa_lock(namespaces);
+	xa_for_each(namespaces, idx, ns) {
+		tnsid = ns->head->ns_id;
+		if (tnsid > nsid || test_bit(NVME_NS_DEAD, &ns->flags)) {
+			xa_unlock(namespaces);
+			xa_erase(namespaces, tnsid);
+			/* Even if insert fails keep going */
+			ret = xa_insert(&rm_array, nsid, ns, GFP_KERNEL);
+			if (ret)
+				pr_err("xa_insert %d\n", ret);
+			xa_lock(namespaces);
+		}
 	}
-	up_write(&ctrl->namespaces_rwsem);
+	xa_unlock(namespaces);
 
-	list_for_each_entry_safe(ns, next, &rm_list, list)
+	xa_for_each(&rm_array, idx, ns)
 		nvme_ns_remove(ns);
-
 }
 
 static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
@@ -4077,10 +4073,6 @@ static void nvme_scan_work(struct work_struct *work)
 	if (nvme_scan_ns_list(ctrl) != 0)
 		nvme_scan_ns_sequential(ctrl);
 	mutex_unlock(&ctrl->scan_lock);
-
-	down_write(&ctrl->namespaces_rwsem);
-	list_sort(NULL, &ctrl->namespaces, ns_cmp);
-	up_write(&ctrl->namespaces_rwsem);
 }
 
 /*
@@ -4090,8 +4082,13 @@ static void nvme_scan_work(struct work_struct *work)
  */
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns, *next;
-	LIST_HEAD(ns_list);
+	struct xarray rm_array;
+	unsigned long tnsid;
+	struct nvme_ns *ns;
+	unsigned long idx;
+	int ret;
+
+	xa_init(&rm_array);
 
 	/*
 	 * make sure to requeue I/O to all namespaces as these
@@ -4112,11 +4109,19 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	if (ctrl->state == NVME_CTRL_DEAD)
 		nvme_kill_queues(ctrl);
 
-	down_write(&ctrl->namespaces_rwsem);
-	list_splice_init(&ctrl->namespaces, &ns_list);
-	up_write(&ctrl->namespaces_rwsem);
+	xa_lock(&ctrl->namespaces);
+	xa_for_each(&ctrl->namespaces, idx, ns) {
+		tnsid = ns->head->ns_id;
+		xa_unlock(&ctrl->namespaces);
+		xa_erase(&ctrl->namespaces, tnsid);
+		ret = xa_insert(&rm_array, tnsid, ns, GFP_KERNEL);
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
@@ -4338,6 +4343,10 @@ static void nvme_free_ctrl(struct device *dev)
 	if (subsys && ctrl->instance != subsys->instance)
 		ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 
+	WARN_ON_ONCE(!xa_empty(&ctrl->namespaces));
+
+	xa_destroy(&ctrl->namespaces);
+
 	list_for_each_entry_safe(cel, next, &ctrl->cels, entry) {
 		list_del(&cel->entry);
 		kfree(cel);
@@ -4372,9 +4381,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
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
@@ -4454,101 +4462,87 @@ EXPORT_SYMBOL_GPL(nvme_init_ctrl);
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
-
-	if (ctrl->admin_q)
-		blk_sync_queue(ctrl->admin_q);
 }
 EXPORT_SYMBOL_GPL(nvme_sync_queues);
 
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
index 25dae702e0a2..1e8dedee74df 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -220,8 +220,7 @@ struct nvme_ctrl {
 	int numa_node;
 	struct blk_mq_tag_set *tagset;
 	struct blk_mq_tag_set *admin_tagset;
-	struct list_head namespaces;
-	struct rw_semaphore namespaces_rwsem;
+	struct xarray namespaces;
 	struct device ctrl_device;
 	struct device *device;	/* char device */
 	struct cdev cdev;
@@ -395,8 +394,6 @@ enum nvme_ns_features {
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
