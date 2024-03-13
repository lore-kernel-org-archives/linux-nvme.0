Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B935C54E58
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Mar 2024 12:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=njgblKV6yYKUHhKiUWdh6CmtTll/pgdv/COytyS4OoQ=; b=V4sIsOUd6PDQVSuhQP0LhJPT1a
	p9/8XFUEBNppaOjCJyn2aYTqce/04lgtq8lhM20FY7OXm/EKJYRn1ZmpkBwSwmJG1/Z2f0fixYgI7
	M6PJWTgWhhsi+Mdke3mjJ/DMgNH9j++sEo771AMz9yIFD7VlG06nogRbPfgtmYfUQ91UUF/D5xzm6
	80PnO1zHRa5r0GLxCtWSHot/RwM95DryxIH3cHVnz5HvAgtz89kYdUOG1fNj8WIcvRrSkz/z5oUMG
	DAqdc7S/EoJXw5Jr6MA3ImCbKLNLONkpfxPohKon75mShCNBO/WpLT66++sW86YlHLaGDB5pCOSgG
	LmBz9/Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkNt1-0000000A5xt-44T8;
	Wed, 13 Mar 2024 12:39:11 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkNsw-0000000A5wN-2oD2
	for linux-nvme@lists.infradead.org;
	Wed, 13 Mar 2024 12:39:09 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ddbad11823so15103535ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 13 Mar 2024 05:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1710333544; x=1710938344; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=njgblKV6yYKUHhKiUWdh6CmtTll/pgdv/COytyS4OoQ=;
        b=hmTy34UmP3WryMzoCZiDgt6sYnxbXces010Zg/SWIlwkdku+vZNHhHnCakwmnrQxSc
         ZJz+7EqbfyUMYV4ehwP5FY9w48Lz5PZ6Assk1W8bEbNLzodctdz7lpNK6hI6LMlp3Pq8
         vj2Sgy//pGWYrG+3VJkg7jinlKsmuJ9jAhfbs8reA17ewGXfYkKesO3vYNL5CCHgYPuC
         9++Ik1iY7NgU2c4DfJD4OwEDDfr4s+4/bp313iJg9wEgV9oTC3pBvUubnZze5MAYYs7t
         4k57l3pDSEToqeCOpuCoMFoEvU0pAjK1BJ1+Zz2m3YVo63V5tvMCnQdvlgfyqyGP9YEo
         YDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710333544; x=1710938344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njgblKV6yYKUHhKiUWdh6CmtTll/pgdv/COytyS4OoQ=;
        b=hAUScv4jssNCPkRA5LaxuWLAzwe/gTYPDs8ftSHIhWQYFYTzbYdxh8vwCbd8tuv7W1
         cySVxa9jasbyO3vZu/urBtsLF+bxKt+RQfcU/krFVQWkyl1HX6R7586BL+eQsq54uftL
         afyll/Oiq6kYUVKUPxu96RB2UXXCTeLDKzo2wAnrLsyYLuCZfcayfYBeuKvj36gbRNDr
         hbDhiUOe9lApY8A8ShRhYk/gQ3RgJZw0rR/2KSZmJQSzRbVqJTGTDQOp+EPUfcPF/8MJ
         EJnumbQqKegND4oTuGLOzAxEYSSEKLPjQuDsauqZIWVh8pkPUeUsUbVSunzB6bwSRylt
         S00Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMkcWRfitoOoZW//a0Xw4D7anXpHRmNAM1PtmLObmpg/JUlAgQ/WjrhC3f4LTVE+bbAYi8KeEPKbWNFPgNaALAVwXXbdDeru5R6k1V8as=
X-Gm-Message-State: AOJu0YymgkwIY5iC576TbtuUD7reH0HVeevAXpXpn6+ybIaNGuKPOeVt
	5Buxkh04CUv7MPHNOQ+GLmnQeGxQR3s2J6WTvYpktNA6uJ9OIlWlmquTTB0UO+k=
X-Google-Smtp-Source: AGHT+IHKm9fQknaASl+M5IgBaTKOQc2BRZdUNRsjnyNo9DIcyVNGt2YqwrfAc1sLBtlVoHNA+bY81Q==
X-Received: by 2002:a17:903:2303:b0:1dd:c1ba:d46c with SMTP id d3-20020a170903230300b001ddc1bad46cmr4672301plh.61.1710333543851;
        Wed, 13 Mar 2024 05:39:03 -0700 (PDT)
Received: from localhost.localdomain.cc ([2407:cdc0:ab48:2284:ee43:5c89:b26a:f291])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902e89100b001dd95b5dd0fsm6440696plg.69.2024.03.13.05.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 05:39:03 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Anton.Gavriliuk@hpe.ua,
	Li Feng <fengli@smartx.com>
Subject: [PATCH v2 1/2] nvme-tcp: Export the nvme_tcp_wq to sysfs
Date: Wed, 13 Mar 2024 20:38:09 +0800
Message-ID: <20240313123816.625115-1-fengli@smartx.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240313_053906_827867_0122AB56 
X-CRM114-Status: GOOD (  12.66  )
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

Make the workqueue userspace visible for easy viewing and configuration.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a6d596e05602..2ec1186db0a3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2800,7 +2800,7 @@ static int __init nvme_tcp_init_module(void)
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_term_pdu) != 24);
 
 	nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq",
-			WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+			WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS, 0);
 	if (!nvme_tcp_wq)
 		return -ENOMEM;
 
-- 
2.44.0


