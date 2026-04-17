Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939F4F8E499
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 01:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i9pyvtNYah5iCr5GskErP9n/SMj5zNsqkI2O6P5JyAY=; b=Mio27Hif3xm0kmuTVPdr/cLshG
	ilHjZbIp1hZeuim7vHPsEURqJWVPiu1USsYqr4/LEv7jYvnLl4AEfX8FTDOuVvMm5SSu2kjW98fql
	ZeqoJvkj8Dpf74xMseWQqllfRxScycKc7ePMFM8CN+EYDpGJlFNtdzo8Yv4mZGljyUK3Ix6pA0EIS
	Ex6UZE5eg4XbTfAFu3in00lFXtTlhpD1Tmik25N49iS/R1OK1+MoCEuyGL6I4bR4k8G1aRPc71jYh
	XM9uIDy28bcMc+KVckKeRXIEXu20lSx+za/RuKT28ob6wen9nwb5OD0N4Az/yxQHGUMYI5PrY1K44
	lQ2jojBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDYSq-00000003IJF-1uUV;
	Fri, 17 Apr 2026 01:57:48 +0000
Received: from mail-pl1-x663.google.com ([2607:f8b0:4864:20::663])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDYSj-00000003IDC-2Poi
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 01:57:45 +0000
Received: by mail-pl1-x663.google.com with SMTP id d9443c01a7336-2b25314f060so20055ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 16 Apr 2026 18:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776391060; x=1776995860; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9pyvtNYah5iCr5GskErP9n/SMj5zNsqkI2O6P5JyAY=;
        b=eL24DK64KIVvgRrapoueRp/vsEy6pvxi1aLGoFAJQJJFmf413SFZmUlV1sYP7IWzG9
         jxFu2FeLDH6vOVqyW7rQdxYZhWgfyxZgvEL08DQjRwh9+rEhA5Kaj+Yebml0tn0nzNZn
         iGwRvSJa0WfEwABbuxK7l4DMz81iv9ule9tq+2FoqlV4LLXMYxG/Okr01zKPYiyoeLhf
         bX4x+KUDuZEn31bXVpSv1RAJGxJ5llnBLpme4gdshcbsJjOY4ezwLMl+EHLXgeQlwqsN
         2g0bQtZ9u1kTQugVA4qzMF5yJQoHva77hUPlX+gFTudt7i0q7LUtKFJpLO/gXTyzx8M2
         HEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776391060; x=1776995860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i9pyvtNYah5iCr5GskErP9n/SMj5zNsqkI2O6P5JyAY=;
        b=MsZabaBAvvHM7EJZTbz80ha30tIUypgfDonJoQAqFcBer5MO98SxVILIULzL7shXbB
         cnWQoH/Kpp/S8+J7lvlcXlRQg+ab5o8d+qD5idePKFx7VXVrVjtU0IEaIBn5F3cC12lo
         1Vyb6Vd8h00PtIc3nLELq/PJSMmDtxWB1rVTOSb3t1J2n9c7Ye1LhCyRA+bihpgd+QXU
         QItqjIcCeGNrp8fArFKs1gG1CPvSsBCjsa0t4qzkgtFWkqD6pfc9/iD1YQeL4uts3Y/U
         IKiiX/24xaOxdJmXF5mg5YExdlIlkyLbiHQExUOtXTV5z7urrN86fg7i82qSRbyQ+wPX
         2N4A==
X-Forwarded-Encrypted: i=1; AFNElJ+6OHyfTokQYm0ImO06Wr6kZoJ8AmX2TuRkS0Z2K4LrVdttl+GswkAwunjvjlRWGgFtpPWCgCZd/Z8G@lists.infradead.org
X-Gm-Message-State: AOJu0YxIF+M9Fo25p8OsRgUYW05XTas20sYVCmnpgraBYoG3MFslCMM8
	+PfJ4JWfacJnciPi0sUzp6KFZ87ISQi3hjdEmwFEjxSDlmp9w6ia7idTYF13xbMvcf2qMcqkgFd
	H99IM1TZasmTCUbTSF1gaytQ5S7HVQeQ5TgcNHtvL9tGVrIa5Q+28
