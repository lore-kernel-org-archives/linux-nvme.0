Return-Path: <SRS0=ohfr=AA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FF4C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 03:35:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42BEA20789
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 03:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TQK0dgnW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="puHUl/Bp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42BEA20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=QilSfZ3S8kH4is21++u6ZQT1yJPdPg3RP3TrLae3BrU=; b=TQK0dgnW7cerJw
	iO0cj8/u6j1eo2adwM6R5RfBraD5pWuAr83C72Z/gbb2wPJhOYe2cK/Ojc/Lzv9QuEN5b57njFPEQ
	6zlte7lI3+L+zJH5PxHTSgHHBlwnHrFmO2y0YGjlRmY8ecE+xfTZA0s+KpRj1ZGDZnq0I7JPHtXuo
	DaqBFfRwgNO+rlL9wXv3EGDRXH/Qw1MvSbetX7jXVfhgWfWxd3joApwkYNlbNzK4abBFqiI6y+upy
	/e7UIesp3gEBlYnEDIGeLNQkgonGpELNYo90gD8CTLOZVHBLa+JYZeX997pINJq+9IkqeYwzJDjou
	bhTBBKJPiH3dCPlUkEHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jm7oY-0004j2-Fg; Fri, 19 Jun 2020 03:35:38 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jm7oU-0004iV-Go
 for linux-nvme@lists.infradead.org; Fri, 19 Jun 2020 03:35:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592537735; x=1624073735;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kpLUynbb+0/quWyaMCg0QIIaeBUciJqrw8NtWa5AnRQ=;
 b=puHUl/BpJdKM8ew7dpkmp5jmNo4CXp1D+AnS12jJWj7u8d8UOUgDk3qV
 wjAcmbftrY1mqTyx6atJnrRewGjx27zw//jp7/EohTwP4BDJRESU4exQy
 0xPT7JE0W7NAuufnyAyH9jPlJOO3Ypt8cW+9lyuEWTvYw1NU5oiM3HOkD
 0E6Do5OHRQvPmffSwEYewygk1OqCeW2y7cNOUc9Qu5YTWuSk3G13NUbdu
 d49zL4D8cEMZ5VdxQVtgpDbueeDyldm5aPHWev+AindQNCxIwNpQ5y+TK
 TCayMEX2/4tFfQL+O2NLunLE5cK3nYALlIRUeNp9w8UwjkVsNG34owRKG A==;
IronPort-SDR: TmXWIVbtAFsijQsmzGkkxA4X3kuKGRmlexMV6RANJC+A1XlEK6xLRD06Tof24+Jf3xslZBJY+l
 XUixt/XHXWwX9fdrEfgTdq7VtTFemCawSyFmMuC1oVdAe7vcQhoE+pmBS+uEkwakc7Obg6aAKJ
 KiNraxYrhAxiJIq6g6N0+7sxsIAq5ov7P1SxbeEHWW+cGaSaA1QVJopq4Fe/3v/NFtXtSFfwz9
 H3/tbvq+7QeePnGQhiepvgKbJG0SHh79i7vK7O+gvDlZJHScIIgo9cri//SJ5SKkZnZqo/YfE5
 F2U=
X-IronPort-AV: E=Sophos;i="5.75,253,1589212800"; d="scan'208";a="141769039"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 11:35:33 +0800
IronPort-SDR: gKsvPR/A0NHF8/S4/H+rZSn7chAE3Wsi1apLxpA06mYB2eSBt98BXB6Um9BsY5s+wMdJYk7hW9
 d4twjObXWZl4CSzc7+uaRXGb6kVHy2opU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 20:24:11 -0700
IronPort-SDR: rBfRVEoGBGb8kjuBI23XPYeGSsw+E1gXRlFNU9gdLjjkQTLvDSNQb6mislIamdpSTPuQ0nWw/x
 mr82pGExIpXw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 18 Jun 2020 20:35:33 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH] nvme-core: use rcu in instead rw_sem
