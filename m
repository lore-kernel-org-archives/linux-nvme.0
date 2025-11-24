Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3F3CFD31F
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 23:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YcqbQ5S4JXXbau3fgh6ZbMU20qGzRcIfkGSPAKTqhkc=; b=SwF+1u1T9tgkkanNavkRIIrfQD
	+z0jxwDHX7+R99HVn4naY4nJMjzFfCtPaOAR/QkNlJlI+fMOQkXv8ktXGUVjy5neHgfZmCnb0DUQ2
	gjv9NLxS6N7eDR8hCs1QgnVN06cJCY3yBo7sbbye0Z1MEZplMEEBQ5gKf1kAEOpJzu7firXM84fsp
	0S/KOX4WqDVos/vRKHGmL/c3RaWLwNtOfUUi8H0PgC7cJAelkGBu6pDTX2T4/hI1yaMZZeLWdh6Rp
	PfvZxJGvnSUFru9ZqhP/mR6UICRHUeOnC5pslhd+OoXvS/7pvWrCB6mz0RKGoYWghPs1Ecxoyj349
	iLkt67TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNgIE-0000000CTbG-0caQ;
	Mon, 24 Nov 2025 23:48:26 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNgIB-0000000CTa8-31hN
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 23:48:24 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso5998009b3a.2
        for <linux-nvme@lists.infradead.org>; Mon, 24 Nov 2025 15:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764028103; x=1764632903; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcqbQ5S4JXXbau3fgh6ZbMU20qGzRcIfkGSPAKTqhkc=;
        b=Y4K+7h60tZx5qylDDOJGhet1xt0EIKqGxWstMEIgRccQqDCC/mbg5Qns1KuSnZ4cyN
         UC2iW0YnVy5O0isV2mtowgdeLNZ6x2sefAiHhRX6GRoes8GfG3tHpQVDuvQTTHXc1bBc
         JjuB2qCz0KhHt2I0V/W1um5XOFjWst4B+P8wvs4GeEJEwIGv3AixdXzGPONTQyTCZNWY
         v78k0MnRfoKYv2B0kfGS9WgJIzYw2XovU5vfnVCjTrrnOPVp8CIi6HNVaxXbK800Kd4K
         SWcJMu3N+5zZbBh28rPU0hAaShfg6+OI/RSfW8qfl0P1YRPYlO8pDinPWAO2jKyZDesK
         JIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764028103; x=1764632903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YcqbQ5S4JXXbau3fgh6ZbMU20qGzRcIfkGSPAKTqhkc=;
        b=w/JS0TSaYvYj/jHXm3bFYcjPgmta/qIqIrDRAXs2kfmY7yYby+z/Pnw1DZZ5LtaSWJ
         Qz2IVVnF4zsCzL5cCUoCUd/olb6er7HwqxWdm6nLB3oWom93Ptk0mX42LZ4quylwpRLc
         0uf+OC2SrUD477LLwKqMkDco/cEnjCnJH+43EOqUH2tRNTqgOgwCoL4tJ7Ls4Ovn/X3J
         3B3md9p4xXMcSbjMI0nYWkjOBmWCBtD/d/FtB+RX4VPdwOMk3CtpwSJXKINB4YNNuDuw
         uYh9ft4sjc2MJOU0n7ObJIk0WUdzp0YMN60x1PiVepueFgXiV0J+Ck+FDe/Av718eQRM
         eAsA==
X-Forwarded-Encrypted: i=1; AJvYcCU/KsNlORsvyX1TaS51qM7qgJQ0HZx000yzpzRYvxZT4ebd1G91gRXMZW56KkIlE5u9tc/lJdwSURC2@lists.infradead.org
X-Gm-Message-State: AOJu0YzfzjNjbaqtKer3xupt2MFVjecovx8FMr5oETvrnO3oIrCgwm4F
	YWDs6QmcLH93Wnfu2+gjYAEAASrjn70jQnpn0iFehVqXdYPTEIv8AdPD
X-Gm-Gg: ASbGncvgbQsoXXNsJRonIxYV/bSNthWwsf+b6yMSNgarkQrXD7Jfw9ZG2OzalzKG+0s
	WnLlsNPOa5nsnF6uX0oTzhdOA54iMZ3zCcOy7oD972I5AIzb3ix1VE64Cey+50eBQARUls6dwaw
	Pylf+6pONb17GndZ82TJ3keauKuaOGhgaTiFAnSKQIDuvv0G0Xm8cNJy9/2tSBL4+xDIMWt5Ken
	1ZqNKryzDPLpDjq+OWcsMYZBZDc+pA9CM5RatOidXVisTuD2x6D3s+4SuMlCKUgIPsvFWMraJsd
	AS+EfsJGYCILFHxDqje9pWias/U9+haWHLlu3etwWv/YhVNZxHyQ5dMS/5Zbkwh8pI+Wis50bMu
	IrnfcdwakUWA/GXWUpnsGKJB2DTBMdDYgtMazQwJok5XfRmYs9+zJsa71OFPPAcM1e8KMkfOXSH
	g5BFUg0b0qnYFyOx1gx15c+sPNoaNqJ2FOXpSnDa4RhxgRJOU=
X-Google-Smtp-Source: AGHT+IH9F80PvdpBpbojg7Y02KngkDHXsfXBdGLUzofDSvSvFO71NKJ3uHp3bN/w9c26If04NsQEQQ==
X-Received: by 2002:a05:7022:d45:b0:11b:c1ab:bdd0 with SMTP id a92af1059eb24-11c9d863a0amr6183635c88.35.1764028102624;
        Mon, 24 Nov 2025 15:48:22 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93cd457dsm72215056c88.0.2025.11.24.15.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 15:48:22 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai@fnnas.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	jaegeuk@kernel.org,
	chao@kernel.org,
	cem@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-xfs@vger.kernel.org,
	bpf@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH V3 1/6] block: ignore discard return value
Date: Mon, 24 Nov 2025 15:48:01 -0800
Message-Id: <20251124234806.75216-2-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_154823_763679_A8ED84C9 
X-CRM114-Status: GOOD (  12.57  )
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

__blkdev_issue_discard() always returns 0, making the error check
in blkdev_issue_discard() dead code.

In function blkdev_issue_discard() initialize ret = 0, remove ret
assignment from __blkdev_issue_discard(), rely on bio == NULL check to
call submit_bio_wait(), preserve submit_bio_wait() error handling, and
preserve -EOPNOTSUPP to 0 mapping.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 block/blk-lib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 3030a772d3aa..19e0203cc18a 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -87,11 +87,11 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 {
 	struct bio *bio = NULL;
 	struct blk_plug plug;
-	int ret;
+	int ret = 0;
 
 	blk_start_plug(&plug);
-	ret = __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, &bio);
-	if (!ret && bio) {
+	__blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, &bio);
+	if (bio) {
 		ret = submit_bio_wait(bio);
 		if (ret == -EOPNOTSUPP)
 			ret = 0;
-- 
2.40.0


