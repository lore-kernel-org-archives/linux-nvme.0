Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40A7C55178
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:18:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C082222B
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dG9KjDIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C082222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=aD5jREPHvnVFVreCn0Cy+qynY4wJvsT0PylytbSqi8U=; b=dG9KjDIjOdKjQ/2K2sFbzoC/dk
	NPBipgy1NqzVoYSDJIqHdvR7CCVAewwEPAlLL4XCbil2I99SCHumLGyubQyvMdUjSbOP/6UP+gjr0
	w8itnZ931oGRBQD9HDoeO/ASmKPHtgobLNqplhYTqYFkF0oqb6AdKlaXw5flFxhpY8WhvjogUkTnB
	RXEgRyM5QFOBi14J8aLp5RPc1fq6sRHme9IMMsKV5jYGwmhBKdYuBZnP0pisimc2H/NZVPzYgcD3D
	HWxd3MkP2S+Eo/bwfpA69IHringlAZAIF24zVfHwflzTSBnmbMPeXpVlMtY/5JYNwwSNDaqwOJ3Sb
	WVfDOUlw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb5Nu-0006gb-4l; Fri, 06 Nov 2020 17:18:46 +0000
Received: from mail-wm1-f68.google.com ([209.85.128.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb5Ns-0006fH-0a
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 17:18:45 +0000
Received: by mail-wm1-f68.google.com with SMTP id v5so2181830wmh.1
 for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2020 09:18:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=y/WhS1WAhil9VuTZj+rg8tQPdjt0NBcSjA8L2dLe8WA=;
 b=AnmU46QYPHsx+WIxiixWxR+tu8/lG4dQ9KEwrCouSjY/GqiFfFcQ54H5UNqMN7iRjG
 cCPBbS7OeYWYZ90fBhL7cLMAYxxG0/OKLNdAlka5zOIDUOcaQs/38Kcy1INs+l8xvXwF
 QibUGmHd9oRaZt9/LpvNMKzooaBDNyw0tZgUBdqdDIMlwBA3fnDaLSRrmnoB2JsCqMHN
 fJ8Ue/a5qBOiTa332YVxq2jmYSiKXSfzSf2ST+X+sSZh2MML3QHCEEJH9wtoK23jv+he
 /zM4ocYMfQtj10PnjBAQp8U0f4CdiTk0wfDX9Rz0Xyk86WAZAlMkFfBcSQDbFM7NyRpm
 YMCg==
X-Gm-Message-State: AOAM533ji0GYak0G6Z8SU6pf10HDhA+SFimR3/yFOyw+yEBAyFR+BFJ5
 kWO/1RGKgW+2M8JBShWeS4DANgON4yo=
X-Google-Smtp-Source: ABdhPJw9bpNmeDQtBUz6UBPjfF3yGTqpl1hbjVEZnmYMwrTJhUcwczwFHWV4qlCSWx1w132ksyx1Zw==
X-Received: by 2002:a1c:9804:: with SMTP id a4mr636344wme.158.1604683121019;
 Fri, 06 Nov 2020 09:18:41 -0800 (PST)
Received: from localhost.localdomain ([2601:647:4802:9070:5d93:b4fd:df52:2680])
 by smtp.gmail.com with ESMTPSA id o10sm3203842wma.47.2020.11.06.09.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 09:18:40 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH] nvme: revert commit 1293477f4f32 as it is breaking BLKROSET
Date: Fri,  6 Nov 2020 09:18:35 -0800
Message-Id: <20201106171835.38236-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_121844_070124_4662F748 
X-CRM114-Status: GOOD (  11.13  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The offending commit breaks BLKROSET ioctl because a device
revalidation will blindly override BLKROSET setting.

The author should resubmit this commit in a way that does
not break BLKROSET.

Fixes: 1293477f4f32 ("nvme: set gendisk read only based on nsattr")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 40ca71b29bb9..f5365672ca82 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2057,11 +2057,6 @@ static void nvme_update_disk_info(struct gendisk *disk,
 
 	nvme_config_discard(disk, ns);
 	nvme_config_write_zeroes(disk, ns);
-
-	if (id->nsattr & NVME_NS_ATTR_RO)
-		set_disk_ro(disk, true);
-	else
-		set_disk_ro(disk, false);
 }
 
 static inline bool nvme_first_scan(struct gendisk *disk)
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
