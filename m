Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF98C25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 17:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6J6lYJM9ssqLkSZEFOkNQo5gY6ZXVSMGoZHPVHfb0mY=; b=0/RKoJjIaaRwrnbyEeDWwyQAz1
	RAJo/eAmx1U7Oautn3BYR6sQ+QCUUYNtVEVrKaWqwcgBY3eXFL51Zni/0ME0W4gJApfUTSysVQLFL
	LYdF5XHIGQt+JAUJJ4B8lA83Clst10kDmcqy0UN80dwjXizhI8yIZ2yw6msyfSip9skHYhzlv0P2N
	WYfsrcCNqHDCeUtyrH2Ij1AQRRE8RozahxsLgR3g5CWh9OH2W3ZL2dWAHIiMjnC8UtWlFUf9gL/7l
	LEznBwwEbIEPz91SztDz/2riCPcc3ipEzrByi8Ws1B+g+StifJrMpm8Lw1fyfeJ0wN9O4ZAG/MM/9
	BVjBNPbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAC7u-00000006smJ-2evZ;
	Thu, 23 May 2024 17:21:14 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAC7r-00000006slQ-2dF8
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 17:21:14 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44NHF8pm004744
	for <linux-nvme@lists.infradead.org>; Thu, 23 May 2024 10:21:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=6J6lYJM9ssqLkSZEFOkNQo5gY6ZXVSMGoZHPVHfb0mY=;
 b=G2F1/LZRPxhmVrVUU18sejduMuLaciuQZx4XxWq3bXiA7kVicz6RKlAHIDmuXuMuaPkb
 U8u3S/8ZD8ewTwPExYD5okZWFk7xCNB/BJK32XTM+4dLMn/9a7uLCIqsiuRyswIkl6Os
 oeA9O8lhmSMgVXOXocrq12naBYWRpPEwrRB5go4bYU/KfOlSsR8lEOMVZp6a3op3dG9z
 Xnqz02d6oSF9hS/0tftMVyITBBZ2IYcfajGDzKIKgDPzzCK8q4bH3LlLSBDzhZfYaZdO
 P3adyjU35DHOciIp43L8dEY81NmXzr8KRAVFHlb1B4gfOhu73DeDAscw5xS/5ayAVt4X dw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ya46bjsh1-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 23 May 2024 10:21:09 -0700
Received: from twshared15377.32.frc3.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 23 May 2024 17:21:08 +0000
Received: by devbig032.nao3.facebook.com (Postfix, from userid 544533)
	id 2CB712DF133B; Thu, 23 May 2024 10:20:58 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <shinichiro.kawasaki@wdc.com>,
        <hch@lst.de>, <sagi@grimberg.me>
CC: <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2] nvme: use srcu for iterating namespace list
Date: Thu, 23 May 2024 10:20:50 -0700
Message-ID: <20240523172050.4080218-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: kfOTIwF0auBwelC-y48M7NXr4VBi8hkV
X-Proofpoint-ORIG-GUID: kfOTIwF0auBwelC-y48M7NXr4VBi8hkV
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_10,2024-05-23_01,2024-05-17_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_102111_748370_A13044AE 
X-CRM114-Status: GOOD (  22.85  )
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

From: Keith Busch <kbusch@kernel.org>

The nvme pci driver synchronizes with all the namespace queues during a
reset to ensure that there's no pending timeout work.

Meanwhile the timeout work potentially iterates those same namespaces to
freeze their queues.

Each of those namespace iterations use the same read lock. If a write
lock should somehow get between the synchronize and freeze steps, then
forward progress is deadlocked.

We had been relying on the nvme controller state machine to ensure the
reset work wouldn't conflict with timeout work. That guarantee may be a
bit fragile to rely on, so iterate the namespace lists without taking a
lock to fix potential circular locks, as reported by lockdep.

Link: https://lore.kernel.org/all/20220930001943.zdbvolc3gkekfmcv@shindev/
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2:
  Improved changelog

 drivers/nvme/host/core.c      | 97 +++++++++++++++++++++--------------
 drivers/nvme/host/ioctl.c     | 12 ++---
 drivers/nvme/host/multipath.c | 21 ++++----
 drivers/nvme/host/nvme.h      |  3 +-
 4 files changed, 78 insertions(+), 55 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7706df2373494..b7cd46f3cef69 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3684,9 +3684,10 @@ static int nvme_init_ns_head(struct nvme_ns *ns, str=
uct nvme_ns_info *info)
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns, *ret =3D NULL;
+	int srcu_idx;
=20
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	srcu_idx =3D srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		if (ns->head->ns_id =3D=3D nsid) {
 			if (!nvme_get_ns(ns))
 				continue;
@@ -3696,7 +3697,7 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ct=
rl, unsigned nsid)
 		if (ns->head->ns_id > nsid)
 			break;
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(nvme_find_get_ns, NVME_TARGET_PASSTHRU);
@@ -3710,7 +3711,7 @@ static void nvme_ns_add_to_ctrl_list(struct nvme_ns *=
ns)
=20
 	list_for_each_entry_reverse(tmp, &ns->ctrl->namespaces, list) {
 		if (tmp->head->ns_id < ns->head->ns_id) {
-			list_add(&ns->list, &tmp->list);
+			list_add_rcu(&ns->list, &tmp->list);
 			return;
 		}
 	}
