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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCB2C2D0C6
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:41:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3242173E
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G9mLAmCb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jH82xtrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3242173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=YG8mszRx6hHMxbnCeqGuo1rjiFfaAMsg1peoJ5ofDZM=; b=G9mLAmCb90vtjmX4vP/OBoYz9q
	bOyJH7xYgLyMmCHqgENJd0YJIImIDeNuoTdajSynms0PCwAAgT2OwfYiJVldoMU6j5z5iFofipVAy
	jZlZ40ju37G9uiUKdJVY+qaNXqJ6YlWTymGq2R7ihYc+3Ksp9GveTcJriLdGMvTaYR+nk42722gDe
	ujW1DBu9iP6rzYOTc8ump7YWFIyi2QCnDj8o+g9REYVnahX0fiDhY15IBLIccERF5zimGWV8sf2P1
	2AhlM7D1AeZztoN9x/qEB5slfgE8vyzHAMw8H59ZMCGkV0ihFxrUmAjHIwqifq/8ALKs+Gklc4bs2
	pPs5+/pA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1if3BF-0000yH-Tk; Wed, 11 Dec 2019 14:41:33 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1if39c-00075w-IJ
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 14:40:16 +0000
Received: by mail-pf1-x442.google.com with SMTP id h14so1900827pfe.10
 for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2019 06:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3VEcdWQti206JWCDW3qI0BTxZ1lYQXCJ5XH3cd981NQ=;
 b=jH82xtrYMxhgUcHQRPKqjw7ZKlvPgF+xBtcnxGsL7fh4pjdfao/pZu4Q6upvCNHIh1
 a+G4WLTV+T+1yx2XyKqc1y8xCv1StbbjpoaBkIg8NeB3ZaZgozkM7fploPXJ9z4wTfQ+
 Ee3DwRsSc0ZQHdjw5TCUYZzZjT/bppcgvXa+XIdYMuUnfrK1g7Ezy9pFVmVYZ5xkzhyz
 fcFVbP3jXuwNeaeDXX7CkGxikmhPQRcLVgS21AwByB3NK8Gi6kZ+6aaemxXGyHfeFQBX
 Jt2PbVWKRidv9CFTbWklTCKJjHPNRfVDQKtXDW3IQIf1C5PkhEmElEAQpjPQPl7rnVYf
 OMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3VEcdWQti206JWCDW3qI0BTxZ1lYQXCJ5XH3cd981NQ=;
 b=BZtksE6IlF6jqMv8Med4Zkc97JvQrXw6r9GOqF9cT4RTDcA8F9c/PurTH/6lBtQvIi
 NlWoDJBdPaucdsBsxELgPFaJmL03BqOsEz5n+izuP2imV6TX6CVHIdjS/YGKAW3aM3vN
 7hCiv8bYKfoAzNNqCcd2kEx0P9hJM3YVtiEmDAQIzS6HE1ocnTC5uWDUlzjojDPA+EJO
 bYU9Ggw9zow0aVv0O3t006pfn9qvWwHcamLy/kxl6cSh6+0qc6TfztYfImqxj+BgNDRK
 kE3vKYnse5dNialPxDrTaF6c/fRzIFz9oJ8RTydjVD+LXEZOFKn72nhFOrf3sPv+fTqS
 sQ4w==
X-Gm-Message-State: APjAAAXiBwQ8zH0/c/RKd1UhFim/b8yrzFZCy0vsfU568QsW6krl+0+K
 cMIfl/8xBN/s64u3mupfPrOFQAl2w/8=
X-Google-Smtp-Source: APXvYqwgEvnp2ndBwiIE94Wh4cRVzfCw2QFRf/3PG5eerLtk1/YgeA2uxE8wypG49aWWT3GbeFUcFg==
X-Received: by 2002:a63:fd43:: with SMTP id m3mr4566724pgj.164.1576075190151; 
 Wed, 11 Dec 2019 06:39:50 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.39.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 11 Dec 2019 06:39:49 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/12] iio: adc: qcom-vadc-common: use <linux/units.h>
 helpers
Date: Wed, 11 Dec 2019 23:38:19 +0900
Message-Id: <1576075099-3441-13-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191211_063952_621557_403028FC 
X-CRM114-Status: GOOD (  13.19  )
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
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Lars-Peter Clausen <lars@metafoo.de>, Akinobu Mita <akinobu.mita@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This switches the qcom-vadc-common to use milli_kelvin_to_millicelsius()
in <linux/units.h>.

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* New patch from v3

 drivers/iio/adc/qcom-vadc-common.c | 6 +++---
 drivers/iio/adc/qcom-vadc-common.h | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index dcd7fb5..2bb78d1 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -6,6 +6,7 @@
 #include <linux/log2.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/units.h>
 
 #include "qcom-vadc-common.h"
 
@@ -236,8 +237,7 @@ static int qcom_vadc_scale_die_temp(const struct vadc_linear_graph *calib_graph,
 		voltage = 0;
 	}
 
-	voltage -= KELVINMIL_CELSIUSMIL;
-	*result_mdec = voltage;
+	*result_mdec = milli_kelvin_to_millicelsius(voltage);
 
 	return 0;
 }
@@ -325,7 +325,7 @@ static int qcom_vadc_scale_hw_calib_die_temp(
 {
 	*result_mdec = qcom_vadc_scale_code_voltage_factor(adc_code,
 				prescale, data, 2);
-	*result_mdec -= KELVINMIL_CELSIUSMIL;
+	*result_mdec = milli_kelvin_to_millicelsius(*result_mdec);
 
 	return 0;
 }
diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
index bbb1fa0..e074902a 100644
--- a/drivers/iio/adc/qcom-vadc-common.h
+++ b/drivers/iio/adc/qcom-vadc-common.h
@@ -38,7 +38,6 @@
 #define VADC_AVG_SAMPLES_MAX			512
 #define ADC5_AVG_SAMPLES_MAX			16
 
-#define KELVINMIL_CELSIUSMIL			273150
 #define PMIC5_CHG_TEMP_SCALE_FACTOR		377500
 #define PMIC5_SMB_TEMP_CONSTANT			419400
 #define PMIC5_SMB_TEMP_SCALE_FACTOR		356
-- 
2.7.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
