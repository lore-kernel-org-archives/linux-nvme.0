Return-Path: <SRS0=7z9d=C3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B574C43463
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 02:19:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1348423600
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 02:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QdavcTlN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEkVuZ3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1348423600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xj1xOq2z7qPOs2ha4KhtOsgbAO5bXuThEXcKW2yb5HQ=; b=QdavcTlNmdOBnj0RQLabeViEm
	Q4ae8AKACpu9CR61fG1j7R11WoXnMIl4naai4Z6XojC9iT6KJCvB+OyyLRUPFMmsln2UVhr8uQqn9
	UCu0RgCG7AJxVlCosZ1XdmZg93SDANLm93CIg1L5oYZKn30F+Z0n+G1uYT5b32ZgIKJMXm3PFOh6R
	UhFIeXzlOHJdj/1kTcBxQQV6Rv/TsWZNva4JE3ghRRW4TdbanVKYFHGEhgmOG+fqbDhxv8qApneK4
	3CwCeQyqjNssLYxV1K5DnI1J+wc2wfPyNd1DlVlHLSOir9VSWrKRgqhtVGbtrysM4F/ew/vTIOTHg
	R1pubQCXg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJ5zI-0002JP-Gk; Fri, 18 Sep 2020 02:19:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJ5oL-0004y6-DJ
 for linux-nvme@lists.infradead.org; Fri, 18 Sep 2020 02:07:42 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D9A7923976;
 Fri, 18 Sep 2020 02:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600394860;
 bh=yl7zAgCsVezaLvg7UrTJDqeHEUSmYT1OIDNF59JKWyw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lEkVuZ3iytkL30dLpnPgBDpHEYrBEFxLQBVJ4XB9v+yR4pvjHTMrcxqKr30K2ZCxB
 YJLWvREmUPSD1srW+DglEdCXD/bOVxV9+5C92+P8qvMpAD8gP6ZEq1ORd5EPIfo9wl
 x19u/cSoGPtkTs5RiQsfB7HGYc3p6Y3HOxDWi4m0=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 314/330] nvme: fix possible deadlock when I/O is
 blocked
Date: Thu, 17 Sep 2020 22:00:54 -0400
Message-Id: <20200918020110.2063155-314-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918020110.2063155-1-sashal@kernel.org>
References: <20200918020110.2063155-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_220741_708269_13E9B171 
X-CRM114-Status: GOOD (  16.70  )
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
Cc: Sasha Levin <sashal@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 3b4b19721ec652ad2c4fe51dfbe5124212b5f581 ]

Revert fab7772bfbcf ("nvme-multipath: revalidate nvme_ns_head gendisk
in nvme_validate_ns")

When adding a new namespace to the head disk (via nvme_mpath_set_live)
we will see partition scan which triggers I/O on the mpath device node.
This process will usually be triggered from the scan_work which holds
the scan_lock. If I/O blocks (if we got ana change currently have only
available paths but none are accessible) this can deadlock on the head
disk bd_mutex as both partition scan I/O takes it, and head disk revalidation
takes it to check for resize (also triggered from scan_work on a different
path). See trace [1].

The mpath disk revalidation was originally added to detect online disk
size change, but this is no longer needed since commit cb224c3af4df
("nvme: Convert to use set_capacity_revalidate_and_notify") which already
updates resize info without unnecessarily revalidating the disk (the
mpath disk doesn't even implement .revalidate_disk fop).

[1]:
--
kernel: INFO: task kworker/u65:9:494 blocked for more than 241 seconds.
kernel:       Tainted: G           OE     5.3.5-050305-generic #201910071830
kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kernel: kworker/u65:9   D    0   494      2 0x80004000
kernel: Workqueue: nvme-wq nvme_scan_work [nvme_core]
kernel: Call Trace:
kernel:  __schedule+0x2b9/0x6c0
kernel:  schedule+0x42/0xb0
kernel:  schedule_preempt_disabled+0xe/0x10
kernel:  __mutex_lock.isra.0+0x182/0x4f0
kernel:  __mutex_lock_slowpath+0x13/0x20
kernel:  mutex_lock+0x2e/0x40
kernel:  revalidate_disk+0x63/0xa0
kernel:  __nvme_revalidate_disk+0xfe/0x110 [nvme_core]
kernel:  nvme_revalidate_disk+0xa4/0x160 [nvme_core]
kernel:  ? evict+0x14c/0x1b0
kernel:  revalidate_disk+0x2b/0xa0
kernel:  nvme_validate_ns+0x49/0x940 [nvme_core]
kernel:  ? blk_mq_free_request+0xd2/0x100
kernel:  ? __nvme_submit_sync_cmd+0xbe/0x1e0 [nvme_core]
kernel:  nvme_scan_work+0x24f/0x380 [nvme_core]
kernel:  process_one_work+0x1db/0x380
kernel:  worker_thread+0x249/0x400
kernel:  kthread+0x104/0x140
kernel:  ? process_one_work+0x380/0x380
kernel:  ? kthread_park+0x80/0x80
kernel:  ret_from_fork+0x1f/0x40
...
kernel: INFO: task kworker/u65:1:2630 blocked for more than 241 seconds.
kernel:       Tainted: G           OE     5.3.5-050305-generic #201910071830
kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kernel: kworker/u65:1   D    0  2630      2 0x80004000
kernel: Workqueue: nvme-wq nvme_scan_work [nvme_core]
kernel: Call Trace:
kernel:  __schedule+0x2b9/0x6c0
kernel:  schedule+0x42/0xb0
kernel:  io_schedule+0x16/0x40
kernel:  do_read_cache_page+0x438/0x830
kernel:  ? __switch_to_asm+0x34/0x70
kernel:  ? file_fdatawait_range+0x30/0x30
kernel:  read_cache_page+0x12/0x20
kernel:  read_dev_sector+0x27/0xc0
kernel:  read_lba+0xc1/0x220
kernel:  ? kmem_cache_alloc_trace+0x19c/0x230
kernel:  efi_partition+0x1e6/0x708
kernel:  ? vsnprintf+0x39e/0x4e0
kernel:  ? snprintf+0x49/0x60
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
kernel:  ? nvme_update_ns_ana_state+0x60/0x60 [nvme_core]
kernel:  nvme_mpath_add_disk+0x47/0x90 [nvme_core]
kernel:  nvme_validate_ns+0x396/0x940 [nvme_core]
kernel:  ? blk_mq_free_request+0xd2/0x100
kernel:  nvme_scan_work+0x24f/0x380 [nvme_core]
kernel:  process_one_work+0x1db/0x380
kernel:  worker_thread+0x249/0x400
kernel:  kthread+0x104/0x140
kernel:  ? process_one_work+0x380/0x380
kernel:  ? kthread_park+0x80/0x80
kernel:  ret_from_fork+0x1f/0x40
--

Fixes: fab7772bfbcf ("nvme-multipath: revalidate nvme_ns_head gendisk
in nvme_validate_ns")
Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f01fe2d910b54..bbf52e88f045a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1864,7 +1864,6 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ns->head->disk) {
 		nvme_update_disk_info(ns->head->disk, ns, id);
 		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
-		revalidate_disk(ns->head->disk);
 	}
 #endif
 }
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
