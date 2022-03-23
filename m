Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E44C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 03:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lfS8WKRgkCVG8EG9aKkBmeHM6y3OKGGCXtzi2bhSfDI=; b=vQLpmEJz4Qwr5tuD5E+sfYmKgx
	8jJ7Bk04YhBeQCKTEmA4wwhlQVlvuzwg6JclSjpEov0471MBAupbNIFYZ/Ce0kGUlP7O9vjbAwQDU
	trOtfHjfW8eU7Y8QVo+nT86NeS56Rohzxvp+vQtxbDrA8DWXPeYAxygeLHHJOurJix0uRz2ohp0pZ
	5JpbW7G06rFeNJBzixAIJsD3KvuMzeet+hmxIlpJk4wJ4adOaRWWNJ86PabJRD9hohM72a7ZFZHqu
	tmzCUPO+U0AUYnC9AfhaI1nHM38PiLymE/hKHYzAJcjgQUjd06Z0x8CmFo8bvYhFs44TAuTKfwOp+
	bYh/yxYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWs7R-00CkFG-8b; Wed, 23 Mar 2022 03:57:09 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWs7O-00CkER-0e
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 03:57:07 +0000
Received: by mail-wr1-x429.google.com with SMTP id w4so311108wrg.12
 for <linux-nvme@lists.infradead.org>; Tue, 22 Mar 2022 20:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lfS8WKRgkCVG8EG9aKkBmeHM6y3OKGGCXtzi2bhSfDI=;
 b=LKRxd/Rml3DSUFU6Nb8Kwpaa616N/2wskXERFArKiEoiVbUIVIRC/2n0JmQonAV5NF
 ZBC/jbln3PHXkhdNkpQzottegwX5dLbwnnShQx+AOOTWK96VC1BVrp4kg9saTezjH8q3
 cKnLSFiXnxhMJF+bh7DgmceFguvqqgIpD39FoNLkEpSA/4DtCFGVXkwxEG4X6lSlLukP
 GpA/g0UCxI9Jn+chwWxoSJAcS2Ni7bSfMjRgRDoOKe973YukjCBfU1zZ1qixsN1wMOxX
 Vlz3a6JJKpNTK0lW5+8o262y51JIpz/omJIQsX7TXhL0G5p3oTUS361niR+RCzC6WvGg
 /b0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lfS8WKRgkCVG8EG9aKkBmeHM6y3OKGGCXtzi2bhSfDI=;
 b=xE2HU1sFMbx2VABH/txT7MermcVpt45xbYunrjAdstEACc9zAe0ILtNi7O30k5HYlS
 h07/9nTEtdXYu03qkQr15bWiT3fSQiU6ocDExEINbtFgLYHTniKJRG+5p/974D2kNxOU
 hr7RO4srxcFDQHHKZ8Y/K3M1RY2AC+ZWv8cOPZn/k3a6I48gg8Bkl4g5W4nx/2DHQuea
 dY5TBeNcojkohXBWvHY2CxGWtlsTg9lwUAHHakCUjq9ku000+vF3PCqQ82eWOBGc2h04
 /nU0D9bW2VKmkZnYRaYdFIUJX8Q1q6TJpqIIVbWjOtXHI9VWR5Y/BP5l+Ad2liStLKsE
 l6Mw==
X-Gm-Message-State: AOAM533Af+sI+zY1OO9yxdzf9jAEnPKosSSUx/NL5Myh+7NZrwFOgsp2
 qgmhTLtLiyASegQyCVz5Ug9THupx+FN51w==
X-Google-Smtp-Source: ABdhPJxUBSUvKsbDPaSnH/eXkSUeBBYd1QfqBqvFFuNy590J1sYVth6RHDFqls3ARoO4kLVAzh/ftQ==
X-Received: by 2002:adf:f102:0:b0:205:7d05:d250 with SMTP id
 r2-20020adff102000000b002057d05d250mr4402093wro.350.1648007821728; 
 Tue, 22 Mar 2022 20:57:01 -0700 (PDT)
Received: from localhost.localdomain (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87]) by smtp.googlemail.com with ESMTPSA id
 n14-20020a7bcbce000000b0038c7776a300sm3541158wmi.0.2022.03.22.20.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Mar 2022 20:57:01 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: ushankar@purestorage.com,
	Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH v2 1/1] nvme/mpath: fix hang when disk goes live over reconnect
Date: Tue, 22 Mar 2022 21:55:51 -0600
Message-Id: <20220323035551.1524128-2-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220323035551.1524128-1-anton@lightbitslabs.com>
References: <20210918215729.388968-1-anton@lightbitslabs.com>
 <20220323035551.1524128-1-anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_205706_107151_199F7676 
X-CRM114-Status: GOOD (  19.87  )
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

nvme_mpath_init_identify() invoked from nvme_init_identify()
fetches a fresh ANA log from the ctrl.
This is essential to have an up to date path states
for both existing namespaces and for those scan_work
may discover once the ctrl is up.

This happens in the following cases:
1) A new ctrl is being connected.
2) An existing ctrl is successfully reconnected.
3) An existing ctrl is being reset.

