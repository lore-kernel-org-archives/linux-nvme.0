Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68DEC61DB9
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2026 23:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cHo8wrnYK75dRLw8qhh6CGbn7wbpr6QFgaBy8/D/vCQ=; b=zz1M6Fi6PDsLclPgvaFeITwYpc
	w+WxaZCLMq6um+aHxzDMY0G53WX6pylALYyu0pGf7ht6RKQndbG75Yl4QVKWN84t2Pb/+13dPpRrb
	LPGp1HaBLCUUBvZqotsCSYHmZL5ZDpLwDNeelCQNIUMgK3YpxpBdyJBtVQorNZRyIzWMnhvqL3ylx
	yXhnfha8vGt+sTq6pRlpbJrX8Yl9BN0jreVo8AUqRUT3EVppCdBSjqk1l3mux96il91mel4IgQ9hk
	18tVuIOW98/X8OIWghpOvabcvEKUyt84WUzROi7HlEPC8ycR3mIPnQ8AzeWgaO5PapPOBJjjMhHMa
	1OK1DLlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x05wi-00000006Vmn-1XtF;
	Fri, 28 Aug 2026 23:25:16 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x05we-00000006Vm6-1fAQ
	for linux-nvme@lists.infradead.org;
	Fri, 28 Aug 2026 23:25:14 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2cad68425a7so926845ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 28 Aug 2026 16:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787959510; x=1788564310; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cHo8wrnYK75dRLw8qhh6CGbn7wbpr6QFgaBy8/D/vCQ=;
        b=OZKpmxWhb91UXn8gntahO+chda8JSbsnuCYow1N1Zda+OCQ3ySgxIqkaLQlM5Fvq7O
         PylMQ3nq4qxnwlE/t20ej9XNLaZpeZ1DojAP3w6d+T/qWMTAxwCpF2SkBkzT8zPWeDpH
         rRlmvcpow2s1yDD22kHFSPnjZrboJed5xL4EKRk88kxTUaEsBW4SCOhdwVGKTjK+gpF5
         okSQZJrPt5o/ADnqaW1O6HkjWFiQXR181RLc/mzi4kIheE95mURmyR02FiHVpUc4C5pi
         9tO5WqYafInPHQkKPC0BYVRJrfBocq+ZlDjXdbjaNre/3Lhl/vqXpTLek2c6hyZs8ivr
         MwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787959510; x=1788564310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cHo8wrnYK75dRLw8qhh6CGbn7wbpr6QFgaBy8/D/vCQ=;
        b=C1u7yfq+8n33Q6LPjbU0RRBCH9JW2gjDwu3OX37VyS2KHUbdXGu9E9P2rGYs4uRByX
         2PGEFvjN24tP2LyOJCpgcdZO5qRgbiA3dxR1RVQF6iGWmPVXWoVfHB7AUZZFjXwFG8Cv
         sbKNhd9ABGhMKlYMi0V9e1n2+wcKTwBbHLTzgL54M5h+KSxaZYCdZvDi5EkXJX8LFkQF
         JvtMu0QHd9+dS2Y/dKw1rvmoqE45UY0A8HIRX9i/amZY5P4hrGEBmJvB6SMREvsvuch5
         fflV7gVEPYHCA014GZMl2hjMnbFtyuKehWQN9gBak4PEzR6M6TJeqvEEP7Rhoq2IR9Un
         nwnQ==
X-Gm-Message-State: AFuF++mJV7Qg0gl8X39apK/MEwSoHn8yEb/XRGPI8u9QH7ftkKZEyt6C
	v23x38d69Z1MFtOvL19mxlw4t1tsWW+KdqOtc8Ng9H5FHX45mTD+E7NqT6sWVUTTLS1Ge94VPPp
	HoS/QZpQNyO/O3wqgTbMh8a8k2P6IdQX6XbEsfAvPbqHc/Drxts3Vwrai/U/m6l92QgRiuY+iAs
	vAMpufKUyz591owUFBppbVo3tygBvQ5RGxQEh7UhaMIQHLYU9oF/p7tQ==
