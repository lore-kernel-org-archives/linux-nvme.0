Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E49AFEFB51
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 20:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iTyR51foYUPBOnnEwYMeOkSAEe5aT2w2QE+WyN/3DlE=; b=wmOD7ZgMMwppIQascrd3+IbJbW
	nmai2puwvYqMygWF7g/q3dcGeENIHgG4RbXeBPGCdLh6c0Op2cfb/BfTlrQNr3BAvklfV2X8Eeogy
	ShhKASmfnteKGBIv2ZVGLe3va4wk+xWqW+CZU7BDX/WNAs1H9ddXtwMILuonV1qXxZEROb6gO6nmR
	ZXsxXiLjqvinSqPGWC5OpviksSqHzPf49NMeLw3DIUEg6s3/g7DvUdgVm4oDd0sH00ABPXqbWeb4k
	5YF0dL2XEC2WqXxTkeX4uRCamR6nSo5nXR31laFuf+YIrjkmBOgsQST70P5J3E7G2e2he+oV9hte1
	xRV49ocw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4Nd-000000096QA-29Qd;
	Fri, 27 Feb 2026 20:24:09 +0000
Received: from mail-vs1-xe61.google.com ([2607:f8b0:4864:20::e61])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4NX-000000096OA-0yw3
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 20:24:05 +0000
Received: by mail-vs1-xe61.google.com with SMTP id ada2fe7eead31-5fde78685d1so74464137.2
        for <linux-nvme@lists.infradead.org>; Fri, 27 Feb 2026 12:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772223841; x=1772828641; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTyR51foYUPBOnnEwYMeOkSAEe5aT2w2QE+WyN/3DlE=;
        b=F6qObVrkbBDkjoScbVF7Q5ya9DcX3WmRYAsAFq+kdkpZ0ane0Kv+cGTRucr/McfQ50
         2EjuLQoPG7NHGccdFh2lCEYSjWWyPDht0yn3Kty83UyZkAFG/4aGdx1COpmLmtRacAiY
         iWCUm/sjkQ8u5SqOpG+y9cfHNH1Jghp+xM58YwjV8WzQD27QRzNAYt6xLvGuupSYklgC
         ErUwYwVo2ZrgeHopr8bT4cJmLbl+hImAu9UziimDTCPFrvUifyiOkCP1SzVxIB+Izzfp
         y8BjksvoY38ov338H/f+GItyApuP+J5YIJnv3fZ3aGPzC0zUH1036PMsl5TLN7ch5q1j
         I1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772223841; x=1772828641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iTyR51foYUPBOnnEwYMeOkSAEe5aT2w2QE+WyN/3DlE=;
        b=b17Nc5dUu8JmUoU+PKKqL0ITndK15Opuzth39IPpkgtL994AM2XIaCl4/NuQDLGR/c
         3fSX5pjJAoUUVyydaojKHpgxFcV19Vqd11J0OOqs5KR7v68Z17xYnF6OcO+4kkBQm8n0
         6eoSfguXNCuHDlZT1dXnptO4uagTtO7z81LdWbN5//ILlKxgF6YU1z/ywVwVs9nqpErP
         HAT9TwWwLwUBEe+xnDGoUH7+IRT+Pow4TybpA/M/CGp4m7otI5TUIotq07rDqI2bf5A/
         98jLBtF3BDPxG/GG878LaoiMeEb/vVGNMA3W83Qxc6Rbrurd1C7R5vK4UoL+xtUWIqG6
         dXDw==
X-Gm-Message-State: AOJu0YyzQNtwY+wG4E3z2Q+V3F2+Rn04yG1AMaInqPQRQ2sHuCuZYCcu
	g5Ts8qOIniQgL5ma1xjzIi0YvIF6zZWpWzGTrTHCwv1CZmrMsR2pzTtv9ZWsj3U/7y5QMmGmNHE
	5uhLFMYVMVvd9H8Ef+VP1u/Zndmoy9yJZn2co
X-Gm-Gg: ATEYQzyXG0KOSxxfkgAjYt32oAatYoJPYeyHhqM7kFuxUdTut1UjR48ipB7lgYHWwap
	Few+0yIPmqx0iORibXi92xSw3G8beUsyOCwMh0Hf3NPszLC44jpKWsvubyUyKqvM84PI7vqa9Eo
	GVBxSu2Qt9UTepiP8cR5OBZNoF3kgf26MjdpLK0xzPDizElA6NzphsNAj74oqhVFLZZKE7GU3FH
	2pMu4c8o55rpyzbrgOijB96asc9Oghv4BlSG8awYnH6uzm5DvU0V5QcHPnJvQCrMAYX6xh+rYee
	FRgctOg/E+zP5GE9kQOqSQHB0lRddd0TDDbIlIp+UNwWWaAo9Ah7eGiWlxHVzl0PUtQZV3rXwwY
	DSqMt7A/v9JJ/5wurMYdDlmL9T4iX69W9LiywrfZ6hw1IYWRKQCct4A==