@@ -3776,17 +3777,18 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, s=
truct nvme_ns_info *info)
 	if (nvme_update_ns_info(ns, info))
 		goto out_unlink_ns;
=20
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
+	synchronize_srcu(&ctrl->srcu);
 	nvme_get_ctrl(ctrl);
=20
 	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_attr_groups))
@@ -3809,9 +3811,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, st=
ruct nvme_ns_info *info)
=20
  out_cleanup_ns_from_list:
 	nvme_put_ctrl(ctrl);
-	down_write(&ctrl->namespaces_rwsem);
-	list_del_init(&ns->list);
-	up_write(&ctrl->namespaces_rwsem);
+	mutex_lock(&ctrl->namespaces_lock);
+	list_del_rcu(&ns->list);
+	mutex_unlock(&ctrl->namespaces_lock);
+	synchronize_srcu(&ctrl->srcu);
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
@@ -3861,9 +3864,10 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
 	del_gendisk(ns->disk);
=20
-	down_write(&ns->ctrl->namespaces_rwsem);
-	list_del_init(&ns->list);
-	up_write(&ns->ctrl->namespaces_rwsem);
+	mutex_lock(&ns->ctrl->namespaces_lock);
+	list_del_rcu(&ns->list);
+	mutex_unlock(&ns->ctrl->namespaces_lock);
+	synchronize_srcu(&ns->ctrl->srcu);
=20
 	if (last_path)
 		nvme_mpath_shutdown_disk(ns->head);
@@ -3953,16 +3957,17 @@ static void nvme_remove_invalid_namespaces(struct n=
vme_ctrl *ctrl,
 	struct nvme_ns *ns, *next;
 	LIST_HEAD(rm_list);
=20
-	down_write(&ctrl->namespaces_rwsem);
+	mutex_lock(&ctrl->namespaces_lock);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
 		if (ns->head->ns_id > nsid)
-			list_move_tail(&ns->list, &rm_list);
+			list_splice_init_rcu(&ns->list, &rm_list,
+					     synchronize_rcu);
 	}
-	up_write(&ctrl->namespaces_rwsem);
+	mutex_unlock(&ctrl->namespaces_lock);
+	synchronize_srcu(&ctrl->srcu);
=20
 	list_for_each_entry_safe(ns, next, &rm_list, list)
 		nvme_ns_remove(ns);
-
 }
=20
 static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
@@ -4132,9 +4137,10 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	/* this is a no-op when called from the controller reset handler */
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
=20
-	down_write(&ctrl->namespaces_rwsem);
-	list_splice_init(&ctrl->namespaces, &ns_list);
-	up_write(&ctrl->namespaces_rwsem);
+	mutex_lock(&ctrl->namespaces_lock);
+	list_splice_init_rcu(&ctrl->namespaces, &ns_list, synchronize_rcu);
+	mutex_unlock(&ctrl->namespaces_lock);
+	synchronize_srcu(&ctrl->srcu);
=20
 	list_for_each_entry_safe(ns, next, &ns_list, list)
 		nvme_ns_remove(ns);
@@ -4582,6 +4588,7 @@ static void nvme_free_ctrl(struct device *dev)
 	key_put(ctrl->tls_key);
 	nvme_free_cels(ctrl);
 	nvme_mpath_uninit(ctrl);
+	cleanup_srcu_struct(&ctrl->srcu);
 	nvme_auth_stop(ctrl);
 	nvme_auth_free(ctrl);
 	__free_page(ctrl->discard_page);
@@ -4614,10 +4621,15 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct d=
evice *dev,
 	ctrl->passthru_err_log_enabled =3D false;
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
+	mutex_init(&ctrl->namespaces_lock);
+
+	ret =3D init_srcu_struct(&ctrl->srcu);
+	if (ret)
+		return ret;
+
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
 	xa_init(&ctrl->cels);
-	init_rwsem(&ctrl->namespaces_rwsem);
 	ctrl->dev =3D dev;
 	ctrl->ops =3D ops;
 	ctrl->quirks =3D quirks;
