Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05432E8538E
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2026 19:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5OR26UHwrmX/qKb/xGTxkRmRxVQZGF/pWpTgOpuYDGw=; b=e9VEdsxGiq6gd2sLvv1CDvek6s
	ZVRwLHY7lJWsCRH1BAdaTxgsPdD1GqOEfQqKYbXtUVKHgYt3sRw8Wl0ymjSxxFyAUZCjYeyN7OahO
	qqZDv4/50TntUfBF2jKb6z1nlGl9Gk9JmXf2q0AJ6mi9zcw8K94dIBHEF7r/E+ByWKGUO6vgYmYCv
	4eCzmggnhLH6NXzStm5w+WSyEKKLiJrPHyaL8QhaY3zQNOWvgBXuMLtLAk6muKK4EAMRDiKQQ2E4x
	1+QxPU7EMgs1FU8FAsJuhRtYJvQisRMBB6dRu7TJG8m67UC45rcuMFZjIOk6xzErEWbCRL05E/bT4
	RULaixzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8kOV-00000002UmA-0rUg;
	Fri, 03 Apr 2026 19:41:27 +0000
Received: from mail-dy1-x1362.google.com ([2607:f8b0:4864:20::1362])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8kOR-00000002UjG-0Bj1
	for linux-nvme@lists.infradead.org;
	Fri, 03 Apr 2026 19:41:25 +0000
Received: by mail-dy1-x1362.google.com with SMTP id 5a478bee46e88-2c7e5f38a69so113200eec.1
        for <linux-nvme@lists.infradead.org>; Fri, 03 Apr 2026 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775245282; x=1775850082; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OR26UHwrmX/qKb/xGTxkRmRxVQZGF/pWpTgOpuYDGw=;
        b=FoYmOp19gR+u8Row0O4Ma+3v0B4V66XrfkRlz8Je88f25/BEeDE59ei9jOBd/CKTUr
         +8Y9LAXdYj8sXDmOKppPghIsnew677lM7ZKbd1usSBd4lk89gvyKywcunoM/yOUqs9GD
         xTX0l7pv1Ld6b+SuXt0mK7tC0aFiS3nOLdPUKko7OWJk9UecqfelsS8akmLtcEhY67Em
         8CEIhKg1ubJqeVFzE8queDSsAp9RVv3BRcHmNqjHuxuSZwDzOWkTz0T4mq285LThBIZH
         iN9YrJOAG15SaTPgykZuNC6xWf47WPY4eWXBUl1fX4jusMcv6GzUk2qb+ew3ytmYOYLr
         q7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775245282; x=1775850082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5OR26UHwrmX/qKb/xGTxkRmRxVQZGF/pWpTgOpuYDGw=;
        b=rWk+QXwK2DoN8jz40sIAacymkab0M1a/9i+Xxs8tuPGmSGCoK/V0GFN0tnFC42vSQe
         lQzs7gGYLbNTuyAuJCpv7TSCBP8o/jwalWEOp+Asp4Mhkuhi4KJKUinQ43hJ+RCC+/uj
         YavIT61/pXWkKp1pLhqDlnMKyN2LTcxBldFrbzOl1VVgTslfwycjbf6H+KQ5GXPlSDCR
         mroPLfIly9DNwb7mJq9/gzeWx8mvkWUO2pUrgSVVWpKrrZj5ZR800NlmAumeoclMH6fm
         eOuc+HtN0cFYVgY9VwCNEpumOk0yes1cwLnWAqmVOHx0dB6dbHsPjzB+s58191KJDOgK
         GiOw==
X-Forwarded-Encrypted: i=1; AJvYcCV6dFB5OL+GpRpUyMKki+AU3V93yYXAjB8dflTeaF+GIuvSowLwEI8Y+zDwW2CpB3T1TKwHF4B64ffb@lists.infradead.org
X-Gm-Message-State: AOJu0YzjQDR3DiW2urDgv+TGS//ZVbLDTdUb7a6fB/uhCpZ7YEVgvPr7
	kN2o+D7Fpy2PRKG7ynmdAg8plQywXbGUGoP4dkQqMNYPUHwNgp25NQ0VzDyucrlJrLg+VoiwBwc
	Nh50eHQjAP/7I7mdaAPW0lnToUjyq8akZvUtV
X-Gm-Gg: AeBDiesa5ZvHJuHJ9DoXV1FN79JPsE0s7FPCFBlgEDbUpf/3519qJ/vnDq+qAtHJo9D
	E03vGyoVF9KaPA0eKeYgwQ5tK8ChlQue+sjR8Vh/YXKFb6chT/rhMpPt4jJn3Dd6c1ljXztCux5
	ueERI6gxRFqYUhLeZS9L77pVgdOAbT3FewFmS0C1K7mNzNkhCYb5gwWnWh8Dt8MwVwTP8QGvMz6
	AdpbIUfnIQmYW7VbckWhDrKN675id7WdD1HUBCo6EV21LYcYlZGEu3okWdkyw+8KZ9ruFuczb1S
	AzmsIszofxkDN9YBz0OhjPcefYmcEFzAYeaDwtfu/ZpFBl5LAJVJia8o01cHmCaRVcm4/NNL1FI
	b7KrlxmqqV17GwQBoEGXaRyNTaSc6QBsOSkdYAGI4efjuAzVkyLb1Wg==
X-Received: by 2002:a05:7300:2315:b0:2c4:76a3:bdfc with SMTP id 5a478bee46e88-2cbf6897126mr861527eec.0.1775245281934;
        Fri, 03 Apr 2026 12:41:21 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2ca7bf00671sm474049eec.22.2026.04.03.12.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:41:21 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0C47D3422DF;
	Fri,  3 Apr 2026 13:41:21 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 029C7E41AC2; Fri,  3 Apr 2026 13:41:21 -0600 (MDT)
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
Subject: [PATCH 3/6] bio-integrity-fs: pass data iter to bio_integrity_verify()
Date: Fri,  3 Apr 2026 13:41:06 -0600
Message-ID: <20260403194109.2255933-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260403194109.2255933-1-csander@purestorage.com>
References: <20260403194109.2255933-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_124123_087567_B9248434 
X-CRM114-Status: GOOD (  13.77  )
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

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 0bde8a12b554 ("block: add fs_bio_integrity helpers")
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