While in (1) ctrl->namespaces is empty, (2 & 3) may have namespaces,
and nvme_read_ana_log() may call nvme_update_ns_ana_state().

This result in a hang when the ANA state of an existing namespace
changes and makes the disk live: nvme_mpath_set_live() issues
IO to the namespace through the ctrl,
which does NOT have IO queues yet.

See sample hang below.

Solution:
- nvme_update_ns_ana_state() to call set_live only if ctrl is live
- nvme_read_ana_log() call from nvme_mpath_init_identify()
  therefore only fetches and parses the ANA log;
  any erros in this process will fail the ctrl setup as appropriate;
- a separate function nvme_mpath_update()
  is called in nvme_start_ctrl();
  this parses the ANA log without fetching it.
  At this point the ctrl is live,
  therefore, disks can be set live normally.

Sample failure:
    nvme nvme0: starting error recovery
    nvme nvme0: Reconnecting in 10 seconds...
    block nvme0n6: no usable path - requeuing I/O
    INFO: task kworker/u8:3:312 blocked for more than 122 seconds.
          Tainted: G            E     5.14.5-1.el7.elrepo.x86_64 #1
    Workqueue: nvme-wq nvme_tcp_reconnect_ctrl_work [nvme_tcp]
    Call Trace:
     __schedule+0x2a2/0x7e0
     schedule+0x4e/0xb0
     io_schedule+0x16/0x40
     wait_on_page_bit_common+0x15c/0x3e0
     do_read_cache_page+0x1e0/0x410
     read_cache_page+0x12/0x20
     read_part_sector+0x46/0x100
     read_lba+0x121/0x240
     efi_partition+0x1d2/0x6a0
     bdev_disk_changed.part.0+0x1df/0x430
     bdev_disk_changed+0x18/0x20
     blkdev_get_whole+0x77/0xe0
     blkdev_get_by_dev+0xd2/0x3a0
     __device_add_disk+0x1ed/0x310
     device_add_disk+0x13/0x20
     nvme_mpath_set_live+0x138/0x1b0 [nvme_core]
     nvme_update_ns_ana_state+0x2b/0x30 [nvme_core]
     nvme_update_ana_state+0xca/0xe0 [nvme_core]
     nvme_parse_ana_log+0xac/0x170 [nvme_core]
     nvme_read_ana_log+0x7d/0xe0 [nvme_core]
     nvme_mpath_init_identify+0x105/0x150 [nvme_core]
     nvme_init_identify+0x2df/0x4d0 [nvme_core]
     nvme_init_ctrl_finish+0x8d/0x3b0 [nvme_core]
     nvme_tcp_setup_ctrl+0x337/0x390 [nvme_tcp]
     nvme_tcp_reconnect_ctrl_work+0x24/0x40 [nvme_tcp]
     process_one_work+0x1bd/0x360
     worker_thread+0x50/0x3d0

Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
---
 drivers/nvme/host/core.c      |  1 +
 drivers/nvme/host/multipath.c | 12 +++++++++++-
 drivers/nvme/host/nvme.h      |  4 ++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3c0461129bca..d4495fa97657 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4509,6 +4509,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 	if (ctrl->queue_count > 1) {
 		nvme_queue_scan(ctrl);
 		nvme_start_queues(ctrl);
+		nvme_mpath_update(ctrl);
 	}
 
 	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c97d7f843977..a22d455f48a9 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -613,7 +613,8 @@ static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
 	ns->ana_state = desc->state;
 	clear_bit(NVME_NS_ANA_PENDING, &ns->flags);
 
-	if (nvme_state_is_live(ns->ana_state))
+	if (nvme_state_is_live(ns->ana_state) &&
+		(ns->ctrl->state == NVME_CTRL_LIVE))
 		nvme_mpath_set_live(ns);
 }
 
@@ -700,6 +701,15 @@ static void nvme_ana_work(struct work_struct *work)
 	nvme_read_ana_log(ctrl);
 }
 
+void nvme_mpath_update(struct nvme_ctrl *ctrl)
+{
+	u32 nr_change_groups = 0;
+
+	mutex_lock(&ctrl->ana_lock);
+	nvme_parse_ana_log(ctrl, &nr_change_groups, nvme_update_ana_state);
+	mutex_unlock(&ctrl->ana_lock);
+}
+
 static void nvme_anatt_timeout(struct timer_list *t)
 {
 	struct nvme_ctrl *ctrl = from_timer(ctrl, t, anatt_timer);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1ea908d43e17..76f7a5f37379 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -781,6 +781,7 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
 void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl);
+void nvme_mpath_update(struct nvme_ctrl *ctrl);
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
 void nvme_mpath_stop(struct nvme_ctrl *ctrl);
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
@@ -852,6 +853,9 @@ static inline int nvme_mpath_init_identify(struct nvme_ctrl *ctrl,
 "Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.\n");
 	return 0;
 }
+void nvme_mpath_update(struct nvme_ctrl *ctrl)
+{
+}
 static inline void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 {
 }
-- 
2.25.1


