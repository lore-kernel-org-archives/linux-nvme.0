Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7600C25B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 21:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EYRD4+gZk4WizP4p9em+YVZ4sWQq44kUyRcamWC81LM=; b=Z6D2cILU61PhwspAWeaBm3r2BY
	sRvTVQIAWOBSIOXPjJcWaaVdluV2g44RJnlQ1YME6IoIWlT06Hx3geBhT6Gb8EumjC7NKvOslRzZS
	LFWftE6bfKu1VZ84E4wtzQJwhEz5gnto3IK9owEK94JM9EKAz8VX03gHgv6E6ugsiGzs1pR9OQZ7l
	KHGn+SV4cdQhHxEbrjnHrgOL+NuordH6hCdFQmdgstODtS7wrK8Tt7ojkIGjNTliXkZQzlVeDRcL3
	08NC2Kv2H++lnMtYUaR+QZMjfoiQR16jHsNt+D8paEDdfXTiiXuc9r0l/UDnNW0FhEFKqIYPnq0Q8
	b3VJzmXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9tdN-00000004ATe-2vTG;
	Wed, 22 May 2024 21:36:29 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9tdK-00000004ASu-4Bsc
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 21:36:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id BB30DCE0B57;
	Wed, 22 May 2024 21:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DBDC2BBFC;
	Wed, 22 May 2024 21:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716413782;
	bh=N1FwWzcOSWZaO+shg26gJg6z1yhNQ0C9raiU4/p/750=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cEj3q1JRH6IO1TOmYXNH7ODd1EuD3J/jqXElKhK2GLJKXavMzzf4qCRnmCDDn1wUm
	 Rvy6uhn6Yjt2VncG278fQSbXGKEG4iNAN/BE/jSoPmmx7deuYvhbPnlOvyPWKi13bT
	 w6v88rX8VwpOXnpdkljnQJbpRpcuqKyX2FKsDw23cSMoV4aFAEcpPCXRwGY06db1fX
	 hnuQLdxLBRI03o8tpTr7WJdaENN+wRgskP9/k/MuuHna/oY/UDMKsQz789glcoUf8i
	 2CmdxMGSyOaY4yAuBulHz7ylC3K19Kjwdb276Dp+0naC9aBRAKllm0ZLxzhPhBX4Kx
	 0uLzjfhNrYrsw==
Date: Wed, 22 May 2024 15:36:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: silence a lockdep complaint
Message-ID: <Zk5lU1IqmLAhhSCX@kbusch-mbp.dhcp.thefacebook.com>
References: <20240522091534.472449-1-sagi@grimberg.me>
 <vjurqn5g6k5fkzqo6iz2rzkxlljrjfna3efgub3o24ol2yv55u@lx77me5f47gm>
 <Zk4ZY2n7dSztQ4Xs@kbusch-mbp.dhcp.thefacebook.com>
 <20240522162845.GA16783@lst.de>
 <a0657f0a-44af-4765-abe3-acc8a1017b40@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0657f0a-44af-4765-abe3-acc8a1017b40@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_143627_478525_D6793336 
X-CRM114-Status: GOOD (  31.90  )
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

On Wed, May 22, 2024 at 09:00:34PM +0300, Sagi Grimberg wrote:
> I don't understand lockdep well enough to do that. This warning
> exists for 6 months now. The conclusion that Keith came to (and I agreed)
> is that it can't happen, because nvme_timeout handler will not disable the
> device while the ctrl reset_work is running, the ctrl state machine will
> prevent that from happening.
> 
> There was an attempt to convert namespaces_rwsem a srcu, but my comment to
> that was that this is an intrusive change for a complaint that we think is a
> false-positive.

I'll play devil's advocate and suggest there might be some whacky
timeout_work, scan_work, reset_work, and pciehp irq that could result in
a read, write, wait, read deadlock. I don't think it can happen, but
it's harder to prove that.

The below patch is what I'm messing with. I have a CMIC PCI NVMe and
nvme native multipathing enabled, and that can recreate the lockdep
splat 100% of the time. It goes away with this patch. Non-multipath
devices are harder to hit the lockdep splat for a different reason.

