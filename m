Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BBFC54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 17:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J49kgsI0MfqfQ5TLF/RW4gwjSEYsrK2gc0LWrb+CHg8=; b=nVPc64QHa4Jz07Z4q8fS3vuvKS
	inRy+zpRv2G7f6w5x/98Cgcrin5g3xeNnX4FxjHoSP9DVxnQ91ziiOiEr/mC8qMjbtIZmSvXFtMi4
	hlcBiMhr9+Ny8qDevfBDiY2apwmfN2qmtlioQMjoepTAli27V5mxaPfjASiiVn/OanG0h3ORlNJWD
	De68qZndWN3xsVz3RX/HNRwN5Gvslix7XrBdwIMmf6MCzXAzTcalgbeb38PWGOXmp5CM19XfJQjNt
	xbWPr/5M7iKPC410gktS6AlfOYHGyYxn7b5zTQR+grP9UTNOSOGJA3s1kLEE+ydPwAspA9NwPelwu
	gLuVzqLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagsE-005M8q-0u; Tue, 20 Sep 2022 17:17:30 +0000
Received: from [77.247.85.102] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagrZ-005Lfu-KS; Tue, 20 Sep 2022 17:16:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 10/13] nvme-loop: initialize sqsize later
Date: Tue, 20 Sep 2022 19:16:08 +0200
Message-Id: <20220920171611.1289361-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220920171611.1289361-1-hch@lst.de>
References: <20220920171611.1289361-1-hch@lst.de>
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

Defer initializing the sqsize field from the options until it has been
capped by MAXCMD.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9750a7fca2688..ed6d36eb7d295 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -601,7 +601,6 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 
 	ret = -ENOMEM;
 
-	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 	ctrl->port = nvme_loop_find_port(&ctrl->ctrl);
 
@@ -621,6 +620,7 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 			opts->queue_size, ctrl->ctrl.maxcmd);
 		opts->queue_size = ctrl->ctrl.maxcmd;
 	}
+	ctrl->ctrl.sqsize = opts->queue_size - 1;
 
 	if (opts->nr_io_queues) {
 		ret = nvme_loop_create_io_queues(ctrl);
-- 
2.30.2


