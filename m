Return-Path: <SRS0=zMYu=ZQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC3EC432C0
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Nov 2019 14:10:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CDCC2073F
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Nov 2019 14:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XJs2SBbQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AG9JNeOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDCC2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=IOfhQMsHxs/KkcZ3inLRNsJPiJQyd+XRFATEjuO8SNk=; b=XJs2SBbQd+Khd/4r3rx6UJoOJ7
	hzJSV99guJ1t53ibp20D+R9T/qdheM1240RkUeXWYw2pLgJAIVrpQiGQV2nt2BIiNscMGZGP4PWbc
	RSv8MnQMhmVRMCTA+feiGQNza/DLXW4Vf8D6qz5yXhsW1yTx77cIeH1UK16JXAMWTg3uQjNjtF7jw
	P8zWow9jGyC4k2qdF9BqSwOqewIELj3eCwHxwqEykDQQFTKwpar+XT4SoEx2ak+k7olXP+cq+x7rb
	eLaFSiSu9P4AJ8GzUotSKEO1iWs7+9XyPyMKKGOu9rrTWvjHhj5h47767aFCL/2pi57JLam9/UOim
	QS0FKgAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iYsar-0005O7-2h; Sun, 24 Nov 2019 14:10:29 +0000
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iYsZz-0003ZV-1U
 for linux-nvme@lists.infradead.org; Sun, 24 Nov 2019 14:09:40 +0000
Received: by mail-pj1-x1043.google.com with SMTP id v93so1991573pjb.6
 for <linux-nvme@lists.infradead.org>; Sun, 24 Nov 2019 06:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=p4GXpFBwRIhrFQe2rae/GEBMEDnMv/ArRbrbnanSG1w=;
 b=AG9JNeOFbszeO/8b9h/bQ0hRUJwthd4/ubsKqui3xK7gywbStUqgNrrNdEEmL7Tar7
 gu5sVIqxXEiiJEJfiiWr0exookUZuvNrXhNg5iUuzt5w/A/c/SOsvqi51ucqkB6GOaUP
 cOd/1mr/huELIW57Ks0kTXf70cNCp3pYFGWLvENGMt7WViPU7dV52Au+I2yoMo+M4rab
 pX98IWw9YPeF7LlK/HfjcSTxCK8xcQGMs4SjHC+VMOeuKt45hg59QuWVDMyGZHTfThXB
 2jIFLnkZeb40aZ65gQsXv3sirdkLXc032HKFsM+R5p/6ARrIa/6cO9qF4CIG0Q2sXRPh
 lwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=p4GXpFBwRIhrFQe2rae/GEBMEDnMv/ArRbrbnanSG1w=;
 b=bzHr2sJhCAwfmarty6naYizTDnePZMN7uB38RIk+XD2x3bm6PZppL9LdLics0kteZG
 lCETKJT/tsT3+8AQImQUwwAJS+0LIUmQA0yet6ySkxcqAF1hICP6MeAM1iLroHrtrYRV
 8CRV85+DarmxPVGa+CkQBokhImuyPVaYXrYnK357mZWlGSk3irkRlSfwNXIZTlka6HTI
 yRjHXZPaYdeipQB345Wr2aKwU/WC7tHKFd8OWy7dj5EoBYpZ8gvZbTD5EHGS8Kb5YbIk
 Tf7c0d6pLIBR/0PCmYgV+v5FuzG01Sz+HzcG78HTk8fR5qlSgGXZcvYXncEUUOnfr11L
 NQnw==
X-Gm-Message-State: APjAAAUaiUIELv5dIiOTOaJ4EeDmyUTuTk2cqjBqZStSrzjHJTxv97Aa
 HZmIEZM4r0cid3QJrNjTlsmZWoj0xE4=
X-Google-Smtp-Source: APXvYqwtRVmCG1ARmbdLuLN5TLXRWlDXeduPpXKaQqk9x+tN4bppuLQSOjFIMlVZ00QWYUoX3M3URg==
X-Received: by 2002:a17:902:7887:: with SMTP id
 q7mr23881753pll.86.1574604573851; 
 Sun, 24 Nov 2019 06:09:33 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id a3sm4816326pgh.91.2019.11.24.06.09.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 24 Nov 2019 06:09:33 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] thermal: int340x: switch to use <linux/temperature.h>
 helpers
Date: Sun, 24 Nov 2019 23:08:47 +0900
Message-Id: <1574604530-9024-6-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191124_060935_123455_7EBC1FB0 
X-CRM114-Status: GOOD (  15.11  )
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

This switches the int340x thermal zone driver to use
deci_kelvin_to_millicelsius() and millicelsius_to_deci_kelvin() in
<linux/temperature.h> instead of helpers in <linux/thermal.h>.

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
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 75484d6..1e653f6 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -34,7 +34,7 @@ static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
 		*temp = (unsigned long)conv_temp * 10;
 	} else
 		/* _TMP returns the temperature in tenths of degrees Kelvin */
-		*temp = DECI_KELVIN_TO_MILLICELSIUS(tmp);
+		*temp = deci_kelvin_to_millicelsius(tmp);
 
 	return 0;
 }
@@ -116,7 +116,7 @@ static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
 
 	snprintf(name, sizeof(name), "PAT%d", trip);
 	status = acpi_execute_simple_method(d->adev->handle, name,
-			MILLICELSIUS_TO_DECI_KELVIN(temp));
+			millicelsius_to_deci_kelvin(temp));
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -163,7 +163,7 @@ static int int340x_thermal_get_trip_config(acpi_handle handle, char *name,
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-	*temp = DECI_KELVIN_TO_MILLICELSIUS(r);
+	*temp = deci_kelvin_to_millicelsius(r);
 
 	return 0;
 }
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
