Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9DCC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jan 2022 17:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I5VZKt903kW9tvlB4nqzn1k067RXwcpjVethnhYd8w8=; b=t10HG3SpBES5OMKHUYGVKQEiFY
	/t//ipviCSWl6iwURfpAgs1eJoE4G9g5t+6t+3PcAxwa7A2WZvgDMuUUOfRFn8MFSio97QQET7Wnf
	rY16fr4RcuGPj0mzUk2IEgVCYR1vo+j8ZE+OZTLHIIJwg1tB8k6ww5VkRSwmzCx2NNfJ2Fo1vsdow
	A8tuw8LYwe3maVj6CmN/TvGtFQxQUA7n4QfvWcMApqjKTzmksLP/32kDkmRoUUSLjOiFScoHBQCGX
	3ICgi0JeESg3NyDHdcwahemCyNM97oSD1xIHU+SkllE+WfSHryJdjUnHstkzgVdPnqYEBgHT5FO+x
	GtVOj96Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n59jo-00FPlO-D3; Wed, 05 Jan 2022 17:06:12 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n59j7-00FPaF-NK
 for linux-nvme@lists.infradead.org; Wed, 05 Jan 2022 17:05:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 70C6AB81CBA;
 Wed,  5 Jan 2022 17:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A599C36AF2;
 Wed,  5 Jan 2022 17:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641402328;
 bh=Z8VHzQF+RrX+Y/7r/9niEAi8EOiYU9sVNurudNt+iRo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y8AhOdMLmHyhNy8IQuJbHY46fft0TAdIoqgsmH9RaOvmOQ8LDMNWbMY5+/oMO8VUz
 W8q9tcHXBR0HDoGhtFOd60NbBImDGgPCJPMwLzYEPq83sfAAl0eoXklTtOTaX/FIV6
 fMdLUH82VgPUkeQZxEc94XCNuG5ykPKSVF7RaczZj2KT58dMuRfDxCNKaL/+CPDa1g
 EcDPw7vYs2fANJO4kF7LhK3biXHXajInSEmJiLyM7Eob/z8/3fK2Wv7g+1yDKbdSMA
 4tzVU39y9kwS6a8yzPVcGaDkds/5uJL/OqUY2WN1lpUOJUpYbENsoaLTKh4J4u/jwb
 vBBjwxY4sxfJw==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, mgurtovoy@nvidia.com,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 4/4] nvme-pci: fix queue_rqs list splitting
Date: Wed,  5 Jan 2022 09:05:18 -0800
Message-Id: <20220105170518.3181469-5-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220105170518.3181469-1-kbusch@kernel.org>
References: <20220105170518.3181469-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220105_090529_934773_549AF0D2 
X-CRM114-Status: GOOD (  15.37  )
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

If command prep fails, current handling will orphan subsequent requests
in the list. Consider a simple example:

  rqlist = [ 1 -> 2 ]

When prep for request '1' fails, it will be appended to the
'requeue_list', leaving request '2' disconnected from the original
rqlist and no longer tracked. Meanwhile, rqlist is still pointing to the
failed request '1' and will attempt to submit the unprepped command.

Fix this by updating the rqlist accordingly using the request list
helper functions.

Fixes: d62cbcf62f2f ("nvme: add support for mq_ops->queue_rqs()")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 50deb8b69c40..d8585df2c2fd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -999,30 +999,30 @@ static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
 
 static void nvme_queue_rqs(struct request **rqlist)
 {
-	struct request *req = rq_list_peek(rqlist), *prev = NULL;
+	struct request *req, *next, *prev = NULL;
 	struct request *requeue_list = NULL;
 
-	do {
+	rq_list_for_each_safe(rqlist, req, next) {
 		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 
 		if (!nvme_prep_rq_batch(nvmeq, req)) {
 			/* detach 'req' and add to remainder list */
-			if (prev)
-				prev->rq_next = req->rq_next;
-			rq_list_add(&requeue_list, req);
-		} else {
-			prev = req;
+			rq_list_move(rqlist, &requeue_list, req, prev);
+
+			req = prev;
+			if (!req)
+				continue;
 		}
 
-		req = rq_list_next(req);
-		if (!req || (prev && req->mq_hctx != prev->mq_hctx)) {
+		if (!next || req->mq_hctx != next->mq_hctx) {
 			/* detach rest of list, and submit */
-			if (prev)
-				prev->rq_next = NULL;
+			req->rq_next = NULL;
 			nvme_submit_cmds(nvmeq, rqlist);
-			*rqlist = req;
-		}
-	} while (req);
+			*rqlist = next;
+			prev = NULL;
+		} else
+			prev = req;
+	}
 
 	*rqlist = requeue_list;
 }
-- 
2.25.4