@@ -4697,6 +4709,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct dev=
ice *dev,
 out:
 	if (ctrl->discard_page)
 		__free_page(ctrl->discard_page);
+	cleanup_srcu_struct(&ctrl->srcu);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
@@ -4705,22 +4718,24 @@ EXPORT_SYMBOL_GPL(nvme_init_ctrl);
 void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
=20
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	srcu_idx =3D srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
 		blk_mark_disk_dead(ns->disk);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 EXPORT_SYMBOL_GPL(nvme_mark_namespaces_dead);
=20
 void nvme_unfreeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
=20
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	srcu_idx =3D srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
 		blk_mq_unfreeze_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 	clear_bit(NVME_CTRL_FROZEN, &ctrl->flags);
 }
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
@@ -4728,14 +4743,15 @@ EXPORT_SYMBOL_GPL(nvme_unfreeze);
 int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
=20
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	srcu_idx =3D srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		timeout =3D blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
 		if (timeout <=3D 0)
 			break;
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 	return timeout;
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze_timeout);
@@ -4743,23 +4759,25 @@ EXPORT_SYMBOL_GPL(nvme_wait_freeze_timeout);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
=20
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	srcu_idx =3D srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
 		blk_mq_freeze_queue_wait(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze);
=20
 void nvme_start_freeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
=20
 	set_bit(NVME_CTRL_FROZEN, &ctrl->flags);
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	srcu_idx =3D srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
 		blk_freeze_queue_start(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 EXPORT_SYMBOL_GPL(nvme_start_freeze);
=20
@@ -4802,11 +4820,12 @@ EXPORT_SYMBOL_GPL(nvme_unquiesce_admin_queue);
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
=20
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	srcu_idx =3D srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
 		blk_sync_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 EXPORT_SYMBOL_GPL(nvme_sync_io_queues);
=20
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 499a8bb7cac7d..0f05058692b55 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -789,16 +789,16 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, =
void __user *argp,
 		bool open_for_write)
 {
 	struct nvme_ns *ns;
-	int ret;
+	int ret, srcu_idx;
=20
-	down_read(&ctrl->namespaces_rwsem);
+	srcu_idx =3D srcu_read_lock(&ctrl->srcu);
 	if (list_empty(&ctrl->namespaces)) {
 		ret =3D -ENOTTY;
 		goto out_unlock;
 	}
=20
-	ns =3D list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
-	if (ns !=3D list_last_entry(&ctrl->namespaces, struct nvme_ns, list)) {
+	ns =3D list_first_or_null_rcu(&ctrl->namespaces, struct nvme_ns, list);
+	if (!ns) {
 		dev_warn(ctrl->device,
 			"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
 		ret =3D -EINVAL;
@@ -808,14 +808,14 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, =
void __user *argp,
 	dev_warn(ctrl->device,
 		"using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!\n");
 	kref_get(&ns->kref);
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
=20
 	ret =3D nvme_user_cmd(ctrl, ns, argp, 0, open_for_write);
 	nvme_put_ns(ns);
 	return ret;
=20
 out_unlock:
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 	return ret;
 }
=20
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 1bee176fd850e..d8b6b4648eaff 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -151,16 +151,17 @@ void nvme_mpath_end_request(struct request *rq)
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
=20
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	srcu_idx =3D srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		if (!ns->head->disk)
 			continue;
 		kblockd_schedule_work(&ns->head->requeue_work);
 		if (nvme_ctrl_state(ns->ctrl) =3D=3D NVME_CTRL_LIVE)
 			disk_uevent(ns->head->disk, KOBJ_CHANGE);
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
=20
 static const char *nvme_ana_state_names[] =3D {
@@ -194,13 +195,14 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	int srcu_idx;
=20
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	srcu_idx =3D srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		nvme_mpath_clear_current_path(ns);
 		kblockd_schedule_work(&ns->head->requeue_work);
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
=20
 void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
@@ -681,6 +683,7 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	u32 nr_nsids =3D le32_to_cpu(desc->nnsids), n =3D 0;
 	unsigned *nr_change_groups =3D data;
 	struct nvme_ns *ns;
+	int srcu_idx;
=20
 	dev_dbg(ctrl->device, "ANA group %d: %s.\n",
 			le32_to_cpu(desc->grpid),
@@ -692,8 +695,8 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	if (!nr_nsids)
 		return 0;
=20
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
+	srcu_idx =3D srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
 		unsigned nsid;
 again:
 		nsid =3D le32_to_cpu(desc->nsids[n]);
@@ -706,7 +709,7 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 		if (ns->head->ns_id > nsid)
 			goto again;
 	}
-	up_read(&ctrl->namespaces_rwsem);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 	return 0;
 }
=20
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
--=20
2.43.0