X-Gm-Gg: AYBFou0EkmOzFhnYcljy6Vqqa9y9hQrbU5sHVqn6SyYSkFIPJM4SfE+NOJvAHlWL8vE
	oLkGPfzk5ShzwgZAHG8kGnYHBpTKvlhTLlZlYL5/A2Q57zItnhne49LxTJytZSzfUzv/VOnWXCR
	0LV2h6agI9vwlKoj/BmEZd289SBk5Dd5o0wun57qJIGta9H6aRPNeaQAiN5ZA9c5p+J7Ix4qQCo
	QzgRzzpc8qSg5N8dsPRYjpkE3KVjtW/vxIinjA6+jNWkVSDpBevCcfdb+jQqO24tyH0iwYdmqpz
	QWgpVMJBpAcHo/k3FDlbhe0NRUIeXl7hvUtO43+EMVH5/Iv6UOhfupdvHAvEXcdOlCCUdOwpADN
	HktlWqtzGvRaXwy/HO45wJoWeHMRyrGRbY6yOTW9H3Y9+UxVrLpl9fezTumgsj35dpVVVxE5hZ6
	teiZAVsydWY0JsUysgdy2fSKTqFDJaty/8icXiXwdG2WSJp1f05uQH0yff2mOADuCN8/JZD/hoy
	ADri3xn6TDvF6Pg
X-Received: by 2002:a17:903:4b24:b0:2c9:d298:6c0a with SMTP id d9443c01a7336-2d74df00293mr100877575ad.2.1787959510193;
        Fri, 28 Aug 2026 16:25:10 -0700 (PDT)
Received: from dev-cachen2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3286f9e907fsm8187866eec.25.2026.08.28.16.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 16:25:09 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-nvme@lists.infradead.org
Cc: leon@kernel.org,
	sagi@grimberg.me,
	kbusch@kernel.org,
	hch@lst.de,
	axboe@kernel.dk,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvme-rdma: fix ib_device removal race that hangs PCI unbind
Date: Fri, 28 Aug 2026 17:24:36 -0600
Message-Id: <20260828232436.270184-1-cachen@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806211822.317074-1-cachen@purestorage.com>
References: <20260806211822.317074-1-cachen@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260828_162512_620596_A126C105 
X-CRM114-Status: GOOD (  34.08  )
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

nvme_rdma_remove_one() samples nvme_rdma_ctrl_list once, then blocks in
flush_workqueue(nvme_delete_wq). A connect can publish a controller on
the same ib_device during that window: nvme_rdma_find_get_device()
matches on node GUID in nvme_rdma's private device_list and never
consults ib_core unregistration state. Such a controller is never
deleted, so its rdma_cm_ids keep a reference on the cma_device.

ib_clients are removed LIFO, so nvme_rdma_remove_one() runs before
cma_remove_one(), which then waits for that reference forever. Removing
the RDMA interface underneath live NVMe-oF connections:

  echo 1 | sudo tee /sys/bus/pci/devices/0000:2a:00.1/remove

wedges the unbind permanently:

  INFO: task tee:164872 blocked for more than 200 seconds.
  task:tee             state:D stack:0     pid:164872 ppid:164870 flags:0x00004002
  Call Trace:
   <TASK>
   __schedule+0x4b4/0xf90
   schedule+0x5a/0xc0
   schedule_timeout+0x105/0x110
   ? cma_process_remove+0x1f9/0x240 [rdma_cm]
   __wait_for_common+0xc7/0x1f0
   ? usleep_range_state+0xb0/0xb0
   cma_remove_one+0x50/0xb0 [rdma_cm]
   remove_client_context+0x88/0xc0 [ib_core]
   disable_device+0x8a/0x160 [ib_core]
   __ib_unregister_device+0x42/0xa0 [ib_core]
   ib_unregister_device+0x22/0x30 [ib_core]
   mlx5r_remove+0x39/0x60 [mlx5_ib]
   auxiliary_bus_remove+0x18/0x30
   device_release_driver_internal+0x18f/0x1f0
   bus_remove_device+0xbc/0x120
   device_del+0x154/0x3d0
   ? devl_param_driverinit_value_get+0x29/0x90
   mlx5_rescan_drivers_locked.part.0+0x78/0x1c0 [mlx5_core]
   mlx5_unregister_device+0x34/0x50 [mlx5_core]
   mlx5_uninit_one+0x45/0x110 [mlx5_core]
   remove_one+0x4e/0xc0 [mlx5_core]
   pci_device_remove+0x39/0xa0
   device_release_driver_internal+0x18f/0x1f0
   pci_stop_bus_device+0x68/0x90
   pci_stop_and_remove_bus_device_locked+0x28/0x40
   remove_store+0x75/0x90
   kernfs_fop_write_iter+0x147/0x1d0
   vfs_write+0x2af/0x410
   ksys_write+0x5f/0xe0
   do_syscall_64+0x35/0x80
   entry_SYSCALL_64_after_hwframe+0x4b/0xb5
   </TASK>

Because the unbind stalls mid-teardown the netdev is never unregistered,
so userspace keeps reconnecting over the interface and loses the race
again.

