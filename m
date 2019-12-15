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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C714DC43603
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Dec 2019 05:18:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9044B21D7E
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Dec 2019 05:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="odnNaxlk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC5Q3xlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9044B21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HRJe9v3Uy9DFupWJ4MjbiV720xlQ5Ag/eGGwNUNg1MA=; b=odnNaxlk9Pt1zTQuL+snf85vua
	v1CLK3uWvk828YfAipEL3iLRcye5rTwTf96cKV+gPE5dr0aE8C7NprvTwgMSj8B80Q3z8B1f/FJHT
	7LSZ+gxcAnomk5299TcZDpqtPS5TtX8QD9ohOc1OYbG00OiXGkWU3srZpg1W74UmOT1bynYo5l8Fd
	moSSbso++hRS2eA/1Uzf2+GiEk2kSOm86ePf+VtsxSVUYXq8oZ19xnv2ccBPNUXB0nZeEWjQZaP2B
	iSSKPCB5Vkt/fzYzJiOJI9oUH030mr9jUHJ3SwceZf/+M6oC8olO40nAtdoz7xuwE6VdW/2ZUj/xY
	HFYrNuZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1igMI6-0002WZ-AL; Sun, 15 Dec 2019 05:18:02 +0000
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1igMHQ-0001vj-9F
 for linux-nvme@lists.infradead.org; Sun, 15 Dec 2019 05:17:31 +0000
Received: by mail-pj1-x1044.google.com with SMTP id ca19so1521208pjb.8
 for <linux-nvme@lists.infradead.org>; Sat, 14 Dec 2019 21:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dFlnRv0hadsugtVajyHRe0JC+tPOCVnj6GsrCbBgD3o=;
 b=NC5Q3xlhCVYDD/m31UtBzIc7GqULlCKQs5ldsS8eMSO7ocTrRah48V7JueoBaZjRfF
 dFYazkMieceVvYDQVsuOkcDgcQgV+R2s3QkTvDH852AG/HAOg/6bmXHwqA+hQrAtvcTY
 B/45nLwULGUuOdCwfUMpOuU0WmNIRaRqaEEXgijAWVFt0CCjv1PAXYcA+jkp2IDrAGBN
 zKWV0O1HL9cnFQ8NQnCN/BvouZMcLq7yOazxwoBEjJMZ//2o82FHAP0v2bFXLdAqt0Lk
 34CbQTdrvH938tKYyDddbbw1RfXz1UJTkIppwnsQSEyG1kyk26wdD9HbuxJJgfkJsY5Y
 3Wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dFlnRv0hadsugtVajyHRe0JC+tPOCVnj6GsrCbBgD3o=;
 b=AI/kqGRPgxMWkv/v6+cBlA7dvnK55g2seEEq9hg37FzmsgMbu2WB5WLeGbhdYdCCYE
 AFxf6xu8G4xjMI7M+QPxMb2VGjwJ73bDAkCzqdNa8BFAdigJuNgY670BR0nNLggZ2AQK
 /+Eg9A+JiZWPE+ioNTIE1x2wc82mcKB3xXLj4IFtttcG2+cB02A4Qvs2ENaiog/fbx97
 RJsjmKt6kb+zHBkUpyTTrEOBxCzHL6CQLyOkKIy1JrhKoznYM1vjiAlVXmuPKIWF3qbL
 TR1lVpVxDwGxHqH2A5PnImRKVd5kzWbloiTWuySbXsrsOBwb7V0GfGMJAeGhhTRfKYMC
 fV+Q==
X-Gm-Message-State: APjAAAX4DGfLZZYJiiL75AR+AU+6U/4Rn5Suq4iTDyE9w05z2bTB0xhK
 hE9aoTcAg49I/AdF68D1NoMabUR3Ock=
X-Google-Smtp-Source: APXvYqwbGw831TCHknZkFd89BpDoeV5W4jcrJR7PjtyCCgpjaIW4I9/0mOvOtFg2s6Cbv4FQ3LiZFQ==
X-Received: by 2002:a17:90a:f84:: with SMTP id 4mr10440876pjz.74.1576387038837; 
 Sat, 14 Dec 2019 21:17:18 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id u10sm16596528pgg.41.2019.12.14.21.17.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 14 Dec 2019 21:17:18 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org
Subject: [PATCH v4 06/12] thermal: intel_pch: switch to use <linux/units.h>
 helpers
Date: Sun, 15 Dec 2019 14:16:09 +0900
Message-Id: <1576386975-7941-7-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
References: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191214_211720_375596_560D7D9C 
X-CRM114-Status: GOOD (  14.72  )
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

This switches the intel pch thermal driver to use
deci_kelvin_to_millicelsius() in <linux/units.h> instead of helpers in
<linux/thermal.h>.

This is preparation for centralizing the kelvin to/from Celsius conversion
helpers in <linux/units.h>.

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

 drivers/thermal/intel/intel_pch_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 4f0bb8f..b118611 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -13,6 +13,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/thermal.h>
+#include <linux/units.h>
 #include <linux/pm.h>
 
 /* Intel PCH thermal Device IDs */
@@ -92,7 +93,7 @@ static void pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd,
 		if (ACPI_SUCCESS(status)) {
 			unsigned long trip_temp;
 
-			trip_temp = DECI_KELVIN_TO_MILLICELSIUS(r);
+			trip_temp = deci_kelvin_to_millicelsius(r);
 			if (trip_temp) {
 				ptd->psv_temp = trip_temp;
 				ptd->psv_trip_id = *nr_trips;
-- 
2.7.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
