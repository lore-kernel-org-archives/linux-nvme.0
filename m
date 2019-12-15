Return-Path: <SRS0=GgRz=2F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17643C43603
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Dec 2019 05:25:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8FB52072B
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Dec 2019 05:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SAWQM2IP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Id8NfdTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8FB52072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=OL+Ga4SUTgYYp+1fhbloegXpLnDc9qjySepzqqtzqJg=; b=SAWQM2IPnbvssbioNeHVH5hXl7
	k1wZGuOxcPR8B/8ie8YxS7EiLf7oByIOOlnoy4Xktbi5nnjQ84XSUKuCbQMlPz+DFqtVtYC8/VjE3
	NTEQLO3Q0pQ77gdpRPBhCbJM/B4b2oYi/oRoZrftt1wTeviP9OvQM6QBwZ6vMF9+6R+h2CGrbVmi6
	ZFFXCoQEP2uIlqYqpkLYSlItV3YwqdGrOa8E2dnNv1dUHyXmQ/BtPI25i4xBQT+KfOOoe4CgIHVLi
	mN7ZZ63/laKeXv2DlGQQNYjdQLB7QeAvqvDNkHT/O5dj/03FzXIgbH1SE7PKE2qmzdZIMqHt6w2R0
	fOfSexUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1igMOw-0005rE-Mg; Sun, 15 Dec 2019 05:25:06 +0000
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1igMOt-0005ND-Rs
 for linux-nvme@lists.infradead.org; Sun, 15 Dec 2019 05:25:05 +0000
Received: by mail-vs1-xe43.google.com with SMTP id y195so2166628vsy.5
 for <linux-nvme@lists.infradead.org>; Sat, 14 Dec 2019 21:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=iJPFiDdoTrBrSdqjTpE+VPFHmC8ax0pLThG7IGKangk=;
 b=Id8NfdTFPUPB+fc7GWUtnaZycNxT1n/743f1r4mmprU8vigdUiO+qwV5Rrz9bb5cvS
 JFpw4kpX7F7iUhfnq57t+ScMl4f95d3tqi8LeBRCdyGMExAcUz/W8rfHTPc1pfSrXXti
 PMZTllluPehaVveLsU7xboTHQ5CkDcPhifUoApxdDmxQ0gAQqd5oYjDFsEAUunFDK7mP
 TgcWBy3rf9x/fCIN+Yd/BB4jRXSBr+guHfyatZ7v7cIomD3n8NclP80repjcNSP2ECzf
 CQnlPaqXdr5iEeQn0VfsxWvGaI4UFf1hAQLbeaaVRYg/4hB/8zQGjBw3kzQd6RWBhlRU
 G1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=iJPFiDdoTrBrSdqjTpE+VPFHmC8ax0pLThG7IGKangk=;
 b=YQo9Y3rmgWGdreytui9cisBcXnaV4yaUyFuVEZOGwfIhr3dH/T7rveAeCP0tWC7dZx
 VSCTmM7IhdScgQ8FvSMEl72J+mnsACg/mFlcS0rIlbIJCZIcZPsT0N2xGOCidQolAEuh
 hEMO6G5Ks9TiQyzpUWHStXTpzLYVxes0FaDQAyPxx+7o/86IGqjTpWjF6dr6RXGQh4rq
 N7PLxcLNvLSqyKRS7eN3fvvcOliskGrom0gXvKwx7N1atXs53HETRbet9GZnhDcMza0J
 H8G1z/WrIBu8XOFS4Z317GvGFD6S1u7iYx4HtY6Ony5nj8uJOYA6rtaBlj/NBoDh+jwe
 PGhw==
X-Gm-Message-State: APjAAAWRfTx/5db6Gy5hNbLD31OIWaCPzGTASFPyjf77VjJkYLW+7BSm
 /IMibcKIL7e1GMEj8ydocf/aJd7NBto=
X-Google-Smtp-Source: APXvYqxTG4dxeNv2aoSLu1cumiV7gAuV9hcPKvGjbWfymM/Tqr7q01DvKziXiVpBQtLaPO5sHG9+HQ==
X-Received: by 2002:a17:902:bd8e:: with SMTP id
 q14mr9152361pls.199.1576387062386; 
 Sat, 14 Dec 2019 21:17:42 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id u10sm16596528pgg.41.2019.12.14.21.17.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 14 Dec 2019 21:17:41 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org
Subject: [PATCH v4 11/12] thermal: armada: remove unused TO_MCELSIUS macro
Date: Sun, 15 Dec 2019 14:16:14 +0900
Message-Id: <1576386975-7941-12-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
References: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191214_212503_930005_4579CF59 
X-CRM114-Status: UNSURE (   9.69  )
X-CRM114-Notice: Please train this message.
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
Cc: Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Akinobu Mita <akinobu.mita@gmail.com>,
 Amit Kucheria <amit.kucheria@verdurent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This removes unused TO_MCELSIUS() macro.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v4
- add Reviewed-by tag

 drivers/thermal/armada_thermal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 709a22f..fc6dc10 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -21,8 +21,6 @@
 
 #include "thermal_core.h"
 
-#define TO_MCELSIUS(c)			((c) * 1000)
-
 /* Thermal Manager Control and Status Register */
 #define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
 #define PMU_TM_DISABLE_OFFS		0
-- 
2.7.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
