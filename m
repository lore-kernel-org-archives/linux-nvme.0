Return-Path: <SRS0=mBQh=ZU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EA7C432C0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 14:56:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F7D21771
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 14:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NuMbNal6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZfJdX6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F7D21771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=CaWK6bYwekSI50oSHb/DmUoJBuDnmJpjAeBLf3uUOGM=; b=NuMbNal6M+oMyBSB+cLESLhEdV
	Sj9xsUX4vB6lO2QyyVTq0G0Y4H/aJzUJvMxNApNEi77uh59mfiwyYLy5qKOPxR78O765ONXf7gADF
	UZoJzzhzBQKjPzn9KBxET3e0xX5i137LA29t7jOtPPht4+WxP5wlyyVUtXpc60yLg+qV62S0zsEHi
	5mG7dewVOpbkQSso710RFZGplM3rj5h+Bk/7CrOhMic1FWzA+c6LuIe4t8/3PqDWZPo9BRWD5STxA
	o6Kl0EghsqrqIW2FRdkLyHe5fSX4jmHSWXRQZnDqQ8Ah4AD/px894qNHTh/o0+wRrTykw02eK7yTn
	kchGrpkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iaLDE-0008KZ-GQ; Thu, 28 Nov 2019 14:56:08 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iaLCN-0006Ta-NG
 for linux-nvme@lists.infradead.org; Thu, 28 Nov 2019 14:55:17 +0000
Received: by mail-pf1-x442.google.com with SMTP id n13so13282582pff.1
 for <linux-nvme@lists.infradead.org>; Thu, 28 Nov 2019 06:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XLU+RhnbOLO++kk3A2l2hX8YNotokH7UjGIfreihyFk=;
 b=OZfJdX6whHMuR6GPApqn8rRuOEAnRf3w5c08IbXIUPnDI1gkAXOeEWealwKTYg1aLG
 11ye6u77N8A2CX+effHDLr1fku3ylPiH3hhhZqlmY3KN0gbLXXS6Z5Q0bAE2f/jcTSwn
 nMLvypyNuRxsTBdEVODvH8U/Xz+FQe4c88fqRuKFL9/BzSY2weg1rA8zg+63sqyQXNvb
 skqYPRd7XR+mT1G/dHIBao98RWWhcDBBTI9lehVrwK79KZyGhK4oyWwj9nGRV3b2spmU
 7cS5vO2Dk3x4plo5u9YFJLUgfjBJ8lKXFcEo7khVKhPa+AlMyTxPh4yq7QCck4JXmJlV
 dlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XLU+RhnbOLO++kk3A2l2hX8YNotokH7UjGIfreihyFk=;
 b=Zk8WjrVGygdRsSi8iw9yZDYmd22+0M6n2XGQq7/vE6LOvnxjWXCk88Cmz1uGUqRMRx
 J35zdIQQ9KIKpUaKhKSU8DODA92vm1LRx3RNqagrYCmzIm2jqCvm414OVdx/Vpos+Ahe
 4Jifl2wrZkneh/KLa3xauuyiOaxNF3WyMwxxMcI3ddGqa0V2iIyCZsJbHuJewfaHu3th
 VlwE4inUtirnmUUVj8mPy44tqY3Sa2d9qH+Wt1Phg3oEXQRe+Qh5Eg6ixAWbh4YSZKg/
 CaqWxj1r1jBNTN/qCk+jVr1OYb+BbmIE3WwX8e0lYIcYMTkkEpDdanvnOVzVTu9/2hW6
 Jh9A==
X-Gm-Message-State: APjAAAXFPDLG2scmELKJ+G9eMKv1cptEsesvZ+jC7R0P5egPUqrFDeSB
 GCg06RonIItIODmJXyH+j3Od5W3VVnU=
X-Google-Smtp-Source: APXvYqwzpYgJ9dVAN3Isp6uQaRiApCWUSpADNNzkXMrApBhMnK2khllI7c2bFpkogeF4MiSUBjiHaw==
X-Received: by 2002:aa7:8aca:: with SMTP id b10mr13507218pfd.213.1574952914062; 
 Thu, 28 Nov 2019 06:55:14 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:8015:e854:5ef0:f52e])
 by smtp.gmail.com with ESMTPSA id z11sm22282563pfg.117.2019.11.28.06.55.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 28 Nov 2019 06:55:13 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] platform/x86: intel_menlow: switch to use
 <linux/temperature.h> helpers
Date: Thu, 28 Nov 2019 23:54:35 +0900
Message-Id: <1574952879-7200-5-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
References: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191128_065515_883112_E9BEB455 
X-CRM114-Status: GOOD (  14.37  )
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

This switches the intel_menlow driver to use deci_kelvin_to_celsius() and
celsius_to_deci_kelvin() in <linux/temperature.h> instead of helpers in
<linux/thermal.h>.

This is preparation for centralizing the kelvin to/from Celsius conversion
helpers in <linux/temperature.h>.

This also removes a trailing space, while we're at it.

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
* v2
- include <linux/temperature.h> explicitly from thermal drivers
- fix s/temprature/temperature/ typo in commit log
- don't mix up another fix (format string for cellsius value)

 drivers/platform/x86/intel_menlow.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86/intel_menlow.c
index b102f6d..12c1094 100644
--- a/drivers/platform/x86/intel_menlow.c
+++ b/drivers/platform/x86/intel_menlow.c
@@ -20,6 +20,7 @@
 #include <linux/pci.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
+#include <linux/temperature.h>
 #include <linux/thermal.h>
 #include <linux/types.h>
 
@@ -302,8 +303,10 @@ static ssize_t aux_show(struct device *dev, struct device_attribute *dev_attr,
 	int result;
 
 	result = sensor_get_auxtrip(attr->handle, idx, &value);
+	if (result)
+		return result;
 
-	return result ? result : sprintf(buf, "%lu", DECI_KELVIN_TO_CELSIUS(value));
+	return sprintf(buf, "%lu", deci_kelvin_to_celsius(value));
 }
 
 static ssize_t aux0_show(struct device *dev,
@@ -332,8 +335,8 @@ static ssize_t aux_store(struct device *dev, struct device_attribute *dev_attr,
 	if (value < 0)
 		return -EINVAL;
 
-	result = sensor_set_auxtrip(attr->handle, idx, 
-				    CELSIUS_TO_DECI_KELVIN(value));
+	result = sensor_set_auxtrip(attr->handle, idx,
+				    celsius_to_deci_kelvin(value));
 	return result ? result : count;
 }
 
-- 
2.7.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
