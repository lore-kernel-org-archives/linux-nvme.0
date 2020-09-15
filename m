Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D15C43461
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 23:11:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A0220B1F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 23:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fhon+hcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A0220B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kwlRPUYh9TvPVm+hhtnIcqKdMFowrOQtRrvxhlwN0pQ=; b=fhon+hcYNb046lCoqo7cLSiaCF
	UlTgnnWYzUsiNmirVXg+URUlzO7AXlOmNYatEvy8flcZhnLBfse0Tv2+DPy5JTM3wn6hwoLbHL+2Z
	DX1Lv/dXMQ22AY4spmGgvGdmNEIMBHSV+fZfHbs3teOmOEDP6OcGjnqJFsvhg1Abwv0L6YP4gZW1+
	nT3rRb79wwijdMNgSk3IYTWc5oNPToZyPb2+lI2reB6JJnikUcFFa+8rsOks2iEQjZ0wfMJaGtKQf
	IZZL0AZ205jxv8uTVwETvh31qb8865jg77XsQzrZOWnsdBVvKHxrZmYvgbv/7vuzb/kcNHben76Sz
	+p2+XNjA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIK6V-0000bn-Jy; Tue, 15 Sep 2020 23:11:15 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIK6T-0000bM-1U
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 23:11:13 +0000
Received: by mail-pl1-f196.google.com with SMTP id c3so2138991plz.5
 for <linux-nvme@lists.infradead.org>; Tue, 15 Sep 2020 16:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2x7Z+gqaj4fVhEKnPBaB4k/zW6UBZ90jXUkN4ILHGaA=;
 b=NZIoWkl8MRHk4a2IRQCOG4KMc+X7rSDDzTNo7JK/GYen+S/KvpV85vFW6xfDdMsqcr
 m+Tz+JB6XYFelRy4RZwKGjSuArkpKHFPSlFR2FB2mGHmoNI6+aFN8e+2HWdDBonLuXTm
 P31yFq1LB4aosHYko9eVeuTS+EW37ZCxgbc5zy8UsdQAlwEO0qYiRbnyfufuxShj2seV
 edlLtM4S6feTAn9uPIs2azPhYCFkeKg/PzfXtbsYGO1iMfi9kzvfUYSNDUI5hOEEA4D1
 if2B/L7EpN7asGh5WGZvqmqmAlehTrRrwHJ9UfddSF3xHsv/roLN0q6WR0n999A7aw4c
 Madg==
X-Gm-Message-State: AOAM530bO5uobNyv8LHT+v0NZf1FMEi0yQGoJ7rMXTW6STHzhiSy34Wi
 CZJXga4q0JaXBCXXu5PV2VHm2MNEH/w=
X-Google-Smtp-Source: ABdhPJy0nJEDirsvJ8cVQAdz963p5XUfOKFJJ0GMK+DEzm65miGdoDvSyeHBr1QV6bxownpLl9d46Q==
X-Received: by 2002:a17:90a:ae12:: with SMTP id
 t18mr1457672pjq.147.1600211470287; 
 Tue, 15 Sep 2020 16:11:10 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:40ae:2cbc:743f:8960])
 by smtp.gmail.com with ESMTPSA id 137sm15343346pfu.149.2020.09.15.16.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 16:11:09 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: relax hwmon logging
Date: Tue, 15 Sep 2020 16:11:08 -0700
Message-Id: <20200915231108.135534-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_191113_085670_F783B0EA 
X-CRM114-Status: GOOD (  13.59  )
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

With fabrics the hwmon is irrelevant, so move this print
to debug level to avoid seeing it every time we connect.

Fixes: 400b6a7b13a3 ("nvme: Add hardware monitoring support")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 412a6c97c0d8..f0c59cc0c594 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -251,7 +251,7 @@ void nvme_hwmon_init(struct nvme_ctrl *ctrl)
 						     &nvme_hwmon_chip_info,
 						     NULL);
 	if (IS_ERR(hwmon)) {
-		dev_warn(dev, "Failed to instantiate hwmon device\n");
+		dev_dbg(dev, "Failed to instantiate hwmon device\n");
 		devm_kfree(dev, data);
 	}
 }
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
