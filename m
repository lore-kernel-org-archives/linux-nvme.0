Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CF7F433CD
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 00:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UbLFjrQgSq+vo/irY8puWuag67WZ2r6Vk4eT1HQFu+k=; b=kkjJGCnhtNYbYrFaCS1cbVpQuy
	NQeYE1z6Rv773CHornnM12sd1E2vEe5JmNTpiSTY1J4U6AvJpGdQLMRKU/LOArvCiEFKR3CgHSBxY
	AKMuJPZr9VowKeywAWJ2cPegBNN5PpOggVL0/2MxXiOGwxRS3W84M7FY/kr7Ej3UuMlAoZX2wzj8d
	VljZUpXzS3Hkp3VKYAzPkxyQYQsdXzMG1hmZ9tYZMNM3Caf5mSoYV5AhyzKjueSnnSmhqLZd2SVUg
	Rnlg0WhYTssw6hs5LjSk5ok8p5KyOMO0QfIq8sFd6PdhKFoSKHDxu6k+Kt/FnxZ4P2F5Be+/3mk/O
	bQb9/XMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDAVP-00000001ngw-3YIv;
	Thu, 16 Apr 2026 00:22:51 +0000
Received: from mail-pj1-x1062.google.com ([2607:f8b0:4864:20::1062])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDAVM-00000001neT-13rG
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 00:22:50 +0000
Received: by mail-pj1-x1062.google.com with SMTP id 98e67ed59e1d1-35e4617924eso811831a91.1
        for <linux-nvme@lists.infradead.org>; Wed, 15 Apr 2026 17:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776298967; x=1776903767; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbLFjrQgSq+vo/irY8puWuag67WZ2r6Vk4eT1HQFu+k=;
        b=Mrcq6J3nFbsVteLyHdumBXN4AN3rkRdGA/C100NSGdR9KM6KZFu6llb/X23/RwgyQS
         dWyJQuNoIutW6wRk8mmpvhE28Bd5/mF098tKcZwy89/OgT63pn4LrujBK79JcCR7i5Sw
         wlkdWbeGQBM8TuyjYFhskAVWekagNRpo3Yzmqv9GjehRga0RQ+37KCmCVfA+dtr43lLb
         EeUK6mcnLc+I3J372sj3ReNTRpjWQQoMUAZ58UMt3fD8wYlx1V8vX/G7iSsC7TsqNDNe
         JhAzyYNcxismvFuNDApA2iEds57yQ3M7kxXNBSjtXhC4c8rWVTAbYvSVuPI4B3wxgg+K
         wvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776298967; x=1776903767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UbLFjrQgSq+vo/irY8puWuag67WZ2r6Vk4eT1HQFu+k=;
        b=hhVGfGMICOldacF93tAsfvZ4GXdgc/I80mrmqURvRx/6D2vmGgBRudUxNAI6VB4FFD
         3pQLeumRmcn+GeeIb5EWCcFxSPAAuwvZPe9zXPuGbYmW3RahzMfhdyMrzlJsHdLBqvXh
         CG7/xVDQRXA2D/dO20Tq9t5LFuT2B3nHkvBUxeUb7q+kfMbn92LeIKYuad1BLaJHy005
         Hp5VFrMzdEbGorMERp4bk4nQDAAY9GkCllzRr8PGLG84ZI3WzxCqFaqrGA/2w5U+3bSY
         upF5vdsjHv1aie/rzo5c2DUez7wOKc5nZA5qpKu1LELUcLL1UscezcpeoVTSnl9e5sTC
         aamQ==
X-Forwarded-Encrypted: i=1; AFNElJ+EMJGdx/DpkWF0aHtxWfaUPyclvNJeSNGopOxuwh0ewKAjmx5+X18UaNBlZAcCkMMWoFpWy9W+9V8A@lists.infradead.org
X-Gm-Message-State: AOJu0Ywg6ou12FUt2Y4UxySHV4LREi2V0dmQaoFyqEu2H44xni2UI3pw
	WITYMBCK5laL0tcEBvzQFVM83ivuPSCQ1HvcWu6ZWhFj5l5MF2Et8yfuRHGrezL0k5c7ayv3Vqx
	mplHLTE8ED9K9kKaQreCkrksY/ANrW9LLnQVjb8XiKFynO228z+c2
X-Gm-Gg: AeBDiesBZVEmkgJLh6mN7rJ7jM4a9HI1xiY82O9BB9KmhyE3LnSlwBhpmuEvLY4CDmw
	uMB57cjhu+BAsfSO0UrAqbZqrdk9BFJt9ikyaxoiTOGoAen0H5rf87MtO6mXdG3yKZk7MwIVZ73
	y2KWC5G23gOqBQWcPLbSq8hFHtxaADzMv/c4SWyU8oIS3N7aiDO+2pgh+4fYK+jd14PK+WpsxC/
	1EIZhFaKrzQUN8Ow1NHlmDZDHftILGK9effIeTpz924lY53jVcjLajUefuUaDDK8TK9znUXqXxO
	IPW3G77OklRbw04XfoiP2kLAVrUG0dTENkOuLFcB188bFIiGJuORv7jbHYejNYZFhBDncjcO8CK
	etSHHOMQM6Fvp6uDc90/QxzDXXvKxD8SQZ4K1g+pR3VRQxY10sg==
X-Received: by 2002:a17:90b:1850:b0:35e:596b:8a3 with SMTP id 98e67ed59e1d1-361333cbb8amr152191a91.8.1776298966715;
        Wed, 15 Apr 2026 17:22:46 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-36132c7b9a8sm25551a91.1.2026.04.15.17.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 17:22:46 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 095613422C2;
	Wed, 15 Apr 2026 18:22:46 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id F2DEDE41B93; Wed, 15 Apr 2026 18:22:45 -0600 (MDT)
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
Subject: [PATCH v2 1/6] block: use integrity interval instead of sector as seed
Date: Wed, 15 Apr 2026 18:22:09 -0600
Message-ID: <20260416002214.2048150-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260416002214.2048150-1-csander@purestorage.com>
References: <20260416002214.2048150-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_172248_333616_50B0F6CB 
X-CRM114-Status: GOOD (  14.43  )
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


