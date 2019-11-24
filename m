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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BA1C432C0
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Nov 2019 14:10:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF272073F
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Nov 2019 14:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DN0FkvFG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOYyBixa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF272073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Tw89vQ98Y8SaCfW2XGgb6aFwbleStAcZLhJwY+owNOw=; b=DN0FkvFGyfANqTAsCKjOXuHkCX
	PchBdk6I8drKc18mMZXr7an3NovWbKCJmB8GQiUZK+U8JIdO394J8TqK45Omc5IivsdT5+Nom5emM
	VBjYZF3Yo/usUpCgV4ZVBI90JuyObvCn8N0ncp+oi1ySItOhJsvMI1MXZZIzztYtFbdadKyFvfl/f
	2OzLk132QphBjHku0UoA7M7mi99A5RM4n/1OhkBQntYPToR5wrvqPf/DMXgniC5lQY6TH+VdUiHmr
	4IkIhusyw3KSzLW0e2+aH9GxTKjXSQ3eclJ4rlNR9I9IMS2BkD5JrxWEpdicHe7v13sft+ETfTXMK
	xTNWGeRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iYsaV-0003ym-Pq; Sun, 24 Nov 2019 14:10:08 +0000
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iYsZv-0003VL-O8
 for linux-nvme@lists.infradead.org; Sun, 24 Nov 2019 14:09:37 +0000
Received: by mail-pj1-x1042.google.com with SMTP id gc1so5248370pjb.8
 for <linux-nvme@lists.infradead.org>; Sun, 24 Nov 2019 06:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=SVtnbt2w8p1WjmEYI/RfZYho5p/l6mhZ+FEaY9XVk9c=;
 b=tOYyBixaF5cpNMF8ZO7JnE6N1EtCAZ75u7z42W4hABZwe+DAWLHZc634bLtAHRXXHd
 TB9DxYSIAu9yTKUTxpfIjmdsEfaTAvlElIA2ZC+kC67lmVZBH1R+ncjMNJve5x0kRuwx
 bFRAB7t+ABuPSvFKh2te4qkm/oIzhUl9d+Z743wlfc+IfcwSZ9bMcRX31RU5XlMejDDQ
 P7VGrC+t+YIZcgMpIC/bxT0sMiZyAqgKd9fgJ3zSgbdgCCE0F/orDI89ghBjQg6tkij5
 BXYQ81S0DWGo9K5+VLrq3Wuy3U1wi2Vjc4A9H2edizEiiWKInP91OPLvd6kM7XlsD3hR
 0I0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=SVtnbt2w8p1WjmEYI/RfZYho5p/l6mhZ+FEaY9XVk9c=;
 b=fyoIj/hA5LPt4eCkMCH7AwynvCsucVfnmsNLMwFk+Ez97ytWiuBReff1zD/QsOpqQD
 6J6cWBFwzgiV+kYNwTihN8hPRhg6gN+QnP7j5uVnXW3knogQcdCgeuzgF5ncOdf3joQc
 3eYr+HvNs5KnYWudKENxNylqkdUPHceVyFtZ3FcVS4hmtKX8/+j1d0qFQ8VWMQUwoj/O
 /Ow+0YWSr9s9CbPuW7KtoTtemHeASLF5KkmtgTf6DLetwYYI65yAcNkM33eXMkRZd5kL
 D07W2OCQMqroSmltq9eCDNKzRYUkSYNH/9uFyHVzVcahNWDEAn/iWWsbvLVx4y7N9UpO
 vsOA==
X-Gm-Message-State: APjAAAUa6OzzBt1x6fz5MyTvg61pP4GuJxGqZkJWAFSiQmtMcF485jwG
 2eR87Yd8r6D/ln09MM4D3Gd/nIyJNDI=
X-Google-Smtp-Source: APXvYqxhgSSnEyAEssT9mHzY0Xl6B6xR3rhtdCcR/L7wxpVcIjm+OFIVSR2lzjjR7O5c30UgpLP8kw==
X-Received: by 2002:a17:90a:9705:: with SMTP id
 x5mr31569174pjo.37.1574604568908; 
 Sun, 24 Nov 2019 06:09:28 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id a3sm4816326pgh.91.2019.11.24.06.09.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 24 Nov 2019 06:09:28 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] platform/x86: intel_menlow: switch to use
 <linux/temperature.h> helpers
Date: Sun, 24 Nov 2019 23:08:46 +0900
Message-Id: <1574604530-9024-5-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191124_060932_031680_A8865449 
X-CRM114-Status: GOOD (  13.98  )
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

This switches the intel_menlow driver to use deci_kelvin_to_celsius() and
celsius_to_deci_kelvin() in <linux/temperature.h> instead of helpers in
<linux/thermal.h>.

This is preparation for centralizing the kelvin to/from Celsius conversion
helpers in <linux/temprature.h>.

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
 drivers/platform/x86/intel_menlow.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86/intel_menlow.c
index b102f6d..6313591 100644
--- a/drivers/platform/x86/intel_menlow.c
+++ b/drivers/platform/x86/intel_menlow.c
@@ -302,8 +302,10 @@ static ssize_t aux_show(struct device *dev, struct device_attribute *dev_attr,
 	int result;
 
 	result = sensor_get_auxtrip(attr->handle, idx, &value);
+	if (result)
+		return result;
 
-	return result ? result : sprintf(buf, "%lu", DECI_KELVIN_TO_CELSIUS(value));
+	return sprintf(buf, "%ld", deci_kelvin_to_celsius(value));
 }
 
 static ssize_t aux0_show(struct device *dev,
@@ -332,8 +334,8 @@ static ssize_t aux_store(struct device *dev, struct device_attribute *dev_attr,
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
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
