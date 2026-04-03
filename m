Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE330E85368
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2026 19:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i7Uy8gUL8icrsg5BG6MoYGthlOT8yOCeEWU7Db5146I=; b=piTvaUBppBGNnn/KqslxQPWNMC
	Hdmlz4RaEIP1M36mklImOguX2077EWbjv4fKgn4oM8OaELT7hH0pETRwlKbzA/91vcsVjmy6WAhnf
	4z5S3q8YGCSI2EVJ7UCNqx/N4jFXyBe7ii1I4eGMdMiqz7CyfMK/X+2NODFRA1oOszAZTUJopJ2uJ
	l29CqfYHQwhsy96QaQtKd4K1NYIcvKn0fm/lHpQkV4NlmWZzSIENFlUPv8ZLuTfsqZh1mWDIYiqff
	/zkJ7DTsLY/NsvvzNtKwzn/4vo4T8tMuWBohN/D6N08NsJzMz59QbUPO/Jhyeqpxc7KHyBcB3N+7e
	ehan2mGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8kOU-00000002Um3-3kJ5;
	Fri, 03 Apr 2026 19:41:26 +0000
Received: from mail-dy1-x1363.google.com ([2607:f8b0:4864:20::1363])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8kOR-00000002Ujk-1AJA
	for linux-nvme@lists.infradead.org;
	Fri, 03 Apr 2026 19:41:25 +0000
Received: by mail-dy1-x1363.google.com with SMTP id 5a478bee46e88-2bda3b4318dso168438eec.1
        for <linux-nvme@lists.infradead.org>; Fri, 03 Apr 2026 12:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775245282; x=1775850082; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7Uy8gUL8icrsg5BG6MoYGthlOT8yOCeEWU7Db5146I=;
        b=QhEjAQz3eKFL2Bd3ZABgezBWNi9ZojSDZqNnlJd3W217xCokJY1yGlxZcFhvhTUgIB
         lnA4rnA2HaPs0fNLToi+YBnZqaxGn3okOL4/Dzr0quwDXImWvn+9RbX3q09N55qNMkH2
         RxjBswZXg5XeqaoFxF52mkHOOPmUTQ78jAAlzWcNLlu2hqqgRyuZLP+NFuCs2Py2MUlx
         Cfvv0Z1aNAELOvjNW4LmBRU4+i0ihrixDTqo3BE2SbybvgW3ut9Qji8VvgWxwtsFX+iK
         F8Lnqwu07IhabVCP4XaGP2orXLOf4pCoYfLiNRZZcSH01DCdwwqkGnWsuso/x8/uh8Zi
         gf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775245282; x=1775850082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i7Uy8gUL8icrsg5BG6MoYGthlOT8yOCeEWU7Db5146I=;
        b=kN2D+kWuHG4rEQ80mfYiPE1R6OKZ9lnVdJJgM2XTp2i4K+zonpSmf/kQfY4sGJVVVK
         Y00zA1WqdabkzSCTgXxTOy+bXp3ij2TvbxRM9JzEdFxDzBEGPgGbARwG5ELXGIZmynjv
         7o3Z7olgJagj9mlrBcaU1ASovDP22KHhWKZmPvIJIUODH3s1dEHUcAtiJp5Z+BVUj3pc
         EQDSH9cLWSkhNEox70zt4N38zl74xPbBBQmhuXJWKCUGxnCJCgDN5G9xre5TWTF1n2M1
         WXodShsOFG9Q8qLxRvMhkVANiOmYTjd1QkrlbHD7tjddP31d/6SFt4s/fIHw2Uo+HGYE
         fWRg==
X-Forwarded-Encrypted: i=1; AJvYcCV4tPXSWpmHSAFaCONqWRvCJjjzOcXAo+w5UuzypN63Q4DRjuJn71i+NxYsdco/81r10tw15RVqYkPQ@lists.infradead.org
X-Gm-Message-State: AOJu0Yw89szbOGl7XTSjD3XGT4isS+/+ewhGrmpYSIk76bkXE1GRHvUL
	8fDeQ3iXr/StO77Jg2yG0aE9HTVheV92xsntT4P7cFlVDz6T6CPSj8qWzjjfAUdeu5lwdPbuO4K
	e9J+4qv99BJrMPicHOhfTuaOPMEfQ6nbe5zbW
