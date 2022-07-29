Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0C5C00144
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jul 2022 07:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RrDJYiNzAodPONp1iHWLjP/H2Wakgg8pZvB3nR5xcaQ=; b=Fp3jTSsrYujKAt0XAJsbVJ9yit
	HCjtkzZcG3G1FRqBDg6k04SIBZhW7ZQ8QCIal3naDPdH52DSqpBNpetd5F2viRJL+NfkEJD/QOTvW
	uXTpErgE/XjLxfZRWPO3Dwlh68+CVJ9okZZbljBkioyoGXuKjygjAyR7ZaaRe+71llH9FWVXp1QTy
	wvoZQxR5rUpZFCnbCj5q53A3b5SiZdGPoII0VFJWxQ6lxwZPAHyecHvX2F4mSVRW77soONwl1T863
	uqLRa0Jm6zL/bKm2NliytPAJyDshZKbk4uoBv5bZDkWwRQg5S+1HE3bnqHbNQmEjNuWifG/8OYx8V
	yK24ouHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHKbR-002gth-SR; Fri, 29 Jul 2022 07:40:09 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHKbG-002gkH-IO
	for linux-nvme@lists.infradead.org; Fri, 29 Jul 2022 07:40:00 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LvK9y08NfzmVKB;
	Fri, 29 Jul 2022 15:37:58 +0800 (CST)
Received: from huawei.com (10.29.88.127) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Jul
 2022 15:39:49 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>, <axboe@kernel.dk>,
	<lengchao@huawei.com>
Subject: [PATCH 1/3] blk-mq: delete unnecessary comments
Date: Fri, 29 Jul 2022 15:39:46 +0800
Message-ID: <20220729073948.32696-2-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20220729073948.32696-1-lengchao@huawei.com>
References: <20220729073948.32696-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220729_003958_823749_1BA68C56 
X-CRM114-Status: UNSURE (   8.90  )
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

To improve the quiesce time when using a large set of namespaces, nvme
need using blk_mq_quiesce_queue_nowait directly.
Thus the comments for blk_mq_quiesce_queue_nowait is unnecessary,
so delete the comments.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 block/blk-mq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 92aae03103b7..6b525640009c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -238,10 +238,6 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
-/*
- * FIXME: replace the scsi_internal_device_*block_nowait() calls in the
- * mpt3sas driver such that this function can be removed.
- */
 void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 {
 	unsigned long flags;
-- 
2.16.4


