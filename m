Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5B2D609A2
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2024 06:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tB9xDCw00JNcyH82hG8ik0fO73OHvg4InJX413iH75Q=; b=MXi+zpTOEVWRg3he/hUX5gxf6B
	sOKPIcKCGIipXn10XYLRYEqaJCjgBmhl2wc1lZlqGw/P3CtGwcgeD6e3/IkVuT1SpClmc41VZg3Zw
	bfSOB+tdIAYUupHA5/2n92m0E3s/leJwtMkWpubLFYHMX/lC4qjcy7d5SymW7zxSdoKI8cmu+xkdy
	B7PpySzLRpohl4V3Jefo0HszMaRfjDKqERZfDWIMl4ydpt42F76Wce+Xncux0QTGgfHO9SqQG4tdw
	53KyDWq1bYKKH0SOwIeLGwj5qMhThzuYsyBF695wttg3jod1ODZYZABCj+r5Pad7RebDCmKd1He1A
	u6rbkg4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGBkn-0000000CLOv-0YgV;
	Wed, 27 Nov 2024 06:42:25 +0000
Received: from 2a02-8389-2341-5b80-ca1d-6753-38e4-d4e4.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ca1d:6753:38e4:d4e4] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGBkj-0000000CLOX-44ws;
	Wed, 27 Nov 2024 06:42:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org,
	Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Subject: [PATCH] nvme: don't apply NVME_QUIRK_DEALLOCATE_ZEROES when DSM is not supported
Date: Wed, 27 Nov 2024 07:42:18 +0100
Message-ID: <20241127064218.42688-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
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

Commit 63dfa1004322 ("nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of
nvme_config_discard") started applying the NVME_QUIRK_DEALLOCATE_ZEROES
quirk even then the Dataset Management is not supported.  It turns out
that there versions of these old Intel SSDs that have DSM support
disabled in the firmware, which will now lead to errors everytime
a Write Zeroes command is issued.  Fix this by checking for DSM support
before applying the quirk.

Reported-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Fixes: 63dfa1004322 ("nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of nvme_config_discard")
Tested-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bfd71511c85f..5e5c9e15ad0c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2043,7 +2043,8 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	lim->physical_block_size = min(phys_bs, atomic_bs);
 	lim->io_min = phys_bs;
 	lim->io_opt = io_opt;
-	if (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
+	if ((ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
+	    (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM))
 		lim->max_write_zeroes_sectors = UINT_MAX;
 	else
 		lim->max_write_zeroes_sectors = ns->ctrl->max_zeroes_sectors;
-- 
2.45.2


