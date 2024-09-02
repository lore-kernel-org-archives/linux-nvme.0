Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AEACD342B
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2024 11:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AaJWcWvxv4YpfZ2fEoAMVNYikwjvzuaToDJLQcsb6jw=; b=qJQo5MxgXyfH+p0UxLonEca6NF
	GVZgulafkEqDZMnQAMxHMBr4Ze5HzZyQ4k5n5oc1VVG84j6hNaq5a8DzECKR9xA/0h3+J/sCPJU40
	ki6Mcgrd8xMZdCoexT9ddV4w/KX9GJs4EXR+kMhsAW1czGxn18PtFkDAJNF16ALyFDi03OZp4T0k6
	0TCOIBp1dEY17vWH1c5yGKVtfTVabaLFlqgqtNFcCw50BWADhavh+2a32Rf+S3yPdmflCw7+l9Uzp
	SxOhOPq9P/SbfYR4h2ADWZ5jDvedkz1IhT/OVlD5xbpfKkUZHZSWKspSF7Ef+OIDWjezPY5kolGgX
	d5/NGBEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl52P-0000000E591-2mVk;
	Mon, 02 Sep 2024 11:16:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl52N-0000000E56g-0cEe
	for linux-nvme@lists.infradead.org;
	Mon, 02 Sep 2024 11:16:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1E4685C57D9;
	Mon,  2 Sep 2024 11:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B71C4CEC6;
	Mon,  2 Sep 2024 11:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725275758;
	bh=dQM4H7rYqfWIlfx+Tq3m8XL5B3bPBc6j0+ALkYGPsd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHzRKIkqxFFgvSN4k+Za5UX5lhA8cOovdRpG6ZJvG28tmSTe56Pwm0FMX/l7pPoip
	 lHIDHTcJlQswFmTkhENdWUf/Ktt38nTwtZUy24FzZL+PT/NVS5p3flrYHnjMRG3ZSX
	 xWufWtyv9V7Jr8TpZaD20TGRrWA3FzrwlXB8ITU9QY0F/B7eMLvGhoJ8jVNmAQ7Naw
	 Pn/gzV1Z4zmSPkpciKi6WGiv1MCCpQEcT3WDau3qQZT+TVbA9z7/gaDmAS0atC5RPL
	 Ih91E8IBR21GWbD3NxF3iXvIEikDbvw6RVlA8qBcuJCtY27fswPkBlMAoGwpXF7Y97
	 XdkgdL5wCeCbg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/4] nvme-multipath: check for NVME_NSHEAD_DISK_LIVE when selecting paths
Date: Mon,  2 Sep 2024 13:15:47 +0200
Message-Id: <20240902111548.41430-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240902111548.41430-1-hare@kernel.org>
References: <20240902111548.41430-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_041559_340081_DA3FE963 
X-CRM114-Status: GOOD (  15.45  )
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

and another scanning process (triggered by AEN) trying to remove the namespaces:

[<0>] __synchronize_srcu+0x17c/0x1b0
[<0>] nvme_ns_remove+0x12e/0x210 [nvme_core]
[<0>] nvme_ns_remove_by_nsid+0x21/0x70 [nvme_core]
[<0>] nvme_scan_work+0x1b7/0x490 [nvme_core]
[<0>] process_scheduled_works+0x37d/0x6d0

none of which is able to make progress as the first process cannot submit I/O
(as all the namespace inforation is stale), and the second process is stalled
waiting on the srcu to be released by the first process.

This patch checks for the NVME_NSHEAD_DISK_LIVE bit when selecting a path,
causing I/O to be aborted and allowing the first process to make progress.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/multipath.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 01dbbe866d61..f5f2e1667c64 100644
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
-- 
2.35.3


