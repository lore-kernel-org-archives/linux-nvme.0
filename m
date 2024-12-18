Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A60E77184
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2024 02:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ngr2fkdVIPOqcy6NvtfvYbQWtAnnnko0+PNeSdDSjNo=; b=JdwUhMLRPxNQgEDNJaRa2SjvFk
	xCHWFYL/iqC0BbMOGiHGaMitd7WkMV1dL4h27InEQ/TP93Vo1I1BY2CBSXsD5FWNdFQTo0fPMh0bZ
	m6naGx5mmjMgStiQXzDKFR3PeIZXIpYOAmB4wIxw9RiS5agYC4xz6UDGcrTXCVakpv6a7uh6PSuGK
	dPbl/YMamlph2EwBBlcnhxEcEnHRcA/2A99U/ovc9TZaMQVtT7r2zjSkGxNn2OTJ4Ke45enBviRLB
	KwJswScGbEvnqeTKezor2EhH+nntndOTy2uvebFJs9HY1C7dRqcfel9AItKaRZhZaxOKcEaJBvEFI
	niO5QEnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNjsQ-0000000FPDn-2buy;
	Wed, 18 Dec 2024 02:33:30 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNjsM-0000000FPDC-0BiN;
	Wed, 18 Dec 2024 02:33:26 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	gost.dev@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH v2] nvmet: propagate npwg topology
Date: Tue, 17 Dec 2024 18:33:25 -0800
Message-ID: <20241218023325.3671826-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.1
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

Ensure we propagate npwg to the target as well instead
of assuming its the same logical blocks per physical block.

This ensures devices with large IUs information properly
propagated on the target.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

On this v2: I just drop the awupf stuff for later work.

 drivers/nvme/target/io-cmd-bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 0bda83d0fc3e..eaf31c823cbe 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -36,7 +36,7 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	 */
 	id->nsfeat |= 1 << 4;
 	/* NPWG = Namespace Preferred Write Granularity. 0's based */
-	id->npwg = lpp0b;
+	id->npwg = to0based(bdev_io_min(bdev) / bdev_logical_block_size(bdev));
 	/* NPWA = Namespace Preferred Write Alignment. 0's based */
 	id->npwa = id->npwg;
 	/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
-- 
2.43.0


