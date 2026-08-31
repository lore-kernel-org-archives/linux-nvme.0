Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C32C61DD3
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2026 22:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1wuT3KA8guOepoCsoUIKjVLNC1Aqj3NCJ3PXMyK/yd8=; b=WtbtLyACqCvVQwT2JfdMMSKZIn
	gMkTOhAJqF46/AlxBq/Vk2M8fx/uZfvi86sAeu2nt/XoNuRiBjq4Wuaa/d+4qmu6krmmjTOcxGuFZ
	nCFyuUkgFXjmaWTL22cAdHApMdvzPHKOcMAdfHV/kDnmehCV0hHuv5r3L6k8FK0mxkkjR9rJX5537
	6NxoTxbueF5KuFNFHMScbTOV6EZdjM948EeJLCodhfYFGIbQRg9QV3rvS6nAqxR/qAaq+XPvQUnT6
	2YkjnDkEOTvMPcwY199qwTrSjvoKJ1S8Z7gZC2RuwQRrz9zzh+YBoqmILiIBja21hhQ6S6L02ttEK
	6fH3U48A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1AGW-0000000AaGF-33lq;
	Mon, 31 Aug 2026 22:14:08 +0000
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1AGT-0000000AaFn-2ZHu
	for linux-nvme@lists.infradead.org;
	Mon, 31 Aug 2026 22:14:06 +0000
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-462fe099816so540956fac.2
        for <linux-nvme@lists.infradead.org>; Mon, 31 Aug 2026 15:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788214444; x=1788819244; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1wuT3KA8guOepoCsoUIKjVLNC1Aqj3NCJ3PXMyK/yd8=;
        b=C4FpU/hd18P/+63Gb5MweZ+mBJEQA4RKxZmEuNe2RpE3CRK0Ok1J5866WgTq8MJcJy
         GgIzMsr2o3f1D1KvIwlD2vsp1tWbMUe24+VKoNhKeWG3ImCJ09PvQVeRpYVqpYv0LUi1
         lnKzWy9HqsnY13WEEoGOnI74LEzaeE8ELEXzCpy7EclBLmXkR+zd3kJY3zP3vL1uu5v0
         ixCm1NhNZYpyqL6ushZkUVUlqybHOZp1Cdr5oN51t6g1PbRs79yPpjUKeMC1SfupKcMG
         Z58aCfJXv6lHeFH4LaZOthgXkcTmK5RqAC9TX2WvA0zhTBDnZN/gfORBV8nSRBBP0W4B
         XUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788214444; x=1788819244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1wuT3KA8guOepoCsoUIKjVLNC1Aqj3NCJ3PXMyK/yd8=;
        b=VCgSEKdU3OMTDygwP2AjosTM4ppuvBmNstBfbh6b+z756adM2ChkdI4V2deZBm+j3B
         If4AWgawEck98vEJR4WAdkiMHEhc2GzuYL0XRTgpamfnQHVrG9+EdpeciN9+WWnflLGn
         V7zo9X6f4ErA2OcIbK2wfclSxIHibaghL2VOq1BrjvfPRZj3R14PaV2ClTg4AUqwX2Rr
         LyjaDUVxWEMlXYY2MCFRdSu/o8/IfPoSf2hwYkhv+twL1XYQZd7bYmL+l/6jfI/ON4YH
         6SfEzOO593d8nLOqTpD8I9eqwVZs5VIm/CZvYWjCoFnrJNCwxzfd+Cn+uK3PRc4jorOS
         RT8A==
X-Gm-Message-State: AFuF++nQw7Y4RrX0kJuP/kHw7MvaWjDo3DRCea1xIMo3Z5/mXGuz+3ui
	qliDqDfTeXVYFXwkdsedHParxiFubqaXeUkWQF5EYGQnsLKlWRJGhB3P6H5onB5nPsUKd7SoT34
	G1QWPcfLwERy5j5r/AKrFqclqb+cHo2WLw0ax3DovfMxjVqSAMkdPom12n4HiTbs8VkAI9Z+VzQ
	UyFyA01/1k+DJmuy8aP/0jqZzqyJqVOODWmCM3JWOFrWKiHICRwNAMkQ==
