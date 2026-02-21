Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC7FC5DF7A
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Feb 2026 03:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eYFSHEsFJdDOj3cQkRPFLn4/+IOAqySMBQqhkpK+Jyo=; b=HBdTD2HXEPItoNLXFeOcKdqAIq
	Uj8A9d/01mPVUwZqEOgj5l0jJN/pLL5bDI/LZ2wqgACa91p5rcF6FnyVm2cP34yFStvvGPEXJJo2+
	lkmFOpho34iGXPEKIpSMvi6iD2LJqPXZy2ulLGNGSQH/7NZ/ytEWWKTZzIoRdL5y+jIWQa1Z/PsPX
	p0j1FwAWEOVIAJ/wkyyl4GZeO/DhwL0CywaPEl6E5xSDlnzZbm0ITBFXHZE4tXxePgMXMOmYtgPZI
	QfzlxWJut50XUE3sjHg3YRYd5yE3RHpWc+cm9RBy93QibW7Xg7OPwNmmVkMi7chHCi5NNu36Ug6f9
	9w8wTLbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtdjx-0000000FnZ1-3ksC;
	Sat, 21 Feb 2026 03:33:09 +0000
Received: from mail-qv1-xf63.google.com ([2607:f8b0:4864:20::f63])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtdjv-0000000FnWP-1vc1
	for linux-nvme@lists.infradead.org;
	Sat, 21 Feb 2026 03:33:08 +0000
Received: by mail-qv1-xf63.google.com with SMTP id 6a1803df08f44-8954d10e62dso4935786d6.2
        for <linux-nvme@lists.infradead.org>; Fri, 20 Feb 2026 19:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771644786; x=1772249586; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYFSHEsFJdDOj3cQkRPFLn4/+IOAqySMBQqhkpK+Jyo=;
        b=X5gg2OLgMRyWe7LTLrh2H+4XFvXbtuA4ok+9NbZZ8ld3aKPRp1gMI2suGeBOqbOZxg
         FKxjzDtmhXJ+MgJTnlEV4F5ay/pmZHlL0YWEG7DUBD4y79mGz4LAlCtxKMlo0OW51Ukz
         rDAUjfuNbEGQwDR1cFKPDeGO7l/bO1gij9cPMJNlE2NcrHuX+b2WK/4bju7kZUNfqEim
         DpaoHllutASjNUIm9j9BEyHalqx9ZK7oo76RFThSbLVFB8sdZIJGgHamher9Mb/Yha/3
         0rKMmdD0RYUe7OdhImVyFGHpd35shVcTa4iA/Erh88n9hezXpaylz018d2RdNt972y8z
         IspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771644786; x=1772249586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eYFSHEsFJdDOj3cQkRPFLn4/+IOAqySMBQqhkpK+Jyo=;
        b=YPsS/i2N2lSRnENb5EMbQNAszIfPuzeyAjtKuPvIPvLa9C/QLnaN+fWlGZgRVQcQ5R
         YHo1uY8nhwULeRs6G6N1g7Rv8nPM2pvPcTe4HjnzA8JQ2i45nz9yT9yZ289mQFgjf8Rm
         aqA4YDAyc606MK0lYyKLk7v2q3rQhRbMGz+QTsqwk4pFr4EpgTnVqfjOU+KC05GCKgKz
         4Oqbd31t/1knEt03aiYCdcCKSNsIJ0DDYwujxwafjDj0Ax+ZsIslYzncunPcTQmXNAEA
         5Mh72ZIrJWlUHtVl8wFA6oa2krbAq1OzD4xnCvSYHuVl0xXqkGmPwhALoIMd8AsPFN7W
         O4CA==
X-Gm-Message-State: AOJu0YxxzZulX+UwaxXZOqdID1CjaRxb634nrzgu0Ifz12bLGWGgEA/i
	Cv0LJK2MFadr8H3qvNIj6MRkWRpLEH3340sb1tqxl9HPH5u0XDx3xhFLUfKnAHZ0fsLL50BfKXI
	OcMDSOY5bGigaKZFEV2MCURA0FY+ADJ+8MY9x
X-Gm-Gg: AZuq6aKUK1qVQTykfGKUelSkqa7AKTetLeqhSiVUejYyc7DgJjAkiMhTJsbq4u3gJaD
	uKqb2MjNYxJ6O9bpSKRGzAdsq5TQk3ICJccAWlNDK/TwT8uphvX6YxI1KjaT41a+u3c/Ka47S5X
	LamkQtJovWXpBLnutPN9+K1WU0fwQlXVJPF6XoR9ofY89KgKmvFvdM8Pn0tqtHdj6m5wEc4wmEb
	Yz74xnyFJmPvkzd3KJUyhMI7jKz/WV2ka/80JKaYABKUTZhqFwGZ6ke8fkjBr6EGs7P0nWb4GPG
	L1yodkYbvtwxpeotAjxnvReLfZC9k+LsUd7366XUpe+/kKpEwIz2NHu9GhscMVjc7TaY4pjrNN7
	r09TDKQno2rp/gp32QY8h4LnfRNpU/iN+Za6lhKzLPQUDxXaQZQYypA==
X-Received: by 2002:a05:6214:4f04:b0:896:fd66:a084 with SMTP id 6a1803df08f44-89979e1ebe5mr22124746d6.8.1771644786127;
        Fri, 20 Feb 2026 19:33:06 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8cb8d0c103csm18720085a.3.2026.02.20.19.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 19:33:06 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 71DA8340705;
	Fri, 20 Feb 2026 20:33:05 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 6D28DE427C8; Fri, 20 Feb 2026 20:33:05 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 2/7] nvme: fold nvme_config_discard() into nvme_update_disk_info()
Date: Fri, 20 Feb 2026 20:32:57 -0700
Message-ID: <20260221033302.1451669-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260221033302.1451669-1-csander@purestorage.com>
References: <20260221033302.1451669-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_193307_509630_651240AD 
X-CRM114-Status: GOOD (  14.54  )
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