Date: Thu, 18 Jun 2020 20:35:31 -0700
Message-Id: <20200619033531.27819-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_203534_659323_F6998CBB 
X-CRM114-Status: GOOD (  18.91  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

With the NVMeOF passthru patches we call nvme_find_get_ns() in fast path
so that we can get the passthru namespace queue for I/O.

The function nvme_find_get_ns() uses ctrl->namespaces list which is
protected by ctrl->namespaces_rwsem. Until now it worked fine but with
nvme_find_get_ns() being in the fast path we need a better
synchronization mechanism. Use of rw-semaphore slows down the 
performance under high pressure I/O.

This patch removes the read-write semaphore and uses mutex lock for 
write-side critical section with read side section being protected by
RCU. Following is the performance difference:-

PT-RCU
   - 11.11% nvmet_passthru_execute_cmd
      + 5.92% blk_mq_sched_insert_request
      + 2.32% nvme_alloc_request
        0.99% nvme_find_get_ns
   - 11.28% nvmet_passthru_execute_cmd
      + 5.90% blk_mq_sched_insert_request
      + 2.42% nvme_alloc_request
        0.99% nvme_find_get_ns
   - 11.23% nvmet_passthru_execute_cmd
      + 5.79% blk_mq_sched_insert_request
      + 2.41% nvme_alloc_request
        1.06% nvme_find_get_ns

PT-SEM
   - 12.52% nvmet_passthru_execute_cmd
      + 6.07% blk_mq_sched_insert_request
      + 2.31% nvme_alloc_request
      + 2.15% nvme_find_get_ns
   - 12.51% nvmet_passthru_execute_cmd
      + 6.10% blk_mq_sched_insert_request
      + 2.27% nvme_alloc_request
      + 2.18% nvme_find_get_ns
   - 12.48% nvmet_passthru_execute_cmd
      + 6.06% blk_mq_sched_insert_request
      + 2.29% nvme_alloc_request
      + 2.17% nvme_find_get_ns

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Hi,

This is based on the nvme-5.9. I've tested the code basic stuff is
working, now trying to generate complex scenarios.

Meanwhile any feedback and suggestions are welcome.

Regards,
Chaitanya
---
 drivers/nvme/host/core.c      | 126 +++++++++++++++++++---------------
 drivers/nvme/host/multipath.c |  12 ++--
 drivers/nvme/host/nvme.h      |   2 +-
 3 files changed, 79 insertions(+), 61 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9491dbcfe81a..23f853d6163d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1376,11 +1376,11 @@ static void nvme_update_formats(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	down_read(&ctrl->namespaces_rwsem);
+	rcu_read_lock();
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		if (ns->disk && nvme_revalidate_disk(ns->disk))
 			nvme_set_queue_dying(ns);
-	up_read(&ctrl->namespaces_rwsem);
+	rcu_read_unlock();
 }
 
 static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
@@ -3059,34 +3059,39 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
 {
 	struct nvme_ns *ns;
+	int count = 0;
 	int ret;
 
-	down_read(&ctrl->namespaces_rwsem);
+	rcu_read_lock();
 	if (list_empty(&ctrl->namespaces)) {
 		ret = -ENOTTY;
 		goto out_unlock;
 	}
 
-	ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
-	if (ns != list_last_entry(&ctrl->namespaces, struct nvme_ns, list)) {
-		dev_warn(ctrl->device,
-			"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
-		ret = -EINVAL;
-		goto out_unlock;
+	/* check if there are more than one namespaces present */
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
+		count++;
+		if (count > 1)
+			goto err;
 	}
 
 	dev_warn(ctrl->device,
 		"using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!\n");
 	kref_get(&ns->kref);
-	up_read(&ctrl->namespaces_rwsem);
+	rcu_read_unlock();
 
 	ret = nvme_user_cmd(ctrl, ns, argp);
 	nvme_put_ns(ns);
 	return ret;
 
 out_unlock:
-	up_read(&ctrl->namespaces_rwsem);
+	rcu_read_unlock();
 	return ret;
+err:
+	dev_warn(ctrl->device,
+			"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
+	ret = -EINVAL;
+	goto out_unlock;
 }
 
 static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
@@ -3585,20 +3590,12 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
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
 	struct nvme_ns *ns, *ret = NULL;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		if (ns->head->ns_id == nsid) {
 			if (!kref_get_unless_zero(&ns->kref))
 				continue;
@@ -3608,10 +3605,31 @@ static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		if (ns->head->ns_id > nsid)
 			break;
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	rcu_read_unlock();
 	return ret;
 }
 
+static void nvme_ns_sorted_insert(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
+{
+	struct nvme_ns *cur;
+	bool added = false;
+
+	if (list_empty(&ctrl->namespaces)) {
+		list_add_rcu(&ns->list, &ctrl->namespaces);
+		return;
+	}
+
+	list_for_each_entry_rcu(cur, &ctrl->namespaces, list, 1) {
+		if (ns->head->ns_id < cur->head->ns_id) {
+			list_add_tail_rcu(&ns->list, &cur->list);
+			added = true;
+			break;
+		}
+	}
+	if (!added)
+		list_add_tail_rcu(&ns->list, &cur->list);
+}
+
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns;
@@ -3679,9 +3697,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		}
 	}
 
-	down_write(&ctrl->namespaces_rwsem);
-	list_add_tail(&ns->list, &ctrl->namespaces);
-	up_write(&ctrl->namespaces_rwsem);
+	mutex_lock(&ctrl->namespace_list_lock);
+	nvme_ns_sorted_insert(ctrl, ns);
+	mutex_unlock(&ctrl->namespace_list_lock);
+	synchronize_rcu();
 
 	nvme_get_ctrl(ctrl);
 
@@ -3735,9 +3754,11 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 			blk_integrity_unregister(ns->disk);
 	}
 
-	down_write(&ns->ctrl->namespaces_rwsem);
-	list_del_init(&ns->list);
-	up_write(&ns->ctrl->namespaces_rwsem);
+	mutex_lock(&ns->ctrl->namespace_list_lock);
+	list_del_rcu(&ns->list);
+	INIT_LIST_HEAD_RCU(&ns->list);
+	mutex_unlock(&ns->ctrl->namespace_list_lock);
+	synchronize_rcu();
 
 	nvme_mpath_check_last_path(ns);
 	nvme_put_ns(ns);
@@ -3772,12 +3793,13 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 	struct nvme_ns *ns, *next;
 	LIST_HEAD(rm_list);
 
-	down_write(&ctrl->namespaces_rwsem);
+	mutex_lock(&ctrl->namespace_list_lock);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
 		if (ns->head->ns_id > nsid || test_bit(NVME_NS_DEAD, &ns->flags))
 			list_move_tail(&ns->list, &rm_list);
 	}
