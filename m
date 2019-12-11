Return-Path: <SRS0=peCB=2B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00514C43603
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:55:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB0F214AF
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SHG1f1m9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PJLv+l1d";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTFNRC0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB0F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=3olNDpPkbz7Y/N0ghSiVvlltkbLX6WHzBJIV4Eglcj0=; b=SHG1f1m9+CsJ8TeVyl6hGIg9VU
	Nqvl+lhxIqh/4+qVw11LZx6Fl+UwuJmAYjMIk9mLrqIagC/6EJvYqdFPJv/BV5cv9NIAe9T1yWFAx
	wHUnu/wqs+nKwYaCgjM72fe+Nn1F/CzVI+qoQlmzkPEE17uK6JCmWZ1V7TNDvEVgFgRG7vwutHCyK
	8ccq6d+v66NA++oGKMJt7/nkTlDTf+vp8h1IYKLMHpSpvjptx4ZB2mrl4Bn/LzaQM/kbf0FhLllFb
	RGd4Geo+ZgO/Wgk0Jr9iZB8er8MFdJ1+3+2LW1AcXJGF4/jJgwvuE7awUkkBwNJcNgN7ISBW7JGdf
	xfROg8Aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1if3Or-0002SL-1P; Wed, 11 Dec 2019 14:55:37 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1if3OH-0000cj-HT
 for linux-nvme@bombadil.infradead.org; Wed, 11 Dec 2019 14:55:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XbYbcASd2+KhdijffyhFolrYSToXlnSKrqANevTKCr0=; b=PJLv+l1dQ6glhKhzB8Qvurdbk
 JHugLA4leLB3AsA1R/JeruOdDQvmgo5+6Wl4hM27TPr6cz81I/CNyEb/kEsgKqaK9yjNfKUI3tdlE
 CYzniwmHVxY3rA8K+TyaReV8P0k0shbNqZux9WanmDg1kx2coPC+3ClMdavDgbo8aHNIrLqWhGHuv
 kJ5xjr6d4nPaaicqhW4uc6FHIkz5UmCC/lr37oaRGL4I8gRGUXGbEGWiErNfUw4hW16D3kzclALef
 HGhvUv5YRh0LABzJBVh9nR7Kc4rIiB6o3P00EejJuRfaVqJHUs8sxozWQck/2qS1jg/IlKqq1JPM5
 Ao/CM8v9g==;
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1if39p-0005hq-QK
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 14:40:07 +0000
Received: by mail-pj1-x1042.google.com with SMTP id j11so7894435pjs.1
 for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2019 06:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XbYbcASd2+KhdijffyhFolrYSToXlnSKrqANevTKCr0=;
 b=cTFNRC0SDsTy6TOB5GAhoEjp+6Nx4jpqI/v0BumN/4YTcJP+nvYX069JP+MbzEagHr
 H0ef6hXStk3Qg5lCvjuLedPwtDGDXfRoB85H+g1U06dX5OfXuUM2jxLvl6Cjs9tJ1WL+
 S0yPKhGp9Gb3thch8kkmllLkaCqodmqe2Sx4pEr+RL5dqATYLc3rAUoO5MLajiv7DCO3
 JNeUQRpuduNY8cUkoj6eofMk5/c454aa+Ha1eoWmL458SQ2qJ+ii3tkN3pBKHkkAAY6b
 u0wOCJNda/YXvxTj1qSg10BkhZrqKRHmv4Z2Tw0e/Zvq2XZkBq2HeYHcgVAzWVb+uVUw
 R2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XbYbcASd2+KhdijffyhFolrYSToXlnSKrqANevTKCr0=;
 b=XVgk0TVRi286y3sBBzheP1WqOIV7gi3yBgoXoDi0we+b4nsS89LlY1Lu+HXvPPlvJw
 wnmugOSPL79CiJlyRh3rC+EJwwNNGQ88vpexyDmvfVbsQCv1Pvbmk0xGh/5LD05GNm2E
 s8o2S452OE8O0WrfWJ0MVJYovG4clIc1NQe0K5VZA2D2tXDXezKKJOtRjejTwmaePzsz
 SHQE1eiL+yr9XUvh9mQ1pyniQvJctdOvUPS3E5cBaePO+Km+bDXzqTaIMAev6WZXkQI/
 IBca0EcSDxbIKWRS89BZSqGnvBDC0O19Eq6+h/4y2df3mwglJbVsPZ40W8EAaCAycZEd
 p4Ow==
X-Gm-Message-State: APjAAAUKPPfCdOINnhJx8OTbUXX67LBQ4jyJCRaL0lBaEcR2qgStZBUp
 XqWOiH2X3OWrQVfn0plYvyCGMzb7wpo=
X-Google-Smtp-Source: APXvYqw0ZMYCDczwvXAKv4QaKyfYTxS7oOjP0rRHfMNhKXXkmJLTUVSslEFXuouLo4HrbdvcoGIzRQ==
X-Received: by 2002:a17:90a:970b:: with SMTP id
 x11mr3797597pjo.35.1576075174618; 
 Wed, 11 Dec 2019 06:39:34 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.39.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 11 Dec 2019 06:39:33 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/12] thermal: remove kelvin to/from Celsius conversion
 helpers from <linux/thermal.h>
Date: Wed, 11 Dec 2019 23:38:15 +0900
Message-Id: <1576075099-3441-9-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191211_144005_853841_DD88CD92 
X-CRM114-Status: GOOD (  13.19  )
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
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* No changes from v2

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
