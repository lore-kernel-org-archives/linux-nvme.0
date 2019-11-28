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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD99C432C0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 14:56:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A3A21771
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 14:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="URVSDTK9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNGiuixp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A3A21771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=i79hiQL72fkADhqhyDV/RQgDP1nV6EsPe+LLZBJmSS8=; b=URVSDTK9lHPWT31qvJictWVZVo
	tcJec4pa3b+3RVHPhA3ydpEMlu71wFhSQ2lvZjUaqwu44IWWsBGJ3xmGP6iYqaVO/jFBTVo8ZWH0m
	RfDrDw6vqRaA+rpmIgGxm5Gyon4UubBvcv/XjAi+Q2G/uAXdcIB5ITpNol5Z6coArL6LFNph52CqW
	BO/E5Huc2mHKhg37TqRlttuUip6IvbUkNtzD5U2DiTmNZoTmj+AiXF4ihnzJgREXIHSHg8T+Z7Tdf
	kJPA6ma8FP/Ed/KplCvjyczUTtHhZHlqdwZaiAamDX7Li9IUvVAz937LQQVhtXwNAy/L/RNeG5j17
	NZ8nIv9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iaLDc-00009C-O2; Thu, 28 Nov 2019 14:56:32 +0000
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iaLCR-0006Xb-UK
 for linux-nvme@lists.infradead.org; Thu, 28 Nov 2019 14:55:25 +0000
Received: by mail-pj1-x1044.google.com with SMTP id r67so4243203pjb.0
 for <linux-nvme@lists.infradead.org>; Thu, 28 Nov 2019 06:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Rl/Muaad0JKZvHEYUN/4/vVrZyhpWqkrNfXezrDAyeU=;
 b=VNGiuixpHdhZlKCdI1lUbF3zqtjKhA8JjC+y8CfCWFSPFQ0BQz3Lmb0QLJTeQzeeOp
 I3MeGV7hUuAKdiWZjr9nz5YeeVEaBxxsWo7QfzwE5sJCF8N4jcodOUIv88gm2xsi9+R7
 +BQRtKJq5MV1L8ufJnXe56xOngFxMRJyrlT/Nc8R94EMwK7GJn8AooBCxywnqUUpcvPZ
 yksVDGyhleVo0RnEBJS31FGBfySon8G+y0S1+6NAYU4EZpHqlqBPdZ3qbFskqmJ4z874
 pzMm7HaYHErXanglixeEhcaG4g6dNNTXqgAj/Pc2fw8A1uCma13Pr826ept1srbPcqFL
 74TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Rl/Muaad0JKZvHEYUN/4/vVrZyhpWqkrNfXezrDAyeU=;
 b=doiOTwC/m3jYat6sdyJM28SaAWKFhutcDrWDCJmerXToJW9WXn2T7MThI3F30bRWEl
 t7SrZGZhT08I6Jt4ZBowACzHIAhomyUHdeRCqLZBBd3Pz4RIEhgW6Avvt+nua8POC54R
 CfTr+GuUHBbvAV6w6Ym1yndTayLHaCRw18h3IB7zlxfA+FHeexgHHz3QaafbvJO2S4vY
 IHeBSDs2KwrXH86NcphwqfrYIfojKeQu9I6wBRtlD9y9POddPDwjgExv4CjehKBCceag
 0n12NbYlzlSVBW8A3um6E6qnTtJ2AdkSaBMOv4Eti/smHFsdpfpDMy9Aj5T5Rtpd49ka
 SXvQ==
X-Gm-Message-State: APjAAAXqEsTFv6YNA1338ZC9U1y5soV7KgF4yeozM0Z93ragDTcfWeJd
 7wPFoHJ76sJlffGJd4w2OQTQX5RVYZA=
X-Google-Smtp-Source: APXvYqwR27zrU/EiAbDRNlN1A8TmOl4w2Fmgs7jCyn1WoiQAAB82sxWB2twhBCfOfzKVYrGHmqrS8Q==
X-Received: by 2002:a17:90a:48:: with SMTP id 8mr12600637pjb.82.1574952918403; 
 Thu, 28 Nov 2019 06:55:18 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:8015:e854:5ef0:f52e])
 by smtp.gmail.com with ESMTPSA id z11sm22282563pfg.117.2019.11.28.06.55.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 28 Nov 2019 06:55:17 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] thermal: int340x: switch to use <linux/temperature.h>
 helpers
Date: Thu, 28 Nov 2019 23:54:36 +0900
Message-Id: <1574952879-7200-6-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
References: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191128_065520_091786_F1DDC859 
X-CRM114-Status: GOOD (  14.62  )
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
<linux/temperature.h> instead of helpers in <linux/thermal.h>.

This is preparation for centralizing the kelvin to/from Celsius conversion
helpers in <linux/temperature.h>.

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

 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 75484d6..6658cc7 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/temperature.h>
 #include <linux/thermal.h>
 #include "int340x_thermal_zone.h"
 
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
