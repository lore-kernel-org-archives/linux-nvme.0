Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14914FD8FF5
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 19:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iTyR51foYUPBOnnEwYMeOkSAEe5aT2w2QE+WyN/3DlE=; b=yDRW7qUcQsGd+uCk9LEBOlZ1tb
	esELI+6kJpZcx8UeVyWUFCdCA3t/k6u+5WtJutw6XdZzZR/EpazASmoJV8hiEVE2vsC7/WvjeZhFJ
	bjNnfNRWk4DA18U70MX3N+16kfzsCK+3vPikb86FgjnGVnWINh1Hj0YWIbM4wNWX9PZWtwdVDMXTa
	tyxI1FMtrMN6NMJjMpv+78NSm7XQk20ExqbZypePtBcChFeTuTltjnOAMpbljqdm70m9b3rMHnN0E
	1Ljor+Cq/iM0H90gTKQYDPipGS43WNLV7YUTURAgV787uHbWKZCuOOjKWsvIsl2raE7SgkTpabqKK
	zOhv0tdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgex-000000070Vx-3hRC;
	Thu, 26 Feb 2026 19:04:27 +0000
Received: from mail-dy1-x1364.google.com ([2607:f8b0:4864:20::1364])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvges-000000070Re-2F4N
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 19:04:24 +0000
Received: by mail-dy1-x1364.google.com with SMTP id 5a478bee46e88-2bddc698f46so22818eec.0
        for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 11:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772132661; x=1772737461; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTyR51foYUPBOnnEwYMeOkSAEe5aT2w2QE+WyN/3DlE=;
        b=eicNV7f021PUEjvdsvn8pH3lAKHBEbAUt+cfKTC8KPaHJSaPHPz43Y/tiGq49DqlBl
         a/z0FhEAAkOwrfgenuC1JDF+cOYLNavBUOmsiVdU7jmnowcxfmRg8+2FmTZne1dek0bK
         xfiretTk7npD6uJvx2G1CC1tzoyiSnfaypBTxrNRMTbn76+PT6dNKyj93/I3XpS9pRXd
         9Fhl1NJRWdMbt3i1+2WqhJcVHuoKY2QQgHuIEmvdsOKGeTmUWcraU6PW0zxhZP3Jrn/j
         ICqgiPlvIIcNh0JS1BSSMJf/YLOdnMVecVzGw5jRVHd6xkAKVUKbXlge84YbJ47qek7d
         Mw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772132661; x=1772737461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iTyR51foYUPBOnnEwYMeOkSAEe5aT2w2QE+WyN/3DlE=;
        b=ePkSYHIVWs14mKn3HUh0gD7N0IksOc9q9L6hBQ9Djs32DRYbZgBmsA9r3t1Y/T+3/k
         Xs2fPy5Zop+KL/bwfYPWnyPGUsE/u65IE1f/vC1Lqevl4rYb3OLgkTbSDcKYmqSMHxFq
         aWNfjbgwN/KEEU9N6ErBmnrx5VCmUmynibY9Aj8+nx30//B9Qb+mRZSc3ydUGtQkGdhy
         uvY8kfEUanVJ0f3a1BmmAJuB59eldQodEAIGo2Qg69CDVwjoxEpk5hc0eXMmb36C5cz8
         iIM/QPzjmo9qP3X5SDOGDp0BiBKvYHC2TM+YfJrd4F5tiSUKZr934rVHgttNGhN2yb6L
         z4aQ==
X-Gm-Message-State: AOJu0YwrglMe8Quebvn7KuvvZgz1F+xE3eSb6OaE2EXQ6Ebm7AwXzL0J
	sU8OAJESork1cE7QUkvGBQagi+XRfhsGJ41CA4mrC8WjCHnObK0qG35Mjp9lF3R/WtdG/duffxT
	IJLzAakBmYXAcinKcaLsoHXmESoe8bEL1CwHv
X-Gm-Gg: ATEYQzzXCrxz1zedlfM3CBeycY3IBs8RK8LTwauLkYxz60ApWM4LIF2LBgtAhC+3hyz
	eKhlT64kgqcotLHJbbAP7WEdOw97UJkInTAquTjXO58bIkqgcejum1NrIPOjbnqPMHQkRl8aa2s
	s58YwzwmWWdB7xsyHwdcnoRIbRK15zvX1FYPd4EBlmx2D50YSZ+uxZhU6fjQ+8CUG0zZIeyZuok
	BBYiayOUCOhyU/kYjpXP3QlFF9ccDKDouwxWIaWw5hL3O//egAERmEveAb2THXajG/FLfvIzF9m
	c1W02xd5QDUNP/0LoJEDk1wTl8eW5jh+cGfQMF9ONrVq+C+R/1u3pSm3AbTUKRbAgLtW79Zm+wg
	GAj6JMRAl6s0XhSADVmy84FuPX2y0vkR+GtR4mzsAJQqdr43unR0L9A==
X-Received: by 2002:a05:7022:6199:b0:11e:3e9:3e89 with SMTP id a92af1059eb24-1278fc28834mr1899c88.7.1772132661187;
        Thu, 26 Feb 2026 11:04:21 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-127899d591csm386473c88.1.2026.02.26.11.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:04:21 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E369834058D;
	Thu, 26 Feb 2026 12:04:19 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DEB0EE41254; Thu, 26 Feb 2026 12:04:19 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 2/8] nvme: fold nvme_config_discard() into nvme_update_disk_info()
Date: Thu, 26 Feb 2026 12:04:09 -0700
Message-ID: <20260226190416.297725-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260226190416.297725-1-csander@purestorage.com>
References: <20260226190416.297725-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_110422_606619_26BEE81E 
X-CRM114-Status: GOOD (  15.35  )
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


