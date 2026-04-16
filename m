Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C3AF433D4
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 00:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KbrCUVte0mVKnP3wd9JwZ7YRnd40ug3Wdm2BJ0sYmnk=; b=n2LGXlsLcCvuOCfHrijP2m+q5h
	1aecDcqxJ0er2cFCPayG7Hs6nCHZbs/VF8+fYo3uc7p32nWnPbMCto++tIO9+X7PMZgvfmHL1D1sU
	y1BV12I6Hmw2Z2Oa6mi7B6csrL2kBfCqQPD9TrFrwO+JtqbH1iaPMiylP59W1TwnbbOio9BDpFDaJ
	EIUOeJi5wiRCNOCVbrrbH0fgavvrXFDRWQfeOvmPginJKajp6gAPui2TfCYBYMTkUv5i/y/nMuZw1
	XdqilF1Gyb1+UxDd22OS8qut5Z9cv8iqFwMbK1ZDUw3Zl0dcx2oe6zwMDU72A5Lpoe2CYKbMzuzPw
	P4GXwCRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDAVT-00000001niv-2aS0;
	Thu, 16 Apr 2026 00:22:55 +0000
Received: from mail-oo1-xc63.google.com ([2607:f8b0:4864:20::c63])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDAVN-00000001nfP-3bYF
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 00:22:51 +0000
Received: by mail-oo1-xc63.google.com with SMTP id 006d021491bc7-6888f36ceaaso122138eaf.2
        for <linux-nvme@lists.infradead.org>; Wed, 15 Apr 2026 17:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776298967; x=1776903767; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbrCUVte0mVKnP3wd9JwZ7YRnd40ug3Wdm2BJ0sYmnk=;
        b=gNLauovkLOPI4AdErNBTjOgypb65nsroEsXPyOHavcl1COzCuA7D69bKE5wkSjWtz5
         TPYhvpCesre2vbvPUyDZAAN2t8xLTOIkQmvRxQhbUrZOnLJuI3bqSLqTdMeQEhPPB6qI
         qxA1PuFCtxP3wGcUVkOPFhVDN1CRlmcPAIvI0Wnpdk/6XsrYxWBYQMVAiKWAFBQcZor4
         jTK0mOZjfYFJ4IRAXFjbEKS4PtK70c3DFINeC58l5EoHfLYXluvmx2NWzhfhizsfNg0K
         QCfYFWA077DkPGO24XrKcFbhCkU3c66KjRUi5bPFtJ+GddoLYB49Iu9jkTQ7Is4iL2vR
         nRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776298967; x=1776903767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KbrCUVte0mVKnP3wd9JwZ7YRnd40ug3Wdm2BJ0sYmnk=;
        b=Hdg6pIGr03EOeHpcMtV7PRr+LgtqkFwnY2ZErDJX9eX8Xubp6FUT8cDI52PZHwNP5N
         jkwXDABbxJvANLi3cO4RwOpuww7r8VLFm4HZEZ/7SuK5/FrSNG1g3TsN6JtoB3BQzduW
         xtQUK4d2m1aFtQ+L0GkmIjHxEqwOLcclZ8stYcr8x5kKHmBgGlHpbKHc+bsRvqT0B8iI
         MIgxZ+GBkblQCIb1j1M1B9BmV3UZTiuZGXzG9nRIXlCAKBV3XhE4LVdI4kFJ9cAZhqlg
         tDNvO3LHqo2AyNcorREjuE5Gz/SngmThUIG07nkTtIo+FZ5xRoKtqDpH9ZfKEQnEft+E
         HlTw==
X-Forwarded-Encrypted: i=1; AFNElJ8wj5Qp1NIiVRRZI2Q8w4gGzrnIRT3gSAWUclP8nOqgIyvohi962xmVDBP3xFerajGwV1QGvMCq7ZtL@lists.infradead.org
X-Gm-Message-State: AOJu0YwlLEhv/ZBl0/B+QRZ9EWUHtyVCMnQHvcNQVYdq1WDPaKkmStc/
	5oe4xs4SmHXZLHUjfoxiT2oAE5mnoxPjkzFQzgwPyrjiT13K08/XeuIiX6rSXmudamo5tPpZ/N1
	HyzNDFU3BEMehnzqLDtUWzFlv50DlMogIeqZ6hu1JxFiPAkR5gWL2