-	up_write(&ctrl->namespaces_rwsem);
+	mutex_unlock(&ctrl->namespace_list_lock);
+	synchronize_rcu();
 
 	list_for_each_entry_safe(ns, next, &rm_list, list)
 		nvme_ns_remove(ns);
@@ -3879,10 +3901,6 @@ static void nvme_scan_work(struct work_struct *work)
 	if (nvme_scan_ns_list(ctrl) != 0)
 		nvme_scan_ns_sequential(ctrl);
 	mutex_unlock(&ctrl->scan_lock);
-
-	down_write(&ctrl->namespaces_rwsem);
-	list_sort(NULL, &ctrl->namespaces, ns_cmp);
-	up_write(&ctrl->namespaces_rwsem);
 }
 
 /*
@@ -3914,9 +3932,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	if (ctrl->state == NVME_CTRL_DEAD)
 		nvme_kill_queues(ctrl);
 
-	down_write(&ctrl->namespaces_rwsem);
-	list_splice_init(&ctrl->namespaces, &ns_list);
-	up_write(&ctrl->namespaces_rwsem);
+	mutex_lock(&ctrl->namespace_list_lock);
+	list_splice_init_rcu(&ctrl->namespaces, &ns_list, synchronize_rcu);
+	mutex_unlock(&ctrl->namespace_list_lock);
 
 	list_for_each_entry_safe(ns, next, &ns_list, list)
 		nvme_ns_remove(ns);
@@ -4170,7 +4188,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
-	init_rwsem(&ctrl->namespaces_rwsem);
+	mutex_init(&ctrl->namespace_list_lock);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
 	ctrl->quirks = quirks;
@@ -4251,7 +4269,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	down_read(&ctrl->namespaces_rwsem);
+	rcu_read_lock();
 
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
 	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
@@ -4260,7 +4278,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		nvme_set_queue_dying(ns);
 
-	up_read(&ctrl->namespaces_rwsem);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(nvme_kill_queues);
 
@@ -4268,10 +4286,10 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	down_read(&ctrl->namespaces_rwsem);
+	rcu_read_lock();
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		blk_mq_unfreeze_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
 
@@ -4279,13 +4297,13 @@ void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 {
 	struct nvme_ns *ns;
 
-	down_read(&ctrl->namespaces_rwsem);
+	rcu_read_lock();
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
 		if (timeout <= 0)
 			break;
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze_timeout);
 
@@ -4293,10 +4311,10 @@ void nvme_wait_freeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	down_read(&ctrl->namespaces_rwsem);
+	rcu_read_lock();
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		blk_mq_freeze_queue_wait(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze);
 
@@ -4304,10 +4322,10 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	down_read(&ctrl->namespaces_rwsem);
+	rcu_read_lock();
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		blk_freeze_queue_start(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
@@ -4315,10 +4333,10 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	down_read(&ctrl->namespaces_rwsem);
+	rcu_read_lock();
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		blk_mq_quiesce_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
@@ -4326,10 +4344,10 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	down_read(&ctrl->namespaces_rwsem);
+	rcu_read_lock();
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		blk_mq_unquiesce_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
@@ -4338,10 +4356,10 @@ void nvme_sync_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	down_read(&ctrl->namespaces_rwsem);
+	rcu_read_lock();
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		blk_sync_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	rcu_read_unlock();
 
 	if (ctrl->admin_q)
 		blk_sync_queue(ctrl->admin_q);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index da78e499947a..84f39d4a511f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -116,12 +116,12 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	down_read(&ctrl->namespaces_rwsem);
+	rcu_read_lock();
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		if (ns->head->disk)
 			kblockd_schedule_work(&ns->head->requeue_work);
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	rcu_read_unlock();
 }
 
 static const char *nvme_ana_state_names[] = {
@@ -157,11 +157,11 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	mutex_lock(&ctrl->scan_lock);
-	down_read(&ctrl->namespaces_rwsem);
+	rcu_read_lock();
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		if (nvme_mpath_clear_current_path(ns))
 			kblockd_schedule_work(&ns->head->requeue_work);
-	up_read(&ctrl->namespaces_rwsem);
+	rcu_read_unlock();
 	mutex_unlock(&ctrl->scan_lock);
 }
 
@@ -510,7 +510,7 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	if (!nr_nsids)
 		return 0;
 
-	down_read(&ctrl->namespaces_rwsem);
+	rcu_read_lock();
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		unsigned nsid = le32_to_cpu(desc->nsids[n]);
 
@@ -521,7 +521,7 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 		if (++n == nr_nsids)
 			break;
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	rcu_read_unlock();
 	return 0;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c0f4226d3299..49839d2db2eb 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -207,7 +207,7 @@ struct nvme_ctrl {
 	struct blk_mq_tag_set *tagset;
 	struct blk_mq_tag_set *admin_tagset;
 	struct list_head namespaces;
-	struct rw_semaphore namespaces_rwsem;
+	struct mutex namespace_list_lock;
 	struct device ctrl_device;
 	struct device *device;	/* char device */
 	struct cdev cdev;
-- 
2.26.0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
