Return-Path: <SRS0=e03W=M2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D732CC4320A
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Aug 2021 09:07:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E18360C3F
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Aug 2021 09:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6E18360C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SMoTx1jQNs6nHhNrqb19gtbVH4gIX8wHxjwJnbpVUBY=; b=oDmbpFCJKKhoYr
	EIZHSmMjZZCqI2Rgny24XRjFxw9Xv6TCaYRSUeGkduyuXXoKQYycYvM04KSlVmQr2d7p8ndCOXslc
	WCQx+UALWqIPCUnKR2kYd2VM9G4Z33pU+5YkMBZJ5tdd4JI2H/xT9ODXwq09EAjmJ7NYHKX44kXLx
	/zNfynb3YP0D1ZoqWgH1g9ahw8gd2ZjLADnAXGaw1y1ScwzdOhULx+2bOjEf2kWA9Dmx3zvh2fvLX
	6W9uxSh9D7MPWR82OVnXQw2vlR34774PhTBAOUWmFdZBx+cRfyySQj0GRseU4zmomBKntP1U6oS/L
	aYGJEbcf1roDt81gH9ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mAqNn-001gla-Od; Tue, 03 Aug 2021 09:06:43 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mAqNi-001gk3-Ud
 for linux-nvme@lists.infradead.org; Tue, 03 Aug 2021 09:06:40 +0000
Received: from dggeme720-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gf8BB3bTlzYcqn
 for <linux-nvme@lists.infradead.org>; Tue,  3 Aug 2021 17:06:26 +0800 (CST)
Received: from huawei.com (10.29.88.127) by dggeme720-chm.china.huawei.com
 (10.1.199.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 3 Aug
 2021 17:06:30 +0800
From: Ruozhu Li <liruozhu@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH 2/2] nvme: don't do scan work if io queue count is zero
Date: Tue, 3 Aug 2021 17:06:30 +0800
Message-ID: <20210803090630.14425-3-liruozhu@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20210803090630.14425-1-liruozhu@huawei.com>
References: <20210803090630.14425-1-liruozhu@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme720-chm.china.huawei.com (10.1.199.116)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210803_020639_201032_FD31A534 
X-CRM114-Status: GOOD (  12.34  )
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

kernel panic when try to rescan ns when io queue count is zero.Because
kernel BUG_ON when hctx_idx is greater than ctrl->queue_count.
--
nvme_rdma_init_hctx+0x58/0x60 [nvme_rdma]
blk_mq_realloc_hw_ctxs+0x140/0x4c0
blk_mq_init_allocated_queue+0x130/0x410
blk_mq_init_queue+0x40/0x88
nvme_validate_ns+0xb8/0x740
nvme_scan_work+0x29c/0x460
process_one_work+0x1f8/0x490
worker_thread+0x50/0x4b8
kthread+0x134/0x138
ret_from_fork+0x10/0x18
--
Defence it by not allowing rescan ns when io queue count is zero.

Signed-off-by: Ruozhu Li <liruozhu@huawei.com>
---
 drivers/nvme/host/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dfd9dec0c1f6..d9f837eb3e26 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -141,7 +141,8 @@ void nvme_queue_scan(struct nvme_ctrl *ctrl)
 	/*
 	 * Only new queue scan work when admin and IO queues are both alive
 	 */
-	if (ctrl->state == NVME_CTRL_LIVE && ctrl->tagset)
+	if (ctrl->state == NVME_CTRL_LIVE &&
+	    ctrl->tagset && ctrl->queue_count > 1)
 		queue_work(nvme_wq, &ctrl->scan_work);
 }
 
@@ -4047,7 +4048,8 @@ static void nvme_scan_work(struct work_struct *work)
 		container_of(work, struct nvme_ctrl, scan_work);
 
 	/* No tagset on a live ctrl means IO queues could not created */
-	if (ctrl->state != NVME_CTRL_LIVE || !ctrl->tagset)
+	if (ctrl->state != NVME_CTRL_LIVE ||
+	    !ctrl->tagset || ctrl->queue_count < 2)
 		return;
 
 	if (test_and_clear_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events)) {
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
