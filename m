Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02553C4345F
	for <linux-nvme@archiver.kernel.org>; Sun,  5 May 2024 10:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Fmp84Ej0jEpkABXCanz/BB8frTB1L88FjsfDIWGr9jw=; b=ZJpjAdrmP9kyxDkKDgb7BDOYBw
	KSt7UwLHBmHH0NeM++j1WeAKDduAKraLrKUVTCHjMjblVau1VwSoGevoWBdhgam5H6wjoBWG13lej
	nl+QwibO8+iYpvrGF006l1KPDLRdg1izNFt7Lt+0EifYyq0LMIq+1i96oIvRtWUCcMmBcqDYWik4l
	glolEQESnT9tiDaqOFGReNa2/dD9CHQkdjAUCebdLjNJLkBUvam3fqStMB+bTfPKeSQ3XUl1yzdpf
	duL7SZXdUMJNGW0PxMnF+qTJkZbjOWEVVXYsGVQmfcGEnHs9NFfezrZ4uVYuAr0/eM7OYOs9Tb7VC
	gyvq2FCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3ZHk-000000045eZ-2fbJ;
	Sun, 05 May 2024 10:40:00 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3ZHg-000000045dW-2sOS
	for linux-nvme@lists.infradead.org;
	Sun, 05 May 2024 10:39:57 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34e663ab1caso78461f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 05 May 2024 03:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714905593; x=1715510393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fmp84Ej0jEpkABXCanz/BB8frTB1L88FjsfDIWGr9jw=;
        b=htGdD5cZ/Fu9KCt6LpmrtYNCzxSnmeRX0lJYn5RvJ0vnZI7EVvPeRrEsxA86wtiA/1
         grYJufKQN009NZEwetrkgAU9hKdtypjk64nNZ2zGHBuIlvWzypqYM8bjcbK64TSH7J/o
         oucZEwsVyFtSvxCTSaSeNRmjQ9At2+g4EyGnEssQzQkxZnNPglz0iHQ/rZqsKGXx5JBx
         6/uuDA/8w6uyS4o+m4OXSiDPIPe2DmxYULLTYYdyG62UkNu/pxLTtAEJA03qZjaTY+Yz
         eIKgvo7CXSmL5s/07KBduN1zjq7o2GcIlyXC04usasagD2cN2wt801UkgJ22cNxYDRBy
         Qx1w==
X-Gm-Message-State: AOJu0Yy7l2jrMbf03Eo/XZCO84hAFWUYq5Z3rNAvrkCDP6ktblzydR0U
	J+Sn297yU0Axu69LHQwV9aiNTs90J74KxiSMh/PWdl6eKl/80hje21mO3Q==
X-Google-Smtp-Source: AGHT+IFsNibzWE70iVr7ZUwpiV9RPzxb3ewWloJhV7dKSare7ZKWnUgehixunuynRI0+4Fvj8F63Rg==
X-Received: by 2002:a05:6000:1e85:b0:34d:707c:9222 with SMTP id dd5-20020a0560001e8500b0034d707c9222mr4873034wrb.2.1714905593539;
        Sun, 05 May 2024 03:39:53 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id i15-20020adfb64f000000b0034af40b2efdsm7988935wre.108.2024.05.05.03.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 03:39:53 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH] nvmet: make nvmet_wq unbound
Date: Sun,  5 May 2024 13:39:51 +0300
Message-Id: <20240505103951.52413-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240505_033956_751390_02AD80CA 
X-CRM114-Status: GOOD (  13.60  )
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

From: Sagi Grimberg <sagi.grimberg@vastdata.com>

When deleting many controllers one-by-one, it takes a very
long time as these work elements may serialize as they are
scheduled on the executing cpu instead of spreading. In general
nvmet_wq can definitely be used for long standing work elements
so its better to make it unbound regardless.

While we are at it, expose it via sysfs to allow cpumask
control of this workqueue if a user wants to modify it.

Signed-off-by: Sagi Grimberg <sagi.grimberg@vastdata.com>
---
 drivers/nvme/target/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e06013c5dace..5e948864ea89 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1686,7 +1686,8 @@ static int __init nvmet_init(void)
 	if (!buffered_io_wq)
 		goto out_free_zbd_work_queue;
 
-	nvmet_wq = alloc_workqueue("nvmet-wq", WQ_MEM_RECLAIM, 0);
+	nvmet_wq = alloc_workqueue("nvmet-wq",
+			WQ_MEM_RECLAIM | WQ_SYSFS | WQ_UNBOUND, 0);
 	if (!nvmet_wq)
 		goto out_free_buffered_work_queue;
 
-- 
2.40.1


