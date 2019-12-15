Return-Path: <SRS0=GgRz=2F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268AEC2D0CB
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Dec 2019 05:17:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F09192253D
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Dec 2019 05:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G+F79Wcg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQvf50Mv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09192253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=FsLpMnIM0Ml5VuXK3OCaPSZ7ApydU0e6WAeNLTV3YuY=; b=G+F79WcgRtOSQ2NARwuW5F/syD
	BIiYMsPZmZKwYBQQ7tKatv5OZH+ylnI0or7hfxaHR5HHZfE/yJhih67m5dAWO/rOWgBaVXDFUANjc
	8Mff/GNVjLDoCm0iwRKtnmQc/VLSKLMhpVuvLDTwtKUi3Xvf8g0NHAs+AS3qOrrWZWdzoMpMIN4rL
	RyQ54/olpJK7pLheeH9aADxTk1mWBLhBdY1Ay8T6EjkSD2zxqNgmWDp6E2wKo7ExBJb6/3zPAfK7Q
	Ou7le2jbaeriVzqACT9QQUN+/GtCXvCoMbUU4DuljQ8oIXg5OcE1V/SRPZ/FO7F7VZ/RUx4N42d2M
	gxBnNobw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1igMHm-0002Gp-NT; Sun, 15 Dec 2019 05:17:42 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1igMHK-0001pq-06
 for linux-nvme@lists.infradead.org; Sun, 15 Dec 2019 05:17:16 +0000
Received: by mail-pg1-x542.google.com with SMTP id z124so1704276pgb.13
 for <linux-nvme@lists.infradead.org>; Sat, 14 Dec 2019 21:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HoM44YO7jKpFM5Bt686W03V+vIzdOR1TWUFJVxsK0iw=;
 b=bQvf50MvBu50bzcy5vOGO4uBYMf9uKla1LUKwxCJkyto5/NGMdf3Tp91MzlfL6sBET
 UfJH9M5g0IhJWYBxQR3K2+zKcF8+fIfQbNn+U7Q/bO5oZGY7JJicPp13WCP49M2D1xZ5
 4pMI9mLCDH1Qrx09uoA9y5Di16KiupsO7XuXUUC90JSJaXmRY0XGJePvIwZ62u1YmLP9
 UR1lezZtd6rQnu3n0XftzclCqSsnTRT5UMe5bZFvV+9Lg4iJDykx6336E/FzikHd+NUi
 6GKCu9ETSkaLNyn1vRk/sIVbMQHLuKvweESCi9ro4XeddFzJS1kvkligms8YTC0+aX0M
 s/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=HoM44YO7jKpFM5Bt686W03V+vIzdOR1TWUFJVxsK0iw=;
 b=sZIihSKjkE3xKMEONkcD6s0VT0/Aln0XMOIHYhA1VLsrI5vAy296TsDzm3oZIy3Ay9
 hdQn6bJLpzLVxLrM86sBP7XToDOTW+TK2HOTEfYEpRSB0zp+kyns0YooGSeQ7dsjjpVw
 ozTiMzYhV0M+wHu8iap+WBhwOiI/0H1KdifUGe+TElhFWRqRAp5+mWsKZ8Nj7HbKUi/J
 oSeu5OEV+whL7sOaWQa3kXDJ5QjMpqyYODkKxZswzcybrVExgIbksZo8pTpXuhO2eEpq
 RZw9QHjbojxULz9kS+byQfEajTyS02PUoh6VaPJzGItFMool3HYy7pRHPz4UsorPOPBA
 AIxw==
X-Gm-Message-State: APjAAAVZI2rfOha7C+CYy9/ZRo0eI6KUitbZUrMdaj9FZKvqRJgx7mQp
 cine9BIGHrYirzObOOcdwHcQyPSamW4=
X-Google-Smtp-Source: APXvYqxw27ngbpk0CKdXZvBZxaaAZi+AM67S8O8H2tETPVHPLmfGtOrWh4fm4fGLIcNlgSc4KcQahg==
X-Received: by 2002:a63:5162:: with SMTP id r34mr10283755pgl.227.1576387033003; 
 Sat, 14 Dec 2019 21:17:13 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id u10sm16596528pgg.41.2019.12.14.21.17.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 14 Dec 2019 21:17:12 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org
Subject: [PATCH v4 05/12] thermal: int340x: switch to use <linux/units.h>
 helpers
Date: Sun, 15 Dec 2019 14:16:08 +0900
Message-Id: <1576386975-7941-6-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
References: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191214_211714_117590_69364C14 
X-CRM114-Status: GOOD (  14.15  )
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

This switches the int340x thermal zone driver to use
deci_kelvin_to_millicelsius() and millicelsius_to_deci_kelvin() in
<linux/units.h> instead of helpers in <linux/thermal.h>.

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

 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 75484d6..4322132 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/acpi.h>
 #include <linux/thermal.h>
+#include <linux/units.h>
 #include "int340x_thermal_zone.h"
 
 static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
@@ -34,7 +35,7 @@ static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
 		*temp = (unsigned long)conv_temp * 10;
 	} else
 		/* _TMP returns the temperature in tenths of degrees Kelvin */
-		*temp = DECI_KELVIN_TO_MILLICELSIUS(tmp);
+		*temp = deci_kelvin_to_millicelsius(tmp);
 
 	return 0;
 }
@@ -116,7 +117,7 @@ static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
 
 	snprintf(name, sizeof(name), "PAT%d", trip);
 	status = acpi_execute_simple_method(d->adev->handle, name,
-			MILLICELSIUS_TO_DECI_KELVIN(temp));
+			millicelsius_to_deci_kelvin(temp));
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -163,7 +164,7 @@ static int int340x_thermal_get_trip_config(acpi_handle handle, char *name,
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-	*temp = DECI_KELVIN_TO_MILLICELSIUS(r);
+	*temp = deci_kelvin_to_millicelsius(r);
 
 	return 0;
 }
-- 
2.7.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
