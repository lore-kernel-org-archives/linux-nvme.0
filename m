Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DEFF433CC
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 00:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eyCXVkuEBYx6RuPx/hECYTdCdsu/oyGta5lJzqSGfU8=; b=nk6Z0W6LXJAxTNx8adV17ufk+6
	hOOrPKzntWHHPGJXoqfBo3p2+BoikMgzYk7OZpIjH3wQN8cWOPy/lTSqIdHDgn1yxMxEUkstoXpaQ
	qIlGNvb84XW2xfXbSx0KojjccbJa2FrbURFsKxTC8QktyZR0YSuTs9UqpbN0dyKlYEmXF6gwRikxQ
	tjua+8W6ZIWL2eSRJCMwXj+SsNX6l5uZ7NS4h+JY1Fn9EeBVxpDheI7wduOSMzViOgTzRZ5DvmNYH
	dNi1RRBvS2KxXvBS+f0pzs5DqIC6v9msvzej90NhR7SZsBYZncI7p/NHM08ZRDCGsTmExv6rQfhok
	PBnHIngw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDAVS-00000001niA-43Mg;
	Thu, 16 Apr 2026 00:22:54 +0000
Received: from mail-pj1-x1064.google.com ([2607:f8b0:4864:20::1064])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDAVM-00000001nf1-44s7
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 00:22:50 +0000
Received: by mail-pj1-x1064.google.com with SMTP id 98e67ed59e1d1-35e4617924eso811838a91.1
        for <linux-nvme@lists.infradead.org>; Wed, 15 Apr 2026 17:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776298968; x=1776903768; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyCXVkuEBYx6RuPx/hECYTdCdsu/oyGta5lJzqSGfU8=;
        b=QOBQtXg/bmdYl8HuVGQRUTBzOAmUeSBPE4CFrlnuM1yZbMcwADfgfrBH0M9acoQydS
         sSBbcat2TUR3j5nh4wGRlsm9ZHwtgnjhbOgtUaUmhezxkTKukQsbcrGoAqaLORRQL4r9
         BOt5pV285ekkoN0Ryn6MpncMVDxYPAz2CJoWp3diVjfvG44UeN3Sgy4YfaNi0vs5Zl6z
         uNqgf1Ro59QsFegzUzRBYpypNtmSGHWv5mG6PXjL84PplNLhubWw7j2VdXlfc/hVP3Zp
         beFxOP565mVdgkhTDDoCDyvL8rJsdeQYP5GceN7nopBGq//91mtUgJcepIdcdDrzqVO0
         spMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776298968; x=1776903768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eyCXVkuEBYx6RuPx/hECYTdCdsu/oyGta5lJzqSGfU8=;
        b=QFKp7UAm5zDQAtUXD3IGXvpltBQ5g239Y5i13EowXGUJyx/D03cioM6kT9cWFq4dkV
         R7oe/BJrcWMx/o4NWuKZ7ggZH72N24IHi2fMPx5ChQj0RGU52zAAnhckEJl/PJ3CoeEZ
         lKEygAl1v45AdvNwz3BNfH5894vhZcqdiJ0Yxc4Uzz0QFZLmzz/T3UxB85018PrupuNd
         PeNShoySSiRlVAfUzNmCQ0EgiDGbFGuZs5l9Q+URFmiu+vIOSLicMaIsmBK9zn7oFg4U
         s+sp2ylbUNYeoS2IRleCogQAuzQyuKrW/ESU49UpNBZyZc7at7i3mQFOmbd9kyiTrTU3
         2rdw==
X-Forwarded-Encrypted: i=1; AFNElJ89K3eJ2HvrcVf8qAG1wGcsiTNciyvzie8cKK4x3bwhmfS1yx5EIYfsCnm7bKp7IQxNA1zOzsx4mu8e@lists.infradead.org
X-Gm-Message-State: AOJu0YxA0QmiIujjfgjzRBxt338WhnJOoaFhfUBcUEFeA5xnwJPb92Vk
	3R3+U877mcL5i39LbX+AswgrRUPhb9D4wMCgag2FMvxP68lL0l7y3zl0Ya68wOSZz6jwH4pmlOE
	jWBbzP+f1VDWUgEitozQLXuR9gFlEqYZCJNiV