X-Gm-Gg: AeBDietpLyjJJV4PcdFNou/wdt5kN0AaXwzdEyvQpcTLwJmXLZv7jZObhZIj+t8gb9K
	49GYOhNLYQRvJDLDjgZ4u8io+E2diH+XeSV59HGbYb4G2on9ydx5ajZOI3muF7sVVKiH2XrMG2y
	jCMVOkL5qFdWuAKYb0Qymy2P4CJKDw6vn5kkL8U0FDnqlNIq/IXefKgNYXN5k6Bb4QFvk6zVRLi
	MV8UAx1PrKVsuEibfvXjEXItFeYKhK/rI6AoILtwt5wtxonO8wJIzJsObAHZ16r9tBgnZBkE9Ws
	2rB28SEKKci1nvfjDHXWhc3Q38pO5wPvd/4+FKkJK+QRDQz+4Xcd6u7Vi+IUzUXX2Pe/dc93VAE
	D3YlVFTbcljY2juAzTkfyi/TMNASCooa7VDst8TD/FAOrSxXXwQ==
X-Received: by 2002:a17:903:3b88:b0:2b2:ac6f:104b with SMTP id d9443c01a7336-2b5f9e79f5bmr4284705ad.1.1776391060519;
        Thu, 16 Apr 2026 18:57:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b5faaf81b5sm203705ad.40.2026.04.16.18.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 18:57:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D6079340796;
	Thu, 16 Apr 2026 19:57:39 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D2633E406BE; Thu, 16 Apr 2026 19:57:39 -0600 (MDT)
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
Subject: [PATCH v3 1/6] block: use integrity interval instead of sector as seed
Date: Thu, 16 Apr 2026 19:57:27 -0600
Message-ID: <20260417015732.2692434-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260417015732.2692434-1-csander@purestorage.com>
References: <20260417015732.2692434-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_185741_617469_455A90A6 
X-CRM114-Status: GOOD (  15.13  )
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

Fixes: 3be91c4a3d09 ("block: Deprecate the use of the term sector in the context of block integrity")
Fixes: 63573e359d05 ("bio-integrity: Restore original iterator on verify stage")
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c | 3 ++-
 block/t10-pi.c        | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index e79eaf047794..3ad6a6799f17 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -103,12 +103,13 @@ void bio_integrity_free_buf(struct bio_integrity_payload *bip)
 
 void bio_integrity_setup_default(struct bio *bio)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
+	u64 seed = bio->bi_iter.bi_sector >> (bi->interval_exp - SECTOR_SHIFT);
 
-	bip_set_seed(bip, bio->bi_iter.bi_sector);
+	bip_set_seed(bip, seed);
 
 	if (bi->csum_type) {
 		bip->bip_flags |= BIP_CHECK_GUARD;
 		if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
 			bip->bip_flags |= BIP_IP_CHECKSUM;
diff --git a/block/t10-pi.c b/block/t10-pi.c
index a19b4e102a83..e58d5eb6cefb 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -308,18 +308,19 @@ static blk_status_t blk_integrity_iterate(struct bio *bio,
 					  struct bvec_iter *data_iter,
 					  bool verify)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
+	u64 seed = data_iter->bi_sector >> (bi->interval_exp - SECTOR_SHIFT);
 	struct blk_integrity_iter iter = {
 		.bio = bio,
 		.bip = bip,
 		.bi = bi,
 		.data_iter = *data_iter,
 		.prot_iter = bip->bip_iter,
 		.interval_remaining = 1 << bi->interval_exp,
-		.seed = data_iter->bi_sector,
+		.seed = seed,
 		.csum = 0,
 	};
 	blk_status_t ret = BLK_STS_OK;
 
 	while (iter.data_iter.bi_size && ret == BLK_STS_OK) {
-- 
2.45.2


