Return-Path: <SRS0=peCB=2B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E141C43603
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:41:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBC8222C4
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uvrv5PZK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfB0dMl6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBC8222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=sTtClo0QRyMGmp8GvVbjJLUhlgJppbnZ2kS+/hXbWuk=; b=Uvrv5PZKjM15AnBj30fYXIw/Pk
	ywjB8RnJAbYZJY3WFW4uHuHTVyVsnPGmjxXcF/W33r3CEORtX46Pg2EfBr+IRmbrlvyVkPVvNwSIP
	bQghOvU5d8wziM/8IRdCYugIG6GtBHPDx40EiS/317LwTT9H68mVgiDfcdcz6GyVI6PK+FtosmzXl
	oggoBFUN6K7nsIO6YunPS/S1vAPPT7FkxLaQnU5SWmlihxqvJcP11WTLvPVQ53skpnuQGuDjH5FMh
	w+2VKuOtIlYDRB5Y9YzcVtiO5MO/p1qsLPSz2B7a+ZJIP8ixekIhkfB7JipWDOcYYgFiu2UI55Xhh
	W4OuajyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1if3B1-0000od-IJ; Wed, 11 Dec 2019 14:41:19 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1if39X-00072G-Rp
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 14:40:03 +0000
Received: by mail-pf1-x441.google.com with SMTP id p14so1916464pfn.4
 for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2019 06:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GhXVAnhaL3dF2Pk0jAZjmHL842tdRou+nNjmrun5mDI=;
 b=GfB0dMl66LMji7iSDluDDgU95hFyrbLyBDa8g9R6tZQrYvzznr7sbD0EI+zx9PZa2a
 UPcDzuUIfU+mXjTqpj1nB/cZRBTziPKDINSxpV160A8qKLUskV7icNyoDpzGtFJ/W4WG
 2iBDG2uBtjRDggXzegIdkZ21vawseCOf6qaPFh0AlPaij/VqPMZ1PrqwB4igUsER3fw9
 MGwC4Bw2o1XiM61vnkvQn/3OuFljldg0RPznpVhmrQCbj2V20rgrMUe4mQ5FtASiBaVH
 t8gKx1S12ypjJZhGV6bC07NGCq71O6eQQkdVJ3Dpwjy0E0oVLRZkOjg1ya4ol/N4tXPC
 gHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GhXVAnhaL3dF2Pk0jAZjmHL842tdRou+nNjmrun5mDI=;
 b=hwpm09dZ1hW9bxshD8dd4f56xhp5Gv1E4BY87NaRI/RN0pWP/PLn5ckJIIsHTl38Mr
 C3JjYVnmI35uCSL/3ldUy+nIGHi5R1em0z5mRueDlxATcVMIci/d0kvDQ3AqfaaKVutB
 fHml9I7PcEgV9/BmlO2lh0FCe3oHpbMJY7uyBUK1bRwdva4ofyGvyUgxzWufW3/aRdMe
 Wvhci5L6VKTCXUfn1NEHrTdocuTaQJ2mZjsC1IGnU/l8D6I2XvGgs9bSlq+Gt6/W1bau
 LIqXv7Ai0H5Mx4evcYyvMFpdJiDGNCPqPdxvQWjBRiY6P4iKlezL0JZhyYvVkTflSCQf
 jimQ==
X-Gm-Message-State: APjAAAWSj1ElH7ILde2LQcH9Bom+ub/WM2Pi1OfNY3OYwHVZNIm56qnc
 PX0ozsRA7YRqbMcPtyNAH3g0+ZMsabA=
X-Google-Smtp-Source: APXvYqwSkDQsttnam5DXc1gmHwbz0oD5Nrbbl83FHdZwnnYrsoV2z/G3N/ntf8aYY+yXSPtKkfWXnQ==
X-Received: by 2002:a62:1883:: with SMTP id 125mr4054521pfy.166.1576075186342; 
 Wed, 11 Dec 2019 06:39:46 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.39.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 11 Dec 2019 06:39:45 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/12] thermal: armada: remove unused TO_MCELSIUS macro
Date: Wed, 11 Dec 2019 23:38:18 +0900
Message-Id: <1576075099-3441-12-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191211_063947_919479_B6FC75DC 
X-CRM114-Status: UNSURE (   9.91  )
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
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* New patch from v3

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
