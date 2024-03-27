Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE10C54E67
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Mar 2024 17:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DZ0DaQAcEntvKxWanANi3dsLKA1cy5dkz9RnbD1mfQw=; b=Rd7sncSGY7/9sUef9mXkcEscxX
	dqvwObI7uFgGoP7fLkXCFHr6xINfxp0BvpoPPX+dC25SXh3JL3NNQB77B8hC8/9sdBtarOubcPr5y
	qJACsYcPu+QRJ1sdYyZs1ENBHMZB0bRv9XoaE3RvLLNeoZmuC8pPgnZGlKopcEiRwHl6yef843yod
	pvzciyUyU49EVN89ASGXsfnUOPizbFZVz5xnjGTmfSlbyN9TL8I3qI3921xcM01G19eW9VleDs+ha
	fHkA6NMsnRH86o5hwMzsUcNsYsXYiTgT36VfVn83sKls5V91njrB32pNNWwJ3ozfKnl3aQ6RSspCl
	e4WLnmHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpWyI-0000000AH80-1Dee;
	Wed, 27 Mar 2024 17:21:54 +0000
Received: from 089144220178.atnat0029.highway.webapn.at ([89.144.220.178] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpWyD-0000000AH5M-1whv;
	Wed, 27 Mar 2024 17:21:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: add a helper to cancel atomic queue limit updates
Date: Wed, 27 Mar 2024 18:21:44 +0100
Message-Id: <20240327172145.2844065-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Drivers might have to perform complex actions to determine queue limits,
and those might fail.  Add a helper to cancel a queue limit update
that can be called in those cases.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f9b87c39cab047..39fedc8ef9c41f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -892,6 +892,19 @@ int queue_limits_commit_update(struct request_queue *q,
 		struct queue_limits *lim);
 int queue_limits_set(struct request_queue *q, struct queue_limits *lim);
 
+/**
+ * queue_limits_cancel_update - cancel an atomic update of queue limits
+ * @q:		queue to update
+ *
+ * This functions cancels an atomic update of the queue limits started by
+ * queue_limits_start_update() and should be used when an error occurs after
+ * starting update.
+ */
+static inline void queue_limits_cancel_update(struct request_queue *q)
+{
+	mutex_lock(&q->limits_lock);
+}
+
 /*
  * Access functions for manipulating queue properties
  */
-- 
2.39.2


