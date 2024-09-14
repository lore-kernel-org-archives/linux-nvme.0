Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A13C02194
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Sep 2024 12:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OjuSu1E6xXfuK8zU0Ollu5H8OFw7kcfOo8dkeQNxeHI=; b=WQvH6yCAFHe/o/LpOOaKnHfVXo
	tJIc5tmHqhJ7WRoKDOvaHxp5qtqq90NvLmdbP6QG4j/NxZouGtplNVzbwF54LcoIaWR7fOx//BMZP
	ZeWXVi1GPjxnxcKJHkePbOSR4gwcJuZIau/pDli252eDZLgO7ZoR3lM3NbyI0t2HdbhJSqfT/FkTL
	aGjMWaDVTxgNhMyUQ7YxPr9xiBZQGZ9f0W1Tffn8DR/cjC/i26RVYkygVGA6OTtWXrQ+qayD3CBhH
	cq3tL+LBVV8TczHGBtN2RkeekElFLjnE/bOWVlev0XCCDkLH9K87NfJQjVrJrkNSC4s2eN2Tl4qJF
	DMOlWkog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spRTA-00000000e3u-2yRD;
	Sat, 14 Sep 2024 12:01:40 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spRT7-00000000e2v-1bJS
	for linux-nvme@lists.infradead.org;
	Sat, 14 Sep 2024 12:01:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 94671A40117;
	Sat, 14 Sep 2024 12:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DA0C4CEC4;
	Sat, 14 Sep 2024 12:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726315295;
	bh=gnPC3bVfXHSb9goE/TiVvsgFbiONVLXJEv25LgXBWZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ePTrUWRx6WsWiAY6i3/2A1eGIni4BYaybS7WPGHLisDXp/WLhM0tf1vpqTeHG7PdL
	 mA43He0LHUQJeIaCJQui83865wBUOxlkiCfFtDMS3zxl5T+pPUdfyRDI28uPcOybfz
	 aUNDm3TcVwTfz+eFeUM3hX6gQn4umowTuSucbgmvjvkVvfQEARQILG3LEf6ckz/Gvy
	 xt/Ju0qaUo8mTD89OsHkLrkkP/DkAHQWSmOc8YkGNpWLEUx7fd/p8v1xWRi8f/9Fy4
	 ypjXecoZssp+z2IJLfi/KybZ1cdt4fqxEhhY/TeUQ/GOkEainz2wOuHoaQYF5wTDpu
	 UIQ+P75ev9SMg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/2] nvme-multipath: avoid hang on inaccessible namespaces
Date: Sat, 14 Sep 2024 14:01:23 +0200
Message-Id: <20240914120123.125967-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240914120123.125967-1-hare@kernel.org>
References: <20240914120123.125967-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240914_050137_571765_5899CF9A 
X-CRM114-Status: GOOD (  15.09  )
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

During repetitive namespace remapping operations on the target the
namespace might have changed between the time the initial scan
was performed, and partition scan was invoked by device_add_disk()
in nvme_mpath_set_live(). We then end up with a stuck scanning process:

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

This happens when we have several paths, some of which are inaccessible,
and the active paths are removed first. Then nvme_find_path() will requeue
I/O in the ns_head (as paths are present), but the requeue list is never
triggered as all remaining paths are inactive.

This patch checks for NVME_NSHEAD_DISK_LIVE in nvme_available_path(),
and requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared once
the last path has been removed to properly terminate pending I/O.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/multipath.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c9d23b1b8efc..f72c5a6a2d8e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -421,6 +421,9 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 {
 	struct nvme_ns *ns;
 
+	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
+		return NULL;
+
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
 		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
 			continue;
@@ -967,11 +970,16 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
-	kblockd_schedule_work(&head->requeue_work);
-	if (test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
+	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
 		nvme_cdev_del(&head->cdev, &head->cdev_device);
 		del_gendisk(head->disk);
 	}
+	/*
+	 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
+	 * to allow multipath to fail all I/O.
+	 */
+	synchronize_srcu(&head->srcu);
+	kblockd_schedule_work(&head->requeue_work);
 }
 
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
-- 
2.35.3


