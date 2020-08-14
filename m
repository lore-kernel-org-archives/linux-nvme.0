Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E5BC433E3
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 15:39:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24BAC2074D
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 15:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AFl3wQbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24BAC2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2vbQu1bHYuCp4HsjXga3BnmJ8TKan1DpvxYxTffuC8A=; b=AFl3wQbJzuEW4eFQXILupWM3BU
	SK05QCbtlPUFIGcwm447BPK1gv+gw3NaisrJfSKSjbZJJLlvi1zCPLNIbQzLcD2Ds1NV8o7Mv753H
	l0PeLnQSZqzNu5g+nAtLjOlQtR4iCKajHn5wiOUxqkeWATgp+NRJyolpp1vvsPY3/AOTHEfQUDu0V
	N9x+yHzIaGTLcfOS+WtSUgFW4t+SU/Ms5/1UtJsBUpv3uPB4FOw+yb+kelOaCpqGYHPCD3Ff71oaZ
	0GPMbPI31LhAPdcoHfLWTgBBHuCt2K8fgCIuD6XjQDtK7Ayk4dvJbbkBnmfbURGtaIc0DL7/pIy+v
	VhMVPpUg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6bnX-0007hB-BA; Fri, 14 Aug 2020 15:39:15 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6bnV-0007gL-2N
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 15:39:14 +0000
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 6B0FCC44427FD80778EA;
 Fri, 14 Aug 2020 23:39:06 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 14 Aug 2020 23:38:56 +0800
From: John Garry <john.garry@huawei.com>
To: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>
Subject: [PATCH] nvme-pci: Use u32 for nvme_dev.q_depth and nvme_queue.q_depth
Date: Fri, 14 Aug 2020 23:34:25 +0800
Message-ID: <1597419265-68122-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_113913_371587_6446D50C 
X-CRM114-Status: GOOD (  10.89  )
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
Cc: John Garry <john.garry@huawei.com>, linux-nvme@lists.infradead.org,
 chaitanya.kulkarni@wdc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Recently nvme_dev.q_depth was changed from an int to u16 type.

This falls over for the queue depth calculation in nvme_pci_enable(),
where NVME_CAP_MQES(dev->ctrl.cap) + 1 may overflow as a u16, as
NVME_CAP_MQES() is a 16b number also. That happens for me, and this is the
result:

root@ubuntu:/home/john# [148.272996] Unable to handle kernel NULL pointer
dereference at virtual address 0000000000000010
Mem abort info:
ESR = 0x96000004
EC = 0x25: DABT (current EL), IL = 32 bits
SET = 0, FnV = 0
EA = 0, S1PTW = 0
Data abort info:
ISV = 0, ISS = 0x00000004
CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=00000a27bf3c9000
[0000000000000010] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 96000004 [#1] PREEMPT SMP
Modules linked in: nvme nvme_core
CPU: 56 PID: 256 Comm: kworker/u195:0 Not tainted
5.8.0-next-20200812 #27
Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI RC0 -
V1.16.01 03/15/2019
Workqueue: nvme-reset-wq nvme_reset_work [nvme]
pstate: 80c00009 (Nzcv daif +PAN +UAO BTYPE=--)
pc : __sg_alloc_table_from_pages+0xec/0x238
lr : __sg_alloc_table_from_pages+0xc8/0x238
sp : ffff800013ccbad0
x29: ffff800013ccbad0 x28: ffff0a27b3d380a8
x27: 0000000000000000 x26: 0000000000002dc2
x25: 0000000000000dc0 x24: 0000000000000000
x23: 0000000000000000 x22: ffff800013ccbbe8
x21: 0000000000000010 x20: 0000000000000000
x19: 00000000fffff000 x18: ffffffffffffffff
x17: 00000000000000c0 x16: fffffe289eaf6380
x15: ffff800011b59948 x14: ffff002bc8fe98f8
x13: ff00000000000000 x12: ffff8000114ca000
x11: 0000000000000000 x10: ffffffffffffffff
x9 : ffffffffffffffc0 x8 : ffff0a27b5f9b6a0
x7 : 0000000000000000 x6 : 0000000000000001
x5 : ffff0a27b5f9b680 x4 : 0000000000000000
x3 : ffff0a27b5f9b680 x2 : 0000000000000000
 x1 : 0000000000000001 x0 : 0000000000000000
 Call trace:
__sg_alloc_table_from_pages+0xec/0x238
sg_alloc_table_from_pages+0x18/0x28
iommu_dma_alloc+0x474/0x678
dma_alloc_attrs+0xd8/0xf0
nvme_alloc_queue+0x114/0x160 [nvme]
nvme_reset_work+0xb34/0x14b4 [nvme]
process_one_work+0x1e8/0x360
worker_thread+0x44/0x478
kthread+0x150/0x158
ret_from_fork+0x10/0x34
 Code: f94002c3 6b01017f 540007c2 11000486 (f8645aa5)
---[ end trace 89bb2b72d59bf925 ]---

Fix by making onto a u32.

Also use u32 for nvme_dev.q_depth, as we assign this value from
nvme_dev.q_depth, and nvme_dev.q_depth will possibly hold 65536 - this
avoids the same crash as above.

Fixes: 61f3b8963097 ("nvme-pci: use unsigned for io queue depth")
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ba725ae47305..1cb09a187ae7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -120,7 +120,7 @@ struct nvme_dev {
 	unsigned max_qid;
 	unsigned io_queues[HCTX_MAX_TYPES];
 	unsigned int num_vecs;
-	u16 q_depth;
+	u32 q_depth;
 	int io_sqes;
 	u32 db_stride;
 	void __iomem *bar;
@@ -157,13 +157,13 @@ struct nvme_dev {
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
 {
 	int ret;
-	u16 n;
+	u32 n;
 
-	ret = kstrtou16(val, 10, &n);
+	ret = kstrtou32(val, 10, &n);
 	if (ret != 0 || n < 2)
 		return -EINVAL;
 
-	return param_set_ushort(val, kp);
+	return param_set_uint(val, kp);
 }
 
 static inline unsigned int sq_idx(unsigned int qid, u32 stride)
@@ -195,7 +195,7 @@ struct nvme_queue {
 	dma_addr_t sq_dma_addr;
 	dma_addr_t cq_dma_addr;
 	u32 __iomem *q_db;
-	u16 q_depth;
+	u32 q_depth;
 	u16 cq_vector;
 	u16 sq_tail;
 	u16 cq_head;
@@ -2320,7 +2320,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	dev->ctrl.cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
 
-	dev->q_depth = min_t(u16, NVME_CAP_MQES(dev->ctrl.cap) + 1,
+	dev->q_depth = min_t(u32, NVME_CAP_MQES(dev->ctrl.cap) + 1,
 				io_queue_depth);
 	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
 	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
