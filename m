Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841C4C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 01:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VMsdk0VXXdM4/zTt6pXG4Myv9Qen3RdxmDfXo8LlUTE=; b=aK1jKbAs97MXgVGOV0S8fPBEF6
	wyJR1f0pBeDMAwyMAHIKSl3pvRn8lKG22Yqtp9Sx12V8Ty7NiiKs6VHUHfZWRKQ3+xe4t8fu+0e0O
	BhCeb4JTftp0kEud3WIalj32Nxxvo0x/C7doJtQ+7DE9lCwbT741ceTB8Dgkqll2GgxzLVVjYWFNb
	VkOyYn/IR50isOLiFzvDOPX1w33cGBrUuakBdnWaKZeB0zNjdn6woGxItk/mf5krmlXDx/RI2SE/I
	hIBhdem6oga65IAsFFd/muCrurErC3Pub5gRAPQyL9LmSGZSJfbdehJ8j2UOc6aZhl1xDosyBijLs
	avDxZcgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncGgS-008UM3-V4; Thu, 07 Apr 2022 01:11:37 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncGgB-008UBd-F6
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 01:11:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2C4BEB82695;
 Thu,  7 Apr 2022 01:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A2AC385A7;
 Thu,  7 Apr 2022 01:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649293876;
 bh=UT6iZwY7jem/7gxVLDXdPr07ACopg5hx7u0zUA9Bg+g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mgDpHAEMenMvfVrCuLVhuNRclHvh9+SNKKgn4pnQuLfGkDJ6xNgHgyfwRk2zVS1G0
 6UyozbY1k5RnErhwBM5G/sDYxAy/koX36EXVe11Y9qfDlvUQWtoNHk0iQI85yEpmbI
 oZU2pEbxgZzolAY9SZcjBYuORVWBGT1SlU3rEitFMYeaVWGaKFsCqyxPKKBJOJtaD3
 3zwZNMBbbhlyjmmB/JfHWKzTPFWKcBQQFhoTdD97LbZ1mKJDe2XULxPy3IQu0oh9GI
 dqpnHh6+UMwhsfPeSZ2spRPuL0sAzpB3cWYG5EOwA9sYLZ1/05N9H54PKeg5FWeME4
 S1ZBOl0k07NrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anton Eidelman <anton.eidelman@gmail.com>,
 Anton Eidelman <anton@lightbitslabs.com>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 kbusch@kernel.org, axboe@fb.com, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.17 23/31] nvme-multipath: fix hang when disk goes
 live over reconnect
Date: Wed,  6 Apr 2022 21:10:21 -0400
Message-Id: <20220407011029.113321-23-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407011029.113321-1-sashal@kernel.org>
References: <20220407011029.113321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_181119_837835_D64F126D 
X-CRM114-Status: GOOD (  25.13  )
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

From: Anton Eidelman <anton.eidelman@gmail.com>

[ Upstream commit a4a6f3c8f61c3cfbda4998ad94596059ad7e4332 ]

nvme_mpath_init_identify() invoked from nvme_init_identify() fetches a
fresh ANA log from the ctrl.  This is essential to have an up to date
path states for both existing namespaces and for those scan_work may
discover once the ctrl is up.

This happens in the following cases:
  1) A new ctrl is being connected.
  2) An existing ctrl is successfully reconnected.
  3) An existing ctrl is being reset.

While in (1) ctrl->namespaces is empty, (2 & 3) may have namespaces, and
nvme_read_ana_log() may call nvme_update_ns_ana_state().

This result in a hang when the ANA state of an existing namespace changes
and makes the disk live: nvme_mpath_set_live() issues IO to the namespace
through the ctrl, which does NOT have IO queues yet.

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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c      |  1 +
 drivers/nvme/host/multipath.c | 25 +++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  4 ++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fd4720d37cc0..25952dfdc580 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4402,6 +4402,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 	if (ctrl->queue_count > 1) {
 		nvme_queue_scan(ctrl);
 		nvme_start_queues(ctrl);
+		nvme_mpath_update(ctrl);
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_start_ctrl);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index ff775235534c..0e137148f5f7 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -634,8 +634,17 @@ static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
 	ns->ana_grpid = le32_to_cpu(desc->grpid);
 	ns->ana_state = desc->state;
 	clear_bit(NVME_NS_ANA_PENDING, &ns->flags);
-
-	if (nvme_state_is_live(ns->ana_state))
+	/*
+	 * nvme_mpath_set_live() will trigger I/O to the multipath path device
+	 * and in turn to this path device.  However we cannot accept this I/O
+	 * if the controller is not live.  This may deadlock if called from
+	 * nvme_mpath_init_identify() and the ctrl will never complete
+	 * initialization, preventing I/O from completing.  For this case we
+	 * will reprocess the ANA log page in nvme_mpath_update() once the
+	 * controller is ready.
+	 */
+	if (nvme_state_is_live(ns->ana_state) &&
+	    ns->ctrl->state == NVME_CTRL_LIVE)
 		nvme_mpath_set_live(ns);
 }
 
@@ -722,6 +731,18 @@ static void nvme_ana_work(struct work_struct *work)
 	nvme_read_ana_log(ctrl);
 }
 
+void nvme_mpath_update(struct nvme_ctrl *ctrl)
+{
+	u32 nr_change_groups = 0;
+
+	if (!ctrl->ana_log_buf)
+		return;
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
index a162f6c6da6e..55f5e4f560a3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -776,6 +776,7 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
 void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl);
+void nvme_mpath_update(struct nvme_ctrl *ctrl);
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
 void nvme_mpath_stop(struct nvme_ctrl *ctrl);
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
@@ -850,6 +851,9 @@ static inline int nvme_mpath_init_identify(struct nvme_ctrl *ctrl,
 "Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.\n");
 	return 0;
 }
+static inline void nvme_mpath_update(struct nvme_ctrl *ctrl)
+{
+}
 static inline void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 {
 }
-- 
2.35.1


