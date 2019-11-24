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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015B0C432C0
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Nov 2019 14:10:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C84A72073F
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Nov 2019 14:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UbDVu3+m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avJspCbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84A72073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=XaPUmlrqNleHvEiA5Kh64Exi6A5WulzWRhg7xWZhc+M=; b=UbDVu3+mCPdLp0G0fW/+11fDMW
	Jf9X6DOVBiWLHrdm1dnhWU03dnz/rfyBtf02RIux3X5VLN/3mCaKQWPAvowKQgKpOd2tvnvp02SvI
	YLAl/H6PlaFULu6epfGiljFNzuxxTyY+mUtIS1MmE+7LBkJHK/s0x8d2j8yQIZis5YSR4I3Ujf1q4
	3vrbsKH9JjJMO83t+hxxSEO87Ivj7rErZ++LjEJGMe6MhSMoPDxJXacxl53wnTrSUiOV+LtCJIdAm
	tVLu/HXE/iWpBKJ3STdSZIWpKH3nGt/pDgQKMBCzwKTnRaqgWuDl4XWt7ykrAmewvlHrd4EcTMSf1
	AhDEQeew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iYsb3-0005ZE-47; Sun, 24 Nov 2019 14:10:41 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iYsa3-0003dt-QR
 for linux-nvme@lists.infradead.org; Sun, 24 Nov 2019 14:09:50 +0000
Received: by mail-pg1-x542.google.com with SMTP id b1so5744581pgq.10
 for <linux-nvme@lists.infradead.org>; Sun, 24 Nov 2019 06:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BIZEOh+2SoolQV+w98xfGiKw61hN8b99t1HqhjHBMcw=;
 b=avJspCbwxgRf8JRPnfdcCZ4RaMm0FlX+WmFZqgukiH8xG1GXXb0pjfOytH3Yz5n9V/
 QFlR7GDaFK4Xln+GbiKZzXwdRLKODx4/eM3hHKE7Jo2naU8Fmh8FOKJH7zIPOr+nJG58
 dc2c/en1D0+/FklNhFoL2s0RegFtqkiG9XY8tLsmfEk2FfS9/1fSNi1kUw//VAmxEvaj
 3hO9ShGZ20KDz98C+aincxS9/tRnkwBEp1PVmJ8kHfop97MLw3vjAgzyVlnDQYc3K+vM
 ngEOz6uUXJ4oAGYqyucJlNnEaJUbqn5KIjRj8Ke78K6D4qHICgweSrCQgY8rEaXVIDQF
 QabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BIZEOh+2SoolQV+w98xfGiKw61hN8b99t1HqhjHBMcw=;
 b=FyhQM9OriVifv8xIcee9BW8qLrwpB1VETaC1jRhmNcR5wIRnUQWeGWCgGs2inZh/ro
 A//byzUxBVD0RogmsnsAv/Z8YTEKzj3MqEIMB2A/xxHUwdY1I2JEfz/E9YoB8cXmqnjH
 NXriFZ18IeRyKkoAfG0fhTwf3nO4DYbKaK+74T4nQvcMZqFDYQFxsl2Hc9tHUdVobeFz
 ebG55QGPCInbJWT67cm0sh0E2IWy0ek6Gvl6MSkTEbp/twc05I0UhcIsnZA7LIUddS3N
 Ph2RWaKqoNdOqOTRQTxfRMe4krgLc0OqbYVyefmBRJnkSbRor+q26aofN42OpeBvewNB
 6/cg==
X-Gm-Message-State: APjAAAVegKXZBK6yoP9p1jGWukQhknSLf0oOVJCWgCWgIzvjM8k1T8pd
 6g1ObDT8N7+bBzeDExc1Z8ttK5FdWGo=
X-Google-Smtp-Source: APXvYqzV4/N4HOdxJ0cQtjPpcUY8RcPuU/t/SwDDADaMHBYnSSbkvE2bypioZl57w/Aw1BOYLeiOig==
X-Received: by 2002:a63:ff0b:: with SMTP id k11mr28003070pgi.274.1574604578685; 
 Sun, 24 Nov 2019 06:09:38 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id a3sm4816326pgh.91.2019.11.24.06.09.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 24 Nov 2019 06:09:37 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] thermal: intel_pch: switch to use <linux/temperature.h>
 helpers
Date: Sun, 24 Nov 2019 23:08:48 +0900
Message-Id: <1574604530-9024-7-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191124_060939_877578_799B19EF 
X-CRM114-Status: GOOD (  15.15  )
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

This switches the intel pch thermal driver to use
deci_kelvin_to_millicelsius() in <linux/temperature.h> instead of helpers
in <linux/thermal.h>.

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
 drivers/thermal/intel/intel_pch_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 4f0bb8f..3cce310 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -92,7 +92,7 @@ static void pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd,
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
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
