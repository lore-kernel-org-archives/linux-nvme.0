Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE644C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 08:53:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC2E207DD
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 08:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OOShAihC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC2E207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iPkuSEYOIf8J4DfhHt7EqwaXDylYJgxMYe62YF5PgdQ=; b=OOShAihCjd9nMNdsWHhA5IwLZ
	dFqI+zUGUQSYdjL66eAvyEM7IXKTU+cWHePSVTJ3XYFinQ/XrrbkfMBQoTNGr1UGrXDIQTwqaLWXh
	BDbtwdscasZxVHGRFtt1tGl3MM8VpAoV7lYpVcL8Apf6GaYGsp/djLE7Mz6+Z1TGl7sl1M0WZwckB
	Gn9iIxlubygo8yibUI1VOkJhVxhRYFxu5uqTWBRAOaUxHrU5j3JoieoIKv3eBH8OEegR1pvkCcLYg
	EaJakogp+7yYe1hWVJ73IsTmnUxMvHREVYh+YWQvn+jLrEZqcRE0cdlqulQsQlc96qveAKPbgHNiz
	QrlPuGwSw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jo19t-00064u-0Q; Wed, 24 Jun 2020 08:53:29 +0000
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jo19o-00062h-28
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 08:53:25 +0000
Received: by mail-pj1-f66.google.com with SMTP id ev7so405472pjb.2
 for <linux-nvme@lists.infradead.org>; Wed, 24 Jun 2020 01:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=59/2qUgAVashx5ayDo6YWkt3myX12ciRoOX2JqBfuPo=;
 b=mngnDtF4l2i9P4d/hk2HT0ThczNy7PA9oKsA6gMJpNcdTW8owwljTPr7p8ZVx0bXQQ
 E8Ho3dz5KAyTz96NyMM8hx6gfe2xebc1tmZRx2Z/DmYgOu/q4zFZt94ZURV6vIDqjwJp
 2Se/tiXB9F5p9MzLRAItuLe3qqf6LHrccDrfPZbfSyPs+r0Dg2fh7EzG0C7TDU7LVQI1
 /0v31Z8E2VlBoulZUhS6DmFxVUrBXUNby3VffUWFbuaeLkwNTQtEIt3aY9PRZY10Jbi3
 O3Vxr0EqMJb9XWw7nQxz21Art3DUhi3ba1i5q8jl8yksKMze5+pUG2PDLL+402kIk62Q
 CQrw==
X-Gm-Message-State: AOAM531O1Ao9+NzZxBSKkrvZ4LZLW97eniVOixcSlev3Y7fr6pE6n4PQ
 6wdNod2uwPN6jYXOFt2l0W5AQkos
X-Google-Smtp-Source: ABdhPJzfGztLdbQ2UQFi4krQ+kslnxIKGDT+YEZwJb+SXXfe/0sFgR+G5ibBuC9yPr+UL9lcG+13vQ==
X-Received: by 2002:a17:90a:c717:: with SMTP id
 o23mr27661491pjt.195.1592988802892; 
 Wed, 24 Jun 2020 01:53:22 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:9915:87a9:9728:63e])
 by smtp.gmail.com with ESMTPSA id m14sm4600814pjv.12.2020.06.24.01.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 01:53:22 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH v3 for-5.8-rc 2/5] nvme-multipath: fix deadlock between
 ana_work and scan_work
Date: Wed, 24 Jun 2020 01:53:09 -0700
Message-Id: <20200624085312.35967-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624085312.35967-1-sagi@grimberg.me>
References: <20200624085312.35967-1-sagi@grimberg.me>
MIME-Version: 1.0
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
Cc: Anton Eidelman <anton@lightbitslabs.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Anton Eidelman <anton@lightbitslabs.com>

When scan_work calls nvme_mpath_add_disk() this holds ana_lock
and invokes nvme_parse_ana_log(), which may issue IO
in device_add_disk() and hang waiting for an accessible path.
While nvme_mpath_set_live() only called when nvme_state_is_live(),
a transition may cause NVME_SC_ANA_TRANSITION and requeue the IO.

In order to recover and complete the IO ana_work on the same ctrl
should be able to update the path state and remove NVME_NS_ANA_PENDING.

The deadlock occurs because scan_work keeps holding ana_lock,
so ana_work hangs [1].

Fix:
Now nvme_mpath_add_disk() uses nvme_parse_ana_log() to obtain a copy
of the ANA group desc, and then calls nvme_update_ns_ana_state() without
holding ana_lock.