X-Gm-Gg: AeBDies1NoivDiG3bk7CyYNIDGY+njsCFuFs2O+0ATeouZrHblN2WJ0ybyA8k8SYkW9
	4VBSiWTWGEXWUbzDV6feS9XyvEjGr5Wz+4Pgz4oiWPTVWc2fcpgAMrhD2gay3M6OzibIrfZwEWF
	W8NsBPCQXSSeHBXPURB0UPmvLWVLnpbao9SoR25EFOZCdP6/vwpufXpeU2MJ6QmkMCpI7CCkSV7
	ADUIrOaMlJJP5N81flxZkoYTqU4B045x4xHFUJPYHGZxZHSnFSKDL585MsVXxaHFx5Vm7sMA09I
	MFfqqFge6NBDZoz0jhPtTXbIdpGBFESs1U6oiGFLWueUIXRP0/ap4WKqBEcNjs9yo8TjFM1lWF5
	sf/7uOhDn7fNqifZmyGzQB25C1ANTADp1GRwhKqE1i1Ynoxgyjw==
X-Received: by 2002:a05:6820:488c:b0:67c:3021:908a with SMTP id 006d021491bc7-69456aa5cd1mr88811eaf.3.1776298967567;
        Wed, 15 Apr 2026 17:22:47 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-6932a7959ddsm231360eaf.4.2026.04.15.17.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 17:22:47 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6AAE23422C7;
	Wed, 15 Apr 2026 18:22:46 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5FA79E41B93; Wed, 15 Apr 2026 18:22:46 -0600 (MDT)
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
Subject: [PATCH v2 2/6] bio-integrity-fs: pass data iter to bio_integrity_verify()
Date: Wed, 15 Apr 2026 18:22:10 -0600
Message-ID: <20260416002214.2048150-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260416002214.2048150-1-csander@purestorage.com>
References: <20260416002214.2048150-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_172249_928543_E350F5C1 
X-CRM114-Status: GOOD (  14.39  )
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

bio_integrity_verify() expects the passed struct bvec_iter to be an
iterator over bio data, not integrity. So construct a separate data
bvec_iter without the bio_integrity_bytes() conversion and pass it to
bio_integrity_verify() instead of bip_iter.

Fixes: 0bde8a12b554 ("block: add fs_bio_integrity helpers")
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity-fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
index acb1e5f270d2..389372803b38 100644
--- a/block/bio-integrity-fs.c
+++ b/block/bio-integrity-fs.c
@@ -53,21 +53,22 @@ EXPORT_SYMBOL_GPL(fs_bio_integrity_generate);
 
 int fs_bio_integrity_verify(struct bio *bio, sector_t sector, unsigned int size)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
+	struct bvec_iter data_iter = {.bi_sector = sector, .bi_size = size};
 
 	/*
 	 * Reinitialize bip->bip_iter.
 	 *
 	 * This is for use in the submitter after the driver is done with the
 	 * bio.  Requires the submitter to remember the sector and the size.
 	 */
 	memset(&bip->bip_iter, 0, sizeof(bip->bip_iter));
 	bip->bip_iter.bi_sector = sector;
 	bip->bip_iter.bi_size = bio_integrity_bytes(bi, size >> SECTOR_SHIFT);
-	return blk_status_to_errno(bio_integrity_verify(bio, &bip->bip_iter));
+	return blk_status_to_errno(bio_integrity_verify(bio, &data_iter));
 }
 
 static int __init fs_bio_integrity_init(void)
 {
 	fs_bio_integrity_cache = kmem_cache_create("fs_bio_integrity",
-- 
2.45.2


