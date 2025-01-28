Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C81CC02192
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 07:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oUpHF+8mv37A03zbYSxD0ErF39pud1C+zIT0GCpeZfA=; b=wUmkYyGKnEoShv0cqW0/iPJOmt
	syTJXeIPFqmSio2Sz79T0QmistVLPNlCzqK6Km+RMxnBPOgS9AOQX0+ErvTGE1T5+Uld01gwaZuvU
	fi7PiYQaqO3195NUVs1QHHxHmlP+yDZcSQyj0qWdGk6zQATqm8YzMBRAqYGi/A7k5j8/9T9lUfCIE
	KdJFcCYZt8GcC3JX1IMQU6tuinWbhl2KgdBESh+tocQeyDh3bFlJbeSH7VuNVV2PfexnMNsvrqY4/
	vk1x9UHP8XowUEtUaIopfV7uqDx7cQ39gHH2PbHVU8NOxX4+DrAE3UpYe4iJzF9KxqIiaE0+VTaAU
	w/6sNjsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcgRm-00000004JDR-3xGt;
	Tue, 28 Jan 2025 07:55:46 +0000
Received: from 2a02-8389-2341-5b80-d7c6-3fcb-a44b-90d7.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d7c6:3fcb:a44b:90d7] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcgRl-00000004JCn-0bMr;
	Tue, 28 Jan 2025 07:55:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvmet: the result field in nvmet_alloc_ctrl_args is little endian
Date: Tue, 28 Jan 2025 08:55:33 +0100
Message-ID: <20250128075539.693870-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250128075539.693870-1-hch@lst.de>
References: <20250128075539.693870-1-hch@lst.de>
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

So use the __le32 type for it.

Fixes: 6202783184bf ("nvmet: Improve nvmet_alloc_ctrl() interface and implementation")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/nvmet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index b540216c0c9a..4be8d22d2d8d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -589,7 +589,7 @@ struct nvmet_alloc_ctrl_args {
 	const struct nvmet_fabrics_ops *ops;
 	struct device		*p2p_client;
 	u32			kato;
-	u32			result;
+	__le32			result;
 	u16			error_loc;
 	u16			status;
 };
-- 
2.45.2


