Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A18CC54756
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 21:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s4xImjCuy85GRC/0mCxTJLCDJUoqCIogFxG7+l4rO8I=; b=GHkymlsCDa2b0FlRw99ad4JJ9m
	NHsPt8dNOBMXq8CBcsl/3POaiywujbe482Vl0OWzff0PDFkRkvhqDbQuXwVsK7yz8kHMKAleIFUnE
	eqcGXcRjnXB20aHL+RBbjzjFrcBIWgjOtggTfzq3ounYJnDjCXDbnBdon3Vc4sOGoeik7EbbfSFo9
	JWV1qTja2H68JRTISuDQNF8umIZf8SEjFJ+mTZX6Vxxv8u4+rhQDlJxm2/JCETkGrbSd4fuXpsfpL
	JUTVrfJwYz0atrgIZNoQUrmIeCaP1moMpqvhSrSlSMgVug0NLi0NsaMbsV6nOn7A3qiBum8VQ9eBg
	NHoLEOyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH7vl-0000000AVq5-34IN;
	Mon, 19 May 2025 21:21:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH7vk-0000000AVpF-1K6R
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 21:21:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 82E70629D0;
	Mon, 19 May 2025 21:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B5FC4CEEB;
	Mon, 19 May 2025 21:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689711;
	bh=gAtsqcqyq2u2ikHmrRudAkmavnu5hJUFh/jSZy+biYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HyWCh5yciQfwC9jY0ddgbIo/IT8Py9+uDRP/LAogltJOnNfFrcZYyUo1ML12a3RA5
	 6yvsXCowjRrXY+AFO5j0BoAUSgg4D7rzEFPO6WDnVKItNmI9XTafy9xTUDPtyZeowB
	 7MMOR09Y3fuMDbQ3yy1z1+rkFVA1kDkCvZGV5LUdksKop2O4vcDdut3ql52RCuTYmJ
	 kmx1UCu+uOrgyxQ8HXw8+N+slbs2s50PRvL1JL34hTR0kwZX1SIYVqPsM5SzBfNY9/
	 vt0qupcOdzVVvSCB2UXbwAZgBmXpp1C3GoPSCK+7A0kZdZkQEys6zg+L4ekU8mppHO
	 ocKSy718mDcKQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 12/23] nvme: multipath: enable BLK_FEAT_ATOMIC_WRITES for multipathing
Date: Mon, 19 May 2025 17:21:19 -0400
Message-Id: <20250519212131.1985647-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212131.1985647-1-sashal@kernel.org>
References: <20250519212131.1985647-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.7
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

From: Alan Adamson <alan.adamson@oracle.com>

[ Upstream commit a21675ee3b1ba094e229ae4cd8bddf7d215ab1b9 ]

A change to QEMU resulted in all nvme controllers (single and
multi-controller subsystems) to have its CMIC.MCTRS bit set which
indicates the subsystem supports multiple controllers and it is possible
a namespace can be shared between those multiple controllers in a
multipath configuration.

When a namespace of a CMIC.MCTRS enabled subsystem is allocated, a
multipath node is created.  The queue limits for this node are inherited
from the namespace being allocated. When inheriting queue limits, the
features being inherited need to be specified. The atomic write feature
(BLK_FEAT_ATOMIC_WRITES) was not specified so the atomic queue limits
were not inherited by the multipath disk node which resulted in the sysfs
atomic write attributes being zeroed. The fix is to include
BLK_FEAT_ATOMIC_WRITES in the list of features to be inherited.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f39823cde62c7..ac17e650327f1 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -638,7 +638,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 
 	blk_set_stacking_limits(&lim);
 	lim.dma_alignment = 3;
-	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
+	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT |
+		BLK_FEAT_POLL | BLK_FEAT_ATOMIC_WRITES;
 	if (head->ids.csi == NVME_CSI_ZNS)
 		lim.features |= BLK_FEAT_ZONED;
 
-- 
2.39.5


