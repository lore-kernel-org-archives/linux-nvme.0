Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C3CC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 15:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EVLw9gT5Xccr6DFN64DtCTFj+ylN0C3A82rSdd0dz8Y=; b=35sZRT0x98D0Mgbo8AAGywp38x
	YBpbxu2J2XcvPEAcPmANuaYCcEPH+rbXHdgE9zGia7iu+mOHdHoOt4ZsbshaPArY8QXSToKzemteq
	3AdCZ83LVwoEhTLME5BqxXzrwWd97d0hmX3z99NSI2CcsXRI24w+T+OKyQHXgTFQOCotNFkGX6KUt
	i8MxVNTFS2PuF+QBAuDgDTELMg4E8M3ESTrq0mUZ844rchy3NiRHGrx7Ji44FNUiCoeGQuDBraeLm
	bcjkDN87mhMEfNGTdlhd1VCUfy+cpzNfvIJ49s3m8Tgxvmz91dMD/SBE70Y85LJdyLvsoyZYDddhn
	Ae5M3dIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ms4tR-005qPk-TW; Tue, 30 Nov 2021 15:18:05 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ms4Uo-005hyj-Np
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 14:52:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 58FD1B81A61;
 Tue, 30 Nov 2021 14:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F74C8D183;
 Tue, 30 Nov 2021 14:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638283955;
 bh=2lNfN6gqBj+HB82ICjyKZBy0cFJR3rHodqFLvvA1Ux4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gX5eViLx2EWvd7+rOOzbfyr4PLSiMYUMvAOqel7MoUJmm1hTmOxYPlksRKF9Z0mRP
 HS38TkQkoNgSG5qsf/rPZfQYrP+ok/W/XNnrhgIwLgH42V/Bg9xCGON92V//fy/cFZ
 un725ncK4Y6RKb26VfFTc0MKpYy5VwqDL9RqEJIGRDWZpxE+oJ1bn9hDNEKKAuod23
 zuIH57Itr1wKZc4nMIYMC3sc4+0bv5XNMaWi1KTBUKYtXoZJy+7dhzmabBZuRvWLgo
 cSFhNgaNbPxQkYpNQh4msPjMKnfBCstpyLqVux1PDNQ0YHUokpb5HCdBoe4rBR0Umt
 HRB5/GV0NBkQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Klaus Jensen <k.jensen@samsung.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 21/25] nvme: fix write zeroes pi
Date: Tue, 30 Nov 2021 09:51:51 -0500
Message-Id: <20211130145156.946083-21-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130145156.946083-1-sashal@kernel.org>
References: <20211130145156.946083-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_065238_997248_C079212E 
X-CRM114-Status: GOOD (  14.95  )
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
index 5fa48d36954ce..45f89a1ebfa69 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -694,10 +694,19 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
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


