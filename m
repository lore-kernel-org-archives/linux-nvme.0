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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02677C43603
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Dec 2019 05:18:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D4421D7E
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Dec 2019 05:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JJndeGf4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CARqNQEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D4421D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=RISom6VTAFAFQWsTEhGkCaSaoNAnjof76c/pTuL4Rd8=; b=JJndeGf4GRsVY04gg0qEROFg2p
	cCYQbZT1GWhXhy+FbTkl5iUqwF0/KRTD+gCPMYNQS/jJCJRvxBII7arJqb1LvLgQ+WWGJS4Jt1J1n
	WrrkRsNNxVo0nlAy5fMvssj3oUeWPVjibmup5EP0IOfKxZTTfjO9mYtxY8DuvqDK685dwm9zEp8M+
	oLqA3WeJa9Z27A5Mo7+kYS5ORC2UaqhOmXWUmxdEaCDUd+eDLoxzUIHGSBjU8rqPy31NxFgABDhgf
	vlRpRqnldhR1rp5Jo82Ghgx8wYGwR8UoxUo54XwnfaDDsDPitwjXPnH2z1VfEc0Xc1u7MBz1Rzl7l
	cMa7ldVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1igMIa-0002s6-HA; Sun, 15 Dec 2019 05:18:32 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1igMHc-00025V-69
 for linux-nvme@lists.infradead.org; Sun, 15 Dec 2019 05:17:46 +0000
Received: by mail-pg1-x541.google.com with SMTP id k3so1729556pgc.3
 for <linux-nvme@lists.infradead.org>; Sat, 14 Dec 2019 21:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wNtUm+SbN+0a8GrjUSZCRK4zHG4L4L6an0ip7ptF0d0=;
 b=CARqNQEGgXO6NPLDpqfdZ8o0UQ+3RuRnE7NqTCXaWSswkmnp/+HkwkITZstEhn/nmX
 HcevBsy0kEg3sUHjdGc0RqmDxfCBhjAM8THzFd+Xvl67sT7JSUzI73iuR2E/l4+ncAGJ
 HjGYI+FzFACe1DhH/ZzpHu+m/62n2xsZzbLMSt/ANKN1fEsj+jZhvTx/XWi1q6glBfat
 kYon/9k2+Ja8NrZx4yY7DMLTmeFx1SwyhBN/NPot2bJVbU54KE/kdEqad/8zdTZi7F3+
 00KDKKCOxU3RqpVpKwJdp4THa1xZJgS+GTAdj9pFAj13S4HJn1Vb6GsDPNKClSLR7Khe
 yOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wNtUm+SbN+0a8GrjUSZCRK4zHG4L4L6an0ip7ptF0d0=;
 b=T5DPceVFZoCP60MtC+g5zPTdp/KMBESQLNDCWiiSeWOUlPb14ExgY+drtpjgk58qP4
 MJdv1aUdCTj0H2gKQQgVcMuM9lRebxETRXFYelsUN6uN70ss0L4zxcmO6TSwgG+Eoew2
 +gJmHy36JX+HSYpKTQQvR89ly10IsXRBl+fg7Cq8lDfczGwNPRBh5DiOQyCyFhdhu/Pn
 oreRQ0d3mae4P19LcryTxGWRp/4yhrOzKrWyL02C9g1Jq/8VmzztDfyZJemZ1SNoSiqd
 gHrmkQXAqHYn3uShT4uGiNDLoIVbHIKOE9+u1horZmqGN2cJJR2w6mEPBxIQ0sD9JKVJ
 dGVw==
X-Gm-Message-State: APjAAAV9xp1xPzGgCN3lWlLMc9nablGJCnSG3AO6Mk6AaQ8V6gkUwZBw
 tJBV2DXaGVuOODDNwFTmS/6czHLAxAk=
X-Google-Smtp-Source: APXvYqyRvp6w8dX6QbBOEnKG62KgsdB7W7pSUy/KgK7EVQbEeUeuesZYikCPANPFgyHy/nhytxOxug==
X-Received: by 2002:a65:4106:: with SMTP id w6mr4234387pgp.347.1576387050494; 
 Sat, 14 Dec 2019 21:17:30 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id u10sm16596528pgg.41.2019.12.14.21.17.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 14 Dec 2019 21:17:29 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org
Subject: [PATCH v4 08/12] thermal: remove kelvin to/from Celsius conversion
 helpers from <linux/thermal.h>
Date: Sun, 15 Dec 2019 14:16:11 +0900
Message-Id: <1576386975-7941-9-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
References: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191214_211732_258617_52BDEBF2 
X-CRM114-Status: GOOD (  10.71  )
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
Cc: Amit Kucheria <amit.kucheria@verdurent.com>,
 Jean Delvare <jdelvare@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Sujith Thomas <sujith.thomas@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Akinobu Mita <akinobu.mita@gmail.com>, Jens Axboe <axboe@fb.com>,
 Guenter Roeck <linux@roeck-us.net>, Keith Busch <kbusch@kernel.org>,
 Darren Hart <dvhart@infradead.org>, Zhang Rui <rui.zhang@intel.com>,
 Christoph Hellwig <hch@lst.de>, Andy Shevchenko <andy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This removes the kelvin to/from Celsius conversion helper macros in
<linux/thermal.h> which were switched to the inline helper functions
in <linux/units.h>.

Cc: Sujith Thomas <sujith.thomas@intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v4
- add Reviewed-by tag

 include/linux/thermal.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index d9111ae..126913c6 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -32,17 +32,6 @@
 /* use value, which < 0K, to indicate an invalid/uninitialized temperature */
 #define THERMAL_TEMP_INVALID	-274000
 
-/* Unit conversion macros */
-#define DECI_KELVIN_TO_CELSIUS(t)	({			\
-	long _t = (t);						\
-	((_t-2732 >= 0) ? (_t-2732+5)/10 : (_t-2732-5)/10);	\
-})
-#define CELSIUS_TO_DECI_KELVIN(t)	((t)*10+2732)
-#define DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(t, off) (((t) - (off)) * 100)
-#define DECI_KELVIN_TO_MILLICELSIUS(t) DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(t, 2732)
-#define MILLICELSIUS_TO_DECI_KELVIN_WITH_OFFSET(t, off) (((t) / 100) + (off))
-#define MILLICELSIUS_TO_DECI_KELVIN(t) MILLICELSIUS_TO_DECI_KELVIN_WITH_OFFSET(t, 2732)
-
 /* Default Thermal Governor */
 #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
 #define DEFAULT_THERMAL_GOVERNOR       "step_wise"
-- 
2.7.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
