Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3BAE85368
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2026 19:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L5n7eMwAf8ARSdCe/bC94DhqCdtLVwx2F31J3F2H4e4=; b=QFdgwxQVVxgdj4dLIAtIhJNYWj
	wC5YG6LROeBN8P3OtDxQtNH77fbHVrDOTmkze9iFzsttDy621lprMn1MLTlp90Hkv4oJP4rfmNpQq
	q4W0NRMvAKcyDGOtRpq7Yg4mD8yJzSHPgER1hPMYA1HInQKg+pLYXSz+5QJsrqfpZH3VNRvPtgZKH
	77X0fL4R1FxzWEXs7ajK3WI5fwD1OTZLobiViUXNJu1Rm7rSvH7vMu7CNqWYldA1gMeFFzQLPV5x4
	IcLgWaYqzlBZudGdVQQiByZyqwWCbMKNb00uzGTZYCyHR53AX5uFfwDh1PlpTWhY3u3j0MtMhE8PT
	RBj+NaIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8kOT-00000002Ulg-3yhW;
	Fri, 03 Apr 2026 19:41:25 +0000
Received: from mail-dl1-x1262.google.com ([2607:f8b0:4864:20::1262])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8kOQ-00000002Uiv-2voK
	for linux-nvme@lists.infradead.org;
	Fri, 03 Apr 2026 19:41:24 +0000
Received: by mail-dl1-x1262.google.com with SMTP id a92af1059eb24-12734af2cdcso91198c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 03 Apr 2026 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775245282; x=1775850082; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5n7eMwAf8ARSdCe/bC94DhqCdtLVwx2F31J3F2H4e4=;
        b=AuNO0k7mUUUuY3OKg4IscqBx/OFVCSsW/b4a17sONnKUshRn4MiptWytXKkGhA/sES
         gjm1TALN782vAGdbw74nbbHeNGRnSl/U6bP3Cbp/rDDKDwCCM0394/pBHXELLa6WoaYE
         yLQXPDVSFF0ettbOGcMzNC1vG8Yv28hn+THOpnVGktMzU3M5LG/9q8qxX4//WT4ds3vE
         fRhtnbjVkgiYKFAARWlNZPNH6hFkSgY3NijSuZfaqDuaRvDkjQaypUobaUZgFr/XQ2z8
         HqB7Uub6OubyN6hrMBjNiL/GNanYHvCLR8TRyi1+BnixjeMPxmnmeH3gh3+tQyz7toVi
         /2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775245282; x=1775850082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L5n7eMwAf8ARSdCe/bC94DhqCdtLVwx2F31J3F2H4e4=;
        b=nbVldohFdYmddH5etzvRhrIRmsmF6n90/xpkl1CCYErEmaMP8xghLc2OA3nFIxxSID
         TkMb6pGG2XLDQe38ZyyApqTfBuQqZjTFEKQr8dvg80jjNhkcCDRkLX6KFsZlXHGwRYzZ
         I0ACzTa89zDMCtJuirk5YIHEy7vjmqyRMoTORvAn4pzhgPvqA5B52Luv0l+dmPsBmJUi
         /SHdDfZYjLf6lfPgP8qFbovSnyRCkHbI7ShQ7infDSeEfJEidqiqQcojuzuJ7LHZ6rEh
         hquCbUo74eoYVZ/cBB1vxTEPwu/giv3qP8tyCzMvLn8LPn4NXVi9ArFkrBeIcbfqZbOQ
         AwqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4oBHetO+FRy5xqwxX5pzPNZjUHuu8ZwL6xemFVtQtU33C/cC5cwDneVJVySRmGjy7gYPRW3lSMeIA@lists.infradead.org
X-Gm-Message-State: AOJu0Ywypl1+qGrMN7ur/IKKk4G1ba1kfIv2bn0jx9T9OV5B18i727db
	KYAd8hnWHLx8tLqlLAEAZ6jSUmj8Je/uLGsdHSLR1QpzgSOQFeIbQYxr2u3X4JdkAhz0Q9jXJji
	gh3X4uJ8P2L/f7KAdjzb/mf/6IMY2khtMs79h
X-Gm-Gg: AeBDiet82XmBzlLSYWsL7++5zth9+RGtiCi5nQEHiDkHiq/m2meULcI1V57WJA++0Oj
	Hj57kVgbxr27Jq7cByYPA8ptO54TpYcoBPLqh+QxVL9e9ECI0l4getWhLSLDDgfSif00T9kMMEB
	yXgKuDaOoNNJKVmXri0UctL2VLANRb51V3TmeIboVvZ0RmkegANfnJXHdAC409JJwzXwLqQ3W1s
	DVvOxfZhVQ5EimdXMGNuA2f0HoRZWVL7dG6AGY9HGjApOnhXwYXyhMGgh+7/dTP6wBeAgJ0UeRr
	+F21QXkexHKXz/Bk7Bzrux1Kt+GA7LbXJ5049tSoc+eBtwv85bUCA1b2HvcwYa83HSE3PKesuEH
	r6p7Rv9cAqj4nA1FqIvQgsi3RKF1cdLOQQvAoUKukLwjLocFmqceYqw==
X-Received: by 2002:a05:7300:4347:b0:2c0:c961:4b98 with SMTP id 5a478bee46e88-2cbfc85e0eemr888275eec.7.1775245281557;
        Fri, 03 Apr 2026 12:41:21 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2ca7b9037b5sm474222eec.17.2026.04.03.12.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:41:21 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id ABDFF34071E;
	Fri,  3 Apr 2026 13:41:20 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A21A2E41AC2; Fri,  3 Apr 2026 13:41:20 -0600 (MDT)
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
Subject: [PATCH 1/6] blk-integrity: take sector_t in bio_integrity_intervals()
Date: Fri,  3 Apr 2026 13:41:04 -0600
Message-ID: <20260403194109.2255933-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260403194109.2255933-1-csander@purestorage.com>
References: <20260403194109.2255933-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_124122_742036_BF30E564 
X-CRM114-Status: GOOD (  13.02  )
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

To allow bio_integrity_intervals() to convert an absolute sector_t to an
absolute integrity interval, change its argument type to sector_t and
its return type to u64.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/blk-integrity.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index b1b530613c34..2e366f03a3d8 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -64,21 +64,21 @@ queue_max_integrity_segments(const struct request_queue *q)
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
+static inline u64 bio_integrity_intervals(struct blk_integrity *bi,
+					  sector_t sectors)
 {
 	return sectors >> (bi->interval_exp - 9);
 }
 
 static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
@@ -151,12 +151,12 @@ static inline unsigned short
 queue_max_integrity_segments(const struct request_queue *q)
 {
 	return 0;
 }
 
-static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
-						   unsigned int sectors)
+static inline u64 bio_integrity_intervals(struct blk_integrity *bi,
+					  sector_t sectors)
 {
 	return 0;
 }
 
 static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
-- 
2.45.2