X-Gm-Gg: AeBDiet09UFwZJBw7dFMPwnvR9MxEVmBGQZ8QR0QZm40ZNsGizAaTXJCYdvjdymOmbw
	YCVv3Hd9hlLyrKj22TAXT3ehXpB3LO65Jyzxu8HPsGlM8C72UMpuCPWzs9zkYlrUZhfIpLZTvzN
	G9mtIKsYso3ZKwGJkzKVDBoKOFle/u/7pOCWxShQfr/CCLllCxtn2UmPE7IscHMSDmYFHILXMIb
	4ZSoi91VGIpmsO3qBvg06ZV8iiwc4KvXWHmD6TdtGzM2XqaihKvyYhFbjS1x8u2gI0frcXODkNV
	d+lZRbxG9wRxCGIZK7X7hBQF0FlNojq5yeiMqb38DZctKXvl5LlPuco3f3OGIMtfRfvM37HMdST
	Gr8FE7YuSXasQ0MC9GFcsWuVEmJaR3ES5hlgOwtO1bpcC/D16r88Nxgt5MMPHNGe/
X-Received: by 2002:a17:902:d58c:b0:2b0:7041:63fc with SMTP id d9443c01a7336-2b5eda8b366mr2383085ad.7.1776298968060;
        Wed, 15 Apr 2026 17:22:48 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b4781301b8sm2399375ad.18.2026.04.15.17.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 17:22:48 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id AEDE23422C8;
	Wed, 15 Apr 2026 18:22:46 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A3C50E41B93; Wed, 15 Apr 2026 18:22:46 -0600 (MDT)
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
Subject: [PATCH v2 3/6] blk-integrity: take u64 in bio_integrity_intervals()
Date: Wed, 15 Apr 2026 18:22:11 -0600
Message-ID: <20260416002214.2048150-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260416002214.2048150-1-csander@purestorage.com>
References: <20260416002214.2048150-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_172249_036019_5D79E06C 
X-CRM114-Status: GOOD (  12.68  )
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

To allow bio_integrity_intervals() to convert an absolute sector to an
absolute integrity interval, use u64 for its argument and return types.
Also use SECTOR_SHIFT instead of the magic constant 9.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
---
 include/linux/blk-integrity.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index b1b530613c34..825d777c078b 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -64,23 +64,23 @@ queue_max_integrity_segments(const struct request_queue *q)
 {
 	return q->limits.max_integrity_segments;
 }
 
 /**
- * bio_integrity_intervals - Return number of integrity intervals for a bio
+ * bio_integrity_intervals - Convert sectors to integrity intervals
  * @bi:		blk_integrity profile for device
- * @sectors:	Size of the bio in 512-byte sectors
+ * @sectors:	Number of 512-byte sectors
  *
  * Description: The block layer calculates everything in 512 byte
  * sectors but integrity metadata is done in terms of the data integrity
  * interval size of the storage device.  Convert the block layer sectors
  * to the appropriate number of integrity intervals.
  */
-static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
-						   unsigned int sectors)
+static inline u64 bio_integrity_intervals(const struct blk_integrity *bi,
+					  u64 sectors)
 {
-	return sectors >> (bi->interval_exp - 9);
+	return sectors >> (bi->interval_exp - SECTOR_SHIFT);
 }
 
 static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
 					       unsigned int sectors)
 {
@@ -151,12 +151,12 @@ static inline unsigned short
 queue_max_integrity_segments(const struct request_queue *q)
 {
 	return 0;
 }
 
-static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
-						   unsigned int sectors)
+static inline u64 bio_integrity_intervals(const struct blk_integrity *bi,
+					  u64 sectors)
 {
 	return 0;
 }
 
 static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
-- 
2.45.2


