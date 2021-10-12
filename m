Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE81C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:18:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D437E60698
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D437E60698
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mG/P++rd49B1cFmUCqJucFFi+Rrv8d1QyeF4NpgH9/4=; b=BhRSsNuK/mDfDh
	+eJjkmj6YpA1fyjwwF/sfy/bQjcXuzcOXD6do1rIWKzUl7h2dONza2EWHVYAjMUDIkhnyxMbG/a2P
	CSwXS3z33duFuHtWGBrT7HX2HSxm8eM9i9qrvcFhEGjy9VfxOG08iWjCdH2ahhM6iLpvNNZ7gCj5+
	RBV80INXW1PudlxppAXWBIKq293XybHCP+jqjDxL3rIKPpmnhe3/pZirDLkI/Fs+L0Sm1rxOAVyVo
	PZBnCEAtwRho1+zynzXH3rkqlLmDLLwuE7tduecx3NAG5K+wjC/uFsjvcryQFZ3oEVO9QQnKixFqs
	hyOvmZWcISSrXXqaz7dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maFn8-00CXad-Jq; Tue, 12 Oct 2021 11:17:54 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maFn6-00CXZp-Kf
 for linux-nvme@bombadil.infradead.org; Tue, 12 Oct 2021 11:17:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=I7TU5196DMrnq1/86jEdT7u0d1r5yBEHlH+oSOn2ra0=; b=VVdPFgVZrGm99g203OQBcrg2Zb
 fT+ItJObCg/eEwF3X0eXwIMR7bMQZhvYTdVq8kI/Tmuj5BrWNyrciyBOrGiH9PxeovcKC03U4RbMC
 kFcOWLo2v/zdMHJyhdEzhLlTeCtl8LQTLK92yyOFXM8SFphSNVaJ+pK0kESW5gh8ERCCaddqiSUpD
 +Ocvee89HbW2d/mwYK1cdYIaLkvsGKZy/Z78GXwgM3Ze3/5Qr27FII8wrfZ/NZF4IPHzsciNoFr8U
 lFNO6ZzAWHGMQ6tCW3weVRRbxx2fBwxr970iAILsUg/uc8bsPq8OOQfRBREgRo7ZakOKGdp7dX7Zz
 5DCFPaMQ==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maFlv-006RYX-4t; Tue, 12 Oct 2021 11:17:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 04/16] io_uring: fix a layering violation in
 io_iopoll_req_issued
Date: Tue, 12 Oct 2021 13:12:14 +0200
Message-Id: <20211012111226.760968-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012111226.760968-1-hch@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

syscall-level code can't just poke into the details of the poll cookie,
which is private information of the block layer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/io_uring.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 82f867983bb32..5b625f97ee225 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2743,19 +2743,12 @@ static void io_iopoll_req_issued(struct io_kiocb *req)
 		ctx->poll_multi_queue = false;
 	} else if (!ctx->poll_multi_queue) {
 		struct io_kiocb *list_req;
-		unsigned int queue_num0, queue_num1;
 
 		list_req = list_first_entry(&ctx->iopoll_list, struct io_kiocb,
 						inflight_entry);
 
-		if (list_req->file != req->file) {
+		if (list_req->file != req->file)
 			ctx->poll_multi_queue = true;
-		} else {
-			queue_num0 = blk_qc_t_to_queue_num(list_req->rw.kiocb.ki_cookie);
-			queue_num1 = blk_qc_t_to_queue_num(req->rw.kiocb.ki_cookie);
-			if (queue_num0 != queue_num1)
-				ctx->poll_multi_queue = true;
-		}
 	}
 
 	/*
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
