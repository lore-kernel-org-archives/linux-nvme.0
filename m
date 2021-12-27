Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330B3C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Dec 2021 16:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ULj9FwK+cVKVgSLAMk8ZRfhf5Fm4n+GoW4PCJS7tBXo=; b=w7TRjdTdAEH9ObmGfShFG40ass
	q5RcaXBVRvjXldFEfkk6wFnLBvk5i3z99dfmUOpYpzDvkchxjSU844keiax6Ns475CY8dXfENGEV8
	EQtTBvX8GPpe7G+aLbI5PN8S0crgPy76wBIEYx1/KAKvmC+p9yuL2PtgKTXu2PJ2kea26mjUeBKf3
	5lNCQDCafSpAv5PHhGvW4+jrlPMtTNbRWsChlj3b2vzyKL0dH5K9pqhSn4k+pD3DsgvHt0Sq1GLNj
	RANUfNnXrOx8pAssDAFLs7jT3xTfOjwvKD216oREBon6vIQvYJxpLftsvIoBZDznqQQLHrFNfn2yf
	O06s2Brg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n1t4a-00H07l-VR; Mon, 27 Dec 2021 16:42:09 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n1t4F-00H04C-S9
 for linux-nvme@lists.infradead.org; Mon, 27 Dec 2021 16:41:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2EEA061127;
 Mon, 27 Dec 2021 16:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1EEC36AED;
 Mon, 27 Dec 2021 16:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640623306;
 bh=EXvrCVLqlbJIq3ahfQk2vdaa75rjTa4g5DSilhy9jUs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=H/6gPL94rCXRjEDlAt1TX3UbAoF8TI5T1J3Jr+DVhvxyuHnbdKUYUHGrdhY0x9QSl
 1swRts3w/G6hPEDxB7qX0V3kuAhaNyPh8MpfRH7sppZv1xVRpQ2OKII/0NWhEDcNXj
 nUqTUNDcXcNwIFINfJLOdfojK75SdbFSO6cIAyvx53OqY53XFR/bt+btIb40wTRt6x
 AYDbdtkLDbzs6LeJ48DmlRFmhCo8Swuk+Ghdp1MNZu7r7TcN8TNIcPBr2p75iqYxFW
 eD27hfab5rE7wG6Yihc2Rv5K2Tep8srnSqGRuKpX1khYZwUbnl2mAYDBNmGdxBbojH
 /oYLvkjqZAxjw==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 axboe@kernel.dk
Cc: hch@lst.de,
	sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 3/3] nvme-pci: fix queue_rqs list splitting
Date: Mon, 27 Dec 2021 08:41:38 -0800
Message-Id: <20211227164138.2488066-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211227164138.2488066-1-kbusch@kernel.org>
References: <20211227164138.2488066-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211227_084147_969660_5E44AB41 
X-CRM114-Status: GOOD (  15.48  )
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
failed request '1' and will attempt to submit an unprepped command.

Fix this by updating the rqlist accordingly using the request list
helper functions.

Fixes: d62cbcf62f2f ("nvme: add support for mq_ops->queue_rqs()")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Replaced the backward looking iterator with the forward looking
  version implemented in PATCH 1/3. This is a little easier to read.

  Replaced the driver's list manipulation with the helper function
  provided in PATCH 2/3.

 drivers/nvme/host/pci.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 50deb8b69c40..992ee314e91b 100644
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
+			rq_list_move(rqlist, &requeue_list, req, prev, next);
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


