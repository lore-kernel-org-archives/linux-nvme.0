Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FEBC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 19:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m1hQV2HgTWWc7nwHZVAJHwYA13XPzcHIl3jsS89TIks=; b=PDZk3DyW37YoYiDwCI0HfHT5su
	B93oKz9VzE+9GW/yEnMH2inHESCrpZz7kB/Q6jIi+EdUUr1dVgFc9So8KSl7fTu9dse0tWk0/TqwC
	qOpoxMirqYRBgOIMr1d5mQBOKBXuGXtoPjb8GzX1XYRaW8faewhtRtDc4gWjPXOkXUJyYkbihfW98
	ul4THJbdmDAa+eBitiub25z3yBfyqOQFsXPZmp+3U52ViSCZoVa8sOBlhNp68EhO+BCqfHHxJ8dV7
	7c8R/XiQoIKCriOT2wiOtviiWlVb26UPwGcwg98UEglzoA6jkGub+YTEgyf6NVsHWWmtoeSv7YIFo
	2sYu7q+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXSmY-0001el-5a; Thu, 24 Mar 2022 19:06:02 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXSmV-0001db-3h
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 19:06:00 +0000
Received: by mail-wm1-x32b.google.com with SMTP id
 bg31-20020a05600c3c9f00b00381590dbb33so3141426wmb.3
 for <linux-nvme@lists.infradead.org>; Thu, 24 Mar 2022 12:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m1hQV2HgTWWc7nwHZVAJHwYA13XPzcHIl3jsS89TIks=;
 b=gH9TCQF5ainPOpR0se1kgdfXSdtNqQCD+ipwRHnfjrL8uaaQDgVSzWMEMTMNu8EfxG
 ltvhXBZ9r3ywlSNHbtPXh5L9K6V5u00HJl3PfkeU9PWfAbOyZIipCzrvlpAMZGNPjQGv
 /rU69Olj78XWx9/NpGOnTlUtw2pfW32KlHgWKwHc9nDP6Qr57DULcgLbN+RjeXoilE26
 qrgn5MEJxJrdUlmjr9krhqHqfixioiflcK/ldAI8UJj5qx5wbfgsTsapIl1YK756YCL2
 Rgd7X8U8vKcRpYF/DNCCEZpy3rHMXTb3BQYNQeKznhTrB/1MFf4b9Df0pK+JKwqU6QrA
 w/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m1hQV2HgTWWc7nwHZVAJHwYA13XPzcHIl3jsS89TIks=;
 b=rYyJPvOjKKtvIcRgqVsMdFPBh28notAWs41MygO4IbGXMxXQOgSTVcRLDZEOJHxDOo
 nDXfnCVQ5BBRNmErJF2eHAJMMN52izBTOMVI4BH9SXHXfIm9mP+Bl/rq3eeU08ISs2o1
 MmEPE8rVKzD+/e4zEX49uVxNehsu5ioCHNcJMYIYiADbDATOncIL7bl7yoiEBKBGJQlW
 6YYaT8JbWx9VP1NTiFeS/Tw3NGP88/E/GOwL78aCso7KNF9STwd6uqAi98WmwASx0Z8k
 PaIP4Vql9mIn9DO8sYcBUsCWBm8+4+v6NkhoSqo1GTGZAjMDEZTkQaWXZKL4/FXNkt3h
 cXJA==
X-Gm-Message-State: AOAM533PzQTkI3SY6fZsBQGtc84mYjQVc00cx9zZnpgZnXVewEEl+KiZ
 FwGfNXTcG1oH5PswUywyP5dHfDoa/uFtDQ==
X-Google-Smtp-Source: ABdhPJzCMpkUMtkOa6JHTvkBUtiIljc6SnEli0cT9h9mwIiSrTQT92CAGC0QVREch2fFHZG8qRSXgg==
X-Received: by 2002:a1c:f409:0:b0:381:500b:ad90 with SMTP id
 z9-20020a1cf409000000b00381500bad90mr6150070wma.42.1648148756169; 
 Thu, 24 Mar 2022 12:05:56 -0700 (PDT)
Received: from localhost.localdomain (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87]) by smtp.googlemail.com with ESMTPSA id
 m3-20020a5d64a3000000b00203ed35b0aesm5516084wrp.108.2022.03.24.12.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Mar 2022 12:05:55 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH v4 1/1] nvme/mpath: fix hang when disk goes live over reconnect
Date: Thu, 24 Mar 2022 13:05:11 -0600
Message-Id: <20220324190511.1659517-2-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324190511.1659517-1-anton@lightbitslabs.com>
References: <20220323152212.GA325@lst.de>
 <20220324190511.1659517-1-anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220324_120559_187804_4E6356B8 
X-CRM114-Status: GOOD (  22.22  )
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
 drivers/nvme/host/multipath.c | 26 ++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  4 ++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ccc5877d514b..8cb1197aac42 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4511,6 +4511,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 	if (ctrl->queue_count > 1) {
 		nvme_queue_scan(ctrl);
 		nvme_start_queues(ctrl);
+		nvme_mpath_update(ctrl);
 	}
 
 	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c97d7f843977..6f4d3108f35b 100644
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
 
@@ -700,6 +710,18 @@ static void nvme_ana_work(struct work_struct *work)
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
index 1ea908d43e17..8cf90c9ed667 100644
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
+static inline void nvme_mpath_update(struct nvme_ctrl *ctrl)
+{
+}
 static inline void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 {
 }
-- 
2.25.1


