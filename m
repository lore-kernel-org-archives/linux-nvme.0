Return-Path: <SRS0=zMYu=ZQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F038C43215
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Nov 2019 14:09:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 649C32075E
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Nov 2019 14:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZHmWjVwa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNhNJTaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649C32075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=lcwC74LnEI8dqdwXRTRlS0hYcpu1adTw2662gCrsZos=; b=ZHmWjVwa1eRVOfAjPYwGXv0AkX
	g7w3gu84FxHLZ5EShWXXPWmJ4yIHLtd46hJsDGUwG75MeSe2ANlvG+kaWCWxos+B0lvUmyPis4Y1a
	WJ1/Rl/2wALEoXBTNjtPZmLwXFoBC0VmK+npPDwX7WclfkSu5FYBr8weEqEB5u9G2lDiCvyOtmPRM
	STZx6W5mEXR9M1tuwldzEzRBiEciC+p+RpR2QjAzyvgYU12fpKvIyWadVKH5PIpqa6t/D/8ruQ08u
	wDwMcoq4UCIKywpUt0Dqq2NRVxZSVX8KZ9y74Z25zAQ/kRBrpBhnCSC20SWgPQP5+RV0Hti0A/WEC
	vCzFJj4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iYsaC-0003lG-V5; Sun, 24 Nov 2019 14:09:48 +0000
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iYsZr-0003Pa-73
 for linux-nvme@lists.infradead.org; Sun, 24 Nov 2019 14:09:30 +0000
Received: by mail-pj1-x1044.google.com with SMTP id bo14so5258893pjb.1
 for <linux-nvme@lists.infradead.org>; Sun, 24 Nov 2019 06:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GqKt6zdWfZywezSW3C4ZkPtud9ch/0Uh/6q3QjZGy/0=;
 b=lNhNJTaVbOYkgvALBg5TYxMoq8zHMyfVOu3sxGp7bmwZFD7wBp4Y1O15pm8Oz3YqTT
 QHYl3RYDZUBvL4JRBlICIV4t5EAUfVooVi999U9O8IpccoBPzz2Tx6DytcNdG+wYBDh/
 5HqaVGDNHbEEDib3zIf4hSbQmCkO2umeNYEMmqBmKQruaVQIFMyzbfA0zl7tFlQWip9N
 Hdbm5rsD48oZ64JjDYvAsyVCipezgtYHBNNPi8JLYzwRhdaG4hOzCBR0S5fig4zc4rHD
 +rdOHy/VgFex1Eqdp9H7p+E4YXM/KtNYUNlHkOnZf81/IPH+SkxfHIXoPV/oUn7WDBTM
 WjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GqKt6zdWfZywezSW3C4ZkPtud9ch/0Uh/6q3QjZGy/0=;
 b=PsSgAmyaAYNSVUAHWIooDWaHM91IoT1MJgT7MOnJ8zdhxNV8zygCLx/OJx+nnz+YlJ
 eh2tQuVXoveQyrtEpm5qOcB11aN5zRRmRuFgP50A9aqJT+IQZ7bKnCEyqjXAv8ER3DRq
 xCWnpvXhg5B3VTxB9khFET086C6q5Om9fCHa00s2gh0lLmrdcLP/6COb0trhFGFy0rH3
 5+Do7Z8UrAJ/i65yKoCmy3/59Gx2gGAVjWzvIX/JPeh6PPaWus8fhz4G/lJurBRrAd70
 IQuhFdkfQkrO+idmJjQyrrkaGpKqzDmyH9IMBxh/CzotoegZwtDqsfejPMbPM1MqZo38
 VJOA==
X-Gm-Message-State: APjAAAUntSZsSKAMojnK4ksdunlEQ2Q9EG+vnuEIngM300KTvaCdw3/P
 ochYkyA/DKzOLtNfuz9YRp5dz/C14eU=
X-Google-Smtp-Source: APXvYqyk+tVzVqLTp1q5GIHaF/zWFrbxTxJ6dlTdJpNb8Ke8+dFQc2bkHdcu0WkqO7ewXlbG9toS4A==
X-Received: by 2002:a17:90a:c56:: with SMTP id
 u22mr31571968pje.24.1574604563465; 
 Sun, 24 Nov 2019 06:09:23 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id a3sm4816326pgh.91.2019.11.24.06.09.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 24 Nov 2019 06:09:22 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] platform/x86: asus-wmi: switch to use
 <linux/temperature.h> helpers
Date: Sun, 24 Nov 2019 23:08:45 +0900
Message-Id: <1574604530-9024-4-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191124_060927_311465_3A7065C3 
X-CRM114-Status: GOOD (  13.64  )
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
Cc: Jens Axboe <axboe@fb.com>, Amit Kucheria <amit.kucheria@verdurent.com>,
 Jean Delvare <jdelvare@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Sujith Thomas <sujith.thomas@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Akinobu Mita <akinobu.mita@gmail.com>, Eduardo Valentin <edubezval@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, Keith Busch <kbusch@kernel.org>,
 Darren Hart <dvhart@infradead.org>, Zhang Rui <rui.zhang@intel.com>,
 Christoph Hellwig <hch@lst.de>, Andy Shevchenko <andy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The asus-wmi driver doesn't implement the thermal device functionality
directly, so including <linux/thermal.h> just for DECI_KELVIN_TO_CELSIUS()
is a bit odd.

This switches the asus-wmi driver to use deci_kelvin_to_millicelsius() in
<linux/temperature.h>.

Cc: Sujith Thomas <sujith.thomas@intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
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
 drivers/platform/x86/asus-wmi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 821b08e..6a1a2f9 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -33,7 +33,7 @@
 #include <linux/seq_file.h>
 #include <linux/platform_data/x86/asus-wmi.h>
 #include <linux/platform_device.h>
-#include <linux/thermal.h>
+#include <linux/temperature.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 
@@ -1512,9 +1512,8 @@ static ssize_t asus_hwmon_temp1(struct device *dev,
 	if (err < 0)
 		return err;
 
-	value = DECI_KELVIN_TO_CELSIUS((value & 0xFFFF)) * 1000;
-
-	return sprintf(buf, "%d\n", value);
+	return sprintf(buf, "%ld\n",
+		       deci_kelvin_to_millicelsius(value & 0xFFFF));
 }
 
 /* Fan1 */
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