X-Gm-Gg: AeBDieuGk4/KadW/iGoMnYBHH5UDsywTreRW0uOJUeqSmXg9h2OpyD7ehkStJbPjhvt
	mnQ2dt0KF4tebSx/OMZXrGpoQDNn/VZcIM8tEWOCYGKL76i95ue35qHwTzFck04gAYf2wBv6qZ4
	LwJ/gFvYIQoKuqnswIKidMF+PD4P/xq8239HmCGPedgmOMwdY31z9odbdXeGeSwfheH+wqmic0c
	zh//w0CLCbvxQj/QogbdAUBpWa3pZgh9J6A8012UatBStpkNJ9NotuA7sQHJBvl/p2Y9JKE5LJh
	Z39/U3qLjDh9DARMmmb36kQl6jNN4VdLqIY4+M+LBoaxfTF5Pc1ky9O3Qv0afTFbvskZFez6zSi
	YpqisT0ciu9jFKqv+YS0k4mTVv03PCX0HXTizTzGXy5xQAPm4AMtopg==
X-Received: by 2002:a05:7301:6093:b0:2c0:c55c:156f with SMTP id 5a478bee46e88-2cbfbc82969mr870935eec.4.1775245282274;
        Fri, 03 Apr 2026 12:41:22 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2cb61750eb8sm339741eec.29.2026.04.03.12.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:41:22 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7623D34014E;
	Fri,  3 Apr 2026 13:41:21 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 6CCCEE41AC2; Fri,  3 Apr 2026 13:41:21 -0600 (MDT)
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
Subject: [PATCH 6/6] target: use bio_integrity_intervals() helper
Date: Fri,  3 Apr 2026 13:41:09 -0600
Message-ID: <20260403194109.2255933-7-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260403194109.2255933-1-csander@purestorage.com>
References: <20260403194109.2255933-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_124123_337637_830A3C64 
X-CRM114-Status: GOOD (  13.79  )
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

Use bio_integrity_intervals() to convert bio->bi_iter.bi_sector to
integrity intervals to reduce code duplication. Make the same change in
the nvmet code that appears to have been copied from the target code.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/target/io-cmd-bdev.c   | 3 +--
 drivers/target/target_core_iblock.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index f2d9e8901df4..dcf273360015 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -218,12 +218,11 @@ static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
 		pr_err("Unable to allocate bio_integrity_payload\n");
 		return PTR_ERR(bip);
 	}
 
 	/* virtual start sector must be in integrity interval units */
-	bip_set_seed(bip, bio->bi_iter.bi_sector >>
-		     (bi->interval_exp - SECTOR_SHIFT));
+	bip_set_seed(bip, bio_integrity_intervals(bi, bio->bi_iter.bi_sector));
 
 	resid = bio_integrity_bytes(bi, bio_sectors(bio));
 	while (resid > 0 && sg_miter_next(miter)) {
 		len = min_t(size_t, miter->length, resid);
 		rc = bio_integrity_add_page(bio, miter->page, len,
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 1087d1d17c36..434ef2b0b120 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -706,12 +706,11 @@ iblock_alloc_bip(struct se_cmd *cmd, struct bio *bio,
 		pr_err("Unable to allocate bio_integrity_payload\n");
 		return PTR_ERR(bip);
 	}
 
 	/* virtual start sector must be in integrity interval units */
-	bip_set_seed(bip, bio->bi_iter.bi_sector >>
-				  (bi->interval_exp - SECTOR_SHIFT));
+	bip_set_seed(bip, bio_integrity_intervals(bi, bio->bi_iter.bi_sector));
 
 	pr_debug("IBLOCK BIP Size: %u Sector: %llu\n", bip->bip_iter.bi_size,
 		 (unsigned long long)bip->bip_iter.bi_sector);
 
 	resid = bio_integrity_bytes(bi, bio_sectors(bio));
-- 
2.45.2