X-Gm-Gg: AR+sD13ZalwZUIcAgUJepSlRVYfHwfhqsXmuoEJ0eJ35Vyinqu9jEynM+nkjV5uLN18
	PPfMPX9qqGCFlv+FuoIhhKlGFrIsgszQW7M6V4ef2mY+DtIB6aqKy40lqVTxC8cWKQn/pP6s0bF
	tj8VsVNmWQE8Q/Bp3UePz5S4cqMNrvngY4DRYqvt2RFsy/R1uqqW1gQ17tHfqP3gbZ3jtvrgLmr
	eRRKmmaKo8IcJBSBdKCx/+0jxMOSodsIkr5FcHSAyFtgd2KIjYBRVipbjAa0eFxZvHREQtooTDl
	Iy83/daJ5FcaY8RTMcs5+YInLwN5HE1CURU25FuXwO2MIh/E4LE9ZOYSXlWxLkOdnCh5NGzAUaU
	F4cjNexGHZCAYE7uYvnbwWgAehEEAdD5fBv/YjVVS48z+mLvuUJnmZJJCyeBOsToZyRAWHsnatI
	oJ77r2hH7bmY75930FrAkax9ZZU3JSgQFl2uS/hHI5+31FQ6ftcA/DJWK3ehV2hfL+izepr/h93
	UIOv7bJX3NAbw+C
X-Received: by 2002:a05:6808:2228:b0:4a4:866:c2c0 with SMTP id 5614622812f47-4b57889dd5cmr10099078b6e.4.1788214443969;
        Mon, 31 Aug 2026 15:14:03 -0700 (PDT)
Received: from dev-cachen2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4b3a16259f5sm8888807b6e.3.2026.08.31.15.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 15:14:03 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-nvme@lists.infradead.org
Cc: leon@kernel.org,
	sagi@grimberg.me,
	kbusch@kernel.org,
	hch@lst.de,
	axboe@kernel.dk,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] nvme-rdma: fix ib_device removal race that hangs PCI unbind
Date: Mon, 31 Aug 2026 16:13:55 -0600
Message-Id: <20260831221355.1715088-1-cachen@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260828232436.270184-1-cachen@purestorage.com>
References: <20260828232436.270184-1-cachen@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_151405_671957_2107B63D 
X-CRM114-Status: GOOD (  32.72  )
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

nvme_rdma has no ->add callback, so its client_data is unused. Use it as
a per-ib_device liveness token: ->add stores the ib_device itself,
nvme_rdma_remove_one() clears it before doing anything else, and ib_core
erases it once ->remove has returned. ib_get_client_data() returning
NULL therefore means "this device is being removed, or already has
been", which is exactly the span over which nvme_rdma must refuse it.
The token needs no allocation, so ->add cannot fail and leave a device
attached with no ->remove to follow.

Two sites test it:

 - nvme_rdma_find_get_device() refuses a device that is going away, so a
   connect starting after removal begins never builds a PD, CQ or QP on
   it, and no stale nvme_rdma_device is handed out by the node GUID
   match.

 - nvme_rdma_create_ctrl() tests it under nvme_rdma_ctrl_mutex
   immediately before publishing, which covers a connect that was
   already in flight. The token is cleared before
   nvme_rdma_remove_one() acquires that mutex, so the two orderings are
   exhaustive: a publisher that takes the mutex first is on the list and
   is deleted by the walk, and one that takes it afterwards observes
   NULL and deletes its own controller. No controller can be added
   behind the walk, so a single sweep suffices.

Keying on the ib_device rather than on nvme_rdma_device matters: the
lookup matches on node GUID while the removal matches on the ib_device
pointer, so the two are not one to one, and the token also outlives the
nvme_rdma_device, which is freed as soon as its last queue is torn down.

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

