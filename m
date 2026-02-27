Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A033310398AD
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 20:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ooHjh6HrTZHmSmxByDLdiCmY2zTnKYEXcZkNLfcMiWM=; b=Ny1QzMN4vI3x8Wea/KX+cevyyA
	xim3aQ/CWpbqPCUT/Gr9FTn26mQ1wXRWnNcjJwe9KGndqE0yYJyBohayx3nXqQ4+MGDLjCBPkxXCp
	YlbgWUkpSwD1WgBwUCIFuKb0Prq28Eh6D5wwpPEGycLsHOV8qZY0XCh+bEWi2ySzMIlO8kvn+sHuz
	NVoRdRktJKUp9gwwebLLWTQoduXMCqz0/y3DDlMD5+nQVvO69u0jYZVCprC1vwFgIyZrTL3Av2YUU
	MCIIAL/kNWWypxuWcQRF1o4D5/YGYFRhge9S9r9cxnONKlgVs64ncvdBDKc9jRNIldS9HMzMjF5os
	J+pXXK9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4Nd-000000096RW-43uM;
	Fri, 27 Feb 2026 20:24:09 +0000
Received: from mail-vk1-xa61.google.com ([2607:f8b0:4864:20::a61])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4NX-000000096OB-1bsf
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 20:24:05 +0000
Received: by mail-vk1-xa61.google.com with SMTP id 71dfb90a1353d-56a942e9ce6so159189e0c.0
        for <linux-nvme@lists.infradead.org>; Fri, 27 Feb 2026 12:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772223841; x=1772828641; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooHjh6HrTZHmSmxByDLdiCmY2zTnKYEXcZkNLfcMiWM=;
        b=NhLOpsB+NXw3Sk+3uWXx0ntMIcUt5ZzmqxNnHVHOFAizGTdZuvppgawWUMA8rEVVrz
         nZ40L52uqglPpVfMWlvvevDcWNwVAjdWyd1HV5EmjcCecCiRJGiMvufYcBoeR9GlM+KZ
         ObgEqtaB5ITj4ZaOE/YYUazevevDF93e5zOHWIJn//3oZJYhyzkAkqyDdBEkZ1FFusPc
         akmq0SIk3zlnUyqpxZSFV13nn9Ov3YAoBFKe2almBbCcXwXgldKad5NpNBSwcQu4wD2o
         ALPCMcR+mATBpgQNIfsofaNe21zvD01i7j5roWy47ajj5myjB+jL/wezAqkpsUjaPjk0
         69ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772223841; x=1772828641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ooHjh6HrTZHmSmxByDLdiCmY2zTnKYEXcZkNLfcMiWM=;
        b=iM1idRTdzmdNlBakxgSb/Cc1iQLoghG3EX9XvYbk1da5OeWjAH0VaSi8IZIbaBSwuq
         1erEftYGXQ8Pcu/+1dELL2f/IVldK7O3eOTeDNtux9EhvBm6E2wfCqPixbAj9JpW5x/O
         ccR7ODhRM4Nydz5M0beJ0HR8DT3jyAlkGGdyCSzSzXN/L9GqW7rpfVQ5JpqN6MZ/80Ho
         Q8KXE2uMlz3NIggfHT4mgDZevf362OsS0iZ1SiDnRThK8iVTa+Azd9BcSoNeqgEsbdhh
         RBjgF2bOGNncJZDD6tt86u2OUoj/re7wl2vG+2sTYJpfbV92q6Caf+qnbUjuV7T+KOek
         uC4A==
X-Gm-Message-State: AOJu0Yz2KDZ+zMJTp2N5X1UpYAnIxpsWRK5dmmIQBk7G/ry8gD5wxnXT
	dI7+OHq94aGhcPXkT848p8SbneK6Z7gTiqdiB1oOQhhIK7+M30tBoF1q4mwNJwz/DGVzrtznFy3
	91dQB36RXBOinuBInCKmWCu7W4c+aXQXbQzzB
X-Gm-Gg: ATEYQzxdMqNfhIuHnnQv+qyRsxfEMDLdpu7YrODGunQwUecHXlvQVAESN/8wrzUarz/
	FwxbxWpLK7BNRf9lBet7qfu/tr7qPk15hhsejb7nkZXyReABX2yvq3VVVxgJFK90VHNAU8ApqS7
	H3/9+JIodpVeRwawkrzS10AEMfvYdVFnyCwFSYpd3TNmFKhfvPOPHfb9Z9qTtuatkVPAmSICt6+
	wyJg/1+CMzfQRfdESsbC/PGa/IsAInJWgfQcHDgcn5bCbi1xlRni71X1PO+gPXDMe8nL89Z0uyQ
	otfVtbwONaZT3UydbJ+MccJ0jXpfUl5anRDxWCRq6wiR7j1/OEL+7X914dmJo0RIiHgyB/IlA9f
	7W2t1UUGsDO+sBGv7jqwzUjsc/xEAlDWMRiLCyZ6HpMBXJmtq0fhVOA==
