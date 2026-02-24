Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB07FF357DA
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 17:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iTyR51foYUPBOnnEwYMeOkSAEe5aT2w2QE+WyN/3DlE=; b=44s9YVo9D+JX6DJ7pBJ1Nkl1AX
	C7ooSpF7W0qDh+HOnQO6lHvLD+jh0PCU3rTQXG9YZe2Awo8XfV8twzHznW5to9n8tH34e3i/6C9iS
	neZ4Byz4Fk6Rk+t3pggRMSiwwbPce1qS+uzTjDK/ML4ADtL1jOD92pXiJVzpYEkAX6DzB1KwmdaoS
	IvSihgQO7NH1kdrlh4BXVSlZFs43LcW8Py1g4Ouc0G8eryVvqBs3qFcZZ/9Wz1sbPCQBKsE/zecGp
	Rlyfhl+JE636epaCVK3LQriKSoESjXMHaSOOtOu/otgAKVt0q+OInzn63HCExtw7+LloMGvbzvB4k
	QYccPhug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuw05-00000002SJM-0d4R;
	Tue, 24 Feb 2026 17:15:09 +0000
Received: from mail-pg1-x563.google.com ([2607:f8b0:4864:20::563])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuvzz-00000002SEL-1f5e
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 17:15:05 +0000
Received: by mail-pg1-x563.google.com with SMTP id 41be03b00d2f7-c6e8fc8aef1so405369a12.3
        for <linux-nvme@lists.infradead.org>; Tue, 24 Feb 2026 09:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771953302; x=1772558102; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTyR51foYUPBOnnEwYMeOkSAEe5aT2w2QE+WyN/3DlE=;
        b=Sa2vuKT7jzUNghwRwwpw3B2xQ/4nLSeg8J9nNykuSKvypFf4I4OtADYxgRJFuNJanC
         ptAuHeVXTvnL33UPq5Kz0ifsA0KRgSOxgbGmjx+BMNUvnEw7cjKm2Mgfk3g0HDSEvaKY
         qq0xQaljo6Dn4QqSo4lKv2KdkQ5/MBubqPZR++jO4x8SOzU8h1Wn/mWev2z2G4KSVS6W
         jh+0Eq0L8CjD2RZEr2plfBm3/kKl1pWb8yD+xe0SYDfIb+n63iuYCvi0u2b+Vz0bDoIW
         bBL9NQAcQ/Dhp7zAg4IwuzB3cZrzFImU2C/eG6ELtiay4vj7O/q1Pmx1s6EJYAg0v6qc
         UJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771953302; x=1772558102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iTyR51foYUPBOnnEwYMeOkSAEe5aT2w2QE+WyN/3DlE=;
        b=T/4qtqG+a1ogL7U42oMTabBjhNjAi8JleXVXv6FF+KHeKJsAn4B5WAA7iyeJJ0vN3f
         fxlWjyc9drMiQSnmefYIxY8oArXt1DoVOR+qYbO5/lmwDesPG3GQ7xUYRI25MA0vw6rx
         EYtffpJTexIm/gXooSY+IR6geacfNm/alvSzNSkOejrkGyM2mZZ2mD7L6H+2dJTEA3g/
         qhuLXWKDNyhkclbdSg3DK0fuDIu8Y+lX1DnzQrQ54R3yqov59rnLJDcu7hPBSCJtawhQ
         QUPiFm38ERHuJPTip8QFIhlgWQiW9IDfZF3o1d/5fHGBE21aK7z/shC5FdgXB0rT3tS+
         AuwA==
X-Gm-Message-State: AOJu0YwhPJecgDC8FFA6ev7PrqgbA0nqw8LIhBp5ZfsgQRChmgE69nP4
	rwohibqlZbfCGTqKpWmxzHtrHrwR3XYzRnuRix9z8xq/1gu6/lPldIn1xp5G5wKGmwC7XN5bJfO
	O6NJE7VDQGTEiFasM52+oOHE4dXGdaTIRJ+cp
X-Gm-Gg: ATEYQzwNaChdPT8YzVZZHtdMhEn/j/vpOTNq1WPFuX2/x7F2eidrWC5li2X1C057fDc
	N2bOIS+P91gkp/UNJC+O4gAUT5QmEFcrcjqIRU5O64nF9RVpAq8C/hlOSwkDPQfyfTTy9x6Yzzj
	00DOtVzFrUYpvqUstr2X3RiDyQiPxGT7skFrdLWuekH3u9GAUSl9V5LVvXj6ow7DROpUFU0sfuc
	kWJiPbz6IkavXBFEXudDzCk0ikSiY40pOEYoPmGgVCdiJ1yAW/L8V6DHJ16wjHfx3WIoYJnkdxr
	eIGPWkUWHo+/GDEiIEslgDQBYMlbXi98A9UFvpb8M3vccuMFjhK/nUBb0oZGrXe18Zu0JR7oHYu
	RgpWnsUkWUumCrJh/+ReN2wdtmsFt6IT7Rytr+gkPFyr+YHq5JhZmZA==
X-Received: by 2002:a17:90b:4b12:b0:341:88bc:7a54 with SMTP id 98e67ed59e1d1-358ae8e3753mr7245157a91.7.1771953302352;
        Tue, 24 Feb 2026 09:15:02 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35900dba287sm56754a91.1.2026.02.24.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 09:15:02 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 1E749341D32;
	Tue, 24 Feb 2026 10:15:01 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 19F96E41254; Tue, 24 Feb 2026 10:15:01 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 2/8] nvme: fold nvme_config_discard() into nvme_update_disk_info()
Date: Tue, 24 Feb 2026 10:14:31 -0700
Message-ID: <20260224171437.3175993-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260224171437.3175993-1-csander@purestorage.com>
References: <20260224171437.3175993-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_091503_439800_1B7C76D3 
X-CRM114-Status: GOOD (  15.47  )
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


