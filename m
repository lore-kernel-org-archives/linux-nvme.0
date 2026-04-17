Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6157EF8E4A1
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 01:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MNTSjciFlX9Rr/279QUaN+sXA97OE3S8NKaAWj6D0d0=; b=COu4g/bslqj+oJqYnhsXYgL90y
	XRj6SZwEqM5Po79CB/gb/119l7qbNuwqbtK67rOyFY9f3WJUWe4btBNcpVtP9BCCJD7/hzXQ/Fs2t
	kKnd5CSrY9DJpm/v1tPKj8fPS5s7NtG7IhLySc/Hv8ROtuUwRqtfuJQcPIFq7BAnX/Rl5+6ytD8z1
	IQy109Yj+H2/GFX69ltHOS/pzgf7gcifpR9+hl/0PB5pz8+KR/Y0FN8qRzyOp+X3D4RBOfgJQz458
	j+OHOZEpLoLKwN1dLD8fSa63dA7gM16fC6lXZ0FFFyL/faKk7dBLZdpJnx1/UswnIGaQk7cOuy+00
	3ICuIzEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDYSo-00000003IGu-0hp5;
	Fri, 17 Apr 2026 01:57:46 +0000
Received: from mail-qt1-x862.google.com ([2607:f8b0:4864:20::862])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDYSk-00000003IDO-1ozz
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 01:57:44 +0000
Received: by mail-qt1-x862.google.com with SMTP id d75a77b69052e-50da6366272so31991cf.1
        for <linux-nvme@lists.infradead.org>; Thu, 16 Apr 2026 18:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776391061; x=1776995861; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNTSjciFlX9Rr/279QUaN+sXA97OE3S8NKaAWj6D0d0=;
        b=dQDDgg2aE8FVe7xKaUzA+I1Na04BXkuGXpSivvPWG1Y5p4oaiXDfyMfvOfePpab8gt
         cVmuZIXytH++/aSSbU46Uae6S3jkSqtJVfWDdKOgOK9daDHNtIqU2xM/Oa0zSXHnm1bC
         T0bFtliQzhH+Ovrhr3UVupsRQdn384RVOALUeHln9RMhB7mGZACQTpSe6gSj71AlY9R6
         7pPf1EEh/XkNLWDDO+kd7Xg7+XsOYozKZA/9FcJsKhE7xQLbYqKGfONI6r2PRigvIRON
         yBMyU/nFADCy85s5vN4377QfLuXv4Veu1qUO8YiMFp7X7bzzcCMXlnMjoOFNygWZ0YEW
         6jKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776391061; x=1776995861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MNTSjciFlX9Rr/279QUaN+sXA97OE3S8NKaAWj6D0d0=;
        b=OJVI9ROF27XcW+p7Y8xgs6MMvA9TJr5p3xIFAxZ1zruX4a6cKJzfQOSDjzUoru+ueg
         lGnycAA8RHQOOQRvEdXCglAaoiLpZ3h4XEvYjgVw5XyPfDy3wxZcHEheDotU+k6ry7Ob
         vDq2YBmGSkm/Co/ws6GZAuMVZFlsCcD//l16APjNo02SHglmGb/V8IQMlHIqHPA65g01
         bvILSW/t9xUXsVpl22uLQH3Rjps/gnwgHwDohcDbsCielG9Yx9ME9aVKwbIoLWZCZIWq
         DHyo2VdHsTXq7W64UVpXPQnn5Y0cHyAKtfANFT+c0q9uhKRb08hk+o4g1bZE4OMvpSr1
         rrbA==
X-Forwarded-Encrypted: i=1; AFNElJ+yJchhtyoxYVE8PLwqj1WUTPn4ZIrRWOQIH/LzCNya4xAd5h3yn9ORLe+iwSCKH/+ftsVEb7clDLw+@lists.infradead.org
X-Gm-Message-State: AOJu0YwF0qpsyBOEWOIfAgzPO9io1pA2ySCVdByXXnQght2dG731o8kZ
	yGPRYpAfBkbhHjwd5WlQbIN6y0XbQbhUiWciiN3SSQSY3TwLxyRsmGFHm65nROBi5AU0UFBC2ab
	8pbF0Ci+Qp82GMOMsx9D0nH+xf2VYmPz4K5eWPOUvIx+ksmiDofo1
X-Gm-Gg: AeBDiesWpT7I8+XhOcr1HYUNd7p+y2URffw/a32rliheXGnmoWEUN8cn1K8LwTbS5sM
	0c70Bx0OBKzHTi1N3bIa4Rhtp4FRTcc/Yon2DWJVybyGQS+OBCcOdXDLK8UfYbUtqlzYSZC+Th3
	dc0xPi9Zfh647AVBV05PD6f2hUlt6sUVWsL/blp5jqCe5GWc5njp4892qTu6+NDnB3baeoqweCQ
	jh5LMgOr4TE80KNf6iSHw5hJ68yix/qjwUd+gWFAwCzXLPRECfqrkO6vWYeeZbiTbMsZmYH2cEr
	fS0X6YIM83/N7n2TboKRWSc4eZY2QM17oI3+98HX92vuj5MKyfpsNgxFYkAj9Fhe1KtPTk8ymsR
	DNw2kSFtqUW0JKIIelK3ksArN6FfiXDfnwbk/O/jRq416PzXwPg==
X-Received: by 2002:a05:622a:44a:b0:509:15aa:cf03 with SMTP id d75a77b69052e-50e36c0afcdmr8556161cf.4.1776391060999;
        Thu, 16 Apr 2026 18:57:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50e394581ccsm55631cf.26.2026.04.16.18.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 18:57:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 446ED340C58;
	Thu, 16 Apr 2026 19:57:40 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3FEBEE406BE; Thu, 16 Apr 2026 19:57:40 -0600 (MDT)
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
Subject: [PATCH v3 4/6] bio-integrity-fs: use integrity interval instead of sector as seed
Date: Thu, 16 Apr 2026 19:57:30 -0600
Message-ID: <20260417015732.2692434-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260417015732.2692434-1-csander@purestorage.com>
References: <20260417015732.2692434-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_185742_476378_B99E9805 
X-CRM114-Status: GOOD (  14.60  )
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

bip_iter.bi_sector is meant to be in units of integrity intervals rather
than 512-byte sectors. bio_integrity_verify() doesn't actually use it
currently (it uses the passed in struct bvec_iter's bi_sector instead).
But let's set it to the expected value for consistency.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity-fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
index 0daa42d9ead7..0ad1c5ab64e9 100644
--- a/block/bio-integrity-fs.c
+++ b/block/bio-integrity-fs.c
@@ -65,11 +65,11 @@ int fs_bio_integrity_verify(struct bio *bio, sector_t sector, unsigned int size)
 	 *
 	 * This is for use in the submitter after the driver is done with the
 	 * bio.  Requires the submitter to remember the sector and the size.
 	 */
 	memset(&bip->bip_iter, 0, sizeof(bip->bip_iter));
-	bip->bip_iter.bi_sector = sector;
+	bip->bip_iter.bi_sector = bio_integrity_intervals(bi, sector);
 	bip->bip_iter.bi_size = bio_integrity_bytes(bi, size >> SECTOR_SHIFT);
 	return blk_status_to_errno(bio_integrity_verify(bio, &data_iter));
 }
 
 static int __init fs_bio_integrity_init(void)
-- 
2.45.2


