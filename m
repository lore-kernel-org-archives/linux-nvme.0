Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C5FCFD36C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 23:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9hEyetpjb5QpX08wjji0bcnEJUxus+pp0XTDG4Zkk6c=; b=0uk3pKnqvbfU8Sr7DAv09mK6ev
	ce9Vd0I9lKJBXVWACEK3N2Za9HSHjDgsJObCo1+PE9y9rULm+BbgysEpg2CfHu35gKa6sdmQLPnra
	aIsak46Z0kcYQwjkZSstpMiRrEo2rZMbrq0WZruWlCwAfpl9Lxgxn0SsHfnswZD69Ff36lzlOgIl6
	nMfPKAuQhF+rF7iVJC5C/YqcB6lUzVnvii5sNnt6rKOJ841H6na64HgvzMg0W1cSTJrDmvD4KM8y5
	mFf3ieNaWhfE3n+jdEfOaqmDKzDYEaN2UF1v0Th325KaRbiXVTCJG/yeG+dZ2kGriy13jLFbJEOGT
	CLK9k2+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNgIF-0000000CTcA-1zaA;
	Mon, 24 Nov 2025 23:48:27 +0000
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNgIC-0000000CTaa-3NIi
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 23:48:25 +0000
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-11b6bc976d6so6067025c88.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Nov 2025 15:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764028104; x=1764632904; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hEyetpjb5QpX08wjji0bcnEJUxus+pp0XTDG4Zkk6c=;
        b=jg6BP4WVt9qsfcHnJNXeuHA0eC3OUq1dnyZyRlZN2KkdvndkU1n9x1eMb0IrEy1jpq
         XL8+oVX7Xr1l1pkT5VgiVChx1buMIPXJz5cjtlykN2YD8Sp2gvznWfullkqWEfvNMZ14
         qW95acpd/8dT90jsG1KbbF3rR6YkykPyPiMI+OHmSfbjGUpSaXOOjNrZrRWXhOilY9lO
         A9pwAjxOI0+bB/8YgzTP9zSnG8sHqn1rA8UpXseKaN2lNeIMame1+DX+B29m/7dSvvRO
         vudHddvs0yU0f3rkyyo97eCjKol+iT/75t3TxcyoPp/clQ89wItNwb+GLltyoA2jUuhA
         KKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764028104; x=1764632904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9hEyetpjb5QpX08wjji0bcnEJUxus+pp0XTDG4Zkk6c=;
        b=VZ7+E/7aISTZtVno/6oZLku09pP06WsVAMC1rqTnwzZA5YfQO+ftv6XP4+oF3Rviu5
         YvMd4t9L3+fx02M3L+0lWcSGx+M+map3XcGqjaPP+eAGUdVmu2KYtWAW357Lljgsw9We
         xiR4XKsuanvnqElJr3l7oxZcwfCuDS2XbCAHsVrhM8WZRPgxJc8BpyMSVshfkmLPHp4c
         p5Faky6wMVGvmWvbeM0wn3jGGkRCLVG7gUfqghgtN0NmDXSqBCjUeg688F258ZEaFGkI
         /jdPjLxLDVmAx3gsO4kMPSY7rp4DCpwspbTVxjtIBqP2L5dsYFxDec51DxuSF2p6ZWao
         bbxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlDjBsyU5JzujmUW/NMywZSFMm5ydj/Yi/OwRCctG26hXriOwgSdc93A65X//t6qmXLIt6Be1Swhhm@lists.infradead.org
X-Gm-Message-State: AOJu0YxNzJhgFJBvtyoa+cDzab1+MTLhdPWDvG8SYvZGf1JIHH7lCxwe
	XTDW8ky/51WKx+bkyeOfslZg2R77oimjXwr2uU0B/9IyV6XutPP7Q0G9
X-Gm-Gg: ASbGncv40yILYBIKVSKcOfQshE5RZxVrn2olP0bNgK1MGEda7Eq8y4tJKaepZ1y/c6u
	ZApwBw0HVde1gZWitI6c6OieH81cTS0QLDDSwaFpoG8UbjI5d1VhaL7voRl7bd0iWn7dGRy9F9r
	RJNPLyjz3YCnm8BCdDvV1zqHR2Uv+Su2EDI8nbJgV3ZEglUzo+eE2QiN3GXAU6GvcC2XWt3Q23F
	0mt9/r+GB6vuShzb8iMuAxi+tDUBkw0fDsmTdY5whySSgmc5VpeT5NyQx8io9V+JtpiOpkfciP/
	bGZ29xJ6+FDPJytC6Axf51ypwNnZOnuAQVVakaTAbzJIVXxEX4/DUz6zxDiC2U2Zn0HifWSu4Md
	wtliuOrM6fFP3aKuog10dxYcU3VrMHeImdM0MHhnsqqxTv1rP+1xqrDGBrrpcBnJpqLcKGDxVyc
	P/sRl9d/IxYoCdC2XCUgFKBAO1DB+Ii/4IIFaJ7yrXJz/Ui3Q=
X-Google-Smtp-Source: AGHT+IG0os1yUTB1U8y0wFQR2JhU9wfG8RKwx2eS9+a2sORTH4Ie8rtwmUzrvPIYkCFTBjjRJcm4Ew==
X-Received: by 2002:a05:7022:ec17:b0:11b:9386:a382 with SMTP id a92af1059eb24-11c9cabc4f0mr8878128c88.21.1764028103912;
        Mon, 24 Nov 2025 15:48:23 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93cd457dsm72215229c88.0.2025.11.24.15.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 15:48:23 -0800 (PST)
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
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH V3 2/6] md: ignore discard return value
Date: Mon, 24 Nov 2025 15:48:02 -0800
Message-Id: <20251124234806.75216-3-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_154824_851410_CC42AFCA 
X-CRM114-Status: GOOD (  11.85  )
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

__blkdev_issue_discard() always returns 0, making all error checking at
call sites dead code.

Simplify md to only check !discard_bio by ignoring the
__blkdev_issue_discard() value.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 drivers/md/md.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 7b5c5967568f..aeb62df39828 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9132,8 +9132,8 @@ void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 {
 	struct bio *discard_bio = NULL;
 
-	if (__blkdev_issue_discard(rdev->bdev, start, size, GFP_NOIO,
-			&discard_bio) || !discard_bio)
+	__blkdev_issue_discard(rdev->bdev, start, size, GFP_NOIO, &discard_bio);
+	if (!discard_bio)
 		return;
 
 	bio_chain(discard_bio, bio);
-- 
2.40.0


