Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB59CD37AB
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2024 18:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zF5QR1yuV9WyKuVpDCHvzOk3y1jM1XSe/vMDs/v54YA=; b=SLkIJEegQ0S7nk+SmKdFU2xvhm
	Q6wb/WJe1v5ahoN5SVjqd4/q39mYfRGxyrEkTTPawSugtYwSRF6rBpoouEiZF50YLh3+8tglry3s7
	HqUAufRSmMAhXADYII1Ck0x7mNztDwwhEQfueBVMDFGephODWxEw1y1uzSuX1VzwGX2runbwS7PE2
	gCAqPpLnc/ZBCBnTmvb+jwd2ONggGPr70RjjFJpQ8kYYeKn9dUpcfbF5eminjBAHU/VFYF4fTkDZS
	wBfuuFT4rsjU8SmAf+foKNbHq+iFe/wLE/4ue458HxrHwnlqbSJqIr1pR7nAe2LjWbQ9CiMgxfuf0
	vWaAcjjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slXso-00000001PKJ-1vgn;
	Tue, 03 Sep 2024 18:04:02 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slXsj-00000001PHU-3dh8
	for linux-nvme@lists.infradead.org;
	Tue, 03 Sep 2024 18:04:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C697D5C5948;
	Tue,  3 Sep 2024 18:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF30AC4AF09;
	Tue,  3 Sep 2024 18:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725386636;
	bh=bJWY86KT/SeBM1X6Y7VLfFCvrjv7saH4mKexJZPxIEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gMNWRSUzlxTuAwr2MNJsb0gJiesdlZrYOseJtZrkluHLAUNzgbmpL0wbEEKk9jyx6
	 PhX/unPHYeqBwmRLkeqxsE+H++lp/mReSsxy33a7ofjT5/znL+gXuWCV2zAcFWqaqj
	 2+d7uOearIsGAp0QmhZ+qVp8YzHApXZkdmloKUXZWKpoqVHd5W1mVnuL3mKanNzYbw
	 XggBf2OrZH2mnMhqq1Ywo/Ng0CL7+/UODnCv56YlLRdlpFFuu5yrY9BFugKikhjohb
	 NCORA0yh1TVI39ACD/PqYVrYXJJVTk+TMKMIAAAtSNI6lf4CnfazhJkKgHxD2iSwcL
	 33Z0Nfq5f6g5w==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/2] nvme-multipath: fix I/O stall when remapping namespaces
Date: Tue,  3 Sep 2024 20:03:45 +0200
Message-Id: <20240903180345.35253-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240903180345.35253-1-hare@kernel.org>
References: <20240903180345.35253-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_110358_012563_01CA38D3 
X-CRM114-Status: GOOD (  17.23  )
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

During repetitive namespace remapping operations (ie removing a namespace and
provision a different namespace with the same NSID) on the target the
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
This patch checks for NVME_NSHEAD_DISK_LIVE when selecting a path,
and requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared once
the last path has been removed to properly terminate pending I/O.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/multipath.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c9d23b1b8efc..1b1deb0450ab 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -407,6 +407,9 @@ static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
 
 inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 {
+	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
+		return NULL;
+
 	switch (READ_ONCE(head->subsys->iopolicy)) {
 	case NVME_IOPOLICY_QD:
 		return nvme_queue_depth_path(head);
@@ -421,6 +424,9 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 {
 	struct nvme_ns *ns;
 
+	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
+		return NULL;
+
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
 		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
 			continue;
@@ -967,11 +973,15 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
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
+	kblockd_schedule_work(&head->requeue_work);
 }
 
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
-- 
2.35.3


