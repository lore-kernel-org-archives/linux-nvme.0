Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D374C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 02:25:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E069520675
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 02:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZI+OxPVG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JSAEKyl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E069520675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=f2I1lh2MPbQiqa2WnpGRCa59KXNiFcq6k64rm9yB3Fc=; b=ZI+OxPVGwlw5rUMMengb1PfiG
	Y4vYjNlmU48xVh1DSYbnUZ7ySYFwPAw314NauXTZ1jWn5iKFretCqKaUlRQp/lU4Pk2HIo3o41k/E
	Ai22tH6JKbr/OZHGNlQjhLPhA3+4I0L/55Wj6mBTTJ2LTv5pR5/8i69HgiSF8ONDsqjVWR4rSWC86
	1p3bXEnY4iIOhtZU7nNdXOufHI8Ze5A8RnH3JET1CxBNYVns4D5HzMPmvtjPsdErdSt3fr7H5eJOd
	wD55+R3kXuQk4ty+lcshzIQ955IidPSgUyhikUJVPzC9dingLFsvfhrczeMb1NKsZvdimu0Lwr3Xy
	QDhyIerCw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqSRH-0001uU-DU; Wed, 01 Jul 2020 02:25:31 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqSRE-0001tE-L6
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 02:25:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593570329; x=1625106329;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VsLH8Favh1zUrdX2AvC3L9BwmcVN4sAQbJY5mt+twZI=;
 b=JSAEKyl3KoNjkYog1YuhxG1SMs3dhMV5DSjADDFgfgD/41cZAw2F1qMd
 2pSfYaxIjqqwL3Btmg+VRbN89+yw2OuhlR5+pAnVXq+eRVJmCxaNyr6aJ
 sskNXKG+XD68aLeNdFvrmTLUU+SF7Pj+2+7cB8BNgRRPLp34t4Mh17YAi
 l9g4SLllO+RToXTrFJISJn3soQ4pvLYOQudPPe5oT2F6ZMqefIEXCPulx
 AOvnGdPcxY6SApuAIELKQGpcAUkgzGoC/t4ZiqOugpF+SMYK5D23upX0J
 SgG7BPgWhXrmT/ux1IXwuXAIn3Hn5HJav7rMTtn9poQOzu73iGhEJMwbn g==;
IronPort-SDR: eaR5MQFNDZ6Is8e8gtlfSUMNU0NmQiwYNV5sUo9PxFFGYUYYmMkvkkQM+URJ513x1zGFmzHHWZ
 wOclyqFBtyStL2vaZ+sppY1ttRnPvmBhMkHOjX+oXJ+si37TJTYErUOy1JyGBXata9K0NDLhfH
 wcPQ4RQLOP0joaPBFbD+p4FMTqdrNafCxJG0KFr4WIFKejBOeidQ92MUDQ4j028levscGaqDCU
 l5DGGpMqUoki9r4gJKH8+DSDSRkaItI+cLH8dBgr3s7e4PUNIC1Z7lETZ6nZzoB40IIjZOHh31
 Aq4=
X-IronPort-AV: E=Sophos;i="5.75,298,1589212800"; d="scan'208";a="141536477"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 10:25:27 +0800
IronPort-SDR: NrI7dw6DS/vInLK/ZuLtBteEIauoaLM8Vu8a5qFiCQbPIFsjHUJF4KQQ9b8rjoaSoNcj273YJ9
 BGtbLCArvlxi+TgZdFAPVs2LJM5eLF2v8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 19:14:17 -0700
IronPort-SDR: Xhmh6rOoLgNFpf2U7c/+4b8p2bTmRkVzmBpWapa+rukTx6UMeXm2T8e53ANCPjkcw9iAiff4td
 FJK01wGEz+2w==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 30 Jun 2020 19:25:26 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: kbusch@kernel.org
Subject: [PATCH V2 1/2] nvme-core: use xarray for ctrl ns tracking
Date: Tue, 30 Jun 2020 19:25:16 -0700
Message-Id: <20200701022517.6738-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200701022517.6738-1-chaitanya.kulkarni@wdc.com>
References: <20200701022517.6738-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200630_222528_930139_A4DF6786 
X-CRM114-Status: GOOD (  20.80  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch replaces the ctrl->namespaces tracking from linked list to
xarray and improves the performance.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c      | 235 ++++++++++++++++++++--------------
 drivers/nvme/host/multipath.c |  15 +--
 drivers/nvme/host/nvme.h      |   5 +-
 3 files changed, 145 insertions(+), 110 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e62fdc208b27..10e1fda8a21d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -437,10 +437,8 @@ static void nvme_put_ns_head(struct nvme_ns_head *head)
 	kref_put(&head->ref, nvme_free_ns_head);
 }
 
