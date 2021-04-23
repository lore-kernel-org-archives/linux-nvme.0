Return-Path: <SRS0=/503=JU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD63C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 22:07:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31DF66146B
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 22:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DF66146B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+Aw7wVDyW2MjuAWlQtyoLzCMtw2QBwEokQ/ACa5lkB8=; b=VxAz5R9Xvdvsrs1ly+i5b/LB/
	X3qc2SkUQBA2wLO3rJL6J2Mi2RJ5Ga8TcWJDnXbres6npvNYRFIx5A8GCFg+eHUhHrwLLZuRsxcon
	dI2e3YF0tfyL5gH5qEu91ntjn0zvFjlbHEYpKB9tx1cmCIyaCX7TnXUpvXjRMwfJxMPU2YR8CxdbN
	jV05H9kRXA2BHhBVTUV3zeHngn6atJ7pj2un3QC3NL6lyQOd7pkX+L+tMt89/rGPEwdox/X/hexEP
	Z7/McdiWJfcxfBAmwf5wl8vNihGgYK8QGCrCABN4TWNowrfV0TzzpkShdsr2YKPcoBMJGnT/hG687
	N1ynpnm9A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1la3wy-002TKh-A3; Fri, 23 Apr 2021 22:07:01 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1la3w6-002TDn-5W
 for linux-nvme@desiato.infradead.org; Fri, 23 Apr 2021 22:06:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=tvmSKXszpRQtqwcF+rUQbvu7V9FJ0ZZ0nnOBijcSKRg=; b=gkEGRGAXboYnbxVo50z7GADoeJ
 Ds6rCOH2dVUo6TK+kLNSuIpY2Nh/C53EMywGk44K565TNHR/0TDVtWi0BPNzF2m7UwMHCsssNPaSH
 TaL78KLFdhOKWu44b/7Egl4XkmO25u9jYUqgG72FzbhpWgbiAQ9BnB1hyG/GEjcAXbtZB2W3xPCbT
 N2kOfWhlilGvx0ojj7WK5WCTyOiOtrA+KTtlRihORZCOBYm7Clgzqt26cvOwpALyBkm1yHr4UleOh
 N/FaIWc5rr9XYMV9iulpDdAiX9Ko85g6xWhmmdaluihgDRRwt9+TqUOXrpccXtduJpkmxIn6FB7WK
 l+DqNw2Q==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1la3w3-00Ej8c-LM
 for linux-nvme@lists.infradead.org; Fri, 23 Apr 2021 22:06:04 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C42BA6147F;
 Fri, 23 Apr 2021 22:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619215563;
 bh=Orw80HiJiHtXUgb9tSaOsuFFaPf+nNNCx4L2ais7NsQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i9hC8QVJg8F8lNFiCLvwp6arEBLF4JhNrgAEkgL5qGXdDP+5Iiz5wUrr7fm0L4GVK
 SOr25o+R18JFwodIOn6VodjdmKnmPDgOgWihwt1VEhjoXE4pKxQOdImp/5U6DpXc75
 BVXPexdUVvXzqSghgMsh6bPQQzzb7SQd+TMzv9humKSYPVsST5UuzTU/G3yGBqJWLS
 426RZ22SVyiPlhWBQBNQ3OgOy3jaFEzxOzCU1qDEW0ulp87wCCtdK2OvTsBVVMoDEe
 uAXJmcO0NG34qtrKzDG7O0qPJu+vUeqF7HtqHRK88fQOUBbFiEAmgw2bkts9dSYRi7
 TA6+hs2rCp24g==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org
Cc: Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 3/5] block: return errors from blk_execute_rq()
Date: Fri, 23 Apr 2021 15:05:56 -0700
Message-Id: <20210423220558.40764-4-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210423220558.40764-1-kbusch@kernel.org>
References: <20210423220558.40764-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210423_150603_736451_ED8C9B36 
X-CRM114-Status: GOOD (  12.74  )
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

The synchronous blk_execute_rq() had not provided a way for its callers
to know if its request was successful or not. Return the errno from the
dispatch status.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-exec.c       | 6 ++++--
 include/linux/blkdev.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index b960ad187ba5..4e8e6fe20956 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -21,7 +21,7 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
 {
 	struct completion *waiting = rq->end_io_data;
 
-	rq->end_io_data = NULL;
+	rq->end_io_data = ERR_PTR(blk_status_to_errno(error));
 
 	/*
 	 * complete last, if this is a stack request the process (and thus
@@ -77,8 +77,9 @@ static bool blk_rq_is_poll(struct request *rq)
  * Description:
  *    Insert a fully prepared request at the back of the I/O scheduler queue
  *    for execution and wait for completion.
+ * Return: The errno value of the blk_status_t provided to blk_mq_end_request().
  */
-void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
+int blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
 	unsigned long hang_check;
@@ -97,5 +98,6 @@ void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
 		while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));
 	else
 		wait_for_completion_io(&wait);
+	return PTR_ERR_OR_ZERO(rq->end_io_data);
 }
 EXPORT_SYMBOL(blk_execute_rq);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b91ba6207365..15e4ffac33af 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -938,7 +938,7 @@ extern int blk_rq_map_kern(struct request_queue *, struct request *, void *, uns
 extern int blk_rq_map_user_iov(struct request_queue *, struct request *,
 			       struct rq_map_data *, const struct iov_iter *,
 			       gfp_t);
-extern void blk_execute_rq(struct gendisk *, struct request *, int);
+extern int blk_execute_rq(struct gendisk *, struct request *, int);
 extern void blk_execute_rq_nowait(struct gendisk *,
 				  struct request *, int, rq_end_io_fn *);
 
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
