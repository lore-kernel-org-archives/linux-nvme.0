Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DBEF433D3
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 00:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qTb4WYVL+QtfOgfKxr2rwJdF5OfB66I75dlU3VTdI6c=; b=hN91oSOe0V5XAVT4UCUffmFjzv
	sT7Qps/WPIYcwofWCLHQFMC2sRd7i4R309jm642Nm9yzKaJjbpCz6fcjKYnhpTG7ZDPbSIGVAWaKO
	iyrJAhrBswRbJkc15cAAW9IKm8YBcRu8VtEemKVcct2ztMd5QUVSDRqJZQQL9zqY+iPjSBUNQ2bJG
	5RG8bNIFRIcfz6j09B3JQlMHmxIWlR4SdJx49xmHFhffCpZgQCLjqmgZ2j3OARuXuS/UuvrHzNoqT
	ikHBrKdnB5wvivH0IRZsPlNu4oGV1oh+ReJ3pjuWI0vrxn6XrveEURdhfuIHqzV1QIR+aOvNcjFPy
	zXzLXGLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDAVT-00000001niT-191D;
	Thu, 16 Apr 2026 00:22:55 +0000
Received: from mail-qk1-x763.google.com ([2607:f8b0:4864:20::763])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDAVN-00000001nf5-2Svd
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 00:22:51 +0000
Received: by mail-qk1-x763.google.com with SMTP id af79cd13be357-8dddb65b7f6so103430785a.2
        for <linux-nvme@lists.infradead.org>; Wed, 15 Apr 2026 17:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776298968; x=1776903768; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTb4WYVL+QtfOgfKxr2rwJdF5OfB66I75dlU3VTdI6c=;
        b=akNSM1LKxMfXLnrzTNnT7Y82HczfwX8aa4iQJnKzdpDZsV4tPScnPzSuSWmaJSyjBr
         zq5H+xmgiW3p95GOYZPha3lmZrrRzrZX4YKnVore7OXcr89ILXnBCBpLNNltj0PRjX3g
         zQH3EFWqDvChK+8SFwiH2ezEERr+sqqJ1p4jY0pXSOgKlw3Xn2pmM2VaPO3rX4Z+KTCf
         4So5m24NCNcOHc7kbIanJOpzfmxIelam76delrIs8KK1fxVKz6s7liHMjFdzeZ6X50ht
         89lSU058Gl7LF/iknCGSnTsIqiiPgIn3/inrPkYZ/iRXxzLr1wV5wudkvhl+CXNVeL95
         4vAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776298968; x=1776903768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qTb4WYVL+QtfOgfKxr2rwJdF5OfB66I75dlU3VTdI6c=;
        b=q/qf7JlIr7V991zLBaCxy3Ujr2H+Db5d0Dd5SwVONb2DbFmDxuf5z584XFJbB/4DwN
         QDKaK0gijEsoUfp+b5mUCpC8x4aK5lAMEndK54c44pzjsLqj3Eoa91u+Nl8eVk3EjTuQ
         CLaYs1dCahkUN8DQHDZXiAvtd/zKN/POBktdrsu9bPV5D+cHUvnarcXYvjjFIFMQJyDM
         qHyeslK1kepRRRQqXrbuPKGwFhlHiLUPM4DefkL+Zg2OUvpepmozwS1ZndPbzEkgHuX5
         wmMkGRBwfqecn1maE1cYr0zIHIzOTTF1kSfGg2Kc+6+xK+0cIkFbAX3YPlUSukK8FiA+
         +CtA==
X-Forwarded-Encrypted: i=1; AFNElJ89Mfl6ujtN6vQ4+wj2u6meP9SYi9LUmqo7g8CxJC4p3mXTSIO8EoaqD7je6zSrg7cxhtMWqe/1Jl7u@lists.infradead.org
X-Gm-Message-State: AOJu0Yw3OOOlQfBaWKAG4VKkr6YuNK95X5BNA2sCkE/ecb91zISSOvmv
	PRYfobNITE0NOQNYgHInpxiuhwBbcbbN0yLwDpkKWCn2/KzoTOTp5OEEBeNikyPjvNp5nt/7K/z
	VP5OWCu1qB/knX9D8enz/MGdMNFcIsyLv5zXi
X-Gm-Gg: AeBDieuscLZd+ZGR1G1eEcEJDeB4QuJ62VbTX3y+d7ECfhOADxm+Fo7yk8hqubgxj35
	xIGH0w5pxkN6dptEj/bpxfeBv+T1yuByRLidJLdy3p3ddVuELhkOkxFIt46NkSjuF+Y3gHKEO9x
	T5lfzdjnaq2rqZ/oR2DRpxGEe6/UYMLFR/P677LWh3B5LUpvIyZoSrBu3WPlrgbdfuxfdI/zv0L
	tL5FQL/I+srdOrZpzu17C92EoTxTvMOgmlAjQG+366qVyKnwbT0VgwzOGz4BNd2LVvTRVQGihgr
	O1Fjy+wg4+tvlzi+l5upwQLowqlYrzvQlC/6kpEy323DXaC+plpJ094OnZY/C1Fv0dILMGJgjyy
	+/XsESS5T9nvFfkZboaVSnNkIxPl+Xi3WwYCKEZKdxFAcEZ6YbCAfMeVRNo4R4FDE
X-Received: by 2002:a05:620a:4614:b0:8d2:394a:d3f3 with SMTP id af79cd13be357-8e6321e7da5mr60618285a.2.1776298968296;
        Wed, 15 Apr 2026 17:22:48 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ae6c93d2b9sm2589456d6.4.2026.04.15.17.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 17:22:48 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 07F4F3422D5;
	Wed, 15 Apr 2026 18:22:47 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id F1B94E41B93; Wed, 15 Apr 2026 18:22:46 -0600 (MDT)
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
Subject: [PATCH v2 4/6] bio-integrity-fs: use integrity interval instead of sector as seed
Date: Wed, 15 Apr 2026 18:22:12 -0600
Message-ID: <20260416002214.2048150-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260416002214.2048150-1-csander@purestorage.com>
References: <20260416002214.2048150-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_172249_629641_DAEFE8A5 
X-CRM114-Status: GOOD (  14.70  )
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
index 389372803b38..5d1b0e33fc5f 100644
--- a/block/bio-integrity-fs.c
+++ b/block/bio-integrity-fs.c
@@ -62,11 +62,11 @@ int fs_bio_integrity_verify(struct bio *bio, sector_t sector, unsigned int size)
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


