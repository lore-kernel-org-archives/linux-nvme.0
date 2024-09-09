Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF05CD4F4C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2024 07:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=St3lqpws4n+J/cxgWexEC6u8XoLT1SYFSYRWBQRC7KA=; b=3z+c1DFBXF39unG4viha2e6mft
	0rRHA3K/3CKzQ0GOmPn0qYmSIXFnXM5bZ4xfdrK1oAsyjh+WIyEh/mfxsQyt3hUQ47WDEXLW9sp2H
	8vSS7cXTtBf6eqxdxoslPlnLJ891i6ZWOpicxYkMlhwrBthNexq1t8vOV/HaoJ9mB7IN5DHIPLyWZ
	Z2iFZdYl/m82Ad43c56OACU5cDgAVElfU5FenT5e7/vGeZdBRb9MESXEDOyZ2Nm/QsOO93GIK/GsB
	GUUlChp8H4BBScMkqscZasVsB6iEo8aSPhlstGI+2vCZjXZkNOkr0l75i0rcPKGKTraHuuOGEUZjv
	Kmvk8ZVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snYgc-00000000mep-1bbJ;
	Mon, 09 Sep 2024 07:19:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snYgY-00000000mdr-41ED
	for linux-nvme@lists.infradead.org;
	Mon, 09 Sep 2024 07:19:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AF03C5C5585;
	Mon,  9 Sep 2024 07:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C51C4CECA;
	Mon,  9 Sep 2024 07:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725866381;
	bh=7ejXV/2IK+jfRXQD09XudYPHwwGuB+xIXiT2/L3BssA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NRejWmtpr8IITV2M4xWiy7i4s7A/YXBR0JPiJCzTkhfS5nEGAY47zLSbbL3LMKZ+Y
	 BvRbbGh3QbNFZE+LRsq8OP61fR5QJSPl6MIERvgv1pv3rTh6Eh90asvaFualucvLjV
	 3zxlCCOu+dIZXu2IArNi1s1aUVc9ck6uo2Bf8qfxoGJtvNu9dwwdFiiGDjD2JsxuHP
	 eYBg+B1QGzQmSPMgaVue81OlGW3DJyHCWlAb6GMRh5EQEkgczlNzEaAPBlFSPQt24H
	 lMMy6Rck93Vl6RFVFwvgGXfw71H+4SXTsI72BNeQB3T4MiHPfukhNZpiGazjb00skx
	 H6+U+tGtTSOUA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/3] nvme-multipath: fixup typo when clearing DISK_LIVE
Date: Mon,  9 Sep 2024 09:19:28 +0200
Message-Id: <20240909071930.146343-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240909071930.146343-1-hare@kernel.org>
References: <20240909071930.146343-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_001943_049548_5ACE7EF2 
X-CRM114-Status: GOOD (  11.12  )
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


