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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D79C2D0C8
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:39:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0C4222C4
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WB63HzXP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmbMzGAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0C4222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=6xjCla+Q34H84jnX6JTe751PcaOhgCE7kU30VESC9Rs=; b=WB63HzXPw0H6QG+TdVeJFxQ4iM
	xTbFjvLkYjrP5cGb1OSj+O3EspUJ+lMrHoQwNQyvzGXDHlXyuZiFa+xSgAYI03ZfAPwLNBioJdnzd
	BIMbYj21PH+S4/++RTNobs3gkPAL3HyfCdPxVgIGjxn+G+viVj7Jh7C2u5c01P6ZVeamzGXic5CkR
	vpDjHd0ca6rtsQvtH4z6XrNnHvsqfrEPRld9esjdN7ccCcvHHvanh+vr15gI6A+0ONI/3IMO55vLP
	oqUqtAX+TkQ9+nYBdpyBhrInzAxduCZbxKxsmVa5EcUQ11sYf4SBV0kbOWhtMbMZX/g2YsjKJjXI+
	GwKZNayQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1if398-0006gC-C8; Wed, 11 Dec 2019 14:39:22 +0000
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1if38o-0006LP-Dv
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 14:39:04 +0000
Received: by mail-pj1-x1041.google.com with SMTP id ca19so9014653pjb.8
 for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2019 06:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aMYza2espJ/tsAfz58SlTUu9MiIVLwdjN+KGLUAdlkE=;
 b=ZmbMzGAVOLos2wnlXjV4De+DkX0AUl8htzrbUZXvcjTz41yV8mzhq2Xh3m+J/Zla9j
 55zJVO5QiBpZCbAs5gWpCCsy+rg/HZoWpr+sH5Mc9Ta5lAH/sOM7w/jAraSQS00LxkBX
 leXm7xaBC3XzleVMz6N9sVnthNhRcEqBY9guO4Y8rron4wVUh/cRu5XLZlPWqg/CTfga
 qK8D9y9qP9Cjqee46+FsICfy275Kte5NsrseywAt/0CQPNuSjgeKzhcme9IG10ccZTZx
 E/YRyK1J/JHwi2MS1QQpaB6/kwzWG1JAR9P+yNptzg1tMglqfgGaypUnmwaibnbJmKyU
 hbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aMYza2espJ/tsAfz58SlTUu9MiIVLwdjN+KGLUAdlkE=;
 b=cxla+DdGDjNWTyqvhhJ6us4w3yK9uDViwbCP941mEzOeDYCfSOSuPJFDqmm82hS8fn
 d2k0IzONJJLPOQ22TJddt0v8p9PW+Q+KqTO+ZVTLmkYoBN8KIg+dNtE15Iuk/l4Vk6tP
 2b3T+GxZelK7DkNCou3vI0egmHpGKIkmfuCMJ5uzdw8ABD13GeHoOeu44CY56w/0klst
 mKyPPaBzaRQXalGFOmHu9pabZclSBIgVYMb6LgMyMM1T1iY4PUHv05LY4RF+lyQWIO0C
 DwERclkwyr4K3kquJ1r/IN6aGCe0pWBP7kC5tJ4DtPvq/ijt/c7JrcP77uTTxL+rxGx3
 NJNw==
X-Gm-Message-State: APjAAAWgLH8u6rZrXmArHboRQ0EZxniHOV6o6Dssigm1D+Qzi00/6I3O
 Mlf6/DusbmUTt0MWJYRtNVmUhIOg8HU=
X-Google-Smtp-Source: APXvYqy6Lr7fbZ/IBRJirlmpGo6SxC7Xb8FPSycy3BjYlrj9ONpGAPdSZREbQPlLJFCiCP7CrAkBZg==
X-Received: by 2002:a17:90b:4396:: with SMTP id
 in22mr3702546pjb.111.1576075141056; 
 Wed, 11 Dec 2019 06:39:01 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.38.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 11 Dec 2019 06:39:00 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/12] ACPI: thermal: switch to use <linux/units.h> helpers
Date: Wed, 11 Dec 2019 23:38:09 +0900
Message-Id: <1576075099-3441-3-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191211_063902_510445_2E23A794 
X-CRM114-Status: GOOD (  16.93  )
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

This switches the ACPI thermal zone driver to use celsius_to_deci_kelvin(),
deci_kelvin_to_celsius(), and deci_kelvin_to_millicelsius_with_offset() in
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
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v3
- rename new header name from <linux/temperature.h> to <linux/units.h>

 drivers/acpi/thermal.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index d831a61..8a436f5 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -24,6 +24,7 @@
 #include <linux/reboot.h>
 #include <linux/device.h>
 #include <linux/thermal.h>
+#include <linux/units.h>
 #include <linux/acpi.h>
 #include <linux/workqueue.h>
 #include <linux/uaccess.h>
@@ -172,7 +173,7 @@ struct acpi_thermal {
 	struct acpi_handle_list devices;
 	struct thermal_zone_device *thermal_zone;
 	int tz_enabled;
-	int kelvin_offset;
+	int kelvin_offset;	/* in millidegrees */
 	struct work_struct thermal_check_work;
 };
 
