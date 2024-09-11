Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FD7EE499D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 12:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w/vHb7ndZbWh4b16CucP1TtiWVTOAdjHdr9nyzx/ikE=; b=vxSQN1nqJs8DIAxRQ7c4aTeZ17
	02XGH9dejKFUo3ODbeu2+ABAeL5FYuWaPxtpfHdljlge8k5CWKPfoX+BMU1+KaImWUtAAy9vUkxRb
	/5xBRAc+k/zZunJKB0nKf5seihR1UUxVaLb3uJZY4KWpNqJBcXRm2dvgzRKPtpCKXErqSXrxv1QlR
	vslJ7OXelQKsuMgbnZbIgWWY+BrU1tI3UU3CFOLXGveKj0HCnLxFjACm5zS8SoabwBEkVrBc/WHel
	Uhdjtads2fgWRHfFFa8kEDhNLlH3GxA2uiQEt5W6ZWeDn3FS7xXy62kuyqkUf3jmoCtVfvMWPoFM2
	mSKYJ0Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soMkM-00000009YMM-3xkb;
	Wed, 11 Sep 2024 12:46:58 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soMjk-00000009YE6-20u1
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 12:46:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0360DA44406;
	Wed, 11 Sep 2024 12:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFC0C4CEC6;
	Wed, 11 Sep 2024 12:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726058779;
	bh=pc8Jyk2eR74GeiF9pgT5v43sllGxj6mlz1QP9LOERW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OR01FssSED0Fjt3GGd5Ym+w9h4RpxCwd+ztz0NKqJIyE40dzf5hauDQ0lc/u+ndEX
	 qkJ5t70CSIuGO7qXj1tTHtA7sLMiTQTGAx65fuJDWYXaHNNvtTG78TAF+ICpl8tuXj
	 OYhLsFH+pZzeKXsYIB/ZbClfv29Uvio/L1Lm2kwjpF2j9496MzGT7zikg/s4iiFTyz
	 JR3IEeHwmDNz8uYmG1xjtFxX7hZkoZ0K7dctM4mRp6/css+h4w7P7DY3aX+eqKoKB8
	 TpCacVTEvEOduf8ykw4hwT9AQYfnzoR14F4lfgFj+Fstg+14e28AnONYRYiI0A3Awo
	 tav928V5dy/VQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/3] nvme-multipath: stuck partition scan on inaccessible paths
Date: Wed, 11 Sep 2024 14:46:10 +0200
Message-Id: <20240911124610.81615-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240911124610.81615-1-hare@kernel.org>
References: <20240911124610.81615-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_054620_665678_2D72C74B 
X-CRM114-Status: GOOD (  14.91  )
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

When a path is switched to 'inaccessible' during partition scan
triggered via device_add_disk() and we only have one path the
system will be stuck as nvme_available_path() will always return
'true'. So I/O will never be completed and the system is stuck
in device_add_disk():

    [<0>] folio_wait_bit_common+0x12a/0x310
    [<0>] filemap_read_folio+0x97/0xd0
    [<0>] do_read_cache_folio+0x108/0x390
    [<0>] read_part_sector+0x31/0xa0
    [<0>] read_lba+0xc5/0x160
    [<0>] efi_partition+0xd9/0x8f0
    [<0>] bdev_disk_changed+0x23d/0x6d0
    [<0>] blkdev_get_whole+0x78/0xc0
    [<0>] bdev_open+0x2c6/0x3b0
    [<0>] bdev_file_open_by_dev+0xcb/0x120
    [<0>] disk_scan_partitions+0x5d/0x100
    [<0>] device_add_disk+0x402/0x420
    [<0>] nvme_mpath_set_live+0x4f/0x1f0 [nvme_core]
    [<0>] nvme_mpath_add_disk+0x107/0x120 [nvme_core]
    [<0>] nvme_alloc_ns+0xac6/0xe60 [nvme_core]
    [<0>] nvme_scan_ns+0x2dd/0x3e0 [nvme_core]
    [<0>] nvme_scan_work+0x1a3/0x490 [nvme_core]

This patch introduces a flag NVME_NSHEAD_FAIL_ON_LAST_PATH to
cause nvme_available_path() to always return NULL, and with
that I/O to be failed if the last path is unavailable. But
we also need to requeue all pending I/Os whenever we have
changed the ANA state as now even inaccessible ANA states
influence I/O behaviour.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/multipath.c | 15 +++++++++++++++
 drivers/nvme/host/nvme.h      |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f72c5a6a2d8e..0373b4043eea 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -422,6 +422,10 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	struct nvme_ns *ns;
 
 	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
+	    return NULL;
+
+	if (test_bit(NVME_NSHEAD_FAIL_ON_LAST_PATH, &head->flags) &&
+	    list_is_singular(&head->list))
 		return NULL;
 
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
@@ -646,8 +650,15 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 	 * head.
 	 */
 	if (!test_and_set_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
+		/*
+		 * Disable queueing to ensure I/O is not retried on unusable
+		 * paths, which would cause the system to be stuck during
+		 * partition scan.
+		 */
+		set_bit(NVME_NSHEAD_FAIL_ON_LAST_PATH, &head->flags);
 		rc = device_add_disk(&head->subsys->dev, head->disk,
 				     nvme_ns_attr_groups);
+		clear_bit(NVME_NSHEAD_FAIL_ON_LAST_PATH, &head->flags);
 		if (rc) {
 			clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags);
 			return;
@@ -737,6 +748,10 @@ static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
 	if (nvme_state_is_live(ns->ana_state) &&
 	    nvme_ctrl_state(ns->ctrl) == NVME_CTRL_LIVE)
 		nvme_mpath_set_live(ns);
+	else {
+		synchronize_srcu(&ns->head->srcu);
+		kblockd_schedule_work(&ns->head->requeue_work);
+	}
 }
 
 static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 50515ad0f9d6..6aef38eba293 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -493,6 +493,7 @@ struct nvme_ns_head {
 	struct mutex		lock;
 	unsigned long		flags;
 #define NVME_NSHEAD_DISK_LIVE	0
+#define NVME_NSHEAD_FAIL_ON_LAST_PATH	1
 	struct nvme_ns __rcu	*current_path[];
 #endif
 };
-- 
2.35.3


