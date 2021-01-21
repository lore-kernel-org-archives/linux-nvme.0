Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DA6C433E9
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 07:04:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5453F23977
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 07:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5453F23977
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+GRVCQTUYJfRXWj/JguJzL88jC874ZkeN8qllghUV7A=; b=XBrHszfLNif0KnL9vjLtpawvj
	K1yENw1MYxbq5vIxAERhxzONoc/AJkbjhSYbojXc4K+tJgo9Q1x/jqszB5qt8pFIFc1P+4fDP0kV+
	Sjc8E1b1Z7+B7h5FEoUFNbzX9Trlm51LQbVGtoSSalrs92Pnai98KGu603HDjWZiJSXf35PfECPxP
	M0AGO2/jeQaBjOW1gCOPbrKPq8Y9L7MZWaxp9skVJBTbkdMp49zTGEqJsEDfday3k9I8t1lQ7mM3H
	0UwELaODFdK7nCETYlnHSiTV8Vr2YNVqaYaAV6YpFDyXokqgmTZ28jQ7sRpeflp/Igd/85Nute5iW
	F8PLhPZkQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2U0S-0006kV-KL; Thu, 21 Jan 2021 07:03:48 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2U0K-0006hZ-Pr
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 07:03:42 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DLtcj4MwDz15wF0;
 Thu, 21 Jan 2021 15:02:29 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Thu, 21 Jan 2021
 15:03:33 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH v3 4/5] nvme-rdma: avoid IO error for nvme native multipath
Date: Thu, 21 Jan 2021 15:03:29 +0800
Message-ID: <20210121070330.19701-5-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20210121070330.19701-1-lengchao@huawei.com>
References: <20210121070330.19701-1-lengchao@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_020341_664760_D3C19F68 
X-CRM114-Status: GOOD (  10.64  )
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, sagi@grimberg.me,
 axboe@fb.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Work with nvme native multipath, if a path related error occurs when
queue_rq call HBA drive to send request, queue_rq will return
BLK_STS_IOERR to blk-mq. The request is completed with BLK_STS_IOERR
instead of fail over to retry.
queue_rq need call nvme_complete_rq to complete the request with
NVME_SC_HOST_PATH_ERROR, the request will fail over to retry if needed.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/rdma.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cf6c49d09c82..5fb0838a5f8b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2030,6 +2030,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	bool queue_ready = test_bit(NVME_RDMA_Q_LIVE, &queue->flags);
 	blk_status_t ret;
 	int err;
+	bool driver_error = false;
 
 	WARN_ON_ONCE(rq->tag < 0);
 
@@ -2077,8 +2078,10 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
 			req->mr ? &req->reg_wr.wr : NULL);
-	if (unlikely(err))
+	if (unlikely(err)) {
+		driver_error = true;
 		goto err_unmap;
+	}
 
 	return BLK_STS_OK;
 
@@ -2093,6 +2096,10 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 unmap_qe:
 	ib_dma_unmap_single(dev, req->sqe.dma, sizeof(struct nvme_command),
 			    DMA_TO_DEVICE);
+	if (driver_error && ret == BLK_STS_IOERR) {
+		nvme_complete_failed_req(rq);
+		ret = BLK_STS_OK;
+	}
 	return ret;
 }
 
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
