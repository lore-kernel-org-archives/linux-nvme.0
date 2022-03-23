Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADC2C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 14:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j7r+WychqzMZsMCp083fFRWVf6uBqAsj2b1hCIgV15c=; b=o8XmLEpObaBcnAPZNIYncwtM8U
	AyWUgNB/EIGEkS5bE6XYBfnBnsmWTyDWKrUaN2VmoBeSlhOBkjDntCg1Y2tr2zXGKrJjlmJSTadmd
	APaz2/QYdMExIytkPgfMKlp0rQT9YN9NrepXPzwASKP+Yt0PGaD0SBsUr8trDRuk0zR6Nwn02ZiEQ
	nu5Uad2v0BDORNxjpUixl/pwEyMFNCcXzv58YXyMhjhzSUAEDFpvEiOqMgDtUXExW2cxzo1OHjR1E
	ssvDqW1UirEK4wV8JM/gMTletdcjtbO+I2r/zMHVFahkj1LJx+dvLp8FKNSHuUPnwQGsS17VnatWr
	amxakahA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX2F7-00Dwky-Mk; Wed, 23 Mar 2022 14:45:45 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX2Ez-00DwiF-PD
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 14:45:39 +0000
Received: by mail-wr1-x42b.google.com with SMTP id a1so2446965wrh.10
 for <linux-nvme@lists.infradead.org>; Wed, 23 Mar 2022 07:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j7r+WychqzMZsMCp083fFRWVf6uBqAsj2b1hCIgV15c=;
 b=q59W8F9PdwpD9dVAZ6xKAkBal9oNoUmi3XY/8KFHMroB2BflW3OEEz2vk9dy0j2gTr
 TGvtYxoWOAf7MG47XQMaELNRiJZkqcYEeeXNdulVF7ZRIPfbFfYlo1yRWoY9euxRAcYy
 52aF5ksejZkbEqPdRUWyC/rEbvsBQ20ZqybbQ0IpXF13xtU2OGgKevzxbbQnO+m1Dr1c
 wv2sz7NwS0his9TmIajbZLydjsmCn4N2wiHcoQXnxPF4NxtDsKSLBeqW/b3TI6C4t6be
 5W7RCeZv50jU2CJsCd4YSaOXQya2/8vTQdI6YUh5DF7hTA/UOPjPMdN6t+GI015xIqMo
 lmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j7r+WychqzMZsMCp083fFRWVf6uBqAsj2b1hCIgV15c=;
 b=0l5MVSSh9phica/c3G9Fit+FcV3dX6X5SM9/hLn6IWExO6WFcpoNo0T5FxZT2q9Nu3
 emPI12xknGhRIz7cNACT7n0BZbI6qYKtPCOu42czNwedNGUnqJEwNBz35A9EWtAV75i3
 kQoqZMvTNMSuCTYYYz4SUqolpL+2e3fvGSJDB6YovtkBp0o7R04w7MBc3AB1oSmP+CwH
 QCjE3T7aakPQ4oQ7qB+B0/S2sSuG6rM0bkGmysUDVp5+UuxB7KkHsl2rb9ewN6PGP26n
 Pk4wb5wGvX9mNlhzpsiLc/drxPtWkcKjlEueeimwLz3JW8D8rbQ4qBFqvf6Iy/DmqjFd
 8umg==
X-Gm-Message-State: AOAM532QDM16ifb9Bz7+kIJT6xGkirADTrGCvQgUx4V+fTxFttUHWjsf
 ygdNe3D/n9HBS7L6heR4A0mvPNB+dut/iQ==
X-Google-Smtp-Source: ABdhPJzjf5d/aktlKu8VbhzfOXP3+3DCgg4zz1tRtkbdl/I/MxDU9emOxt8QDre19kc7DVWwehaK0g==
X-Received: by 2002:a05:6000:186d:b0:204:110a:d832 with SMTP id
 d13-20020a056000186d00b00204110ad832mr122730wri.47.1648046735658; 
 Wed, 23 Mar 2022 07:45:35 -0700 (PDT)
Received: from localhost.localdomain (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87]) by smtp.googlemail.com with ESMTPSA id
 c12-20020a05600c0a4c00b00381141f4967sm132736wmq.35.2022.03.23.07.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 07:45:35 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: ushankar@purestorage.com,
	Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH v3 1/1] nvme/mpath: fix hang when disk goes live over reconnect
Date: Wed, 23 Mar 2022 08:45:04 -0600
Message-Id: <20220323144504.1557518-2-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220323144504.1557518-1-anton@lightbitslabs.com>
References: <20220323035551.1524128-2-anton@lightbitslabs.com>
 <20220323144504.1557518-1-anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_074537_848533_8FB56D0E 
X-CRM114-Status: GOOD (  23.04  )
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
 drivers/nvme/host/multipath.c | 23 +++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  4 ++++
 3 files changed, 26 insertions(+), 2 deletions(-)

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
index c97d7f843977..12d4afde3662 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -612,8 +612,18 @@ static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
 	ns->ana_grpid = le32_to_cpu(desc->grpid);
 	ns->ana_state = desc->state;
 	clear_bit(NVME_NS_ANA_PENDING, &ns->flags);
-
-	if (nvme_state_is_live(ns->ana_state))
+	/*
+	 * nvme_mpath_set_live() will trigger I/O to the mpath
+	 * device node and in turn to this path device, however we
+	 * cannot accept this I/O if the ctrl is not live.
+	 * This may deadlock if called from the nvme_mpath_init_identify()
+	 * and the ctrl will never complete initialization,
+	 * preventing I/O from completing.
+	 * For this case we will reprocess the ANA log page
+	 * in nvme_mpath_update() once the ctrl ready.
+	 */
+	if (nvme_state_is_live(ns->ana_state) &&
+	    ns->ctrl->state == NVME_CTRL_LIVE)
 		nvme_mpath_set_live(ns);
 }
 
@@ -700,6 +710,15 @@ static void nvme_ana_work(struct work_struct *work)
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