X-Received: by 2002:a05:6123:2a:b0:566:fec7:2ac3 with SMTP id 71dfb90a1353d-56aa08c75camr916564e0c.0.1772223841453;
        Fri, 27 Feb 2026 12:24:01 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-56a9204c539sm697320e0c.8.2026.02.27.12.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 12:24:01 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B69293420BE;
	Fri, 27 Feb 2026 13:24:00 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B0F46E420D8; Fri, 27 Feb 2026 13:24:00 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v5 3/8] nvme: update nvme_id_ns OPTPERF constants
Date: Fri, 27 Feb 2026 13:23:48 -0700
Message-ID: <20260227202354.1012322-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260227202354.1012322-1-csander@purestorage.com>
References: <20260227202354.1012322-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_122403_424905_F2E830E8 
X-CRM114-Status: GOOD (  15.37  )
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

In NVMe verson 2.0 and below, OPTPERF comprises only bit 4 of NSFEAT in
the Identify Namespace structure. Since version 2.1, OPTPERF includes
both bits 4 and 5 of NSFEAT. Replace the NVME_NS_FEAT_IO_OPT constant
with NVME_NS_FEAT_OPTPERF_SHIFT, NVME_NS_FEAT_OPTPERF_MASK, and
NVME_NS_FEAT_OPTPERF_MASK_2_1, representing the first bit, pre-2.1 bit
width, and post-2.1 bit width of OPTPERF.

Update nvme_update_disk_info() to check both OPTPERF bits for
controllers that report version 2.1 or newer, as NPWG and NOWS are
supported even if only bit 5 is set.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/core.c | 8 +++++++-
 include/linux/nvme.h     | 6 +++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8dda2fe69789..bff6f26d7bcf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2062,10 +2062,11 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	struct nvme_ns_head *head = ns->head;
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	u32 bs = 1U << head->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt = 0;
 	bool valid = true;
+	u8 optperf;
 
 	/*
 	 * The block layer can't support LBA sizes larger than the page size
 	 * or smaller than a sector size yet, so catch this early and don't
 	 * allow block I/O.
@@ -2076,11 +2077,16 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	}
 
 	phys_bs = bs;
 	atomic_bs = nvme_configure_atomic_write(ns, id, lim, bs);
 
-	if (id->nsfeat & NVME_NS_FEAT_IO_OPT) {
+	optperf = id->nsfeat >> NVME_NS_FEAT_OPTPERF_SHIFT;
+	if (ctrl->vs >= NVME_VS(2, 1, 0))
+		optperf &= NVME_NS_FEAT_OPTPERF_MASK_2_1;
+	else
+		optperf &= NVME_NS_FEAT_OPTPERF_MASK;
+	if (optperf) {
 		/* NPWG = Namespace Preferred Write Granularity */
 		phys_bs = bs * (1 + le16_to_cpu(id->npwg));
 		/* NOWS = Namespace Optimal Write Size */
 		if (id->nows)
 			io_opt = bs * (1 + le16_to_cpu(id->nows));
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 1134e6bf2d5c..d840f5fe79fa 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -595,11 +595,15 @@ enum {
 };
 
 enum {
 	NVME_NS_FEAT_THIN	= 1 << 0,
 	NVME_NS_FEAT_ATOMICS	= 1 << 1,
-	NVME_NS_FEAT_IO_OPT	= 1 << 4,
+	NVME_NS_FEAT_OPTPERF_SHIFT = 4,
+	/* In NVMe version 2.0 and below, OPTPERF is only bit 4 of NSFEAT */
+	NVME_NS_FEAT_OPTPERF_MASK = 0x1,
+	/* Since version 2.1, OPTPERF is bits 4 and 5 of NSFEAT */
+	NVME_NS_FEAT_OPTPERF_MASK_2_1 = 0x3,
 	NVME_NS_ATTR_RO		= 1 << 0,
 	NVME_NS_FLBAS_LBA_MASK	= 0xf,
 	NVME_NS_FLBAS_LBA_UMASK	= 0x60,
 	NVME_NS_FLBAS_LBA_SHIFT	= 1,
 	NVME_NS_FLBAS_META_EXT	= 0x10,
-- 
2.45.2


