Return-Path: <SRS0=/QSy=NJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C81FC4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 12:06:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4693C60EBC
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 12:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4693C60EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vr3UZ7PVcIFoK8QLZznZwYJCg+FxddF/yE+Y4idZSqI=; b=sUlIadYkmuHRu9
	FURNcKXe/h6KTf2FHMHtg7FvVHnlJinhLODCGp4YVPmyPXeclQAiyXORpNcfRWGIiAnVWVAeePNVZ
	vfNJXZLHlvfKv0IztoAitGHY/GOLv5uA+/QdrVlvX5ZxISJexEytIQJBKDjVNnA0HpIwReKpulRcx
	a4ib7EPejqCx00M05ZwZfELI7hPRvt/4OnIPuaqoxvjS4trdQJsln8BCGbTzDctj7aVk0qSkcRZ0D
	CgfFADaLrLqoUvBZ4WVLFab4cHXqlbpL1OhmUhedrq/GEqlGWH3DLjfLQ/M+UKsOILbu+Hj7WoOE0
	KSFl1k/SwjE90sBE/s+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGKKM-005Qbp-06; Wed, 18 Aug 2021 12:05:50 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGKK6-005QXs-Fe
 for linux-nvme@lists.infradead.org; Wed, 18 Aug 2021 12:05:38 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 2CC7620070;
 Wed, 18 Aug 2021 12:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629288333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tn6D90iiLsb4IxhJIealrzVbHO75LAAXZtFjemxcuD4=;
 b=udQdDomnjekz6QUNNwMDFN28CjCjQvZ0QXTUx9+PrBk/JhLepukkr8O7Rfd/O2KVuh1cnT
 mcoq2uJ4RIix3tL2snllpZBRRLXzRmksVtqFGdRFyeYjsAx4Mbo6hV9HPXXgg9S/TbHAf8
 Og7muASTPiSqM6O6lJ8Bqj8+OhV4HPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629288333;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tn6D90iiLsb4IxhJIealrzVbHO75LAAXZtFjemxcuD4=;
 b=4zw1AW6MuUlFmI0bELHcQ0k4510gePTHt/IJQRRBu86rvNHyDAt/nYsaO9qsxQkG4gHz27
 Hwygz6/j7O23tBAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 55558A3B9A;
 Wed, 18 Aug 2021 12:05:31 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 7FD2E518CF7D; Wed, 18 Aug 2021 14:05:31 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 James Smart <jsmart2021@gmail.com>, Chao Leng <lengchao@huawei.com>,
 Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 2/3] nvme-fc: avoid race between time out and tear down
Date: Wed, 18 Aug 2021 14:05:29 +0200
Message-Id: <20210818120530.130501-3-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210818120530.130501-1-dwagner@suse.de>
References: <20210818120530.130501-1-dwagner@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210818_050534_749393_A28CF540 
X-CRM114-Status: GOOD (  11.73  )
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

To avoid race between time out and tear down, in tear down process,
first we quiesce the queue, and then delete the timer and cancel
the time out work for the queue.

This patch merges the admin and io sync ops into the queue teardown logic
as shown in the RDMA patch 3017013dcc "nvme-rdma: avoid race between time
out and tear down". There is no teardown_lock in nvme-fc.

Signed-off-by: James Smart <jsmart2021@gmail.com>
CC: Chao Leng <lengchao@huawei.com>
Tested-by: Daniel Wagner <dwagner@suse.de>
[dwagner: updated commit id referenced in commit message]
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 8e59e6d142c1..3ff783a2e9f7 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2487,6 +2487,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	 */
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
+		nvme_sync_io_queues(&ctrl->ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
 		blk_mq_tagset_wait_completed_request(&ctrl->tag_set);
@@ -2510,6 +2511,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	 * clean up the admin queue. Same thing as above.
 	 */
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	blk_sync_queue(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
 	blk_mq_tagset_wait_completed_request(&ctrl->admin_tag_set);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