Close the window at both ends, each with state guarded by the lock that
already covers the list it belongs to:

 - nvme_rdma_device gains ->dying, set and tested under
   device_list_mutex. nvme_rdma_find_get_device() refuses a device that
   is going away, so no new queues, PD or QP are created on it once
   nvme_rdma_remove_one() has started. A re-probed HCA with the same node
   GUID is a distinct ib_device and gets a fresh nvme_rdma_device.

 - nvme_rdma_remove_one() records the ib_device on nvme_rdma_removing_list
   in the same nvme_rdma_ctrl_mutex section that walks
   nvme_rdma_ctrl_list, and nvme_rdma_create_ctrl() tests that list under
   the same mutex immediately before publishing. A connect that took the
   mutex first is on the list and is deleted by the walk; one that takes
   it afterwards sees the entry and deletes its own controller. No
   controller can be added behind the walk, so a single sweep suffices.

The controller is fully live at the point the connect is refused, so it
is torn down with nvme_delete_ctrl_sync(). ->list is still empty there,
leaving opts to nvmf_create_ctrl(), and nvme_init_ctrl() left two
references while nvme_delete_ctrl_sync() consumes only the one that
nvme_uninit_ctrl() drops, so the other is put explicitly.

Reproduced on a 6.6 based kernel by removing and rescanning the mlx5
interface carrying the NVMe-oF RDMA connections in a loop, with IO
running and a userspace daemon reconnecting the controllers throughout.
The hang is racy: most removals complete normally, and only one that
lands while a connect is in flight leaves the sysfs write stuck in D
state with the trace above. With this patch the loop ran clean: removals
complete and the controllers reconnect after the following PCI rescan.

Fixes: e87a911fed07 ("nvme-rdma: use ib_client API to detect device removal")
Signed-off-by: Casey Chen <cachen@purestorage.com>
---

Changes since v1:
https://lore.kernel.org/all/20260806211822.317074-1-cachen@purestorage.com/

 - ->dying is no longer read under nvme_rdma_ctrl_mutex (Leon). It stays
   guarded by device_list_mutex and is only tested in
   nvme_rdma_find_get_device(), which already holds that mutex. The test at
   the publish point now uses a separate nvme_rdma_removing_list guarded by
   nvme_rdma_ctrl_mutex, so each piece of state is accessed only under the
   lock that declares it and the READ_ONCE()/WRITE_ONCE() pair is gone. The
   two mutexes are still never held at the same time.
 - Drop the code comments; the reasoning lives in the commit message (Sagi).

Leon, on moving the dying device off device_list onto a local removal list
instead of keeping ->dying: that does remove the flag, but it also lets a
connect racing the removal allocate a fresh nvme_rdma_device and call
ib_alloc_pd() on the device being unregistered, since
nvme_rdma_find_get_device() would no longer see anything to refuse. That
exposure exists upstream today, so unlinking is not a regression, but
keeping ->dying closes it as well, which seemed worth the one bool now that
it is no longer read across locks. A local (on-stack) removal list also
needs care: nvme_rdma_free_dev() does list_del() whenever the last kref
drops, and a connect holding a reference can outlive nvme_rdma_remove_one(),
so the list head would have to be static rather than on the stack. Happy to
switch to unlinking if you prefer it.

Sagi, on moving the test into nvme_rdma_setup_ctrl() before
nvme_start_ctrl(): that would let the existing destroy_io path do the
unwind, which is nicer, but I do not think it closes the race on its own.
setup_ctrl() returns before nvme_rdma_create_ctrl() takes
nvme_rdma_ctrl_mutex and calls list_add_tail(), so a removal landing in that
gap still walks nvme_rdma_ctrl_list before the controller is published. The
test has to be atomic with the publish, which is why it stayed under the
mutex. Happy to be told I am missing something.

One window is knowingly left open. Once nvme_rdma_remove_one() has returned,
the removal entry is gone and the nvme_rdma_device it marked has usually
been freed by the last nvme_rdma_dev_put(), taking ->dying with it. A
connect arriving between that point and cma_remove_one() unlinking the
cma_device allocates a fresh nvme_rdma_device and can still publish a
controller that nothing will delete. ib_clients are removed LIFO, so that
gap spans every remaining client's remove callback. It exists upstream today
and is strictly narrower with this patch, so I did not try to cover it here.
Closing it needs a test keyed on ib_core state rather than nvme_rdma's, for
example an ->add callback storing a token so that
ib_get_client_data(cm_id->device, &nvme_rdma_ib_client) == NULL identifies
"our remove callback has already returned". That reads client_data outside
what its kernel-doc permits, so it seemed better kept as a separate patch.
 drivers/nvme/host/core.c |  1 +
 drivers/nvme/host/rdma.c | 41 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 758245c799a1..bede16fe1ff5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -282,6 +282,7 @@ void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 		nvme_do_delete_ctrl(ctrl);
 	nvme_put_ctrl(ctrl);
 }
