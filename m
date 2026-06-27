Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6CEC43327
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jun 2026 05:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jnhzn4PnyE6/ck4Kf6jRx3+nK+/tFuTU2ywEa+RZ3LI=; b=OH8xe7kGejRuECmKCW971OFmK2
	BtkIDZNcjYh4eKD37UTI5IaE7S/YfcUSoFXFX/oNGs78IuuYljeBqz2YkGs+epZblDqbR/YYp3/qX
	26yzQTOtyWpS/lI5T07/X+GXHBfJrrhuQaDwNBbb7VHdEP072L8DML0zuNgUhxz9m/Yp+n6iD9RUQ
	h1BzVAgoYUJonolIFjyaupCDFf2nF9ITmAdHURfW/AzONgt8EACj9kJHTVbuby4HMntx/RfthM/IF
	t+syKAXmFNnBacRHbba+O4nDO65SilOb/hznsiGnGU9hHC8oFuBoRKIOVt6KYITSpZIMc5+qc7aWb
	E5gTps1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdLoZ-0000000CA5U-1JZN;
	Sat, 27 Jun 2026 05:42:51 +0000
Received: from mail-pl1-x665.google.com ([2607:f8b0:4864:20::665])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdLoW-0000000CA4C-1nhs
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jun 2026 05:42:50 +0000
Received: by mail-pl1-x665.google.com with SMTP id d9443c01a7336-2c7e8df1d28so1477995ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2026 22:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782538967; x=1783143767; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jnhzn4PnyE6/ck4Kf6jRx3+nK+/tFuTU2ywEa+RZ3LI=;
        b=RTjeSOMUmws0C0iJOBn1GxGbijsZLxdyNxr5vB5+rKhidhHXFJ1meUusDryks+WPGO
         bksnlGs1y5vjcgim1fjQ9lUybbx0iTbaQpKFoi73HFf9XqacRk1oxCfdcgu92XU371gh
         1Iba2hCX7pWZbbjrerNRR6wbrCIJ55QdjpGwlXID3dH0y3CC0xC/8smYBvAlLz61o8ur
         /A/W104UlO5QHFqRFg8PDlOOUPBK+5h4EjcP6wcA3ooNeK0OzWqWQYiC/7LdCJ65MDS9
         cvjNZhuQ5zy2I3Z5ZJ/ovI88sepKnJX9vPL1ZpyL6lD+uINInCRd+mSBE8FXQuVKpmBD
         ztaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782538967; x=1783143767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jnhzn4PnyE6/ck4Kf6jRx3+nK+/tFuTU2ywEa+RZ3LI=;
        b=Xt+3TbSHqdlijFGVuNFHNYkuMck63xBjT0wKXPRJakmrkenXuNkOLoPVyNcqITqj3T
         0vyKlhRXQ5XcwGUtOJeRA2R2cMHMf5K7Nc6fBWWkrXa65lBOC0BhOPMuy2cMisVAhJ9k
         1V1Dye11NDIbVO+4lAC1gc0CUFlp1Jvw/tGgTLIsXKvpbkZeT29luh/KPBfEYJQsv8Lf
         QANZQWVFh+NUSi6X9E/Z3nn3eKqXGpK8qxGry1B9J+RGj/eLFD/mtHmzlCuIdwx8tnZL
         qOMGGc1WItVLd01KntkFB0mBfgRyl5TS1LbxNl/KFyVIo5HqeMZ9U3G8PBh5Zz9QDAte
         u2Eg==
X-Forwarded-Encrypted: i=1; AHgh+RpUsLHq6as3UiCMwes+ox4tJnZ9pal7f9VTkwzmDyDdZJ2kYsKQA4F6DahfS98pDkdZCyVolyS4P/UQ@lists.infradead.org
X-Gm-Message-State: AOJu0Yzz4Qmwh+3uh/3jZ6kH8wfGTUX11qg3b7UOTE36h+O2J1zqOO0d
	QihG1zmwuclArTXJ4CheYtBxhoNLYfidA1Zi6mHJ3MdTt1opYFobPhCtacQeQZQo4P4sgMJn3Ma
	tNvab5SeaoC8jhB/3Pkk2JAROBXlbFjJIUffuUKuVakZX+lIl2rn/
