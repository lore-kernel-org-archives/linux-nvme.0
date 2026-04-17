Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B06F8E4A0
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 01:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zj1lF3dU8n4YC5fdjZZVtRHMdHV4skYCpsqVKv3fQsI=; b=Wio7wN25cJu4rEOtMrHPUDVXtw
	CF/SqSpu3wVpGktE4xFcFG+n/LhSYBGMJJbyCRLcvKpJ53buS9cpxUcM4YeOKA1vkHU960ayYOtg+
	b3GEmfoGjiN/miaS7QGpOGx8k8LkI54E5BdvtXqjoVkIycXch+7K349kKixU9Ex3T4mvILJX5+YE9
	VpGPOdRpQlud1Oqxa59pmfT17NA4vjdaOP7zckTxQvHktV5XqzfTbD8akiL1XvCvWSv/sdD9qoVU6
	WHSGgPfcTh+UKMLbpX3I7dp5V7hl89KyGN0eGp4BQBYqf04DwmKyxuKVAPRmryogWes8WlSpguSer
	MTd/527g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDYSn-00000003IFl-1nZa;
	Fri, 17 Apr 2026 01:57:45 +0000
Received: from mail-pj1-x1061.google.com ([2607:f8b0:4864:20::1061])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDYSj-00000003IDE-2yqV
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 01:57:43 +0000
Received: by mail-pj1-x1061.google.com with SMTP id 98e67ed59e1d1-35daa02ea08so14261a91.2
        for <linux-nvme@lists.infradead.org>; Thu, 16 Apr 2026 18:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776391061; x=1776995861; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zj1lF3dU8n4YC5fdjZZVtRHMdHV4skYCpsqVKv3fQsI=;
        b=PhOh21aHiKmfXvBB1OiRznCZq1u84TYfThquUJnZ7ba6gLVcJrTWHhDHNNLCktB0MJ
         I1wEiZ20R5ollKzP3P0kR8RdsnaQ6CIB+lWu3miF+KgZxza19AuJowCZnw5gmDQF94kH
         LBkPRR64yU4R3mcBwH7wpmQw+fITQtgs1gA6fDnEz2l7U4y7mGCq4oFtYBKZ4F7vbeLg
         gCfQ5E2wdyTUd3BiY7VSwc9UGpHqVr3+THMToRQvddMFi7eA/36tdIZto6H6muhz74dU
         4Se56Xec+2lrY9HHb/Pcf6dsOtcNJZwOjCKgneFABGMMsixhhfOHVk46JI2grRfliLrx
         ZduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776391061; x=1776995861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zj1lF3dU8n4YC5fdjZZVtRHMdHV4skYCpsqVKv3fQsI=;
        b=gnj3o/DxvbpBlmmLIeH0RdV/p1hAxcsojdT4skC+El55zYKHdPxAAH57UIpcbaDewu
         3Xojz3vLM4Cm/Lp6qeMAJgrhLeQjT/cF6NrcobLMd2n9J5VA8d5IxB1xqjqt+CBVzjIr
         isR3ovCUI18d/n05H7O8JpLYVktWhBbEIMfsfOzmQcklF2dPKr4b29bET+4RJ0d3jUJT
         ijlo1SiGaQxys4C6sq3rrpJlBcLWqnKXcFyV8nX+57t4aPLrDTsQ2cTRGKGTHeGo9BWL
         0IyqIcsLgQXPJSafQu3wNkgWdtKqRaN/x6fS7jEJgMiGgBgWnEJ2iqQWaiLU0cylDVci
         78Wg==
X-Forwarded-Encrypted: i=1; AFNElJ+gKnVtJvR+k2EAngLVV6UY1HoIQbeTyXfDZECGyIp1wqSzdb9RV1RWzKzlgSqGZ/uH8VWLZ4BcLGIF@lists.infradead.org
X-Gm-Message-State: AOJu0Yw0z1EUuu0GVa7i35+REmLnNuY1srpe5yidTZc20dlUvj1obdlT
	yX8eNPUV8YN+S+MRXsR6DfDg/IuLrp9UlYnbWc0685CsgN81U0yuSc1xOYKrMYLCo3zsQX1pslv
	yXY+D6z9/XgnF1RVgnLECRSbWPlliaql1G68mZdeDslpcH7UJILnq
