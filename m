Return-Path: <SRS0=DDko=AE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644F8C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 16:23:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A53206D4
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 16:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I1yKJnT6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uPC2+nAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A53206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=36xYDmX4sLgSEALsej93KP8lcTQ+XugFis9uq3OOLNk=; b=I1yKJnT6K2+FKE8KtNROhz+qy
	VyIj1+u8Kn82dcWhnLtiRH84C6UeVnd+uJkmcBihFlAcBQAFQ19mtaN9Pi75H3nWUjrN/sIntehVK
	za5k58T09xmPjT+h8WjLVdkO8cm8jq587gqq+WD+3mD3QQ8I3oyAwXUxHu4FGseb3e1B78Tht2KGQ
	+5/hk6pbHzjaf4l8zUles+FXlYjvwK0P8sqVxy7Kz1y5idrRjVaiTH9wxaZwBxPa2n52xh3999OWK
	IoKdNikY6dab82FsFsv0QRejL7dfuXr7+TV4tK2mTxrcstFqKSrup6gV+Z7+E/6fPO5JMqU/MF30b
	KoMNZqemg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnlhc-0008If-A6; Tue, 23 Jun 2020 16:23:16 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnlh6-0008F4-Ai
 for linux-nvme@merlin.infradead.org; Tue, 23 Jun 2020 16:22:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=hI46KEhBpP7FCI+cM87ItkKFaNtYUfLhEg1ncvoDxY8=; b=uPC2+nAnIjrS99SE1ypAyjszOe
 fsPh3/0fcbP0jlM1tH5+WM8mRjeGDIOGiGT+nyCp2b8ArWEw+AL6JqVtt4xqgeyv5Wpb5y6sYCJXj
 yLHAGzLSO/nNTyhCK1VbGPb9cn2BV5IDqqoQou3uCoxI84L/KYkR7jEXZtNgT412dt2bpbcBRf5oJ
 ttdRpPbvy1iS6N3ToKyzUt7mrVNJleNT7c/D+qyGZc3qif5688KydVnHQRttjJzEPvO1xzZJISLFM
 rYxuAByrBSEMdpsFV5Af7aO/lKYVF9v+2Wqpg5IQDPLqQPFCRORiOFUFfXg821BwcMvrbq+2D07jA
 IsVMTl4g==;
Received: from [2001:4bb8:180:a3:c70:4a89:bc61:3] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnlh5-000235-Ag; Tue, 23 Jun 2020 16:22:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Subject: [PATCH] nvme-rdma: fix a missing completion with remove invalidation
Date: Tue, 23 Jun 2020 18:22:39 +0200
Message-Id: <20200623162239.950789-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623162239.950789-1-hch@lst.de>
References: <20200623162239.950789-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Bart Van Assche <bvanassche@acm.org>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Revert and incorret transformation that caused requests using remote
invalidation to never complete.

Fixes: 421147be863b ("nvme-rdma: factor out a nvme_rdma_end_request helper")
Reported-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/nvme/host/rdma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 97b1054efb8409..6d5c4495f352ea 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1696,9 +1696,10 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 			nvme_rdma_error_recovery(queue->ctrl);
 		}
 		/* the local invalidation completion will end the request */
-	} else {
-		nvme_rdma_end_request(req);
+		return;
 	}
+
+	nvme_rdma_end_request(req);
 }
 
 static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
