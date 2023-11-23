Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5024C61D85
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Nov 2023 11:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EW8cM780DyYloJn9iCXNpnTxx8FSx9qyfXJQnz3/b6Q=; b=kmIqbqVnAi51hGrWSFYT3W541W
	Q05EDrd5RzjhftvVOecimCFSG7i4cBoPzdpunkQMc2lI0LXBBbmMsGyUznR5HxpIdFuAYsD1JDR7D
	Fyv2Vo8xMg23tYicxkaldWlD4X+ay6El4oUzLa7M5ti1er9svMkWXhHn2EB5wng68GdvbgvrMDS0z
	bDWe3txMP3ONO6Wh7XLgaQ2MD2u53vmswKKr2XieXrL7N4N0nwOltnA/UeO9wAjL9denH1RWfryjg
	BSlHZXRTsEIQgFMwqkHwE/vfUb+vO3ME9z94t8Wyin583oDiyp3LXpaaiYs9z48Jexehoz16lfADk
	gvCqezXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r67Rr-004S2Y-14;
	Thu, 23 Nov 2023 11:00:43 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r67Ro-004S24-0N
	for linux-nvme@lists.infradead.org;
	Thu, 23 Nov 2023 11:00:41 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VwzFwnV_1700737214;
Received: from localhost(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0VwzFwnV_1700737214)
          by smtp.aliyun-inc.com;
          Thu, 23 Nov 2023 19:00:34 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kanie@linux.alibaba.com
Subject: [PATCH] nvme: fix deadlock between reset and scan
Date: Thu, 23 Nov 2023 19:00:13 +0800
Message-Id: <1700737213-110685-1-git-send-email-yaoma@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231123_030040_326017_A5C87246 
X-CRM114-Status: UNSURE (   8.39  )
X-CRM114-Notice: Please train this message.
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

If controller reset occurs when allocating namespace, both
nvme_reset_work and nvme_scan_work will hang, as shown below.

Test Scripts:

    for ((t=1;t<=128;t++))
    do
    nsid=`nvme create-ns /dev/nvme1 -s 14537724 -c 14537724 -f 0 -m 0 \
    -d 0 | awk -F: '{print($NF);}'`
    nvme attach-ns /dev/nvme1 -n $nsid -c 0
    done
    nvme reset /dev/nvme1

We will find that both nvme_reset_work and nvme_scan_work hung:

    INFO: task kworker/u249:4:17848 blocked for more than 120 seconds.
    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
    message.
    task:kworker/u249:4  state:D stack:    0 pid:17848 ppid:     2
    flags:0x00000028
    Workqueue: nvme-reset-wq nvme_reset_work [nvme]
    Call trace:
    __switch_to+0xb4/0xfc
    __schedule+0x22c/0x670
    schedule+0x4c/0xd0
    blk_mq_freeze_queue_wait+0x84/0xc0
    nvme_wait_freeze+0x40/0x64 [nvme_core]
    nvme_reset_work+0x1c0/0x5cc [nvme]
    process_one_work+0x1d8/0x4b0
    worker_thread+0x230/0x440
    kthread+0x114/0x120
    INFO: task kworker/u249:3:22404 blocked for more than 120 seconds.
    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
    message.
    task:kworker/u249:3  state:D stack:    0 pid:22404 ppid:     2
    flags:0x00000028
    Workqueue: nvme-wq nvme_scan_work [nvme_core]
    Call trace:
    __switch_to+0xb4/0xfc
    __schedule+0x22c/0x670
    schedule+0x4c/0xd0
    rwsem_down_write_slowpath+0x32c/0x98c
    down_write+0x70/0x80
    nvme_alloc_ns+0x1ac/0x38c [nvme_core]
    nvme_validate_or_alloc_ns+0xbc/0x150 [nvme_core]
    nvme_scan_ns_list+0xe8/0x2e4 [nvme_core]
    nvme_scan_work+0x60/0x500 [nvme_core]
    process_one_work+0x1d8/0x4b0
    worker_thread+0x260/0x440
    kthread+0x114/0x120
    INFO: task nvme:28428 blocked for more than 120 seconds.
    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
    message.
    task:nvme            state:D stack:    0 pid:28428 ppid: 27119
    flags:0x00000000
    Call trace:
    __switch_to+0xb4/0xfc
    __schedule+0x22c/0x670
    schedule+0x4c/0xd0
    schedule_timeout+0x160/0x194
    do_wait_for_common+0xac/0x1d0
    __wait_for_common+0x78/0x100
    wait_for_completion+0x24/0x30
    __flush_work.isra.0+0x74/0x90
    flush_work+0x14/0x20
    nvme_reset_ctrl_sync+0x50/0x74 [nvme_core]
    nvme_dev_ioctl+0x1b0/0x250 [nvme_core]
    __arm64_sys_ioctl+0xa8/0xf0
    el0_svc_common+0x88/0x234
    do_el0_svc+0x7c/0x90
    el0_svc+0x1c/0x30
    el0_sync_handler+0xa8/0xb0
    el0_sync+0x148/0x180

The reason for the hang is that nvme_reset_work occurs while nvme_scan_work
is still running. nvme_scan_work may add new ns into ctrl->namespaces
list after nvme_reset_work frozen all ns->q in ctrl->namespaces list.
The newly added ns is not frozen, so nvme_wait_freeze will wait forever.
Unfortunately, ctrl->namespaces_rwsem is held by nvme_reset_work, so
nvme_scan_work will also wait forever. Now we are deadlocked!

PROCESS1                         PROCESS2
==============                   ==============
nvme_scan_work
  ...                            nvme_reset_work
  nvme_validate_or_alloc_ns        nvme_dev_disable
    nvme_alloc_ns                    nvme_start_freeze
     down_write                      ...
     nvme_ns_add_to_ctrl_list        ...
     up_write                        nvme_wait_freeze
    ...                                down_read
    nvme_alloc_ns                      blk_mq_freeze_queue_wait
     down_write

Fix by checking ctrl->state whether is NVME_CTRL_LIVE before adding new
ns into ctrl->namespaces.

Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 62612f8..7551b55 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3631,6 +3631,11 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 		goto out_unlink_ns;
 
 	down_write(&ctrl->namespaces_rwsem);
+	/* preventing adding ns during resetting */
+	if (unlikely(ctrl->state != NVME_CTRL_LIVE)) {
+		up_write(&ctrl->namespaces_rwsem);
+		goto out_unlink_ns;
+	}
 	nvme_ns_add_to_ctrl_list(ns);
 	up_write(&ctrl->namespaces_rwsem);
 	nvme_get_ctrl(ctrl);
-- 
1.8.3.1