From 00dd7a573d3dd14be748b46e040bb5eb0f5687b1 Mon Sep 17 00:00:00 2001
From: Keith Busch <kbusch@kernel.org>
Date: Tue, 21 May 2024 06:41:45 -0700
Subject: [PATCH] nvme: switch rwsem to srcu

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c      | 94 +++++++++++++++++++++--------------
 drivers/nvme/host/ioctl.c     | 12 ++---
 drivers/nvme/host/multipath.c | 21 ++++----
 drivers/nvme/host/nvme.h      |  3 +-
 4 files changed, 76 insertions(+), 54 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7706df2373494..480af74f1606e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3684,9 +3684,10 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns, *ret = NULL;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		if (ns->head->ns_id == nsid) {
 			if (!nvme_get_ns(ns))
 				continue;
@@ -3696,7 +3697,7 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		if (ns->head->ns_id > nsid)
 			break;
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(nvme_find_get_ns, NVME_TARGET_PASSTHRU);
@@ -3710,7 +3711,7 @@ static void nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)
 
 	list_for_each_entry_reverse(tmp, &ns->ctrl->namespaces, list) {
 		if (tmp->head->ns_id < ns->head->ns_id) {
-			list_add(&ns->list, &tmp->list);
+			list_add_rcu(&ns->list, &tmp->list);
 			return;
 		}
 	}
@@ -3776,17 +3777,17 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (nvme_update_ns_info(ns, info))
 		goto out_unlink_ns;
 
-	down_write(&ctrl->namespaces_rwsem);
+	mutex_lock(&ctrl->namespaces_lock);
 	/*
 	 * Ensure that no namespaces are added to the ctrl list after the queues
 	 * are frozen, thereby avoiding a deadlock between scan and reset.
 	 */
 	if (test_bit(NVME_CTRL_FROZEN, &ctrl->flags)) {
-		up_write(&ctrl->namespaces_rwsem);
+		mutex_unlock(&ctrl->namespaces_lock);
 		goto out_unlink_ns;
 	}
 	nvme_ns_add_to_ctrl_list(ns);
-	up_write(&ctrl->namespaces_rwsem);
+	mutex_unlock(&ctrl->namespaces_lock);
 	nvme_get_ctrl(ctrl);
 
 	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_attr_groups))
@@ -3809,9 +3810,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 
  out_cleanup_ns_from_list:
 	nvme_put_ctrl(ctrl);
-	down_write(&ctrl->namespaces_rwsem);
-	list_del_init(&ns->list);
-	up_write(&ctrl->namespaces_rwsem);
+	mutex_lock(&ctrl->namespaces_lock);
+	list_del_rcu(&ns->list);
+	mutex_unlock(&ctrl->namespaces_lock);
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
@@ -3861,10 +3862,11 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
 	del_gendisk(ns->disk);
 
-	down_write(&ns->ctrl->namespaces_rwsem);
-	list_del_init(&ns->list);
-	up_write(&ns->ctrl->namespaces_rwsem);
+	mutex_lock(&ns->ctrl->namespaces_lock);
+	list_del_rcu(&ns->list);
+	mutex_unlock(&ns->ctrl->namespaces_lock);
 
+	synchronize_srcu(&ns->ctrl->srcu);
 	if (last_path)
 		nvme_mpath_shutdown_disk(ns->head);
 	nvme_put_ns(ns);
@@ -3953,16 +3955,17 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 	struct nvme_ns *ns, *next;
 	LIST_HEAD(rm_list);
 
-	down_write(&ctrl->namespaces_rwsem);
+	mutex_lock(&ctrl->namespaces_lock);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
 		if (ns->head->ns_id > nsid)
-			list_move_tail(&ns->list, &rm_list);
+			list_splice_init_rcu(&ns->list, &rm_list, synchronize_rcu);
 	}
-	up_write(&ctrl->namespaces_rwsem);
+	mutex_unlock(&ctrl->namespaces_lock);
 
 	list_for_each_entry_safe(ns, next, &rm_list, list)
 		nvme_ns_remove(ns);
 
+	synchronize_srcu(&ctrl->srcu);
 }
 
 static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
@@ -4132,12 +4135,14 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	/* this is a no-op when called from the controller reset handler */
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
 
-	down_write(&ctrl->namespaces_rwsem);
-	list_splice_init(&ctrl->namespaces, &ns_list);
-	up_write(&ctrl->namespaces_rwsem);
+	mutex_lock(&ctrl->namespaces_lock);
+	list_splice_init_rcu(&ctrl->namespaces, &ns_list, synchronize_rcu);
+	mutex_unlock(&ctrl->namespaces_lock);
 
 	list_for_each_entry_safe(ns, next, &ns_list, list)
 		nvme_ns_remove(ns);
+
+	synchronize_srcu(&ctrl->srcu);
 }
 EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
 
@@ -4582,6 +4587,7 @@ static void nvme_free_ctrl(struct device *dev)
 	key_put(ctrl->tls_key);
 	nvme_free_cels(ctrl);
 	nvme_mpath_uninit(ctrl);
+	cleanup_srcu_struct(&ctrl->srcu);
 	nvme_auth_stop(ctrl);
 	nvme_auth_free(ctrl);
 	__free_page(ctrl->discard_page);
