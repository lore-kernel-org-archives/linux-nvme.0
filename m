Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FC4F8E49F
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 01:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ePLDDsMaoT6WX22t4kx7uDAhAvj4BaoTe7M9oy5w3tM=; b=EPyHDTNNh0rspkAOwT43pUJKs3
	jrDbDhayZSuhw3zO263h8ANj2vC//j0nok2B4UgALRIQZZvLbj9N6/A9wKL09XQiMB4m6nD0Wp2CY
	Q7zOHlmeJoxCuatdi5c8p1z3gBT2QmtpCr3HKYDr0qmYGRcu/hZi832puK1oUa0hO5bmxczdyQRsf
	qOocdMl9uRJRVlYGZQQ+DBvc9Yv8clGQjQTd1rXiieWerx1BRmMJ4mUqpV3EQYZjGhZpQ1L6tbOFO
	OHDyT3DdEdf2T66q0Luod1KYQhDpn301+RggCRiCu+WJ0M6dxNNoJ7D9gRxt+5iztbFvEVLJSdRdj
	8n5aHpsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDYSq-00000003IJw-3QlH;
	Fri, 17 Apr 2026 01:57:48 +0000
Received: from mail-pl1-x664.google.com ([2607:f8b0:4864:20::664])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDYSl-00000003IEc-0C1h
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 01:57:45 +0000
Received: by mail-pl1-x664.google.com with SMTP id d9443c01a7336-2ae1255a90bso329785ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 16 Apr 2026 18:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776391062; x=1776995862; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePLDDsMaoT6WX22t4kx7uDAhAvj4BaoTe7M9oy5w3tM=;
        b=A6j0kgD8c2fyXcY5CVc2vpo1ls7GLX2YffP5lclXkN4hiswetJXSb4MtbvQGQcGO9B
         IgdmX7VIb+HXcMeh5e5BfcYpgDBp/+BEIdP7DW/I33AsKA66RzztaS6LzhtWKJpz5S6H
         ZgdFLXCU/dxPdARXFU2sgJ//JUztCkKvJejSUREoAtOD4ON01Wj/iciGQhU6y6TQrGgg
         Oymdl1jNQQjEgUv61s81zdPu9vq3+AhUD5S5ShBRFuaIgTw873yTZjhE8KrGZUPc72j1
         IWurXbJTSzHLRlIppmQvTDobkeVFzbBAMNtsVmwNb2FidnF+24Bagg/7r9vV3d3dnx3c
         mhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776391062; x=1776995862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ePLDDsMaoT6WX22t4kx7uDAhAvj4BaoTe7M9oy5w3tM=;
        b=eixTFL9+SwwVe832vBfSC3OfrPahBB7PjyT6aOpQ9tjFAG7TyuYPO8RXdJ03LWHKug
         y8svTEGDWiTF8Tlha6Acoy2wbQ0iugWdmWYpBWZ9CYKVKROa3/PJqcqD3ZQiJWkKF2ex
         KNFiQEoha4djQk9cbq4mNN20ZKLCIbV60To4Qemyw47funx3rz3JGBSAi75W6xxoczew
         uQOOfhonlePzvPmm/3/Cw8I2mrcTeMr/IBr/9c0FeMmL/1ihlEpeJE8GSdyzEAzMF6T6
         5YWftFyRzbgv4ZMhHuU3Jmk2tevicXM8jYssVoweWRGlONoiNArwz7L4GQykEvyCOefg
         Wc1A==
X-Forwarded-Encrypted: i=1; AFNElJ8Ow0hErb7x7D4AYU03abgR41eI46HQL7Af4hJGfLLFPJ7G5mMoHT1avIv/xsPxiTrs6x3Im8Nnzb+z@lists.infradead.org
X-Gm-Message-State: AOJu0YxZ+OblNchpGTGcHdE4QINS3qzDduLa5E5n90Dt0i0lggECgK8l
	89fXkLBmoVfkuFQ+aqUvHkJ9XALgS4CwY+i4+N8tf6Rm9kC64THYbTrN7kmz9iZVtXHFA16Hg5t
	I2n06K5yn6WfdDuo0LgMbCJWFhOzNGDZ1fvYz
X-Gm-Gg: AeBDieuGEYddzDjuMZrMA5u2RxUecVdXAdmcOlJSWfiY+xbsGSwDvMSQBVnSd5ykYNg
	XwbtT/8LNa/hAKDXRHEr0W6C5GoKGAF4i7UFVSeJ+stTus/X6AzeJM8x1/by0CLO30FsisYdRKX
	oVX0iVw1QhG88Mdv9/BVKDcBI8/0dXJrBY75QY6b0F2y/9KY5iElrcKRFUR83X90EQkfkLkwgJ5
	K71PtMfJ9yc5gXXBEcAbtScvsQX+XrfZ5tP+inTnxZvPjyOvt82ZpDD2o9PsPMS8skYCLicbDQz
	CAJ3nnWfN2kXNwoVhJ1CmCAp9tOWfAOyQ6JEX3Wd5uDOgPmKTyOde+RKf6hUed80StWAFP6/vXI
	/gvhknWE3faCcWZnbRMR8pTunRAQnf9ZNKdzeQn5xvN1oaYa2KGtDF1d1ZL/GFX6G
X-Received: by 2002:a17:902:b68f:b0:2b2:48a5:45c3 with SMTP id d9443c01a7336-2b5f9eceb6amr2890535ad.1.1776391062085;
        Thu, 16 Apr 2026 18:57:42 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b5faa0fa70sm233095ad.14.2026.04.16.18.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 18:57:42 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 658EC3406AA;
	Thu, 16 Apr 2026 19:57:41 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 60208E406BE; Thu, 16 Apr 2026 19:57:40 -0600 (MDT)
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
Subject: [PATCH v3 5/6] t10-pi: use bio_integrity_intervals() helper
Date: Thu, 16 Apr 2026 19:57:31 -0600
Message-ID: <20260417015732.2692434-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260417015732.2692434-1-csander@purestorage.com>
References: <20260417015732.2692434-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_185743_085349_1F45831F 
X-CRM114-Status: GOOD (  12.86  )
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
2.45.2


