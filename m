Return-Path: <SRS0=peCB=2B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F16C00454
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:40:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82583214D8
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fTO7m3JT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoL2MEKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82583214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=OL7iakta3CCTrbxSYnaFqXJZ+quQhLL3sY+dWzDK75c=; b=fTO7m3JTt5KxX3BlTazlP4SxFU
	OOY3nwV9pa4fO6cgFS1R0lBCHE+QuIWiXs4JT6dsdGnJEcH4CEw6CcdDur02BQZnqun/vy1Lm9ORL
	0tG5VjAuBLaJXDQR5A1w+6Vqn/Fn6VZqHEBmYYXjx4ZoFhKyj5lrEQ8ddY7ODrujFfiGMMU1GQgCw
	2q4HP/aZFJmo2igRs4sc8C3lX8Oicc+CxG+GJS8gnnrz00L0pz47wVuELKxbtjBZMUr69pLNU14Ss
	fb2qQDUDZM/kFvPy7oNXyKIYKeiwCsBlo9Si4BahopIMe6AjPkb5O63A/HlV6IF7Qe9q2Hv9z9ljt
	KBK6yx9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1if3AS-0000Oe-Qp; Wed, 11 Dec 2019 14:40:44 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1if39G-0006nQ-JT
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 14:39:45 +0000
Received: by mail-pg1-x542.google.com with SMTP id x8so10867927pgk.8
 for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2019 06:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=G8HIqSOZSM7ZlLEzj0GZfcJL15LCKkAAkMEEiYP0HJ8=;
 b=EoL2MEKylC7MRqf5P3y3JFnFsr/PlSKtVjomV2dX1/7ZSkV2+sxGzrxZgEuNx091fk
 BKawpY7SEcgPihrYuDNS8X4ilRtwzzhvRNz/AIAys5SXt6tk57NEE4iu7lnfD69q1MaW
 lM+ROlYqmBV7vWcGEdg+EBFfrBzoG9BnscbToBGTv0UUqVM6tRuIYW9y0G9yUItH0IDI
 78hDdjc9KWP8qvsmAJWrfJQaJT2vvOr/fukTIe3fuetky7ZWaSF0Tm9w6MNghRv5gt0H
 CFFT98TRV57WRqjS6Teyv1JeMDWtMguVNnparclOk16OHVcOW1sbOMoEhNquGUAmPP7k
 A6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=G8HIqSOZSM7ZlLEzj0GZfcJL15LCKkAAkMEEiYP0HJ8=;
 b=MiZUo8e94DJbKc0rPC7caJzqO22xu5LG/BuRxpbQa57dNzaY5h9EgyCQwAD5Pz6Bzp
 hkSebscmlumFuUBnMSQy4KexrT08ZeRQlun31zSdTHPR7lqybNmhiysw3oTIP0r1ZBB9
 YvVBv25yqBp7jgPEEsJ9XqWiSSqBaWjsGAzOsBMLzOuoTVcZD71L5cjoaVIgZAmM0qA1
 6G0X8Qyg4dLNs/DVi/NTnGScB4jvF3ojQbfkDSXrAJUhAgK5ezeSnV5yYkykeXQqk+w1
 sAS7uoBI85DYYd7gF20mCJyPnsm6HEZoEMPBIIsYPQx8ArbMKHamIhViLV6ejQWnGJPL
 Eoxw==
X-Gm-Message-State: APjAAAWxq4FEpzdh9Tl3ypvXVUfgPPDIygz9iGeK1yHhJm/iK+pNa4fw
 MvvCmNM9djBkxGYAcfI9+8A4EjFo+zk=
X-Google-Smtp-Source: APXvYqzLIbq4qGAJSSgC9xZ/3+iluFA3br6Tz1ZQ92AYrpH9YCceKsABt6khTNhi4u+9CunGqaDYTg==
X-Received: by 2002:a63:6507:: with SMTP id z7mr4631816pgb.322.1576075169052; 
 Wed, 11 Dec 2019 06:39:29 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.39.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 11 Dec 2019 06:39:28 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/12] nvme: hwmon: switch to use <linux/units.h> helpers
Date: Wed, 11 Dec 2019 23:38:14 +0900
Message-Id: <1576075099-3441-8-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191211_063930_695936_BDA43C0E 
X-CRM114-Status: GOOD (  15.65  )
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

This switches the nvme driver to use kelvin_to_millicelsius() and
millicelsius_to_kelvin() in <linux/units.h>.

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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v3
- rename new header name from <linux/temperature.h> to <linux/units.h>

 drivers/nvme/host/hwmon.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index a5af21f..2e6477e 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -5,14 +5,11 @@
  */
 
 #include <linux/hwmon.h>
+#include <linux/units.h>
 #include <asm/unaligned.h>
 
 #include "nvme.h"
 
-/* These macros should be moved to linux/temperature.h */
-#define MILLICELSIUS_TO_KELVIN(t) DIV_ROUND_CLOSEST((t) + 273150, 1000)
-#define KELVIN_TO_MILLICELSIUS(t) ((t) * 1000L - 273150)
-
 struct nvme_hwmon_data {
 	struct nvme_ctrl *ctrl;
 	struct nvme_smart_log log;
@@ -35,7 +32,7 @@ static int nvme_get_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
 		return -EIO;
 	if (ret < 0)
 		return ret;
-	*temp = KELVIN_TO_MILLICELSIUS(status & NVME_TEMP_THRESH_MASK);
+	*temp = kelvin_to_millicelsius(status & NVME_TEMP_THRESH_MASK);
 
 	return 0;
 }
@@ -46,7 +43,7 @@ static int nvme_set_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
 	unsigned int threshold = sensor << NVME_TEMP_THRESH_SELECT_SHIFT;
 	int ret;
 
-	temp = MILLICELSIUS_TO_KELVIN(temp);
+	temp = millicelsius_to_kelvin(temp);
 	threshold |= clamp_val(temp, 0, NVME_TEMP_THRESH_MASK);
 
 	if (under)
@@ -88,7 +85,7 @@ static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_temp_min:
 		return nvme_get_temp_thresh(data->ctrl, channel, true, val);
 	case hwmon_temp_crit:
-		*val = KELVIN_TO_MILLICELSIUS(data->ctrl->cctemp);
+		*val = kelvin_to_millicelsius(data->ctrl->cctemp);
 		return 0;
 	default:
 		break;
@@ -105,7 +102,7 @@ static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			temp = get_unaligned_le16(log->temperature);
 		else
 			temp = le16_to_cpu(log->temp_sensor[channel - 1]);
-		*val = KELVIN_TO_MILLICELSIUS(temp);
+		*val = kelvin_to_millicelsius(temp);
 		break;
 	case hwmon_temp_alarm:
 		*val = !!(log->critical_warning & NVME_SMART_CRIT_TEMPERATURE);
-- 
2.7.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
