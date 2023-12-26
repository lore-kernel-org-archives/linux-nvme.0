Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF39C46CD4
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Dec 2023 08:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+v/bO/M4PjU0yUrQk/ouh/qqmRpnLPNa6WrUmi5LogI=; b=Je3j8h5dfpgKGF5EDWzTjSdT5a
	60l0dZ/BYtrELoGKJZ4lBmnAe3UNbiYh9MT1tNa8Mv5RSu/nZvoHdZ6fFL4P45k3vGWa4YWEyNE9/
	PMYpvXGye88CxBLCA3pyrSrQiJU55ZqZv0E9+NEHacUEMyUukukoLh36KMIeVQDJCNDLBOaglULcf
	P+qHxSwdAOndX8BuIiGr5F5PWLm1W1XL973KVqW+FsXDoaDHQMrcna+j3e/aj3vaQ6fGg7Q8Hcfso
	4PqrLK33xQ06LV1M+IIYxSk3Ykxq+dygp16kr5KyM0Z/EURToxaz9qOWVWlBqzoly0+s+/3pixHOz
	KPPm5n3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rI3HA-00Bvyq-0E;
	Tue, 26 Dec 2023 08:59:00 +0000
Received: from [89.144.222.247] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rI3H7-00Bvxh-21;
	Tue, 26 Dec 2023 08:58:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 1/4] nvme: update the explanation for not updating the limits in nvme_config_discard
Date: Tue, 26 Dec 2023 08:58:41 +0000
Message-Id: <20231226085844.203878-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231226085844.203878-1-hch@lst.de>
References: <20231226085844.203878-1-hch@lst.de>
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

Expeand the comment a bit to explain what is going on.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d144d1acb09a05..56107cfc97b7bc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1743,7 +1743,13 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
 
 	queue->limits.discard_granularity = size;
 
-	/* If discard is already enabled, don't reset queue limits */
+	/*
+	 * If discard is already enabled, don't reset queue limits.
+	 *
+	 * This works around the fact that the block layer can't cope well with
+	 * updating the hardware limits when overridden through sysfs.  This is
+	 * harmless because discard limits in NVMe are purely advisory.
+	 */
 	if (queue->limits.max_discard_sectors)
 		return;
 
-- 
2.39.2


