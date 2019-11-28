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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1FBC432C0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 14:55:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D1E217AB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 14:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R7drK8cV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ5RWnOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D1E217AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Xp1bHaQgeIDoVG2bn8HMzYAL6BkBUVAqm/RCtubwwiU=; b=R7drK8cVKtHS7vDRfuQ1d9aLer
	zGdsEDL5nl0H/PK6PCI4U6eG3kl2EeKUBGIergTjhPL+bAM7f6VSRynq3+4E9EZUfTbydLIRT0O+8
	wLm0n86LortNnuRmNQPpHXOY9tbr1o5YuGInID95OJMCiiM7WzLYZHfUe4E/ZCilOjWGiAn656I6W
	aETnqeJKQhTFa16PHIroTOc/DeoL4EFmjE9kwy3uWfCxapsAthnJg3sl6+h9PHuJtjcBZR7Db9jLr
	9hmmX+OQYhWL2+vQiSWTG1R3P95M4NqMwGe1z1HQBQ0Z1kvnc3jgHcqMqbeWM/OteyLqaIWJHgi37
	XEs3mdIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iaLCd-0007XH-68; Thu, 28 Nov 2019 14:55:31 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iaLCE-0006LK-OD
 for linux-nvme@lists.infradead.org; Thu, 28 Nov 2019 14:55:09 +0000
Received: by mail-pf1-x442.google.com with SMTP id d199so8619492pfd.11
 for <linux-nvme@lists.infradead.org>; Thu, 28 Nov 2019 06:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Tz6cOySRhhfYX2f36nBxCYaBCi3b9m633gEDdn5gfjw=;
 b=lJ5RWnOcf9hz2ftj8KTcQGPpf3wmYM+buvrM43OU3L8IBdlJvDoFySEr6Ue1r2NAvW
 OYp1QSPl6ahDR1CDkXEivs4ODAvYZug9dj9HhQTY1LKZrNkuxAnh401HCWVlZZSFeidX
 rUtYPWdE7gSSX9CMXKAudZf05NeeGvzR6WCiFrrU/rKincHxgWuxSj8IVbwlZ51tUPfY
 HuwA1o5s2Om+mh2dF27jNNQtMZ/mBieMAnprCgL7ckqtM10ghRMSDhDaxqLqg/JtLSWK
 Zq1onyweBBJgqzDy5KgcLWV4MrjHdSxuiDFUhIrcVBHJMpftNWDdngWfHB7G8EWQ+riY
 aCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Tz6cOySRhhfYX2f36nBxCYaBCi3b9m633gEDdn5gfjw=;
 b=DB+UVMPpg5A8XTS37OCzDlrbrbA82+Fs4HWTamMg7mpHwmcAWHwmh3DFP3+aCjspcy
 vFT12mYN4DW1UIslpa+gVXHyjnrfgSPpMWLvnhrKr46s5R6hmQZWs3Y6wioZLPfrW0Qm
 LfCjOWpwerxoUy+IQruSfP5GMtWFWTWLywsgUvdsz/VVwJR2QFGyr7N+fYnKeZLVxgJ1
 bKggZ1MZd8CtuCeJm1/We4hx4YgAw+oZn4ECVjaUZ6YfCagFKQgiGK4jKrUYL8srYjjU
 23OYsI24m37lrHHrTvxNSJ/s8a9N3ef3fE0gL/IoewrlJmjF3M6s6qpN6r6h1od8rEQZ
 mhJA==
X-Gm-Message-State: APjAAAVXHVPqHXRAM1nDU36HdK421fM2Ae2QEi0oVHOApCohxCmh/T1q
 fQ/iHL+al0J+BIg57l16nrBHmDkUhU4=
X-Google-Smtp-Source: APXvYqxXpb6vyYoRS/aQShEZodxv0UryrA00GtVnoBcusA/RH5RFqbeXCJm2b9a9wHzCXw69HHgjWg==
X-Received: by 2002:a65:6916:: with SMTP id s22mr11388523pgq.244.1574952905215; 
 Thu, 28 Nov 2019 06:55:05 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:8015:e854:5ef0:f52e])
 by smtp.gmail.com with ESMTPSA id z11sm22282563pfg.117.2019.11.28.06.55.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 28 Nov 2019 06:55:04 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] ACPI: thermal: switch to use <linux/temperature.h>
 helpers
Date: Thu, 28 Nov 2019 23:54:33 +0900
Message-Id: <1574952879-7200-3-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
References: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191128_065506_863461_E995DDEE 
X-CRM114-Status: GOOD (  16.89  )
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
- use deci_kelvin_to_millicelsius_with_offset()

 drivers/acpi/thermal.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index d831a61..9f96e66 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -24,6 +24,7 @@
 #include <linux/reboot.h>
 #include <linux/device.h>
 #include <linux/thermal.h>
+#include <linux/temperature.h>
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