Changes since v2:
https://lore.kernel.org/all/20260828232436.270184-1-cachen@purestorage.com/

 - Drop ->dying, nvme_rdma_removing_list and struct
   nvme_rdma_removing_device entirely (Sagi, Leon). The state is now a
   per-ib_device liveness token in client_data, which nvme_rdma was not
   using, so there is no new field, list or struct and nothing to reset
   on re-probe.
 - The test is keyed on the ib_device rather than on nvme_rdma_device.
   That also fixes something v2 got wrong: the lookup matches on node
   GUID while the removal matches on the ib_device pointer, so the two
   are not one to one, and a flag on nvme_rdma_device can be set on an
   ndev shared with a device that is not being removed.
 - This closes the window v2 documented as knowingly open. Once
   nvme_rdma_remove_one() returned, v2 had no state left, so a connect
   arriving before cma_remove_one() unlinks the cma_device could still
   strand a controller. remove_client_context() erases client_data after
   ->remove returns, so the token stays NULL and that path is refused.

Why the test cannot move to nvme_rdma_setup_ctrl(), and the alternatives
to this approach, are discussed in the reply to Sagi on v2:
https://lore.kernel.org/all/20260831220754.1714514-1-cachen@purestorage.com/

Two side effects of adding ->add, neither of which I think is a problem
but both worth naming:

 - A device with !kverbs_provider never gets ->add
   (add_client_context() returns early), so nvme_rdma now refuses it in
   nvme_rdma_find_get_device() rather than failing later at QP creation.
   nvme_rdma cannot use such a device either way.

 - Clients are added FIFO and rdma_cm registers before nvme_rdma, so
   during ib_register_device() cma_add_one() runs before
   nvme_rdma_add_one(). A connect resolving in that gap is refused with
   -ECONNREFUSED until ->add has run. Self correcting on retry, but a
   real transient at probe time.

Note ib_get_client_data()'s kernel-doc says it "can only be called while
the client is registered to the device, once the ib_client remove()
callback returns this cannot be called", and this uses it precisely to
detect that state. It works, since it is a bare xa_load() and xa_erase()
runs after ->remove, but it is outside what the API documents. Leon, if
you would rather ib_core grew something explicit for this, or if you
prefer the flag based variant, say so and I will respin.

The ->add path is new in this version and has not run on the setup that
reproduced the hang, so this wants a fresh soak before it is applied.
 drivers/nvme/host/core.c |  1 +
 drivers/nvme/host/rdma.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

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
index 29ecbe71bb2e..04687fe22804 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -46,6 +46,19 @@ static LIST_HEAD_GUARDED(device_list, device_list_mutex);
 static DEFINE_MUTEX(nvme_rdma_ctrl_mutex);
 static LIST_HEAD_GUARDED(nvme_rdma_ctrl_list, nvme_rdma_ctrl_mutex);
 
+static struct ib_client nvme_rdma_ib_client;
+
+static int nvme_rdma_add_one(struct ib_device *ib_device)
+{
+	ib_set_client_data(ib_device, &nvme_rdma_ib_client, ib_device);
+	return 0;
+}
+
+static bool nvme_rdma_device_removing(struct ib_device *ib_device)
+{
+	return !ib_get_client_data(ib_device, &nvme_rdma_ib_client);
+}
+
 struct nvme_rdma_device {
 	struct ib_device	*dev;
 	struct ib_pd		*pd;
@@ -377,6 +390,9 @@ nvme_rdma_find_get_device(struct rdma_cm_id *cm_id)
 	struct nvme_rdma_device *ndev;
 
 	mutex_lock(&device_list_mutex);
+	if (nvme_rdma_device_removing(cm_id->device))
+		goto out_err;
+
 	list_for_each_entry(ndev, &device_list, entry) {
 		if (ndev->dev->node_guid == cm_id->device->node_guid &&
 		    nvme_rdma_dev_get(ndev))
@@ -2380,6 +2396,15 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
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
 
@@ -2411,6 +2436,8 @@ static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 	struct nvme_rdma_device *ndev;
 	bool found = false;
 
+	ib_set_client_data(ib_device, &nvme_rdma_ib_client, NULL);
+
 	mutex_lock(&device_list_mutex);
 	list_for_each_entry(ndev, &device_list, entry) {
 		if (ndev->dev == ib_device) {
@@ -2437,6 +2464,7 @@ static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 
 static struct ib_client nvme_rdma_ib_client = {
 	.name   = "nvme_rdma",
+	.add    = nvme_rdma_add_one,
 	.remove = nvme_rdma_remove_one
 };
 

base-commit: 9eabc91952f9821824ca0288a76b3aba57961c6b
-- 
2.34.1


