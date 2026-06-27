Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0F8C43602
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jun 2026 05:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hJetzVCmipfxkIYaKGKmSSwqDl0tCRIuzU++fp89zak=; b=4buxhjejFVfUv040g2orgXMgkT
	D1YLSN9GB0P2fgHzbWzvzxsSn7X+6awSQWKQQBUz04Wm2Ei9r2tsJfbWDtZ7zPpgOOXPbqE7UDWdR
	/16EplR3kwk2jgOC1GL5IvdKuY7yxft+NXTgbVPpo3aqoDSufuMkEWKNhEXNne4ZLDMAVwtFu72FR
	7PWw6i3PCpE5NRk59Xe7Tlt3HAmAleaFzKgIiknClEBtbrc0AfeGaoDgDzlSupJlG3DgvxMnotw9L
	1JgPe9QR7lVIwDw6Rk+NUop5GmgN8dzvMdypGpONUU3uP9kZ30ChNZKKgO7+Ys9qOmG+GTZsLPLt+
	318aHe7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdLob-0000000CA73-3H76;
	Sat, 27 Jun 2026 05:42:53 +0000
Received: from mail-pj1-x1062.google.com ([2607:f8b0:4864:20::1062])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdLoW-0000000CA4D-2cxJ
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jun 2026 05:42:51 +0000
Received: by mail-pj1-x1062.google.com with SMTP id 98e67ed59e1d1-37c9d82cd8bso130296a91.1
        for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2026 22:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782538968; x=1783143768; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hJetzVCmipfxkIYaKGKmSSwqDl0tCRIuzU++fp89zak=;
        b=V0WUveC5eYGf+zm8TJJ/SkCNiz9vHGvoNwqR3NfaRInoZBzdMiLSiSDdgvq4MEEcRv
         nxoHuTBV62vBVnETPGE/b0o3Wnj/GZvOFV5jEp4kjnQ/P3wT52LHKME81rY9pD0ytvC8
         u/NKWpfBWumi1NWrbWnqlFGqVRdEQlON/JD5XhJws0MRI3hEDp9QUSV+TqOsY+zQ4Frn
         FOAUokLr4Kl+wJKD/DTCSNE1kiHjouNSSiCnQ8StMmNOKn+hVpmervumPt/41Cxl7s9I
         +QfNXTWyC2pONVbh6uzYZpoZxaCzw3p4Lnsmy88cdlpWnW6d2X0nZ+C8HzNopFJ/DVLa
         hC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782538968; x=1783143768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hJetzVCmipfxkIYaKGKmSSwqDl0tCRIuzU++fp89zak=;
        b=A87RgSxSG+EUKuVzXLBHOaBumZFj2AcZN+yPmTD9OkqKGIAKzgullFQoRPCDUHGQWi
         UDYCAFtR/0toZoD49gRwMjP5Kjm0Eb29lngdRwjjCDF3zDiKCtPhzCuwSKdZbPHRZDcC
         XP9tF8gyjKxuSucbKEOIJ9p6Acu6WEi0yuAGAGyyKfhYs4e7wQuZzRlhl5ILvDqHdYng
         /Rvq+UVDjLITXC6C7jvixRUj9hpi02pDCDT0xXG1LCEGjR8M9hIj+a53jnuUi9kbMO1Q
         T07ycwAkl+xsiyWe7BcKeDI7fHu3gl4kBbwTaU0FyCExOCuege4xAl39CzL1htdcpDKm
         lm3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrh3KnBwFuKcWsC7h0KofCwLQxNmnzJPBmPZ9wBpFVzBbm6y1w2d97bDZVsijlkYs52ja9eHeuz9hAf@lists.infradead.org
X-Gm-Message-State: AOJu0YxxvOZkwLVpRBxuuv8OA2bheQ2574ADq01IIDlRiXZtBaM9Y/Ka
	mV91Mn4VFFYlWpTRYSXbWtNGtAh8qpOEw5OKU1IIEemPzVxgkuRUG5mtfFilHCkePiGx/Xyavn8
	lmt/K753V+6Rkdm6jA0G3kCSFbbUtuJr8xpze3YGAc1S7TZDo5j9f
X-Gm-Gg: AfdE7clqXW7dQKK2TaH6GGRuiH4TM+am0xWIoGHX2nG/5e3G+H7XWx8sWj2c3dsHNye
	LUdDuy/rhpFpAocFim63GB1xmipiEkW7trXq0Q/ZqZgT9wKc1gATKK1Gubz3HozaK+Z8XiLfiMK
	DdxoZ+zxzJN94Kgynsu41lnoEm9OM2IS1J8gPEqaMvxOri5w78vBvqlmNPK1+pGM2n4s/XK2Zmd
	YpWdRlOorN9IibuK0wQ4j3DSb8H/Gl+cWGeaFh8Cs+z+rV4bz2LnX58wAylERo/QyIjH6Mgo4V3
	u65OXxqToe1fvVR5mGYbLpPhnT0ouiV4VpnvN4XoNozgJunImG8Jr5fE+BBnLReIYArF9392Tt2
	PF5oyxyQ7/fQbKEUre7l37D9KPB5h
X-Received: by 2002:a17:90b:53c3:b0:36b:9231:9718 with SMTP id 98e67ed59e1d1-37dfa2c9951mr5148619a91.6.1782538967568;
        Fri, 26 Jun 2026 22:42:47 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-37df39562besm848289a91.1.2026.06.26.22.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 22:42:47 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id E8FAD402B5;
	Fri, 26 Jun 2026 23:42:46 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E6AE6E40712; Fri, 26 Jun 2026 23:42:46 -0600 (MDT)
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
Subject: [PATCH v4 4/5] t10-pi: use bio_integrity_intervals() helper
Date: Fri, 26 Jun 2026 23:42:19 -0600
Message-ID: <20260627054220.2174166-5-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260627054220.2174166-1-csander@purestorage.com>
References: <20260627054220.2174166-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_224248_665821_E7ECD9EF 
X-CRM114-Status: GOOD (  12.43  )
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

Use bio_integrity_intervals() to convert blk_rq_pos(rq) to integrity
intervals to reduce code duplication.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/t10-pi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index e58d5eb6cefb..787950dec50a 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -541,11 +541,11 @@ static void __blk_reftag_remap(struct bio *bio, struct blk_integrity *bi,
 
 static void blk_integrity_remap(struct request *rq, unsigned int nr_bytes,
 				bool prep)
 {
 	struct blk_integrity *bi = &rq->q->limits.integrity;
-	u64 ref = blk_rq_pos(rq) >> (bi->interval_exp - SECTOR_SHIFT);
+	u64 ref = bio_integrity_intervals(bi, blk_rq_pos(rq));
 	unsigned intervals = nr_bytes >> bi->interval_exp;
 	struct bio *bio;
 
 	if (!(bi->flags & BLK_INTEGRITY_REF_TAG))
 		return;
-- 
2.54.0


