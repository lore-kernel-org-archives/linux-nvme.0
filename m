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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682E1C43603
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Dec 2019 05:19:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 398AF21D7E
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Dec 2019 05:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mrvbi9qv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrmuGguM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398AF21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=3kbyGaqwRBOLZ0kNAWK2IB1HLoaYzT4KwhbZI79+hM4=; b=Mrvbi9qvL1/FoV9zgQCqw4vmRc
	K+Ug8gSf466N+E0a6DIQd58Cgrrufht8ZalZ5tF9y0K7/9LbMcUSDrzqwPQNzhx74DrWKIER49Wbc
	KZLM1TxvGhYemlHcJdnRfT/KQCotJa3gumCygWDxI7isnWlW/S9AVcjxRjTeGkq13/erRoTq9k5Qj
	SDCBd2IGtVezm6aTcn3RZGwL2Z6YnB0q38q2aK1XBUjqB6pHpeZnQ9d5zmeyHH47feW6DfSoJS7Zq
	d5lWdXkKK8T6CPl7GRR7yIYcRCo2wIdHRiuOl5gvtJYIU37JylbuboyUSGTVn+SCJ41tVZBKASCVe
	JkG77LDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1igMJ1-0003BA-Jh; Sun, 15 Dec 2019 05:18:59 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1igMHr-0002LG-Lj
 for linux-nvme@lists.infradead.org; Sun, 15 Dec 2019 05:18:06 +0000
Received: by mail-pf1-x442.google.com with SMTP id s18so3759335pfd.8
 for <linux-nvme@lists.infradead.org>; Sat, 14 Dec 2019 21:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rs+ph61PgowUB2wxJYFFkBstw61v/JyioJPVFcT1dTo=;
 b=PrmuGguMd8I2icLDPcfOnUjhxgAkYI89eucLm58rL6pWLvQL2jZxJTUV6iNRcYSoQ2
 sKk2OHbbVJPQZZq8MT2heyABgtzLtkONYwt26Zk+TkTkAYRNziB7w4K8Q5suhmYOXkR3
 POykAo/0yD/76gVPmRSp7biObXx0ma7YjYqyoVxlPQ1JTyhH6KpJ6H6Jnz94BeV/15du
 cwtfk9+BTmygl5heycnwix988ik+j1JV7n6H5L4OTWXP+GKoFXjVCQy4x2NB/4vNQaOA
 eoYdoyMlUaHLlo+pSFsk56d5j/vVEZ5cSa73TgiJO85GCfq+XhKbVxnbyPrRf8JLKn9b
 /OUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rs+ph61PgowUB2wxJYFFkBstw61v/JyioJPVFcT1dTo=;
 b=Nj+oelqu5CLtjN/Ucvfy2m/pp6VUX+uiCi4mfdfZQNq0Fx7HqYK2rLdjsrLGq2GcuC
 uou5YBq1VwWv85xiZ6vjFKr5xhjCHIYuBAdCaBvJa6Oeii2oOp6Cv2sivcerUlYSLYD1
 qfKljjE9JtCT1ZBK/ESgRqfMFoR/EEFnJ/r7EBW5CiGFBgbhz24V46r/kYd0tOxsSh1m
 VaDfF+kprLX1hSuJFM4zLLrPuUKiX3fnuPn9tt91KQ6GIOodZ/134wtEzYiABGIHrReA
 z5UAcgNNYvZUW3V2R4bH8Zr7ztT7T2p3sgU1NTbg4iHHTjetQzGZLbjJbfyqj4YeCU0Y
 ELzg==
X-Gm-Message-State: APjAAAWJaDyLEl+R0bcORAMu6tYvdex7OySVwbqyw3kHk3HqZUAH22lT
 y6ueOvLMPMdZTBD0Qwi78tmW04guiSI=
X-Google-Smtp-Source: APXvYqyz2b9p5as0HpR/8ZvYU3LMjgqtKZ/4OlUPaESNc9g0DwHCBTVHwRTYyxlafrFwiY2Ib4eY4g==
X-Received: by 2002:a63:3104:: with SMTP id x4mr9984060pgx.369.1576387066555; 
 Sat, 14 Dec 2019 21:17:46 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id u10sm16596528pgg.41.2019.12.14.21.17.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 14 Dec 2019 21:17:45 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org
Subject: [PATCH v4 12/12] iio: adc: qcom-vadc-common: use <linux/units.h>
 helpers
Date: Sun, 15 Dec 2019 14:16:15 +0900
Message-Id: <1576386975-7941-13-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
References: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191214_211747_796920_D853921A 
X-CRM114-Status: GOOD (  12.97  )
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
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Lars-Peter Clausen <lars@metafoo.de>, Akinobu Mita <akinobu.mita@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This switches the qcom-vadc-common to use milli_kelvin_to_millicelsius()
in <linux/units.h>.

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v4
- add Reviewed-by tag

 drivers/iio/adc/qcom-vadc-common.c | 6 +++---
 drivers/iio/adc/qcom-vadc-common.h | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index dcd7fb5..2bb78d1 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -6,6 +6,7 @@
 #include <linux/log2.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/units.h>
 
 #include "qcom-vadc-common.h"
 
@@ -236,8 +237,7 @@ static int qcom_vadc_scale_die_temp(const struct vadc_linear_graph *calib_graph,
 		voltage = 0;
 	}
 
-	voltage -= KELVINMIL_CELSIUSMIL;
-	*result_mdec = voltage;
+	*result_mdec = milli_kelvin_to_millicelsius(voltage);
 
 	return 0;
 }
@@ -325,7 +325,7 @@ static int qcom_vadc_scale_hw_calib_die_temp(
 {
 	*result_mdec = qcom_vadc_scale_code_voltage_factor(adc_code,
 				prescale, data, 2);
-	*result_mdec -= KELVINMIL_CELSIUSMIL;
+	*result_mdec = milli_kelvin_to_millicelsius(*result_mdec);
 
 	return 0;
 }
diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
index bbb1fa0..e074902a 100644
--- a/drivers/iio/adc/qcom-vadc-common.h
+++ b/drivers/iio/adc/qcom-vadc-common.h
@@ -38,7 +38,6 @@
 #define VADC_AVG_SAMPLES_MAX			512
 #define ADC5_AVG_SAMPLES_MAX			16
 
-#define KELVINMIL_CELSIUSMIL			273150
 #define PMIC5_CHG_TEMP_SCALE_FACTOR		377500
 #define PMIC5_SMB_TEMP_CONSTANT			419400
 #define PMIC5_SMB_TEMP_SCALE_FACTOR		356
-- 
2.7.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
