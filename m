Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17502C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Dec 2021 21:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SgZqYhIvFV96mJ5xf6sVJoUyDyvRbF36PHrMRlIIm8c=; b=Qj/nKbuj7AyoLD5QIOB3X3JYTC
	Jvah+zZErveENO107rdHq+quMYUID+0iJeugBz+sPK0eU0or37Ck9CZ14HrJYZ79/UCERyZBiTFTn
	SftnIuHJMAybkWIWDHRnbFNSj7DUsEjlkYOLA3VEF9viB3nhAWw41QbRDCA6cVq8vsrOgnHbKZfGW
	H2fqLtRpis3srmmcPBYoqWhdYa8dPaVMD7w5QYqzUGUB4ltj6uuVW7CuKQzkRJyK/7MZW4stk3JLH
	crDEqpLseF4N9a8JiyJANDfmYzs27J77OtE2YcILSKwD1lq+GSDMuE8+oFoJoMu5PbC+343cfATg/
	MEtkQyDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n09N7-00BNq9-Nz; Wed, 22 Dec 2021 21:42:05 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n09N4-00BNpd-LH
 for linux-nvme@lists.infradead.org; Wed, 22 Dec 2021 21:42:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7F6C661C31;
 Wed, 22 Dec 2021 21:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C1CC36AE8;
 Wed, 22 Dec 2021 21:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640209320;
 bh=iR1x+QAjlk1rP1AnvgGLvqi7fUYNYoBgdemmi8XbLTk=;
 h=From:To:Cc:Subject:Date:From;
 b=pCvZ5dHRnD1Dnge4iEDkPgxAzJ093rOSG4tKChkdDoTB5QItdBCTxxq1I4SYqi7ma
 p7Tv35SD3GwrSzHLkuOvuBOW+aGpILIaQhMdwhd2cB7yQBJS4bEPQcWEgBMZYV9pgt
 YNHBCaSJXCkxB294yWVtqCup6qLE8phAeR+96++KM8r2zNHT53hHSPZ4MyghiSs2OD
 RkqH81kGFyrlSTkG5FXzirhNoggH03cVlT5Mv4ClVXnsMKniLr6dcnrCU0evgH83zF
 +ml7TPbXuiO7cdZTVYZZBL/hVRFqFEJScip7aD7F/QSoXhusqUvSlbwG/gvAvQeOAb
 KX2A5C8pO0q9w==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	axboe@kernel.dk
Cc: hch@lst.de,
	sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme/pci: fix queue_rqs list splitting
Date: Wed, 22 Dec 2021 13:41:59 -0800
Message-Id: <20211222214159.1767965-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211222_134202_784030_F82A40CC 
X-CRM114-Status: GOOD (  16.08  )
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
failed 'req' and will attempt to submit the unprepped command.

Fix this by updating the rqlist accordingly.

Fixes: d62cbcf62f2f ("nvme: add support for mq_ops->queue_rqs()")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
Just IMO, the rq list manipulation looks a bit fragile for the lld. If
more drivers want to subscribe to the new .queue_rqs() interface, I have
another patch set ready for consideration with helper macros to make
this sort of error handling a little easier for re-use.

 drivers/nvme/host/pci.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 50deb8b69c40..36398fee66c1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1007,20 +1007,33 @@ static void nvme_queue_rqs(struct request **rqlist)
 
 		if (!nvme_prep_rq_batch(nvmeq, req)) {
 			/* detach 'req' and add to remainder list */
+			struct request *next = rq_list_next(req);
+
 			if (prev)
-				prev->rq_next = req->rq_next;
+				prev->rq_next = next;
+			else
+				*rqlist = next;
+
 			rq_list_add(&requeue_list, req);
-		} else {
+
+			if (prev)
+				req = prev;
+			else
+				req = next;
+		}
+
+		if (req) {
 			prev = req;
+			req = rq_list_next(req);
 		}
 
-		req = rq_list_next(req);
 		if (!req || (prev && req->mq_hctx != prev->mq_hctx)) {
 			/* detach rest of list, and submit */
 			if (prev)
 				prev->rq_next = NULL;
 			nvme_submit_cmds(nvmeq, rqlist);
 			*rqlist = req;
+			prev = NULL;
 		}
 	} while (req);
 
-- 
2.25.4


