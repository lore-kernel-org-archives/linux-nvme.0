Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C5CC433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 16:54:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17BEA60FF1
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 16:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BEA60FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rUDrm9TL0jQIXv9/yhJv6uoJafe6PzfY1k29dZY8TQg=; b=TNMrwv3N1XztZcGImZNGe1GIir
	SYqbsgOom8dGsU3YmhbDpz2aILg7kgjuuzuGYMimG97sMpPeml3P/I6LXEcNwzP6/1++yDV7J3EkT
	kKKr38jHJmSAT/PoVSJ5e7wMN3BgUOkYIZpceGl1sFMxtWh9y7S+GyTFW/paeTkexu5aJsBc8E4DU
	6c75FL+Ffdc2KLDsZgXVV9XWZomI/OQM13ajmFfW6gxFXz70+E11jmj1eq/xD+FmGNMh6g4ckQXQz
	qHAxaVGRJRHF08fAbs5igEGjyhvr2ldzqXLPxQ60LjPiZyprWCZCt8LyDktwd5v2it3hx0xVgGLcg
	kCeonzdA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXRjZ-002s6D-2T; Fri, 16 Apr 2021 16:54:21 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXRjL-002s4D-GH
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 16:54:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=+O+YxZDQioH/AD2AD49lDr2ndGC+K3wt/SU/UqnTyH4=; b=lubltUIkMG6d/cFjBkuNmJly8v
 d8a0dOnk7VAvjkqPcb6tEzu8+OUQTWtqjCFmTr15+EGge0Rplk93K/Edq4s+Sx3FdnUkYAMj0vp0+
 mTPgTOSfsqX9ThR+WvEWUbpmrMkvQPpMK3AfdDJRvDZLEhhzxH5izp+qdEg533vq6SyIdaaOcfLin
 ewzZT8EMtybFB0MBa/QZmnROXu4n/koVdhx4Kzee7wDgdLihUVE/+vypuVVGCNWH3RbIwEjSxrbod
 17pKJNFogSsIQez8mb55SjXp7gXe5uUcBL1+4nMzXfztVdXaqwWsNRgtrlQfmsPIqfHMMnsZ/Fqsm
 D8yl4f7A==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXRjJ-009ZbB-0W
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 16:54:06 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39CE5611BF;
 Fri, 16 Apr 2021 16:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618592041;
 bh=eNRCFt6SI/oWgzlTLt9gANdNPhtqg4xLovQCFl45UpI=;
 h=From:To:Cc:Subject:Date:From;
 b=tX4ivfzNNcnY4xWTzZo14H4EnZa5b9dP3WT4C91gXJqHAGoxk9Ztm5jnY51UCOYv2
 R1M5yjQ8WNc8wTzZixfsW9G+p6mJ3BMGatNNRtSzCuHjAaov4EZl/teUuOiklmKgv+
 ErzlHAZwobkL8Yeyl9ppcPkuuCZNDSZwA40PblPtJCMfC9MVDxc8nU9vC3G1VWmjGZ
 DGoPLUuvMu+GQ62HU30Z9r54WKe84ecjH0lEloPV+oXuUfofcB+wqNjCexWSgjFwtq
 KcF6DhEJJgIiROZlkwu20ckGQ4ZiNeJznqICjcpExY690zhit2AVgKvUwbXeZUSpqw
 gE2QGv5mzd12Q==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Yuanyuan Zhong <yzhong@purestorage.com>
Subject: [PATCH 1/2] block: return errors from blk_execute_rq()
Date: Fri, 16 Apr 2021 09:53:52 -0700
Message-Id: <20210416165353.3088547-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_095405_099207_8A862FF7 
X-CRM114-Status: GOOD (  12.83  )
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
completion status.

Reported-by: Yuanyuan Zhong <yzhong@purestorage.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-exec.c       | 6 ++++--
 include/linux/blkdev.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index beae70a0e5e5..3877a2677dd4 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -21,7 +21,7 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
 {
 	struct completion *waiting = rq->end_io_data;
 
-	rq->end_io_data = NULL;
+	rq->end_io_data = ERR_PTR(blk_status_to_errno(error));
 
 	/*
 	 * complete last, if this is a stack request the process (and thus
@@ -72,8 +72,9 @@ EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
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
@@ -87,5 +88,6 @@ void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
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