[1]:
kernel: Workqueue: nvme-wq nvme_scan_work [nvme_core]
kernel: Call Trace:
kernel:  __schedule+0x2b9/0x6c0
kernel:  schedule+0x42/0xb0
kernel:  io_schedule+0x16/0x40
kernel:  do_read_cache_page+0x438/0x830
kernel:  read_cache_page+0x12/0x20
kernel:  read_dev_sector+0x27/0xc0
kernel:  read_lba+0xc1/0x220
kernel:  efi_partition+0x1e6/0x708
kernel:  check_partition+0x154/0x244
kernel:  rescan_partitions+0xae/0x280
kernel:  __blkdev_get+0x40f/0x560
kernel:  blkdev_get+0x3d/0x140
kernel:  __device_add_disk+0x388/0x480
kernel:  device_add_disk+0x13/0x20
kernel:  nvme_mpath_set_live+0x119/0x140 [nvme_core]
kernel:  nvme_update_ns_ana_state+0x5c/0x60 [nvme_core]
kernel:  nvme_set_ns_ana_state+0x1e/0x30 [nvme_core]
kernel:  nvme_parse_ana_log+0xa1/0x180 [nvme_core]
kernel:  nvme_mpath_add_disk+0x47/0x90 [nvme_core]
kernel:  nvme_validate_ns+0x396/0x940 [nvme_core]
kernel:  nvme_scan_work+0x24f/0x380 [nvme_core]
kernel:  process_one_work+0x1db/0x380
kernel:  worker_thread+0x249/0x400
kernel:  kthread+0x104/0x140

kernel: Workqueue: nvme-wq nvme_ana_work [nvme_core]
kernel: Call Trace:
kernel:  __schedule+0x2b9/0x6c0
kernel:  schedule+0x42/0xb0
kernel:  schedule_preempt_disabled+0xe/0x10
kernel:  __mutex_lock.isra.0+0x182/0x4f0
kernel:  ? __switch_to_asm+0x34/0x70
kernel:  ? select_task_rq_fair+0x1aa/0x5c0
kernel:  ? kvm_sched_clock_read+0x11/0x20
kernel:  ? sched_clock+0x9/0x10
kernel:  __mutex_lock_slowpath+0x13/0x20
kernel:  mutex_lock+0x2e/0x40
kernel:  nvme_read_ana_log+0x3a/0x100 [nvme_core]
kernel:  nvme_ana_work+0x15/0x20 [nvme_core]
kernel:  process_one_work+0x1db/0x380
kernel:  worker_thread+0x4d/0x400
kernel:  kthread+0x104/0x140
kernel:  ? process_one_work+0x380/0x380
kernel:  ? kthread_park+0x80/0x80
kernel:  ret_from_fork+0x35/0x40

Fixes: 0d0b660f214d ("nvme: add ANA support")
Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/multipath.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index da78e499947a..0ef183c1153e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -640,26 +640,34 @@ static ssize_t ana_state_show(struct device *dev, struct device_attribute *attr,
 }
 DEVICE_ATTR_RO(ana_state);
 
-static int nvme_set_ns_ana_state(struct nvme_ctrl *ctrl,
+static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
-	struct nvme_ns *ns = data;
+	struct nvme_ana_group_desc *dst = data;
 
-	if (ns->ana_grpid == le32_to_cpu(desc->grpid)) {
-		nvme_update_ns_ana_state(desc, ns);
-		return -ENXIO; /* just break out of the loop */
-	}
+	if (desc->grpid != dst->grpid)
+		return 0;
 
-	return 0;
+	*dst = *desc;
+	return -ENXIO; /* just break out of the loop */
 }
 
 void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	if (nvme_ctrl_use_ana(ns->ctrl)) {
+		struct nvme_ana_group_desc desc = {
+			.grpid = id->anagrpid,
+			.state = 0,
+		};
+
 		mutex_lock(&ns->ctrl->ana_lock);
 		ns->ana_grpid = le32_to_cpu(id->anagrpid);
-		nvme_parse_ana_log(ns->ctrl, ns, nvme_set_ns_ana_state);
+		nvme_parse_ana_log(ns->ctrl, &desc, nvme_lookup_ana_group_desc);
 		mutex_unlock(&ns->ctrl->ana_lock);
+		if (desc.state) {
+			/* found the group desc: update */
+			nvme_update_ns_ana_state(&desc, ns);
+		}
 	} else {
 		mutex_lock(&ns->head->lock);
 		ns->ana_state = NVME_ANA_OPTIMIZED; 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