+EXPORT_SYMBOL_GPL(nvme_delete_ctrl_sync);
 
 static blk_status_t nvme_error_status(u16 status)
 {
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 29ecbe71bb2e..63453d902619 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -45,6 +45,24 @@ static LIST_HEAD_GUARDED(device_list, device_list_mutex);
 
 static DEFINE_MUTEX(nvme_rdma_ctrl_mutex);
 static LIST_HEAD_GUARDED(nvme_rdma_ctrl_list, nvme_rdma_ctrl_mutex);
+static LIST_HEAD_GUARDED(nvme_rdma_removing_list, nvme_rdma_ctrl_mutex);
+
+struct nvme_rdma_removing_device {
+	struct list_head	entry
+		__guarded_by(&nvme_rdma_ctrl_mutex);
+	struct ib_device	*dev;
+};
+
+static bool nvme_rdma_device_removing(struct ib_device *ib_device)
+	__must_hold(&nvme_rdma_ctrl_mutex)
+{
+	struct nvme_rdma_removing_device *removing;
+
+	list_for_each_entry(removing, &nvme_rdma_removing_list, entry)
+		if (removing->dev == ib_device)
+			return true;
+	return false;
+}
 
 struct nvme_rdma_device {
 	struct ib_device	*dev;
@@ -53,6 +71,8 @@ struct nvme_rdma_device {
 	struct list_head	entry
 		__guarded_by(&device_list_mutex);
 	unsigned int		num_inline_segments;
+	bool			dying
+		__guarded_by(&device_list_mutex);
 };
 
 struct nvme_rdma_qe {
@@ -378,6 +398,11 @@ nvme_rdma_find_get_device(struct rdma_cm_id *cm_id)
 
 	mutex_lock(&device_list_mutex);
 	list_for_each_entry(ndev, &device_list, entry) {
+		if (ndev->dying) {
+			if (ndev->dev == cm_id->device)
+				goto out_err;
+			continue;
+		}
 		if (ndev->dev->node_guid == cm_id->device->node_guid &&
 		    nvme_rdma_dev_get(ndev))
 			goto out_unlock;
@@ -2380,6 +2405,15 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		nvmf_ctrl_subsysnqn(&ctrl->ctrl), &ctrl->addr, opts->host->nqn);
 
 	mutex_lock(&nvme_rdma_ctrl_mutex);
+	if (nvme_rdma_device_removing(ctrl->device->dev)) {
+		mutex_unlock(&nvme_rdma_ctrl_mutex);
+		dev_info(ctrl->ctrl.device,
+			 "hca %s is being removed, aborting connect\n",
+			 dev_name(ctrl->device->dev->dma_device));
+		nvme_delete_ctrl_sync(&ctrl->ctrl);
+		nvme_put_ctrl(&ctrl->ctrl);
+		return ERR_PTR(-ECONNREFUSED);
+	}
 	list_add_tail(&ctrl->list, &nvme_rdma_ctrl_list);
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
@@ -2407,6 +2441,7 @@ static struct nvmf_transport_ops nvme_rdma_transport = {
 
 static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 {
+	struct nvme_rdma_removing_device removing = { .dev = ib_device };
 	struct nvme_rdma_ctrl *ctrl;
 	struct nvme_rdma_device *ndev;
 	bool found = false;
@@ -2414,6 +2449,7 @@ static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 	mutex_lock(&device_list_mutex);
 	list_for_each_entry(ndev, &device_list, entry) {
 		if (ndev->dev == ib_device) {
+			ndev->dying = true;
 			found = true;
 			break;
 		}
@@ -2425,6 +2461,7 @@ static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 
 	/* Delete all controllers using this device */
 	mutex_lock(&nvme_rdma_ctrl_mutex);
+	list_add(&removing.entry, &nvme_rdma_removing_list);
 	list_for_each_entry(ctrl, &nvme_rdma_ctrl_list, list) {
 		if (ctrl->device->dev != ib_device)
 			continue;
@@ -2433,6 +2470,10 @@ static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
 	flush_workqueue(nvme_delete_wq);
+
+	mutex_lock(&nvme_rdma_ctrl_mutex);
+	list_del(&removing.entry);
+	mutex_unlock(&nvme_rdma_ctrl_mutex);
 }
 
 static struct ib_client nvme_rdma_ib_client = {

base-commit: 9eabc91952f9821824ca0288a76b3aba57961c6b
-- 
2.34.1


