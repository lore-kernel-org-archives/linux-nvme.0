Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FF3D730AD
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2026 19:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YNpmXbw2grXDnIgg2ghLS/nTKNFvNfDaTGEvndg19+Q=; b=Fd7dDAc1SlKKjUaoaEENDlqAxc
	LqujCr3EDEF9h/61U8RjA19MwGQymY/IdHgkkh+O7HkLs9m9tK0/HzN71viSrr2UDeZD+fx5jxsW9
	aF4Qpq6KRTq4vPLpOqGu1f5+JPWk7j0f11DB5NyuQ/6NrWA+/LcNowylon4VAW0dlzYv0jMRxCEnE
	Lande34oCUJiZe7NQ5p+pumjCCP/wCgDo4hbFR01KbW9nHaExH8sDF5Pl/64n+v1Zu9XqOfQvAW4B
	vLKVYZlr8eVB6JHObv6BsH125Bb0uz6+HRdEJ+8VBKFviKhHenikfM96jXWzQd6276fiRx6LuR9Ql
	jVxaNl7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8kOU-00000002Ulw-2LEx;
	Fri, 03 Apr 2026 19:41:26 +0000
Received: from mail-pj1-x1062.google.com ([2607:f8b0:4864:20::1062])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8kOQ-00000002Uiu-3X1u
	for linux-nvme@lists.infradead.org;
	Fri, 03 Apr 2026 19:41:25 +0000
Received: by mail-pj1-x1062.google.com with SMTP id 98e67ed59e1d1-35d9b4f93f0so483668a91.3
        for <linux-nvme@lists.infradead.org>; Fri, 03 Apr 2026 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775245282; x=1775850082; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNpmXbw2grXDnIgg2ghLS/nTKNFvNfDaTGEvndg19+Q=;
        b=Vn8GDN07Futz++/m4AgwO+quQt92QR0xo9p/eHnTmYPRFQcTGuTgrwL7uLXpjB4XaT
         XcI2Thh4ng6UWnKYOCCeD7ydby6uablIXjmnXvPc5nQwbM5BE1wDWV9mHfZyeEoNMl7l
         TIb5QwCLIhz7GJ96UMZmN8vmZMXqHYxQs8cTCS1ZNR8lla/Z+Q0MPmnztQdkXj+rg4iC
         NF1VCfxfPVl2ZmEMoe7UMUf1rCVfO5mA8HmpEbo8HVVR6XMvgCXuWMFjJHIl19WdkLvf
         Xp2h5cESXGO7P7ouLdNIWV1tM8GxW8vDvcTLIaLKw8bxHNV/un8utn9ZPH2PnVMfZ1jk
         uIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775245282; x=1775850082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YNpmXbw2grXDnIgg2ghLS/nTKNFvNfDaTGEvndg19+Q=;
        b=m1aerlHzesdNgONbmEs72QKGxw21YMM8vFxWzz02MdEretVzutmgZI1Ez5LeS8VGDi
         /aOn0gdmMrt7v9sdYDEBumkafITKEZZwCzcqELFNrfd6rl6L+pMnL7AEnyA3IvH2wrdf
         EVnQjB5ioH8F1v/aMLaxdujTXAToHpxy6EldOByDx7j3Oy5qAP6+1gHE8UCydDHXZfFk
         zQP1emoWZDgEw1rhANdxtYC3atJSy/MsLYq1RJ35KCB3Uj5mHCT1Y890jAQeK10OZljh
         Is6R2Fy66GXyWwmfy+C+2LPbEXipnk88lmiB5K4YBeG18iV6sF2/YqgaduXg23unTxlt
         LUlw==
X-Forwarded-Encrypted: i=1; AJvYcCWhEq4wVaFoyxOsxAcgChQUKErOo7Yd0RI2J/vELtWy+YXzRsomwLpP4PxmjKM9/I/UTtloxXXSa7I9@lists.infradead.org
X-Gm-Message-State: AOJu0YxoZ/BXsPAaPj7fEgj7UsxQMSrEVDSrxtTuG0ZToO7j5XiSbZXr
	HcZMaHgTW3UG5cUojZCAr1s8A8lszD8qe0bctYvS+H20PSPQ5SHRMLjXYg2tl8AGZRVOPkqcnk5
	NyXvEE3X3dDomn9J4u6rOnsUda/SobY+pePPh7DLSMv2yrg4vkv5E
