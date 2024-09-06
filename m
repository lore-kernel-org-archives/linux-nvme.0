Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B816CE7AFB
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 10:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=St3lqpws4n+J/cxgWexEC6u8XoLT1SYFSYRWBQRC7KA=; b=IqGaau9jeeedMoeEcUUm6i2ckz
	tUixFOGOGDHjWZmXT97wGZvL/Sajwm+m2BRjjKG69CT8OTQRJILrIVRadvOBWVdr7Axudf01I0wLz
	11DHsv7vDjbrC1xJ/HYCEaL5XWvdFIFU19kYHTMm0ZIIwZv/tdhYkfiucvaAtQH2zcNsRoluWP5+T
	tPnA1lmbWToEBaUay8Olg1qUVQhpPjO7DNzDsRyN4C8X/Ui1f+JM3rYahHhQVAeKw1M/GGt7otFuQ
	u/neu1yZnZoJXcnbPskEteDAamiJ83D+H4kWCxxdw9QsZ8kBbC5NLXw+t4ECOuNzsL5IQwPu/l+Zw
	mGXPIK4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smWAo-0000000BkZZ-0NP7;
	Fri, 06 Sep 2024 10:26:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smW1W-0000000BiG5-13VD
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 10:17:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CD7535C570C;
	Fri,  6 Sep 2024 10:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5817C4CEC5;
	Fri,  6 Sep 2024 10:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725617821;
	bh=7ejXV/2IK+jfRXQD09XudYPHwwGuB+xIXiT2/L3BssA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DMXtfwzGU7LzjBfQGxls/QfVP4HaGlMk63BMprmnqPyYObs9PC+3GgFa3lbSx6qPx
	 5nMBfgLO+8bZRWvlPHw/0mtob8JdH38CmP+E/OghCIX7CSH+b+YhmKvWzouQB96e8I
	 kKh6/dnJBebVnxA+OuNh5+49jwrUgDEjo7uDVnjNZvMEj2ay37y4qcEKlcfMhKnNzy
	 TrUweqLpClhJX03UJxP+jZCEi0u2CxFprooQl5L0kbgYSsYNENsAJKTcj0zfhutKFg
	 x5wiuVJ0EQaNcsf5q4xBjP2NcebuXYPavgVeonF+x4Cxw3rfpS2zUqQoXO9JSsmfLH
	 mhVnU/SGGVUMQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/3] nvme-multipath: fixup typo when clearing DISK_LIVE
Date: Fri,  6 Sep 2024 12:16:38 +0200
Message-Id: <20240906101640.44417-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240906101640.44417-1-hare@kernel.org>
References: <20240906101640.44417-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_031702_376426_631C1298 
X-CRM114-Status: GOOD (  10.91  )
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

NVME_NSHEAD_DISK_LIVE is a flag for 'struct nvme_ns_head', not
'struct nvme_ns'.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 91d9eb3c22ef..c9d23b1b8efc 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -646,7 +646,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		rc = device_add_disk(&head->subsys->dev, head->disk,
 				     nvme_ns_attr_groups);
 		if (rc) {
-			clear_bit(NVME_NSHEAD_DISK_LIVE, &ns->flags);
+			clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags);
 			return;
 		}
 		nvme_add_ns_head_cdev(head);
-- 
2.35.3