X-Gm-Gg: AfdE7cnEZR1QzP5C82lxTBo6chRPctBAI2zds4kTi+VI9yoBqtk20p4yKwhZcbH1AYW
	NUIRMf784sXYnsMdfPEk2HVFhI5whMXhn43l7k7caw4kbNlJnvKixk+nHqc+ilqh9A4mcOr5PXF
	l9PSN8K71nVKw6ReBonusSt6El9HKQuo1O8TsAYKx28QBTh+Lv5SwMC290CbrwebpgrC6iteUEx
	C6R656zPdxCsLXFGRdlHkiA1QiYnx3YfHpXwTupjANaqtim2oNU36avsQtmN4HqQHQARRzOU0Cw
	8p5xi50YrnoFi36jf0jAGgxsORJFKyiBDIzHQm9OJIBQbxzro3B2zAgX6QmDnLonwPborOec5vT
	qiktqU9OcLpulWOWLIrnYCdcP/t/e
X-Received: by 2002:a17:903:1c2:b0:2bf:2e93:c626 with SMTP id d9443c01a7336-2c7fc8a89c4mr47071505ad.5.1782538966883;
        Fri, 26 Jun 2026 22:42:46 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c7f63977fbsm7067815ad.49.2026.06.26.22.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 22:42:46 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 3E13A40278;
	Fri, 26 Jun 2026 23:42:46 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3B27EE40712; Fri, 26 Jun 2026 23:42:46 -0600 (MDT)
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
Subject: [PATCH v4 1/5] block: use integrity interval instead of sector as seed
Date: Fri, 26 Jun 2026 23:42:16 -0600
Message-ID: <20260627054220.2174166-2-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260627054220.2174166-1-csander@purestorage.com>
References: <20260627054220.2174166-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_224248_524123_F5EC5E44 
X-CRM114-Status: GOOD (  17.24  )
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
block device in units of 512-byte sectors. However, Type 1 and Type 2
ref tags are actually the least significant bits of the integrity
interval number. On devices with integrity interval size > 512 bytes,
the ref tag seed thus isn't the correct initial ref tag. The ref tag
seed is correctly incremented/decremented in units of integrity
intervals in bio_integrity_map_iter(), bio_integrity_advance(), and
blk_integrity_interval().

For REQ_OP_{WRITE,READ}, blk_integrity_{prepare,complete}() covers up
this ref tag seed discrepancy by adding/subtracting the difference
between the initial integrity interval and ref tag values to/from each
ref tag in the protection information. However, REQ_OP_ZONE_APPEND can
also carry PI but doesn't go through blk_integrity_prepare() because the
final data location on the zoned block device isn't known until the
operation completes. As a result, the REQ_OP_ZONE_APPEND PI ref tags
start from the ref tag seed, which isn't in integrity interval units.
Subsequent reads of the appended blocks will fail to remap the ref tags
from the expected integrity interval numbers to sector numbers.

Additionally, NVMe and many SCSI transports support offloading ref tag
remapping to the device by specifying the expected initial ref tag in
the command. The kernel doesn't currently take advantage of this, always
remapping ref tags in software for reads and writes and setting the
expected initial ref tag to the integrity interval. Setting the ref tag
seed in units of integrity intervals would be a prerequisite to allowing
the kernel to skip the software remapping and pass the ref tag seed as
the expected initial ref tag in the command.

So compute the ref tag seed in units of integrity intervals instead of
sectors to avoid relying on ref tag remapping for the conversion.

Fixes: 0512a75b98f8 ("block: Introduce REQ_OP_ZONE_APPEND")
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c | 3 ++-
 block/t10-pi.c        | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index b23e2434d80c..d20f9002c7c9 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -102,12 +102,13 @@ void bio_integrity_free_buf(struct bio_integrity_payload *bip)
 
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
2.54.0


