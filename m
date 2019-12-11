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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711ECC43603
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:39:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ACBD2173E
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PeTUvVbv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2AOHOEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACBD2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=lnQErmzuWN+62e7UA3pHwPJkDkfVxln5HtTfHObbjRk=; b=PeTUvVbva9CZGkxpZBpC6XGCaK
	HOnEcCFzNg9FEk1e5qHcDxYZtjSqQ2/pC/p+541DokjuBSR+uTqaH1C/pWjifUDsoYsi4cPiqfXrO
	Azljgiix1bM9/1ZX5Hg/6AaBhfelE9ZEFRcw9L7ag/T259jQ+2MS+ixPtjvN890PbKN9kCKw8jDff
	vOKkxCPfclHQYe5JOGBxRlAjKK58uw33CS7umXASkSVEG3QpWfIyJuBOkBr2N994ZQk0YwjMQbPul
	rcEJiwHYizBWWH4NRttsOWxdWqEoYlzEKNxPD4/77mBm9h4lIJ/gtVSnrLv4m4npEwrAjMrHL6eQ+
	sXrtxZZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1if39T-0006yB-54; Wed, 11 Dec 2019 14:39:43 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1if38u-0006Rl-2C
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 14:39:09 +0000
Received: by mail-pf1-x441.google.com with SMTP id x184so1918484pfb.3
 for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2019 06:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5F0PPdfZoQeR4+ehc0BK4J4+yf/kLV8FFWeTQgbLqO4=;
 b=D2AOHOEMCyO3k0hjvFxCCgKEqw3qsFhSE3sCThcc9FU8sN4//6ZWrWkG4W0Gw5n5Ql
 tnp6kAtoTrDnZfAVIlvPnYrYsz7QXKkZDhw44viq5clQ7OOY+SMTFX/cE0NORObwwHJw
 C4CPlUCRgN2zccpdBIat2VJElRlPGOguLM6h2WjaYzB7Hw4VCD8ljH78NdA9JrCOe5bh
 B2+rv7y7IQkBPBmDzviHzyAhk8WOzaLp9nk55/T4PP4tUjiDmDN6zvWs7KXdkfW7+da9
 81bR72bXCAr0IbLnDyZkZcA/Zmg1Qm376KSytapK2fxSgAtL7XjJ/OyTV0lIxAZXC/42
 nRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5F0PPdfZoQeR4+ehc0BK4J4+yf/kLV8FFWeTQgbLqO4=;
 b=mU0IlsiWBRZKoAybghL0u+UIHZMUr2rGyGg/CcqEJE7UIkqtpNIqcI1L4Yw8RSSZdq
 drPJCVXjq7j7FWIvfUttZu0og0p+jK3xtMelf/jPq754PocXLY1B8tnMkV/Y/YII4Ee+
 uupigUyE8cPxj9FgfgKB34sWPEDq2lBY/sTBXREKq6VZY2cl7V1vC8KpecBvCNFgpHDi
 EQ1pSHCZ5h92SaPC3/fJxsOVVAMbp5zFNWMX61GzIrDsAq2xcp8poOtbfMA9jB+59IMS
 wdo8atXhfj1hfeieE8Gmm32rQSWbwOVTOY6VNRs1RWAbFhf15AnMnEVsELR/1Bt7n+Rh
 6AaA==
X-Gm-Message-State: APjAAAX9I7ZoWk2Vun77p9FyD+fSVbKbxYlos/9ui3/V1VfyyeiYLBoz
 yyltAoecqbz+XMyido/0uKqs0NCtRuk=
X-Google-Smtp-Source: APXvYqy+ULp0BtV8BOiWwljH1aYQKPrE2YUyS2+/jHA9IgLPTQUYtDOyRF2WZHmnIuuz2UODfEYp1Q==
X-Received: by 2002:a63:184d:: with SMTP id 13mr4515647pgy.132.1576075146466; 
 Wed, 11 Dec 2019 06:39:06 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.39.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 11 Dec 2019 06:39:05 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/12] platform/x86: asus-wmi: switch to use
 <linux/units.h> helpers
Date: Wed, 11 Dec 2019 23:38:10 +0900
Message-Id: <1576075099-3441-4-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191211_063908_122501_C3135FB5 
X-CRM114-Status: GOOD (  13.68  )
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

The asus-wmi driver doesn't implement the thermal device functionality
directly, so including <linux/thermal.h> just for DECI_KELVIN_TO_CELSIUS()
is a bit odd.

This switches the asus-wmi driver to use deci_kelvin_to_millicelsius() in
<linux/units.h>.

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
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v3
- rename new header name from <linux/temperature.h> to <linux/units.h>

 drivers/platform/x86/asus-wmi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 821b08e..ed74c0d 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -33,7 +33,7 @@
 #include <linux/seq_file.h>
 #include <linux/platform_data/x86/asus-wmi.h>
 #include <linux/platform_device.h>
-#include <linux/thermal.h>
+#include <linux/units.h>
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
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