-static void nvme_free_ns(struct kref *kref)
+static void __nvme_free_ns(struct nvme_ns *ns)
 {
-	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
-
 	if (ns->ndev)
 		nvme_nvm_unregister(ns);
 
@@ -450,6 +448,13 @@ static void nvme_free_ns(struct kref *kref)
 	kfree(ns);
 }
 
+static void nvme_free_ns(struct kref *kref)
+{
+	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
+
+	__nvme_free_ns(ns);
+}
+
 static void nvme_put_ns(struct nvme_ns *ns)
 {
 	kref_put(&ns->kref, nvme_free_ns);
@@ -1381,12 +1386,11 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 static void nvme_update_formats(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	unsigned long idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	xa_for_each(&ctrl->namespaces, idx, ns)
 		if (ns->disk && nvme_revalidate_disk(ns->disk))
 			nvme_set_queue_dying(ns);
-	up_read(&ctrl->namespaces_rwsem);
 }
 
 static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
@@ -3063,34 +3067,36 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 
 static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
 {
+	struct nvme_id_ctrl *id;
 	struct nvme_ns *ns;
-	int ret;
+	int ret = 0;
 
-	down_read(&ctrl->namespaces_rwsem);
-	if (list_empty(&ctrl->namespaces)) {
+	if (xa_empty(&ctrl->namespaces)) {
 		ret = -ENOTTY;
-		goto out_unlock;
+		goto out;
 	}
 
-	ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
-	if (ns != list_last_entry(&ctrl->namespaces, struct nvme_ns, list)) {
-		dev_warn(ctrl->device,
-			"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
+	/* Let the scan work finish updating ctrl->namespaces */
+	flush_work(&ctrl->scan_work);
+	if (nvme_identify_ctrl(ctrl, &id)) {
+		dev_err(ctrl->device, "nvme_identify_ctrl() failed\n");
 		ret = -EINVAL;
-		goto out_unlock;
+		goto out;
+	}
+	if (le32_to_cpu(id->nn) > 1) {
+		dev_warn(ctrl->device,
+		"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
+		goto out;
 	}
 
 	dev_warn(ctrl->device,
 		"using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!\n");
 	kref_get(&ns->kref);
-	up_read(&ctrl->namespaces_rwsem);
 
 	ret = nvme_user_cmd(ctrl, ns, argp);
 	nvme_put_ns(ns);
-	return ret;
-
-out_unlock:
-	up_read(&ctrl->namespaces_rwsem);
+out:
+	kfree(id);
 	return ret;
 }
 
@@ -3590,31 +3596,21 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
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
+	XA_STATE(xas, &ctrl->namespaces, nsid);
 
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
+	do {
+		ns = xas_load(&xas);
+		if (xa_is_zero(ns))
+			ns = NULL;
+	} while (xas_retry(&xas, ns));
+	ns = ns && kref_get_unless_zero(&ns->kref) ? ns : NULL;
+	rcu_read_unlock();
+
+	return ns;
 }
 
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
@@ -3684,9 +3680,19 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		}
 	}
 
-	down_write(&ctrl->namespaces_rwsem);
-	list_add_tail(&ns->list, &ctrl->namespaces);
-	up_write(&ctrl->namespaces_rwsem);
+	ret = xa_insert(&ctrl->namespaces, nsid, ns, GFP_KERNEL);
+	if (ret) {
+		switch (ret) {
+		case -ENOMEM:
+			dev_err(ctrl->device,
+				"xa insert memory allocation\n");
+			break;
+		case -EBUSY:
+			dev_err(ctrl->device,
+				"xa insert entry already present\n");
+			break;
+		}
+	}
 
 	nvme_get_ctrl(ctrl);
 
@@ -3718,6 +3724,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 static void nvme_ns_remove(struct nvme_ns *ns)
 {
+	struct xarray *xa = &ns->ctrl->namespaces;
+	bool free;
+
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
@@ -3740,12 +3749,14 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 			blk_integrity_unregister(ns->disk);
 	}
 
-	down_write(&ns->ctrl->namespaces_rwsem);
-	list_del_init(&ns->list);
-	up_write(&ns->ctrl->namespaces_rwsem);
+	xa_lock(xa);
+	__xa_erase(xa, ns->head->ns_id);
+	free = refcount_dec_and_test(&ns->kref.refcount) ? true : false;
+	xa_unlock(xa);
 
 	nvme_mpath_check_last_path(ns);
-	nvme_put_ns(ns);
+	if (free)
+		__nvme_free_ns(ns);
 }
 
 static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
@@ -3774,19 +3785,38 @@ static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
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
+			switch (ret) {
+			case -ENOMEM:
+				pr_err("xa insert memory allocation failed\n");
+				break;
+			case -EBUSY:
+				pr_err("xa insert entry already present\n");
+				break;
+			}
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
@@ -3884,10 +3914,6 @@ static void nvme_scan_work(struct work_struct *work)
 	if (nvme_scan_ns_list(ctrl) != 0)
 		nvme_scan_ns_sequential(ctrl);
 	mutex_unlock(&ctrl->scan_lock);
-
-	down_write(&ctrl->namespaces_rwsem);
-	list_sort(NULL, &ctrl->namespaces, ns_cmp);
-	up_write(&ctrl->namespaces_rwsem);
 }
 
 /*
@@ -3897,8 +3923,13 @@ static void nvme_scan_work(struct work_struct *work)
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
@@ -3919,11 +3950,30 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
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
+		/* Even if insert fails keep going */
+		ret = xa_insert(&rm_array, tnsid, ns, GFP_KERNEL);
+		if (ret) {
+			switch (ret) {
+			case -ENOMEM:
+				dev_err(ctrl->device,
+					"xa insert memory allocation\n");
+				break;
+			case -EBUSY:
+				dev_err(ctrl->device,
+					"xa insert entry already present\n");
+				break;
+			}
+		}
+		xa_lock(&ctrl->namespaces);
+	}
+	xa_unlock(&ctrl->namespaces);
 