X-Gm-Gg: AeBDiesXPwdfZwyxCXqOKf2fZemCiQoGZCmnV0Scem6dcfqnnUpB2GfZvjJRXr5aKg0
	BFcY3GIA04cnfvjKCa3aigngtwHT8pjs3X5NOc40ay1KDkfPMneaea4U0QeHjUHJLolcVI3elRh
	OTAdqQdIVWXIefIGfUjW2yGofbFapPxfzLfAvhbcrY6NwA6OZ2TTzeltbeqHZRk41wcjklURbBl
	5XN8rad89MmGBGmh13yASw8+vgFIcH8tADiXxkqmq6UbOc/3KM0WJC8R/VPj6LfQNdU2wBIv4/t
	5Mzdn8uKC86CFJXrji6Lp1bL6hdhfYMBq1LXh23MdRvfa2o/7BWfB6sY8gjeMaWhcmFZjhUMTRM
	cUO/haY9g2hqTEsQtoG/+ZKe0gp0/DzDqtZW29/A=
X-Received: by 2002:a17:902:f70e:b0:2b0:ba60:7210 with SMTP id d9443c01a7336-2b28173d1f4mr25910015ad.1.1775245281579;
        Fri, 03 Apr 2026 12:41:21 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b27493545fsm4944455ad.54.2026.04.03.12.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:41:21 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D7FEE34084D;
	Fri,  3 Apr 2026 13:41:20 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id CE528E41AC2; Fri,  3 Apr 2026 13:41:20 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/6] block: use integrity interval instead of sector as seed
Date: Fri,  3 Apr 2026 13:41:05 -0600
Message-ID: <20260403194109.2255933-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260403194109.2255933-1-csander@purestorage.com>
References: <20260403194109.2255933-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_124122_894763_6DBDE070 
X-CRM114-Status: GOOD (  15.21  )
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

bio_integrity_setup_default() and blk_integrity_iterate() set the
integrity seed (initial reference tag) to the absolute address in the
block device in units of 512-byte sectors. The seed is correctly
incremented/decremented in units of integrity intervals in
bio_integrity_map_iter(), bio_integrity_advance(), and
blk_integrity_interval(). As a result, the ref tag written or read to a
particular integrity interval on a block device with integrity interval
size > 512 bytes varies with the starting offset of the read/write.

Convert the initial seed to units of integrity intervals so a consistent
ref tag is used for each integrity interval.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 3be91c4a3d09 ("block: Deprecate the use of the term sector in the context of block integrity")
Fixes: 63573e359d05 ("bio-integrity: Restore original iterator on verify stage")
---
 block/bio-integrity.c | 2 +-
 block/t10-pi.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index e79eaf047794..4be2cf649e54 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -104,11 +104,11 @@ void bio_integrity_free_buf(struct bio_integrity_payload *bip)
 void bio_integrity_setup_default(struct bio *bio)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 
-	bip_set_seed(bip, bio->bi_iter.bi_sector);
+	bip_set_seed(bip, bio_integrity_intervals(bi, bio->bi_iter.bi_sector));
 
 	if (bi->csum_type) {
 		bip->bip_flags |= BIP_CHECK_GUARD;
 		if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
 			bip->bip_flags |= BIP_IP_CHECKSUM;
diff --git a/block/t10-pi.c b/block/t10-pi.c
index a19b4e102a83..36475369cd16 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -315,11 +315,11 @@ static blk_status_t blk_integrity_iterate(struct bio *bio,
 		.bip = bip,
 		.bi = bi,
 		.data_iter = *data_iter,
 		.prot_iter = bip->bip_iter,
 		.interval_remaining = 1 << bi->interval_exp,
-		.seed = data_iter->bi_sector,
+		.seed = bio_integrity_intervals(bi, data_iter->bi_sector),
 		.csum = 0,
 	};
 	blk_status_t ret = BLK_STS_OK;
 
 	while (iter.data_iter.bi_size && ret == BLK_STS_OK) {
-- 
2.45.2


