Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3174FC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 15:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=11kqAf+NOeqd+osbgAcN4lwhXRPC2AX//HVP/uRwno8=; b=mioTbqRfQ7Pja73tVT/YCy0v22
	TzkJnXPVVHTeIuD2xwXfQRJd9uYLMUbh/SzQNLfNxaR/Vz2sCQTxA8SBuuUFsS3rDtWPM/oxBUU/Z
	rtsN0QYqT3jPaITAdov1OiklJxlw3ArIE1dHOibiUpNaholz2d35cudG3oH3r4vi6hbZ27xlx2SQ1
	xX+tSOFlv5mEvzzQiJRf8p1HtNclxHPW2gnQix2ngUfCdF3+S5RlFuN5HMTcrorS1NBqKmb03kO1K
	xTvw1rRTsewoOpFPF34j1e1PA83o88XKg0G1TgcR/pb4PEdgpU3qBOao6UpF4tQI+ee08RhweORev
	H85VoMxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ms4lJ-005o3d-90; Tue, 30 Nov 2021 15:09:41 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ms4Tn-005hYT-Mx
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 14:51:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 51718B817AB;
 Tue, 30 Nov 2021 14:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C81C53FCD;
 Tue, 30 Nov 2021 14:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638283893;
 bh=71CGjOfUIb3TjUWIc4RjZNQ40Lhywk3KLg33jW+fqjc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KWU5Qq+6+BdZ6fIpgGAECSYY4Tqpl2tFeYIw34hs2nd7IlH8N1CShwcCDEKf5J5Vy
 iL10V7Cxc4qRJexqrSCqsbDwYLyry8DXA1BABy45Nvt4l786uhxkLAnkT8Cs854hda
 z5tI6Ogxl+o3ySAeklWQ8/xHtaA8Sxjg2aIjqLCr4QRMAbklBdxdLEXIxI9MIp5OIR
 I0lxywa8m8wRCsBswx9MjIK//f5bVyW3jVp1dwteZr95+7c9eiI8WrpAzcTLIYqHyV
 aJJ/M3pyZd2VyB/QOmMlzaLAjAtdUhuVYOb8vzKw5DvdFVVpzCVWRgcfVlbaeIYCB4
 fkBrB8byi3ttg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Klaus Jensen <k.jensen@samsung.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 33/43] nvme: fix write zeroes pi
Date: Tue, 30 Nov 2021 09:50:10 -0500
Message-Id: <20211130145022.945517-33-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130145022.945517-1-sashal@kernel.org>
References: <20211130145022.945517-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_065135_963930_204DDD3C 
X-CRM114-Status: GOOD (  15.05  )
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

From: Klaus Jensen <k.jensen@samsung.com>

[ Upstream commit 00b33cf3da726757aef636365bb52e9536434e9a ]

Write Zeroes sets PRACT when block integrity is enabled (as it should),
but neglects to also set the reftag which is expected by reads. This
causes protection errors on reads.

Fix this by setting the reftag for type 1 and 2 (for type 3, reads will
not check the reftag).

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c76f3a7fb1d18..9b57a9db8f1dc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -750,10 +750,19 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 		cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->write_zeroes.length =
 		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
-	if (nvme_ns_has_pi(ns))
+
+	if (nvme_ns_has_pi(ns)) {
 		cmnd->write_zeroes.control = cpu_to_le16(NVME_RW_PRINFO_PRACT);
-	else
-		cmnd->write_zeroes.control = 0;
+
+		switch (ns->pi_type) {
+		case NVME_NS_DPS_PI_TYPE1:
+		case NVME_NS_DPS_PI_TYPE2:
+			cmnd->write_zeroes.reftag =
+				cpu_to_le32(t10_pi_ref_tag(req));
+			break;
+		}
+	}
+
 	return BLK_STS_OK;
 }
 
-- 
2.33.0