-	list_for_each_entry_safe(ns, next, &ns_list, list)
+	xa_for_each(&rm_array, idx, ns)
 		nvme_ns_remove(ns);
 }
 EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
@@ -4144,6 +4194,9 @@ static void nvme_free_ctrl(struct device *dev)
 	if (subsys && ctrl->instance != subsys->instance)
 		ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 
+	WARN_ON_ONCE(!xa_empty(&ctrl->namespaces));
+
+	xa_destroy(&ctrl->namespaces);
 	kfree(ctrl->effects);
 	nvme_mpath_uninit(ctrl);
 	__free_page(ctrl->discard_page);
@@ -4174,8 +4227,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->state = NVME_CTRL_NEW;
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
-	INIT_LIST_HEAD(&ctrl->namespaces);
-	init_rwsem(&ctrl->namespaces_rwsem);
+	xa_init(&ctrl->namespaces);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
 	ctrl->quirks = quirks;
@@ -4255,98 +4307,87 @@ EXPORT_SYMBOL_GPL(nvme_init_ctrl);
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
index 18d084ed497e..18674735c4bc 100644
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
 
@@ -497,6 +495,7 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	u32 nr_nsids = le32_to_cpu(desc->nnsids), n = 0;
 	unsigned *nr_change_groups = data;
 	struct nvme_ns *ns;
+	unsigned long idx;
 
 	dev_dbg(ctrl->device, "ANA group %d: %s.\n",
 			le32_to_cpu(desc->grpid),
@@ -508,8 +507,7 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	if (!nr_nsids)
 		return 0;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	xa_for_each(&ctrl->namespaces, idx, ns) {
 		unsigned nsid = le32_to_cpu(desc->nsids[n]);
 
 		if (ns->head->ns_id < nsid)
@@ -519,7 +517,6 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 		if (++n == nr_nsids)
 			break;
 	}
-	up_read(&ctrl->namespaces_rwsem);
 	return 0;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2ef8d501e2a8..cff40e567bee 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -206,8 +206,7 @@ struct nvme_ctrl {
 	int numa_node;
 	struct blk_mq_tag_set *tagset;
 	struct blk_mq_tag_set *admin_tagset;
-	struct list_head namespaces;
-	struct rw_semaphore namespaces_rwsem;
+	struct xarray namespaces;
 	struct device ctrl_device;
 	struct device *device;	/* char device */
 	struct cdev cdev;
@@ -376,8 +375,6 @@ enum nvme_ns_features {
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
