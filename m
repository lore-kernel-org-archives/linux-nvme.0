Return-Path: <SRS0=ohfr=AA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20634C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 23:35:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2DB120656
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 23:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tpq0YQkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2DB120656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P5DQa31Q7vK6X9UyUDFQnR5fxsQ2l/m1NTLcRL0q9pU=; b=tpq0YQkpDjT09k
	NAMXRE9imjuFGkkOm1DLDAIj4X3GGzmDuw6KuNzxyHJ8Fs1+Y9piluSKwhiknOzGBzj8elAVgeUCI
	Gcp6qxVVKJfbTFa+cp5u4dLDx3UEX+8COlm4OLbsmLXZlU/8LnWhGE/mHfAcvd4mv0wKP6Y2N1Vwe
	pfE6u9HFXOsou9k29NMP0qRUiB3EXFonhZcMz1nvr4/M7pqemuU6BcoXN4LzVGogxq+ToEDxlsHMJ
	cWUSWsC2zZv7yFc/yG9SP7uXMlPeSrlYqjdf83igEPZbIPoCtHiEQQUViXZK1k6iAs+S8gB3EJ3pw
	rC1aWpJzAHkE/yDIk35g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jmQY0-0007Wl-5T; Fri, 19 Jun 2020 23:35:48 +0000
Received: from [2601:647:4802:9070:4430:34bd:1e1c:d6bc]
 (helo=localhost.localdomain)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jmQXC-0004Qq-Qv; Fri, 19 Jun 2020 23:34:58 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH 4/5] nvme-multipath: fix deadlock due to head->lock
Date: Fri, 19 Jun 2020 16:34:55 -0700
Message-Id: <20200619233456.379778-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200619233456.379778-1-sagi@grimberg.me>
References: <20200619233456.379778-1-sagi@grimberg.me>
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Anton Eidelman <anton@lightbitslabs.com>

In the following scenario scan_work and ana_work will deadlock:

When scan_work calls nvme_mpath_add_disk() this holds ana_lock
and invokes nvme_parse_ana_log(), which may issue IO
in device_add_disk() and hang waiting for an accessible path.

While nvme_mpath_set_live() only called when nvme_state_is_live(),
a transition may cause NVME_SC_ANA_TRANSITION and requeue the IO.

Since nvme_mpath_set_live() holds ns->head->lock, an ana_work on
ANY ctrl will not be able to complete nvme_mpath_set_live()
on the same ns->head, which is required in order to update
the new accessible path and remove NVME_NS_ANA_PENDING..
Therefore IO never completes: deadlock [1].

Fix:
Move device_add_disk out of the head->lock and protect it with an
atomic test_and_set for a new NVME_NS_HEAD_HAS_DISK bit.

[1]:
kernel: INFO: task kworker/u8:2:160 blocked for more than 120 seconds.
kernel:       Tainted: G           OE     5.3.5-050305-generic #201910071830
kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kernel: kworker/u8:2    D    0   160      2 0x80004000
kernel: Workqueue: nvme-wq nvme_ana_work [nvme_core]
kernel: Call Trace:
kernel:  __schedule+0x2b9/0x6c0
kernel:  schedule+0x42/0xb0
kernel:  schedule_preempt_disabled+0xe/0x10
kernel:  __mutex_lock.isra.0+0x182/0x4f0
kernel:  __mutex_lock_slowpath+0x13/0x20
kernel:  mutex_lock+0x2e/0x40
kernel:  nvme_update_ns_ana_state+0x22/0x60 [nvme_core]
kernel:  nvme_update_ana_state+0xca/0xe0 [nvme_core]
kernel:  nvme_parse_ana_log+0xa1/0x180 [nvme_core]
kernel:  nvme_read_ana_log+0x76/0x100 [nvme_core]
kernel:  nvme_ana_work+0x15/0x20 [nvme_core]
kernel:  process_one_work+0x1db/0x380
kernel:  worker_thread+0x4d/0x400
kernel:  kthread+0x104/0x140
kernel:  ret_from_fork+0x35/0x40
kernel: INFO: task kworker/u8:4:439 blocked for more than 120 seconds.
kernel:       Tainted: G           OE     5.3.5-050305-generic #201910071830
kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kernel: kworker/u8:4    D    0   439      2 0x80004000
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
kernel:  nvme_mpath_add_disk+0xbe/0x100 [nvme_core]
kernel:  nvme_validate_ns+0x396/0x940 [nvme_core]
kernel:  nvme_scan_work+0x256/0x390 [nvme_core]
kernel:  process_one_work+0x1db/0x380
kernel:  worker_thread+0x4d/0x400
kernel:  kthread+0x104/0x140
kernel:  ret_from_fork+0x35/0x40

Fixes: 0d0b660f214d ("nvme: add ANA support")
Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/multipath.c | 4 ++--
 drivers/nvme/host/nvme.h      | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c8fc42e37138..505f5f43cd69 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -412,11 +412,11 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 	if (!head->disk)
 		return;
 
-	mutex_lock(&head->lock);
-	if (!(head->disk->flags & GENHD_FL_UP))
+	if (!test_and_set_bit(NVME_NS_HEAD_HAS_DISK, &head->flags))
 		device_add_disk(&head->subsys->dev, head->disk,
 				nvme_ns_id_attr_groups);
 
+	mutex_lock(&head->lock);
 	if (nvme_path_is_optimized(ns)) {
 		int node, srcu_idx;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c0f4226d3299..eccafd52b055 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -365,6 +365,8 @@ struct nvme_ns_head {
 	struct work_struct	requeue_work;
 	struct mutex		lock;
 	struct nvme_ns __rcu	*current_path[];
+	unsigned long		flags;
+#define NVME_NS_HEAD_HAS_DISK	0
 #endif
 };
 
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
