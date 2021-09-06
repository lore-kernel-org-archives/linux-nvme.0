Return-Path: <SRS0=/f9n=N4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AD7C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 01:35:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2974B60EE6
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 01:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2974B60EE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XjraNNJE+WUjeoGbUIkOmBBBwsuh63luXWRQGCB9hTw=; b=C4rAFRU/v1CptY
	+fy3A9I20qYNV0q0G/pKS1bt2HwuOS8lOErLTevXlf9RhjISGwhx4zDm3TrH6POvBGC5q4dJ6ahrX
	ptEsbPHZX9v/6pKUoq+kEb52bnlIiQQdq2Il9Zw+cDDIkzL5GRdNoxNQ7Qqqos+d4Iu7B57JRIx5l
	kjvjQ/4ggJiE8Xb8aTtMrhvC7njYiHbTBg36Lo3fgwZKWowEeVrCMsK5Rwg1TPMZidnvfRprc6ApD
	yz1SWU248/yiVTWhmkQCR82DP3qpleblLkj4FrqXlYI3GIVu+c66TfjiVxLdZSHayA5gz/IczQCGE
	5OkYNLEbyG5keubJSqgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mN3Y6-00GyY7-M0; Mon, 06 Sep 2021 01:35:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mN3Mh-00Gv1k-EB
 for linux-nvme@lists.infradead.org; Mon, 06 Sep 2021 01:24:04 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46D516121D;
 Mon,  6 Sep 2021 01:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630891443;
 bh=/PFJ4pbHRSZwAwaEW9zIMTjtpDXkqd6b6P6mVRcUW/c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bjlTdhP2xANroNKMfWhGSmKHRUjH9l1kvw8orEQaIAkGwnLUUQQUtHB5gUi5yiprg
 fxwEyf3kYgBJwOmmuAoqd+xox2o2i3/i88d+7nYineY2WqGTJy+zxgJQxh1FY1jz+l
 kwT3rPeq+kTsXrZMgaN/vRST+En5JJeMrhoXLToxQJD07ORgHG54oArafgPwiEQ/iU
 /p4WkPre4AAt15HcTu7luiR2w0KGt+Bf49+RcCI7yIN1C/Bd34XyH7A/jQhOclscDk
 vUZs48IrwcylNaTi1Yu+r8vagI2rgUw+pk5CEdDsfR083AnvT4vKdKacuUPisP+qSW
 FP+YE5Rd4t9Aw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ruozhu Li <liruozhu@huawei.com>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 08/17] nvme-rdma: don't update queue count when
 failing to set io queues
Date: Sun,  5 Sep 2021 21:23:43 -0400
Message-Id: <20210906012352.930954-8-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210906012352.930954-1-sashal@kernel.org>
References: <20210906012352.930954-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210905_182403_589985_56202183 
X-CRM114-Status: GOOD (  13.84  )
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

From: Ruozhu Li <liruozhu@huawei.com>

[ Upstream commit 85032874f80ba17bf187de1d14d9603bf3f582b8 ]

We update ctrl->queue_count and schedule another reconnect when io queue
count is zero.But we will never try to create any io queue in next reco-
nnection, because ctrl->queue_count already set to zero.We will end up
having an admin-only session in Live state, which is exactly what we try
to avoid in the original patch.
Update ctrl->queue_count after queue_count zero checking to fix it.

Signed-off-by: Ruozhu Li <liruozhu@huawei.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 57e1c0dd63c4..11fd3a7484ac 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -654,13 +654,13 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 	if (ret)
 		return ret;
 
-	ctrl->ctrl.queue_count = nr_io_queues + 1;
-	if (ctrl->ctrl.queue_count < 2) {
+	if (nr_io_queues == 0) {
 		dev_err(ctrl->ctrl.device,
 			"unable to set any I/O queues\n");
 		return -ENOMEM;
 	}
 
+	ctrl->ctrl.queue_count = nr_io_queues + 1;
 	dev_info(ctrl->ctrl.device,
 		"creating %d I/O queues.\n", nr_io_queues);
 
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
