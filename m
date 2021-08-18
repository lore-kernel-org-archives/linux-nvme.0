Return-Path: <SRS0=/QSy=NJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C3DC4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 12:06:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F10460EBC
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 12:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4F10460EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6/62mz6mpTfj2nk0iXCvOAI+9h82Y4Q9DVZGSXmdr5s=; b=hBeFuUyg2S+ofL
	o/S5mXpqf1pcs9rN1/haL4UDTVLFr4NLWHO6JN9qk6dAgQWH8PXOk+hk9Ik39wwwS2Zxnjnwi81rM
	VdBqGChFE1ToM0FtF7bVdpt4cKLtD2HbKU2YwPqVpAZFYVPTkWWWQDEVUPb7c0SWUUzz3udyOPAZI
	Et4A5p8N02NjZ2ZPK8ZWNd96kDsR4iu5PFskYjkAGWkBTlnyC3ym61BTjN9PSrykF0pjGpux7P31e
	EVcleI60hcTiksYFAyU4M08kzyxM1vJa3t9zGWs4+9OEzghcvKT56DNLnExdPmrQadB0mSengXzFs
	5J0JN9dPFhFsLxvH/qVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGKKg-005Qfo-Kv; Wed, 18 Aug 2021 12:06:10 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGKK6-005QXt-Fz
 for linux-nvme@lists.infradead.org; Wed, 18 Aug 2021 12:05:42 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2DD8E22031;
 Wed, 18 Aug 2021 12:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629288333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swJyPQGAzH4b6Jy9/zoJjKAUe/5cuKhRUPwssLPQDNI=;
 b=fY0cVzRp1TgEEVqpu1uqOorozEh1y0bq3L0laRdffvWVXPId4yL39WEC+x/Oeb9CtHqHq0
 i5NSjIZelR0x1fXCRyO++ophmnLzrLk1xzDCPG3vRZ5Ep8tPkRQcAVN2hf/HCIY+AmJ84N
 q5TC+tM4OqeVZQN16tg+AOXZLEAtvQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629288333;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swJyPQGAzH4b6Jy9/zoJjKAUe/5cuKhRUPwssLPQDNI=;
 b=mWRRoR5npJuDr87GIBuBmboaqbt7VHyqQ2nbrVAp/Pbf++cJzcoCrHuXlqPF5v8sv5cMgB
 PFqwsKXm7QAfcHBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 5557CA3B9C;
 Wed, 18 Aug 2021 12:05:31 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 84E4D518CF7F; Wed, 18 Aug 2021 14:05:31 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 James Smart <jsmart2021@gmail.com>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 3/3] nvme-fc: fix controller reset hang during traffic
Date: Wed, 18 Aug 2021 14:05:30 +0200
Message-Id: <20210818120530.130501-4-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210818120530.130501-1-dwagner@suse.de>
References: <20210818120530.130501-1-dwagner@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210818_050534_768039_0B231BE6 
X-CRM114-Status: GOOD (  14.51  )
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

From: James Smart <jsmart2021@gmail.com>

commit fe35ec58f0d3 ("block: update hctx map when use multiple maps")
exposed an issue where we may hang trying to wait for queue freeze
during I/O. We call blk_mq_update_nr_hw_queues which may attempt to freeze
the queue. However we never started queue freeze when starting the
reset, which means that we have inflight pending requests that entered the
queue that we will not complete once the queue is quiesced.

So start a freeze before we quiesce the queue, and unfreeze the queue
after we successfully connected the I/O queues (the unfreeze is already
present in the code). blk_mq_update_nr_hw_queues will be called only
after we are sure that the queue was already frozen.

This follows to how the pci driver handles resets.

This patch added logic introduced in commit 9f98772ba307 "nvme-rdma: fix
controller reset hang during traffic".

Signed-off-by: James Smart <jsmart2021@gmail.com>
CC: Sagi Grimberg <sagi@grimberg.me>
Tested-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 3ff783a2e9f7..99dadab2724c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2974,9 +2974,10 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 			return -ENODEV;
 		}
 		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
-		nvme_unfreeze(&ctrl->ctrl);
 	}
 
+	nvme_unfreeze(&ctrl->ctrl);
+
 	return 0;
 
 out_delete_hw_queues:
@@ -3215,6 +3216,9 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	ctrl->iocnt = 0;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
+	if (ctrl->ctrl.queue_count > 1)
+		nvme_start_freeze(&ctrl->ctrl);
+
 	__nvme_fc_abort_outstanding_ios(ctrl, false);
 
 	/* kill the aens as they are a separate path */
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
