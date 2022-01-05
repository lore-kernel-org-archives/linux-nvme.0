Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DBDC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jan 2022 17:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eC0pVy2KU8EBOFLPCJhLxER6qjGWG8sYw00IZpoFkA8=; b=jMNjl2wFo3bLOtX3n+0zSWiBIe
	zy2+XCqkkDs/DvGBE8DNd1InndsmiCYKYgxTqhfBwL1cNKcKD2IdfhImaMYhdD8sZlDn/bNlclyHS
	NyOsdp48noVUv0DTlhWpNqoKUPYOdbnbRVD3t+KYmkfUGUTfhGsTYm66i6ZCli985r3gko1uNNs7k
	+nNC7f2nmUUtW0uWUkn+RybwPR54qJZ9ZQYWPgSC0qK2rTYXe2YUwlcTKXznJQU+/RHJgH/Hsga8X
	NsJzWFa/hGwqUfwe64DGQK6jJ4TcsjlgqUZ9qUJtCVi2bo0cFbedD6rrl6IqJ8ORZjj84nLHvSQ/H
	ZoW9xtyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n59jS-00FPf5-94; Wed, 05 Jan 2022 17:05:50 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n59j6-00FPZn-I7
 for linux-nvme@lists.infradead.org; Wed, 05 Jan 2022 17:05:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 000B76182F;
 Wed,  5 Jan 2022 17:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44DEC36AE3;
 Wed,  5 Jan 2022 17:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641402327;
 bh=+XQTZk3ubgunqyEYSBvBH7FNv+2vNL2x2STiFK+7xVM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TUv91FY+XbaScxPCnY65ap951HrSwbcsxBme3YMO8BrxR0go5m4laqctjvQeRqvCP
 v22/mim3vpwzf7ZuZ4nPF5He5t4PeGpYNHTRWpRMbDqy5722UF34rLl5oi8h6ucDyu
 cyXtzzNlHW0D8XTsmBsVYdJ+r3EnVr6LaC6s8eJPLTOI156scT+kTm/gSYjQbbg3z5
 N+AQN1ANxE1buEO2g/HRtmz39KBTsYc+/tlYdUTU894jhhMSrvHb640CVKdxx7ZPtK
 xeptnBP+pmKp7wqgZQ6/a/wc/TKrpj/CCAKDJtG3z4W+Qz+fCym3dBOCVXTDLPVzEM
 tajuVOJg90VtA==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, mgurtovoy@nvidia.com,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 3/4] block: introduce rq_list_move
Date: Wed,  5 Jan 2022 09:05:17 -0800
Message-Id: <20220105170518.3181469-4-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220105170518.3181469-1-kbusch@kernel.org>
References: <20220105170518.3181469-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220105_090528_657081_5D723EB8 
X-CRM114-Status: GOOD (  14.10  )
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

When iterating a list, a particular request may need to be moved for
special handling. Provide a helper function to achieve that so drivers
don't need to reimplement rqlist manipulation.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blk-mq.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1467f0fa2142..f40a05ecca4a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -249,6 +249,23 @@ static inline unsigned short req_get_ioprio(struct request *req)
 #define rq_list_next(rq)	(rq)->rq_next
 #define rq_list_empty(list)	((list) == (struct request *) NULL)
 
+/**
+ * rq_list_move() - move a struct request from one list to another
+ * @src: The source list @rq is currently in
+ * @dst: The destination list that @rq will be appended to
+ * @rq: The request to move
+ * @prev: The request preceding @rq in @src (NULL if @rq is the head)
+ */
+static void inline rq_list_move(struct request **src, struct request **dst,
+				struct request *rq, struct request *prev)
+{
+	if (prev)
+		prev->rq_next = rq->rq_next;
+	else
+		*src = rq->rq_next;
+	rq_list_add(dst, rq);
+}
+
 enum blk_eh_timer_return {
 	BLK_EH_DONE,		/* drivers has completed the command */
 	BLK_EH_RESET_TIMER,	/* reset timer and try again */
-- 
2.25.4