X-Received: by 2002:a05:6102:d86:b0:5f5:3a57:1e88 with SMTP id ada2fe7eead31-5ff32536282mr1200513137.6.1772223841310;
        Fri, 27 Feb 2026 12:24:01 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-94df6542376sm546097241.7.2026.02.27.12.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 12:24:01 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8F7C53405ED;
	Fri, 27 Feb 2026 13:24:00 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8A735E420D8; Fri, 27 Feb 2026 13:24:00 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v5 2/8] nvme: fold nvme_config_discard() into nvme_update_disk_info()
Date: Fri, 27 Feb 2026 13:23:47 -0700
Message-ID: <20260227202354.1012322-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260227202354.1012322-1-csander@purestorage.com>
References: <20260227202354.1012322-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_122403_300037_486BCAFC 
X-CRM114-Status: GOOD (  14.94  )
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

The choice of what queue limits are set in nvme_update_disk_info() vs.
nvme_config_discard() seems a bit arbitrary. A subsequent commit will
compute the discard_granularity limit using struct nvme_id_ns, which is
only passed to nvme_update_disk_info() currently. So move the logic in
nvme_config_discard() to nvme_update_disk_info(). Replace several
instances of ns->ctrl in nvme_update_disk_info() with the ctrl variable
brought from nvme_config_discard().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 43 ++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3a2126584a23..8dda2fe69789 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1880,30 +1880,10 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
 		bi->pi_offset = info->pi_offset;
 	}
 	return true;
 }
 
-static void nvme_config_discard(struct nvme_ns *ns, struct queue_limits *lim)
-{
-	struct nvme_ctrl *ctrl = ns->ctrl;
-
-	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns->head, UINT_MAX))
-		lim->max_hw_discard_sectors =
-			nvme_lba_to_sect(ns->head, ctrl->dmrsl);
-	else if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
-		lim->max_hw_discard_sectors = UINT_MAX;
-	else
-		lim->max_hw_discard_sectors = 0;
-
-	lim->discard_granularity = lim->logical_block_size;
-
-	if (ctrl->dmrl)
-		lim->max_discard_segments = ctrl->dmrl;
-	else
-		lim->max_discard_segments = NVME_DSM_MAX_RANGES;
-}
-
 static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 {
 	return uuid_equal(&a->uuid, &b->uuid) &&
 		memcmp(&a->nguid, &b->nguid, sizeof(a->nguid)) == 0 &&
 		memcmp(&a->eui64, &b->eui64, sizeof(a->eui64)) == 0 &&
@@ -2078,10 +2058,11 @@ static void nvme_set_ctrl_limits(struct nvme_ctrl *ctrl,
 
 static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 		struct queue_limits *lim)
 {
 	struct nvme_ns_head *head = ns->head;
+	struct nvme_ctrl *ctrl = ns->ctrl;
 	u32 bs = 1U << head->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt = 0;
 	bool valid = true;
 
 	/*
@@ -2112,15 +2093,30 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	 */
 	lim->logical_block_size = bs;
 	lim->physical_block_size = min(phys_bs, atomic_bs);
 	lim->io_min = phys_bs;
 	lim->io_opt = io_opt;
-	if ((ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
-	    (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM))
+	if ((ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
+	    (ctrl->oncs & NVME_CTRL_ONCS_DSM))
 		lim->max_write_zeroes_sectors = UINT_MAX;
 	else
-		lim->max_write_zeroes_sectors = ns->ctrl->max_zeroes_sectors;
+		lim->max_write_zeroes_sectors = ctrl->max_zeroes_sectors;
+
+	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns->head, UINT_MAX))
+		lim->max_hw_discard_sectors =
+			nvme_lba_to_sect(ns->head, ctrl->dmrsl);
+	else if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
+		lim->max_hw_discard_sectors = UINT_MAX;
+	else
+		lim->max_hw_discard_sectors = 0;
+
+	lim->discard_granularity = lim->logical_block_size;
+
+	if (ctrl->dmrl)
+		lim->max_discard_segments = ctrl->dmrl;
+	else
+		lim->max_discard_segments = NVME_DSM_MAX_RANGES;
 	return valid;
 }
 
 static bool nvme_ns_is_readonly(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
@@ -2381,11 +2377,10 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm, info);
 	nvme_set_chunk_sectors(ns, id, &lim);
 	if (!nvme_update_disk_info(ns, id, &lim))
 		capacity = 0;
 
-	nvme_config_discard(ns, &lim);
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
 	    ns->head->ids.csi == NVME_CSI_ZNS)
 		nvme_update_zone_info(ns, &lim, &zi);
 
 	if ((ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT) && !info->no_vwc)
-- 
2.45.2


