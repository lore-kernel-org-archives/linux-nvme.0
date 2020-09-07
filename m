Return-Path: <SRS0=Qo8g=CQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25322C433E2
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 16:35:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0F521927
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 16:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UoGrAvN9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1X0dhQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0F521927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CUx14Tm/k+8+y+QFwpuZTtYBTQiHmbhf7/F/Js/khBw=; b=UoGrAvN91KQXqswdJ7P2H3/WR
	ITBrU4EHdFUYEgTpntBkBqH8Li+tdrEP1AnkwLTCdjnFjZlzT0www+R2/jx7HVA1obsfx2eXm53uh
	Wx41Q/BPuwySU++yNamZkkZs40t5L9Ke1HTf7AxxXb7284wIHf0GJszNN+MUN2NDFQz5Wii49DHbE
	FOjhAE0sGQoEHL+kbQtbpSKxIlkNbRBa1KDOc+wtQb+AIxMH6gCu4fmWfBlBJiwaAMfDg9Mw/5ata
	I1FxGhHl6saWvGjsS2YGYtupc7ah7ODHcGewLL8xYwyZxTfe1lqYQrjlXNJdK+Ap5C4TlKW/FzHYM
	YOG4O3Wgw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFK7W-0006fL-J9; Mon, 07 Sep 2020 16:35:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFK5o-0005nx-F2
 for linux-nvme@lists.infradead.org; Mon, 07 Sep 2020 16:34:14 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1ADA721974;
 Mon,  7 Sep 2020 16:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599496445;
 bh=jeOg/tDfVDnb1MejOcNsq1POFj6bdB/SRk7/p9m+VMM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n1X0dhQ2ATo1kCTMlpXxjVxHpRUZGFch2SBi2brsx5XxJrMrhHjyB1F2bXkXV7A32
 0xED0jxADJJNZaHU59ZfQcB/hqjZe6+lTAFowG2pLsQFFoe2N67wbHDFUvdUxm1Ryf
 vugBllUYZcLpukqwCyN5M8otm9mSdt8PT8hafpkw=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 28/43] nvme-rdma: fix reset hang if controller
 died in the middle of a reset
Date: Mon,  7 Sep 2020 12:33:14 -0400
Message-Id: <20200907163329.1280888-28-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163329.1280888-1-sashal@kernel.org>
References: <20200907163329.1280888-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200907_123408_586957_D8CF1D9D 
X-CRM114-Status: GOOD (  17.18  )
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
Cc: Sasha Levin <sashal@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 2362acb6785611eda795bfc12e1ea6b202ecf62c ]

If the controller becomes unresponsive in the middle of a reset, we
will hang because we are waiting for the freeze to complete, but that
cannot happen since we have commands that are inflight holding the
q_usage_counter, and we can't blindly fail requests that times out.

So give a timeout and if we cannot wait for queue freeze before
unfreezing, fail and have the error handling take care how to
proceed (either schedule a reconnect of remove the controller).

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/rdma.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 4e73da2c45bb6..f0847f2bb117b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -899,7 +899,15 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 	if (!new) {
 		nvme_start_queues(&ctrl->ctrl);
-		nvme_wait_freeze(&ctrl->ctrl);
+		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
+			/*
+			 * If we timed out waiting for freeze we are likely to
+			 * be stuck.  Fail the controller initialization just
+			 * to be safe.
+			 */
+			ret = -ENODEV;
+			goto out_wait_freeze_timed_out;
+		}
 		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
 			ctrl->ctrl.queue_count - 1);
 		nvme_unfreeze(&ctrl->ctrl);
@@ -907,6 +915,9 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 	return 0;
 
+out_wait_freeze_timed_out:
+	nvme_stop_queues(&ctrl->ctrl);
+	nvme_rdma_stop_io_queues(ctrl);
 out_cleanup_connect_q:
 	if (new)
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
