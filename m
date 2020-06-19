Return-Path: <SRS0=ohfr=AA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF02C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 23:35:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA20E20656
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 23:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gDy/87Iw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA20E20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NXZIhzK1ErzJv+zsTPnszs3lkNlRxd73eWgp4bJysx8=; b=gDy/87Iwfz50Hw
	tNTQai5ouVagOzZ3/kMWnAdxl1mEKuJN95AuxxHxWOWXr0axmTvz9ybWKJJqO2dwFrHYBaCGgIAeb
	nNRqoOzbhaSRygtlazZoxkZYv9WxLkDNjzRZh0/ZE3OvcHwbija9ObyHSvq7mT8bUmX988nYhPvyg
	jQK8fpl97TPhIBjMytIeRG2SrblRJ4mQAUGSsU0fJeDbYmEvDoqPpQj0FyN+DFCUomtmcPNVHvRII
	XutPrEB0KWmAFQ54qCK1INHyD0APBnA58dA67BRmqU3FuB/4sJMNq20LnP+GINEE0cLXxTrO2XuUt
	aRr1YH2EoH6VdxHYUsUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jmQXO-0005cf-Tr; Fri, 19 Jun 2020 23:35:11 +0000
Received: from [2601:647:4802:9070:4430:34bd:1e1c:d6bc]
 (helo=localhost.localdomain)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jmQXC-0004Qq-Ek; Fri, 19 Jun 2020 23:34:58 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/5] nvme: fix possible deadlock when I/O is blocked
Date: Fri, 19 Jun 2020 16:34:52 -0700
Message-Id: <20200619233456.379778-2-sagi@grimberg.me>
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

This is no longer needed since commit cb224c3af4df ("nvme: Convert to
use set_capacity_revalidate_and_notify") which already updates resize
info without unnecessarily revalidating the disk.

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
---
 drivers/nvme/host/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 915fa2e609eb..28f4388c1337 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1974,7 +1974,6 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ns->head->disk) {
 		nvme_update_disk_info(ns->head->disk, ns, id);
 		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
-		revalidate_disk(ns->head->disk);
 	}
 #endif
 	return 0;
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
