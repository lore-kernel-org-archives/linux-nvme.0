Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2D5EB64D9
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jul 2023 00:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=M5XFd2seTsTdpNFV9Rdqe1hDZ8fCdXYKM4A9xm9ZPb8=; b=RyLOby/dYC2krfbjIyvQPOyi33
	ffCssr2avNvZ7A5UDcxBeE/aFBechcFL3pSu2oQWRvrfx30UD4hflgtKoE9oENxhSTpDNXrVOWee/
	pq6KPcODqLddpk05B1yLFiMUaEJ6oYiGt1L1cqhBZfQFMH+fK1WTuU7htxFditk/73VcM5J65Fx+B
	ql6/7mlfuCwTFr9B6Uj8mlU8MFfr+R7N95Z/QvQIpfpJhBk0S5l10iTHaKFwWARbBeLnq13hWMLFl
	iPgzjUeca4rXuovQuDGBK+lEq7NwEVof7hWbIPoDaBX7Rmokwb5MuA2DfGFUfNDihtCLGP9tRvrEJ
	+CWSsDUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHZOe-0033gO-27;
	Fri, 07 Jul 2023 00:32:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHZOb-0033fw-1X
	for linux-nvme@lists.infradead.org;
	Fri, 07 Jul 2023 00:32:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EF7F961208;
	Fri,  7 Jul 2023 00:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83ADC433C8;
	Fri,  7 Jul 2023 00:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688689944;
	bh=+WSUJ6T1QrwUljeCTDuJyd/HyCB6U09i9My5GVrX8dI=;
	h=From:To:Subject:Date:From;
	b=o31fhWJcSvhNL4WJXmqoRxn7SPIjyoKvpKwrbFwdZjYvV2i+mlVDiFe7BB0OWUCxl
	 wBxhlPvX4VpCCJfvjHgUOCE3CvIDTViJW5XH1dcEY6ug/+NRxU0NNZJ2684lauLy0v
	 +iBv+BQ7spfQtIA8eAm7l9NMK0rta2V4IMpStyTEMwPwMoWh28mjNWalwwv9453DXs
	 K8PFumhbv4D3mTnr+K1tkDrb0YDnEJE96xOKW7x4rksmKyPVGXXxRnSYDBCnhe7ayG
	 TSt+IDpbfZAqDRU+9gLpvqWa3TfrSXX5tozAeDYIhoLuLr1zW2hpLmrnbj0d7mF4wJ
	 ViBK+spsDiCMw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] nvmet: use PAGE_SECTORS_SHIFT
Date: Fri,  7 Jul 2023 09:32:22 +0900
Message-ID: <20230707003222.5854-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230706_173225_557685_943F4B6D 
X-CRM114-Status: GOOD (  11.87  )
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

Replace occurences of the pattern "PAGE_SHIFT - 9" in the passthru and
loop targets with PAGE_SECTORS_SHIFT.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/target/loop.c     | 2 +-
 drivers/nvme/target/passthru.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index f2d24b2d992f..48d5df054cd0 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -373,7 +373,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 		goto out_cleanup_tagset;
 
 	ctrl->ctrl.max_hw_sectors =
-		(NVME_LOOP_MAX_SEGMENTS - 1) << (PAGE_SHIFT - 9);
+		(NVME_LOOP_MAX_SEGMENTS - 1) << PAGE_SECTORS_SHIFT;
 
 	nvme_unquiesce_admin_queue(&ctrl->ctrl);
 
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 71a9c1cc57f5..9fe07d7efa96 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -102,14 +102,14 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 	 * which depends on the host's memory fragementation. To solve this,
 	 * ensure mdts is limited to the pages equal to the number of segments.
 	 */
-	max_hw_sectors = min_not_zero(pctrl->max_segments << (PAGE_SHIFT - 9),
+	max_hw_sectors = min_not_zero(pctrl->max_segments << PAGE_SECTORS_SHIFT,
 				      pctrl->max_hw_sectors);
 
 	/*
 	 * nvmet_passthru_map_sg is limitted to using a single bio so limit
 	 * the mdts based on BIO_MAX_VECS as well
 	 */
-	max_hw_sectors = min_not_zero(BIO_MAX_VECS << (PAGE_SHIFT - 9),
+	max_hw_sectors = min_not_zero(BIO_MAX_VECS << PAGE_SECTORS_SHIFT,
 				      max_hw_sectors);
 
 	page_shift = NVME_CAP_MPSMIN(ctrl->cap) + 12;
-- 
2.41.0


