Return-Path: <SRS0=YdFy=DT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E1BC43457
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2020 08:56:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D96208D5
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2020 08:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UWg7Ezlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D96208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gwss/MNhFk5w3+xYdw3ziHb4fcugMsySw4hofK8JzPM=; b=UWg7EzlhP5LUOMuhKapL5X8/4b
	xoV0ZKUOXvUsLgCydYi5py2okRyqjqxWUrWERV+xRAX5aq2oZFyC5f/Y8PQG6ybOH7vO14jY/3UmV
	irpBzeVcGyol1Ygwjw4Buh8fkS9Zd4lAZ5GuTmdmVZMDLI61DpKvF/FL04hNyQX7PMrSAZOeD/WF6
	IX0lvx0lROgfxQE5XCadijXFZmiS/wcQ5y4DKlR5OarVzC/xxZ7Fo8Sy9CbmxywE9CpxK07BtpEzk
	mLAFTd8kG87BGfZHI2+G0FMIC3WqwMeJ26N8QuPqaZ+5/Fll4hLlSjWusGwJ/IdWyKRdIUAk2ySJm
	AZcqBlhg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kRtcc-0006dL-Kh; Mon, 12 Oct 2020 08:55:58 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kRtca-0006c8-9k
 for linux-nvme@lists.infradead.org; Mon, 12 Oct 2020 08:55:57 +0000
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 465302B43BC0A327C0F1;
 Mon, 12 Oct 2020 16:55:48 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 12 Oct 2020
 16:55:37 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvme-rdma: fix crash due to incorrect cqe
Date: Mon, 12 Oct 2020 16:55:37 +0800
Message-ID: <20201012085537.2599-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201012_045556_581482_166D0422 
X-CRM114-Status: GOOD (  10.55  )
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

A crash happened due to injecting error test. The cqe has incorrect
command id, host may find a request which already be freed.
req->mr->rkey cause a crash in nvme_rdma_process_nvme_rsp.
Because the mr is already freed.

Add a check for the mr to fix it.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/rdma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9e378d0a0c01..70dbc289d22e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1730,10 +1730,11 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 	req->result = cqe->result;
 
 	if (wc->wc_flags & IB_WC_WITH_INVALIDATE) {
-		if (unlikely(wc->ex.invalidate_rkey != req->mr->rkey)) {
+		if (unlikely(!req->mr ||
+			     wc->ex.invalidate_rkey != req->mr->rkey)) {
 			dev_err(queue->ctrl->ctrl.device,
 				"Bogus remote invalidation for rkey %#x\n",
-				req->mr->rkey);
+				req->mr ? req->mr->rkey : 0);
 			nvme_rdma_error_recovery(queue->ctrl);
 		}
 	} else if (req->mr) {
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
