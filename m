Return-Path: <SRS0=YdFy=DT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6EAC433E7
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2020 08:11:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F5D208B6
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2020 08:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sOOcXAG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F5D208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1xNlac45sp2PpEJ7KEzBN/Kpbri+vgLB4PG5eiuoi+o=; b=sOOcXAG/TB6ApQ9JZ2QLpxLRyd
	zPplnlkvQMFfnEA68hKZ6v8VG+ymnIFa2WZ2ZnLUK50k1jiwJ4yaEzoPdDC0fBpbQf6tbQFZzrZL3
	I2P8I/EfGlolQPhSI9dRosKLccI/WGoKN0cxTr7ZGTDLkuo1Nv/bHN0obz9aX6vJL9wm+ZTpa4gyg
	FeAx7inWCyGaTGfC0jYvukjAkMJ7se0jtDVlME20fzXWvN6OoY0dG2WQtrB2NjZtSaslw+x6Y99xK
	cdvV3mk9BwNMsfY/dobRU3l8j6iO8tgFKPjqG84F6HsDz5jbN81EixQhqtcKz1OmkLBdIKjgdqdNA
	HlO59eGw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kRsv6-0001qL-TW; Mon, 12 Oct 2020 08:11:00 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kRsv1-0001pU-3S
 for linux-nvme@lists.infradead.org; Mon, 12 Oct 2020 08:10:56 +0000
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 9C692AF24D9CD53564BD;
 Mon, 12 Oct 2020 16:10:48 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 12 Oct 2020
 16:10:41 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvme-rdma: fix crash when connect rejected
Date: Mon, 12 Oct 2020 16:10:40 +0800
Message-ID: <20201012081040.31741-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201012_041055_389650_1E2B3523 
X-CRM114-Status: UNSURE (   9.24  )
X-CRM114-Notice: Please train this message.
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, lengchao@huawei.com,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A crash happened when connect rejected. host establish the connect after
received ConnectReply, and then continue to send FabricsConnect.
If target do not receive ReadyToUse, host may receive ConnectReject.
Call nvme_rdma_destroy_queue_ib after host received the event of
RDMA_CM_EVENT_REJECTED. Then the command of FabricsConnect timeout,
nvme_rdma_timeout call nvme_rdma_complete_rq to fail the request.
The crash happened due to use after free in nvme_rdma_complete_rq.

nvme_rdma_destroy_queue_ib is redundant when handle the event of
RDMA_CM_EVENT_REJECTED. nvme_rdma_destroy_queue_ib is already
called in the error handling process of connection failure.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/rdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9e378d0a0c01..116902b1b2c3 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1926,7 +1926,6 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		complete(&queue->cm_done);
 		return 0;
 	case RDMA_CM_EVENT_REJECTED:
-		nvme_rdma_destroy_queue_ib(queue);
 		cm_error = nvme_rdma_conn_rejected(queue, ev);
 		break;
 	case RDMA_CM_EVENT_ROUTE_ERROR:
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
