Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C59C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 12:56:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3E064FB3
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 12:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3E064FB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NMc6k8686rq0H6Cdm55SkaYRRjdoY3bHEDl5U1bJuQ4=; b=gazxwrq7iqlwMkz+taMbawcBw
	sfqBm3Qb2sc9lavNFBh5a0iVerZnpg8oMsUU9jXbxjWF6iQKdMHRmxyJq6FsBRETlYRJltAqDrmHr
	9T7FNPlZ9W5kmlAW392aaXBOK00Gieft0fjNyGuX/AoyJuZVrGyxhbY1uZscI313W1KOuEc675Xcu
	YZuoYFiYWCCCM/z+f3UpY6T7+JGXOzvH+h+wasdyKgW2wCNDZbVCMJ10f/eIM7NjmOdl4pOGm3BSG
	HHcRZJMO6rtwRNQywRw9aKFWZo5Vl2fqcvR5WBQ4bkl32YCiUOv378e0mCMQ5CfjY05PhBgoQTPLG
	lPy0ankQg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEti3-0004Ov-LZ; Wed, 24 Feb 2021 12:56:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEtht-0004K9-Gh
 for linux-nvme@merlin.infradead.org; Wed, 24 Feb 2021 12:55:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=zBZnrZKPEhZD4IXjghFrNLQ7xG/Dk6om6vGX8uRh0x4=; b=dCFYUowD1JRNK0L523Jt8ihIpu
 k4rM0uGpWPfny7debDjPBAncfKl71AlNKeukKfwDsPvB8V95EFmBiYkicAG9C4Y0/2jN13PHNqSYg
 Mj+8jAi0MvGZe8arA/alIKK+qUYZj1lKUCLVNNhneCONSoIUFAEy/Ngovvz0bP5lqom/TGZca/KtI
 wAnbweq51CekIzIpUewFaDsQ3uY4Cw2Mf/ziZA22V16OhPY8cMVKZIqjKB5EFD/WCKZMMOyjWN/Nm
 ixE910PfJMenYmoQJQZ3AK5UNpdA+ouqG5mxmcmD0i8rXdGBGaY4kuiy83UddwXwlwWFLToiMe0Q7
 u7nr5NZA==;
Received: from mail.kernel.org ([198.145.29.99])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lEthX-009PYG-FR
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 12:55:43 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B64B64F8B;
 Wed, 24 Feb 2021 12:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614171256;
 bh=vOaq+XCE08cfBU4HxzIJMSbb7MRGJapuX0It14Owib8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bM9KxqRA6z2m0ZU2EeSassWWuusTb9tgBUXiQsRknFSg+4GZSTGitCmSfehsvpR2W
 lLODVM9gRaoE40szPo3RIHg535Bec30yHNkMud2BdTYRoNy33JuXh2bHXbkfhPV3u5
 J7P0r4fROgDlODpSsiFP4i2J4gR1NPDIubMj9g7DR+TGte22cL/KeWIjKtbjW5vcr9
 +bsgSTVlM9Uwu/k9XsztyBBXru6H3C92mDLrnhpmqC+YsKz7SaANMy5yKg36mOrq3l
 jSE8ydG0CkMWObtn1gw+a+DD+eWQ1pLNl0V3QKolUvzf0qbRtZ7BAfM6KEp+TbX1Si
 jkcwfqrn/Fd+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 27/40] nvme-rdma: add clean action for failed
 reconnection
Date: Wed, 24 Feb 2021 07:53:27 -0500
Message-Id: <20210224125340.483162-27-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210224125340.483162-1-sashal@kernel.org>
References: <20210224125340.483162-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_125543_216709_A6E35946 
X-CRM114-Status: GOOD (  12.74  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Chao Leng <lengchao@huawei.com>

[ Upstream commit 958dc1d32c80566f58d18f05ef1f05bd32d172c1 ]

A crash happens when inject failed reconnection.
If reconnect failed after start io queues, the queues will be unquiesced
and new requests continue to be delivered. Reconnection error handling
process directly free queues without cancel suspend requests. The
suppend request will time out, and then crash due to use the queue
after free.

Add sync queues and cancel suppend requests for reconnection error
handling.

Signed-off-by: Chao Leng <lengchao@huawei.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/rdma.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8a62c2fe5a5ec..da60300104322 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -835,12 +835,16 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
 	error = nvme_init_identify(&ctrl->ctrl);
 	if (error)
-		goto out_stop_queue;
+		goto out_quiesce_queue;
 
 	return 0;
 
+out_quiesce_queue:
+	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	blk_sync_queue(ctrl->ctrl.admin_q);
 out_stop_queue:
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
+	nvme_cancel_admin_tagset(&ctrl->ctrl);
 out_cleanup_queue:
 	if (new)
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
@@ -917,8 +921,10 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 out_wait_freeze_timed_out:
 	nvme_stop_queues(&ctrl->ctrl);
+	nvme_sync_io_queues(&ctrl->ctrl);
 	nvme_rdma_stop_io_queues(ctrl);
 out_cleanup_connect_q:
+	nvme_cancel_tagset(&ctrl->ctrl);
 	if (new)
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
 out_free_tag_set:
@@ -1054,10 +1060,18 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 	return 0;
 
 destroy_io:
-	if (ctrl->ctrl.queue_count > 1)
+	if (ctrl->ctrl.queue_count > 1) {
+		nvme_stop_queues(&ctrl->ctrl);
+		nvme_sync_io_queues(&ctrl->ctrl);
+		nvme_rdma_stop_io_queues(ctrl);
+		nvme_cancel_tagset(&ctrl->ctrl);
 		nvme_rdma_destroy_io_queues(ctrl, new);
+	}
 destroy_admin:
+	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	blk_sync_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
+	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	nvme_rdma_destroy_admin_queue(ctrl, new);
 	return ret;
 }
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