@@ -4614,10 +4620,15 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->passthru_err_log_enabled = false;
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
+	mutex_init(&ctrl->namespaces_lock);
+
+	ret = init_srcu_struct(&ctrl->srcu);
+	if (ret)
+		return ret;
+
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
 	xa_init(&ctrl->cels);
-	init_rwsem(&ctrl->namespaces_rwsem);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
 	ctrl->quirks = quirks;
@@ -4697,6 +4708,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 out:
 	if (ctrl->discard_page)
 		__free_page(ctrl->discard_page);
+	cleanup_srcu_struct(&ctrl->srcu);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
@@ -4705,22 +4717,24 @@ EXPORT_SYMBOL_GPL(nvme_init_ctrl);
 void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
 		blk_mark_disk_dead(ns->disk);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 EXPORT_SYMBOL_GPL(nvme_mark_namespaces_dead);
 
 void nvme_unfreeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
 		blk_mq_unfreeze_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 	clear_bit(NVME_CTRL_FROZEN, &ctrl->flags);
 }
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
@@ -4728,14 +4742,15 @@ EXPORT_SYMBOL_GPL(nvme_unfreeze);
 int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
 		if (timeout <= 0)
 			break;
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 	return timeout;
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze_timeout);
@@ -4743,23 +4758,25 @@ EXPORT_SYMBOL_GPL(nvme_wait_freeze_timeout);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
 		blk_mq_freeze_queue_wait(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze);
 
 void nvme_start_freeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
 	set_bit(NVME_CTRL_FROZEN, &ctrl->flags);
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
 		blk_freeze_queue_start(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
@@ -4802,11 +4819,12 @@ EXPORT_SYMBOL_GPL(nvme_unquiesce_admin_queue);
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
 		blk_sync_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 EXPORT_SYMBOL_GPL(nvme_sync_io_queues);
 
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 499a8bb7cac7d..0f05058692b55 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -789,16 +789,16 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
 		bool open_for_write)
 {
 	struct nvme_ns *ns;
-	int ret;
+	int ret, srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
 	if (list_empty(&ctrl->namespaces)) {
 		ret = -ENOTTY;
 		goto out_unlock;
 	}
 
-	ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
-	if (ns != list_last_entry(&ctrl->namespaces, struct nvme_ns, list)) {
+	ns = list_first_or_null_rcu(&ctrl->namespaces, struct nvme_ns, list);
+	if (!ns) {
 		dev_warn(ctrl->device,
 			"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
 		ret = -EINVAL;
@@ -808,14 +808,14 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
 	dev_warn(ctrl->device,
 		"using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!\n");
 	kref_get(&ns->kref);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 
 	ret = nvme_user_cmd(ctrl, ns, argp, 0, open_for_write);
 	nvme_put_ns(ns);
 	return ret;
 
 out_unlock:
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 	return ret;
 }
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 1bee176fd850e..d8b6b4648eaff 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -151,16 +151,17 @@ void nvme_mpath_end_request(struct request *rq)
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		if (!ns->head->disk)
 			continue;
 		kblockd_schedule_work(&ns->head->requeue_work);
 		if (nvme_ctrl_state(ns->ctrl) == NVME_CTRL_LIVE)
 			disk_uevent(ns->head->disk, KOBJ_CHANGE);
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 
 static const char *nvme_ana_state_names[] = {
@@ -194,13 +195,14 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		nvme_mpath_clear_current_path(ns);
 		kblockd_schedule_work(&ns->head->requeue_work);
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 
 void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
@@ -681,6 +683,7 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	u32 nr_nsids = le32_to_cpu(desc->nnsids), n = 0;
 	unsigned *nr_change_groups = data;
 	struct nvme_ns *ns;
+	int srcu_idx;
 
 	dev_dbg(ctrl->device, "ANA group %d: %s.\n",
 			le32_to_cpu(desc->grpid),
@@ -692,8 +695,8 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	if (!nr_nsids)
 		return 0;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		unsigned nsid;
 again:
 		nsid = le32_to_cpu(desc->nsids[n]);
@@ -706,7 +709,7 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 		if (ns->head->ns_id > nsid)
 			goto again;
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 	return 0;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index fc31bd340a63a..a005941a8b67e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -282,7 +282,8 @@ struct nvme_ctrl {
 	struct blk_mq_tag_set *tagset;
 	struct blk_mq_tag_set *admin_tagset;
 	struct list_head namespaces;
-	struct rw_semaphore namespaces_rwsem;
+	struct mutex namespaces_lock;
+	struct srcu_struct srcu;
 	struct device ctrl_device;
 	struct device *device;	/* char device */
 #ifdef CONFIG_NVME_HWMON
-- 
2.43.0


