Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64D5ECDFA1
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k1kg6IVEr0hlMFLZy31AHqcDsQHIna0GFSfhUFMmhEA=; b=UOWg9YTYzEY4FAaKOFx23+tlFb
	/6RUTOVvTXZQfXilUF5KtwirdE4ggK8I12gODi2asxmyaY2LvG+jSSjitFgYLA08/hQVy0y7mvplI
	kZr2tk1s5AiNx0LeLhUkSlmNYFedf1ZTqD/CrofHK4wBUQgO8H26d4qTwLI/G4fHEwC/DuNvNQ6n+
	B32gFPCQlp6vvc8rAt3hCZP62G2snMkkdgH/lADsTtDhlVOkVzrzxvbTjKcyD3ldW5zINqZIFQyzM
	+3uorEhl6aeF8o1Q/AP1dt1vMICPlH0YpPYqudfss5373AnDs4tQEhYFvVqUl0etDZ61mpIwZ+YOz
	ZOtRWx2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onL6o-005q2s-Lw; Tue, 25 Oct 2022 14:40:50 +0000
Received: from [12.47.128.130] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onL6M-005pmX-5N; Tue, 25 Oct 2022 14:40:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 05/17] nvme: don't remove namespaces in nvme_passthru_end
Date: Tue, 25 Oct 2022 07:40:08 -0700
Message-Id: <20221025144020.260458-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025144020.260458-1-hch@lst.de>
References: <20221025144020.260458-1-hch@lst.de>
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

The call to nvme_remove_invalid_namespaces made sense when
nvme_passthru_end revalidated all namespaces and had to remove those that
didn't exist any more.  Since we don't revalidate from nvme_passthru_end
now, this call is entirely spurious.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8eb46ca9f6acf..50b440e1a0ca0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1118,7 +1118,6 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 		nvme_unfreeze(ctrl);
 		nvme_mpath_unfreeze(ctrl->subsys);
 		mutex_unlock(&ctrl->subsys->lock);
-		nvme_remove_invalid_namespaces(ctrl, NVME_NSID_ALL);
 		mutex_unlock(&ctrl->scan_lock);
 	}
 	if (effects & NVME_CMD_EFFECTS_CCC)
-- 
2.30.2