X-Gm-Gg: AeBDievNWFc4CgRNF0D2ettyjoWo7iB8vKORVxGoMXTyMMwkovsQpefuvuzUxyDQizK
	enb1zcZsEYPH3z6tFlgzEzr8T+DVyVy6qmaKwfwmAqzwRUs8zowoGNwXDZj5wg1kwZ6PEVjCeek
	BLffFP+7O3KNNBXxwAsYEva6ov+/CVgZrJAScHhNPUI+Vyibn9ev3HktaM8Rb9QZbOT0f4lsTMz
	6YmG3sGVBo4zqvFeO1DPOkUVYE6hgX0QZrJO/8YVYng1vztwxjx3cG6Yu3de3imbKk7x/ji2vNo
	BDNwZcrmNy9Ksp+0ERGdQPhZziAg1g5OMoRG+CMrKAI0hHJavOfhPbvHcWYEEjSlvEynQ+xnDXm
	K6ctY/2a5vevGR160Ojqi8cEKlnjrgtQVDQYcU4uCRjgMN8rslQ==
X-Received: by 2002:a17:903:3dd2:b0:2b2:57a0:9c08 with SMTP id d9443c01a7336-2b5f9f7bc49mr2795455ad.4.1776391060723;
        Thu, 16 Apr 2026 18:57:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b5faae2378sm215195ad.25.2026.04.16.18.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 18:57:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0333F340B52;
	Thu, 16 Apr 2026 19:57:40 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id F3652E406BE; Thu, 16 Apr 2026 19:57:39 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 2/6] bio-integrity-fs: pass data iter to bio_integrity_verify()
Date: Thu, 16 Apr 2026 19:57:28 -0600
Message-ID: <20260417015732.2692434-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260417015732.2692434-1-csander@purestorage.com>
References: <20260417015732.2692434-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_185741_750073_2DADA365 
X-CRM114-Status: GOOD (  14.73  )
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

bio_integrity_verify() expects the passed struct bvec_iter to be an
iterator over bio data, not integrity. So construct a separate data
bvec_iter without the bio_integrity_bytes() conversion and pass it to
bio_integrity_verify() instead of bip_iter.

Fixes: 0bde8a12b554 ("block: add fs_bio_integrity helpers")
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity-fs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
index acb1e5f270d2..0daa42d9ead7 100644
--- a/block/bio-integrity-fs.c
+++ b/block/bio-integrity-fs.c
@@ -53,21 +53,25 @@ EXPORT_SYMBOL_GPL(fs_bio_integrity_generate);
 
 int fs_bio_integrity_verify(struct bio *bio, sector_t sector, unsigned int size)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
+	struct bvec_iter data_iter = {
+		.bi_sector	= sector,
+		.bi_size	= size,
+	};
 
 	/*
 	 * Reinitialize bip->bip_iter.
 	 *
 	 * This is for use in the submitter after the driver is done with the
 	 * bio.  Requires the submitter to remember the sector and the size.
 	 */
 	memset(&bip->bip_iter, 0, sizeof(bip->bip_iter));
 	bip->bip_iter.bi_sector = sector;
 	bip->bip_iter.bi_size = bio_integrity_bytes(bi, size >> SECTOR_SHIFT);
-	return blk_status_to_errno(bio_integrity_verify(bio, &bip->bip_iter));
+	return blk_status_to_errno(bio_integrity_verify(bio, &data_iter));
 }
 
 static int __init fs_bio_integrity_init(void)
 {
 	fs_bio_integrity_cache = kmem_cache_create("fs_bio_integrity",
-- 
2.45.2