@@ -297,7 +298,9 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 			if (crt == -1) {
 				tz->trips.critical.flags.valid = 0;
 			} else if (crt > 0) {
-				unsigned long crt_k = CELSIUS_TO_DECI_KELVIN(crt);
+				unsigned long crt_k =
+					celsius_to_deci_kelvin(crt);
+
 				/*
 				 * Allow override critical threshold
 				 */
@@ -333,7 +336,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		if (psv == -1) {
 			status = AE_SUPPORT;
 		} else if (psv > 0) {
-			tmp = CELSIUS_TO_DECI_KELVIN(psv);
+			tmp = celsius_to_deci_kelvin(psv);
 			status = AE_OK;
 		} else {
 			status = acpi_evaluate_integer(tz->device->handle,
@@ -413,7 +416,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 					break;
 				if (i == 1)
 					tz->trips.active[0].temperature =
-						CELSIUS_TO_DECI_KELVIN(act);
+						celsius_to_deci_kelvin(act);
 				else
 					/*
 					 * Don't allow override higher than
@@ -421,9 +424,9 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 					 */
 					tz->trips.active[i - 1].temperature =
 						(tz->trips.active[i - 2].temperature <
-						CELSIUS_TO_DECI_KELVIN(act) ?
+						celsius_to_deci_kelvin(act) ?
 						tz->trips.active[i - 2].temperature :
-						CELSIUS_TO_DECI_KELVIN(act));
+						celsius_to_deci_kelvin(act));
 				break;
 			} else {
 				tz->trips.active[i].temperature = tmp;
@@ -519,7 +522,7 @@ static int thermal_get_temp(struct thermal_zone_device *thermal, int *temp)
 	if (result)
 		return result;
 
-	*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(tz->temperature,
+	*temp = deci_kelvin_to_millicelsius_with_offset(tz->temperature,
 							tz->kelvin_offset);
 	return 0;
 }
@@ -624,7 +627,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 
 	if (tz->trips.critical.flags.valid) {
 		if (!trip) {
-			*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+			*temp = deci_kelvin_to_millicelsius_with_offset(
 				tz->trips.critical.temperature,
 				tz->kelvin_offset);
 			return 0;
@@ -634,7 +637,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 
 	if (tz->trips.hot.flags.valid) {
 		if (!trip) {
-			*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+			*temp = deci_kelvin_to_millicelsius_with_offset(
 				tz->trips.hot.temperature,
 				tz->kelvin_offset);
 			return 0;
@@ -644,7 +647,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 
 	if (tz->trips.passive.flags.valid) {
 		if (!trip) {
-			*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+			*temp = deci_kelvin_to_millicelsius_with_offset(
 				tz->trips.passive.temperature,
 				tz->kelvin_offset);
 			return 0;
@@ -655,7 +658,7 @@ static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
 		tz->trips.active[i].flags.valid; i++) {
 		if (!trip) {
-			*temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+			*temp = deci_kelvin_to_millicelsius_with_offset(
 				tz->trips.active[i].temperature,
 				tz->kelvin_offset);
 			return 0;
@@ -672,7 +675,7 @@ static int thermal_get_crit_temp(struct thermal_zone_device *thermal,
 	struct acpi_thermal *tz = thermal->devdata;
 
 	if (tz->trips.critical.flags.valid) {
-		*temperature = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+		*temperature = deci_kelvin_to_millicelsius_with_offset(
 				tz->trips.critical.temperature,
 				tz->kelvin_offset);
 		return 0;
@@ -692,7 +695,7 @@ static int thermal_get_trend(struct thermal_zone_device *thermal,
 
 	if (type == THERMAL_TRIP_ACTIVE) {
 		int trip_temp;
-		int temp = DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+		int temp = deci_kelvin_to_millicelsius_with_offset(
 					tz->temperature, tz->kelvin_offset);
 		if (thermal_get_trip_temp(thermal, trip, &trip_temp))
 			return -EINVAL;
@@ -1043,9 +1046,9 @@ static void acpi_thermal_guess_offset(struct acpi_thermal *tz)
 {
 	if (tz->trips.critical.flags.valid &&
 	    (tz->trips.critical.temperature % 5) == 1)
-		tz->kelvin_offset = 2731;
+		tz->kelvin_offset = 273100;
 	else
-		tz->kelvin_offset = 2732;
+		tz->kelvin_offset = 273200;
 }
 
 static void acpi_thermal_check_fn(struct work_struct *work)
@@ -1087,7 +1090,8 @@ static int acpi_thermal_add(struct acpi_device *device)
 	INIT_WORK(&tz->thermal_check_work, acpi_thermal_check_fn);
 
 	pr_info(PREFIX "%s [%s] (%ld C)\n", acpi_device_name(device),
-		acpi_device_bid(device), DECI_KELVIN_TO_CELSIUS(tz->temperature));
+		acpi_device_bid(device),
+		deci_kelvin_to_celsius(tz->temperature));
 	goto end;
 
 free_memory:
-- 
2.7.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
