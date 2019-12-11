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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D44C43603
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:40:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71AD3214D8
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gB0Z1owj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPTNp0Ed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AD3214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Hs0CaNaUDgpfcbY5uUd5duwHlvD1Jn6ucRBdy1/NYME=; b=gB0Z1owjYvdFu7StXRMa4KW7v8
	4RS7+Qyii059bZF5ehdbjGn2E6PId4Zftak8ctf2QZ2CPJkDOIwv3PUHKuw2VyM2/0shxwssCADD+
	BJcCv6pk3ngsjkrVfcHkXxTz+BkFwjn97Dt0LACWwuHcTuIsgonunStvRkttqgUEbRnHGuxMxdhbs
	DJrBw6hTpBKgOxFIYKIA5W+aYD+CQfnhk91OkRH14Nz3Vtoas0iv8L+3dYAOWforNOmMQGGW9YT4c
	f1jQByJOfEFPLGCOkBBtIlIAxGAXhpcQs8WpgrC3PP8MzjQl29KqI/6FLTXS4gtkbFSOSXeY7Dvrw
	wGEXi4RQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1if3AF-0000ED-GG; Wed, 11 Dec 2019 14:40:31 +0000
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1if39A-0006iN-K1
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 14:39:37 +0000
Received: by mail-pj1-x1044.google.com with SMTP id j11so7894245pjs.1
 for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2019 06:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=30ClsBWVMQFbgwDIq9w8WCwwNMvj/q4ymjJp8oUF1J0=;
 b=iPTNp0EdadO4y2qivxFKBUpzEsaPwhGKdyaPxOlJenJBVxrjZDK77cuy1xm8y3/vwo
 XAU33lFCH4T/3DEpnMyPFn6xvlTZdCX8Y/G3vVNDBizKWUagtzlppvbFHBKxI8/Qzgli
 056XNDvIhN4ii1itJlKwXt80wjd295T2EeFmuKxHDcesF1kjQH1DUsdulYHgs8J8gmp8
 InGX15hisePqvBdSawpSkTi5rAQXLdhUlmEHERSnfwz5Z3FiZ+nZFa1WP1exJSLOjypP
 wqQIAcTsATodjUx32eYVG4H6IPzbyD7WHdjJLcss5z7w5GHfOtNx7Sjbyizgieki1RVz
 OCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=30ClsBWVMQFbgwDIq9w8WCwwNMvj/q4ymjJp8oUF1J0=;
 b=c5I9Ptz2hMXYmnf/fJhoclUdw1QeN/IW8mcnIknD2RZnZ1uIiy3Zk0+u2wB388QQO4
 lG5PFC8fSHaAZ9UP8TP9DJptW45zhYRncDdfhiAen2pRPgxKizPIe99PbjIb8QrgaYvS
 mTnZlm6yyH8hqzk7SzrGiEc2QW1xQMMIBylWireJ+/QIUdaUoeYV6ZMKjH6gC3CRp2vL
 kkgmdKQsIOGYhvWyl/NaVUqenoB/CQVSiFg+8Wsf3OrixJ6l3ZIsAKwDzx7OAWs9Dutf
 JkqP4IcoHrAWN10ulhpgiozBgkqJUgm+8/eozMSA/qIlWYKUoa6vSz8RngZ8KEpU8vFM
 Lmag==
X-Gm-Message-State: APjAAAXi0mgCxCHntlUECWO6Go6is2SNEWEz9KYoeYetmYV3Oy0sPeW1
 MBiSrpTKLRmC2NU9KbRRDTnV4F8emE8=
X-Google-Smtp-Source: APXvYqyPc4UFSiMgsD4yZYd76DuxU8U2qOWD+TGrVH0/E0V5787xpYx4yK1YXlYV7OTuxTKh7/rsHg==
X-Received: by 2002:a17:902:8507:: with SMTP id
 bj7mr3489251plb.69.1576075163124; 
 Wed, 11 Dec 2019 06:39:23 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.39.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 11 Dec 2019 06:39:22 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/12] thermal: intel_pch: switch to use <linux/units.h>
 helpers
Date: Wed, 11 Dec 2019 23:38:13 +0900
Message-Id: <1576075099-3441-7-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191211_063924_773074_24C6A2B6 
X-CRM114-Status: GOOD (  15.08  )
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

This switches the intel pch thermal driver to use
deci_kelvin_to_millicelsius() in <linux/units.h> instead of helpers in
<linux/thermal.h>.

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

 drivers/thermal/intel/intel_pch_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 4f0bb8f..b118611 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -13,6 +13,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/thermal.h>
+#include <linux/units.h>
 #include <linux/pm.h>
 
 /* Intel PCH thermal Device IDs */
@@ -92,7 +93,7 @@ static void pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd,
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
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
