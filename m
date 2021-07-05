Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B15CC07E99
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 13:30:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964A7613FC
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 13:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964A7613FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=U7t4smMXaFu9pcJwcwQKIoBqfeBG9glrYoR9aNmaZn0=; b=w/1E18vEwNaKMz
	zdq0jpn34nP8sT/Sb9RYeKjHZPbwbQjCNNnW3CCkvJe+F062lwFryrwsUfKznDQlno6g1gFlNPJKU
	0dtjGKFUvqngEf9ZY30iZL1Td4dpDB8ClXQQ4SjXOsjSmclG04GXu9If92tfOvrAE855j47aseVp1
	M3HZHDuysXeob87DqYfbZX/KWbWNMf0YJES6Hw1ty+BcFext7z3iYKSzE5OeV2iCbVc9CTly89WSa
	jPrvyDhFvC6aWfcU5aV8RtvgieYbs9bLjE03QM7SjuoJNoUI5jU4+0xRXoBLaqfNl+RKdshbWUWCn
	qgSMOdQnB2BmNXiuqyKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0Ofw-0090wG-Q6; Mon, 05 Jul 2021 13:30:16 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0Ofs-0090uJ-QE
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 13:30:14 +0000
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GJRL556JgzZqwB;
 Mon,  5 Jul 2021 21:26:53 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 21:30:04 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 5 Jul
 2021 21:30:03 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
 <rakesh@tuxera.com>
CC: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH] nvme-pci: Don't WARN_ON in nvme_reset_work if ctrl.state is
 not RESETTING
Date: Mon, 5 Jul 2021 21:38:29 +0800
Message-ID: <20210705133829.349660-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_063013_119529_A9617320 
X-CRM114-Status: UNSURE (   9.38  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Followling process:
nvme_probe
  nvme_reset_ctrl
    nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING)
    queue_work(nvme_reset_wq, &ctrl->reset_work)

-------------->	nvme_remove
		  nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING)
worker_thread
  process_one_work
    nvme_reset_work
    WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING)

, which will trigger WARN_ON in nvme_reset_work():
[  127.534298] WARNING: CPU: 0 PID: 139 at drivers/nvme/host/pci.c:2594
[  127.536161] CPU: 0 PID: 139 Comm: kworker/u8:7 Not tainted 5.13.0
[  127.552518] Call Trace:
[  127.552840]  ? kvm_sched_clock_read+0x25/0x40
[  127.553936]  ? native_send_call_func_single_ipi+0x1c/0x30
[  127.555117]  ? send_call_function_single_ipi+0x9b/0x130
[  127.556263]  ? __smp_call_single_queue+0x48/0x60
[  127.557278]  ? ttwu_queue_wakelist+0xfa/0x1c0
[  127.558231]  ? try_to_wake_up+0x265/0x9d0
[  127.559120]  ? ext4_end_io_rsv_work+0x160/0x290
[  127.560118]  process_one_work+0x28c/0x640
[  127.561002]  worker_thread+0x39a/0x700
[  127.561833]  ? rescuer_thread+0x580/0x580
[  127.562714]  kthread+0x18c/0x1e0
[  127.563444]  ? set_kthread_struct+0x70/0x70
[  127.564347]  ret_from_fork+0x1f/0x30

The preceding problem can be easily reproduced by executing following
script (based on blktests suite):
test() {
  pdev="$(_get_pci_dev_from_blkdev)"
  sysfs="/sys/bus/pci/devices/${pdev}"
  for ((i = 0; i < 10; i++)); do
    echo 1 > "$sysfs/remove"
    echo 1 > /sys/bus/pci/rescan
  done
}

Since the device ctrl could be updated as an non-RESETTING state by
repeating probe/remove in userspace (which is a normal situation), we
can replace stack dumping WARN_ON with a warnning message.

Fixes: 82b057caefaff ("nvme-pci: fix multiple ctrl removal schedulin")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/nvme/host/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a29b170701fc..966a4c84e699 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2591,7 +2591,9 @@ static void nvme_reset_work(struct work_struct *work)
 	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result;
 
-	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING)) {
+	if (dev->ctrl.state != NVME_CTRL_RESETTING) {
+		dev_warn(dev->ctrl.device, "ctrl state %d is not RESETTING\n",
+			 dev->ctrl.state);
 		result = -ENODEV;
 		goto out;
 	}
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
