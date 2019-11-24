Return-Path: <SRS0=zMYu=ZQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C603EC43141
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Nov 2019 14:09:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DAB207DD
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Nov 2019 14:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hQSLwQ1w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZIHl+Fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DAB207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=1ULWi99l1OiI0Z503xg7H4s7TQlcEk6q39RjWbDV/Is=; b=hQSLwQ1wUIHa+zIIUHqRVWAdwY
	VkwrIws1fNRn6IxrB0SqHAzpTYdZvS3tNHKkoYFAeL42A665n3vWpYJLxjAWo5JWc5MEEYoDNvfsU
	raLRhi/5zi4thFdpuxqnb/qMud66C0kSVEBUN6I9DOVKB55CuN/fAEXZjGfdpQpZqvZXKb4EArnBG
	+gspsO+PczpwLP7XDzBPgeGB+MDMqRO2xJvlgFB1biQEiCf8l27hI4njYn6+/8uf6zyqF22IRmZFp
	+qnkC7a+SJy8hKp3WQmc3a7kVgg3eOXXdGbKdZ8gCSU7TrQAgf1QBzkcHcl3AecJMRnp5wqZQFRh1
	rSlIuaWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iYsZh-0003He-RG; Sun, 24 Nov 2019 14:09:17 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iYsZe-0003E5-6v
 for linux-nvme@lists.infradead.org; Sun, 24 Nov 2019 14:09:15 +0000
Received: by mail-pg1-x544.google.com with SMTP id t3so5312874pgl.5
 for <linux-nvme@lists.infradead.org>; Sun, 24 Nov 2019 06:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uiVaOYC0AJAeDJiNsTnIMMgr41e8eY8TpWvmzxTalS8=;
 b=UZIHl+FvynMquo91lmoV5lbWmLcB+8Iw8tQF+m0vCBO8UCd9CRAQcTeAd+sMHZP4jo
 B6Xmatc+2rgYJ+34ssDGYNBtJiUINZ7+QB/gQplVjthaNSrMy7CSwwU1ucQLlf6Giaof
 RmRShwUrp8NUVqYWsha6437Pq0+vhr3TLYELT1yPmV1/KZZmDjeJbQFOq3MaBxRqYQQl
 SHu6KL9a66DZesCDnoB59cQL5Rh1E/13ZazzHc7ARMdE7lHt6pFFCXdkGHuk2BCh37uM
 A2hSAc1RcaWOLGy67uLEvZGH2wuKAwZsFzYeDmcmMK3gnM/ALNPxjGQhAOJ1zNSS55O+
 yqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uiVaOYC0AJAeDJiNsTnIMMgr41e8eY8TpWvmzxTalS8=;
 b=ceJuZsvwj1NfKCsyKlPQXGXz+VU8hnCRhKfH9PgARsz+qXnUPXEIiqcow5R5S5LxiQ
 AVOeGyGaHB4W09UR8CX8gMAffKKfy9Nmxk+kdfExMvRhQyUXHtXMZwreIEndiPzaipFq
 W3yg0HvdFme0psYNMDkjawuNdpEknLK8pPbFlZ77AV8dn6KBDRoSrgwnmPZnfSKWQY3k
 OUGLSvvn3jTvlTuqCbaKxj86HPdrh+MGvkO4BRcnuV8Qnrufddqa/r4KMCsV0FhV2F2g
 bP+C083s1wMRZKxjMBQx4AgBorerMPsM9YgJ8bQ4KqGbnQOdLEL1zMKUjHz814gz8uHC
 4uqA==
X-Gm-Message-State: APjAAAXTaC4HFxBjHq9l58hEnRCUGs26ZM1J2p2B2vL8iqZt0W/cm3FY
 XAR/qZivQ6JO/JDry60jDVT69ZHJPeA=
X-Google-Smtp-Source: APXvYqxa+x5Ky0KmnA9MrXJ6wT3QpcqvpcitOx/D7jKeOjTqkBRfuQPdefSpwDVRKgldh3VsRGRMZQ==
X-Received: by 2002:aa7:8b1a:: with SMTP id f26mr8162545pfd.81.1574604552956; 
 Sun, 24 Nov 2019 06:09:12 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id a3sm4816326pgh.91.2019.11.24.06.09.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 24 Nov 2019 06:09:12 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] add header file for kelvin to/from Celsius conversion
 helpers
Date: Sun, 24 Nov 2019 23:08:43 +0900
Message-Id: <1574604530-9024-2-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191124_060914_251767_6E05DC0C 
X-CRM114-Status: GOOD (  15.37  )
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

There are several helper macros to convert kelvin to/from Celsius in
<linux/thermal.h> for thermal drivers.  These are useful for any other
drivers or subsystems, but it's odd to include <linux/thermal.h> just for
the helpers.

This adds a new <linux/temperature.h> that provides the equivalent inline
functions for any drivers or subsystems.  It is intended to replace the
helpers in <linux/thermal.h>.

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
 include/linux/temperature.h | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h     |  1 +
 2 files changed, 40 insertions(+)
 create mode 100644 include/linux/temperature.h

diff --git a/include/linux/temperature.h b/include/linux/temperature.h
new file mode 100644
index 0000000..d7e2aed
--- /dev/null
+++ b/include/linux/temperature.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TEMPERATURE_H
+#define _LINUX_TEMPERATURE_H
+
+#include <linux/kernel.h>
+
+#define ABSOLUTE_ZERO_MILLICELSIUS -273150
+
+static inline long kelvin_to_millicelsius(long t)
+{
+	return t * 1000 + ABSOLUTE_ZERO_MILLICELSIUS;
+}
+
+static inline long millicelsius_to_kelvin(long t)
+{
+	return DIV_ROUND_CLOSEST(t - ABSOLUTE_ZERO_MILLICELSIUS, 1000);
+}
+
+static inline long deci_kelvin_to_celsius(long t)
+{
+	return DIV_ROUND_CLOSEST(t * 100 + ABSOLUTE_ZERO_MILLICELSIUS, 1000);
+}
+
+static inline long celsius_to_deci_kelvin(long t)
+{
+	return t * 10 - DIV_ROUND_CLOSEST(ABSOLUTE_ZERO_MILLICELSIUS, 100);
+}
+
+static inline long deci_kelvin_to_millicelsius(long t)
+{
+	return t * 100 + ABSOLUTE_ZERO_MILLICELSIUS;
+}
+
+static inline long millicelsius_to_deci_kelvin(long t)
+{
+	return DIV_ROUND_CLOSEST(t - ABSOLUTE_ZERO_MILLICELSIUS, 100);
+}
+
+#endif /* _LINUX_TEMPERATURE_H */
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e45659c..ed549e4 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -14,6 +14,7 @@
 #include <linux/idr.h>
 #include <linux/device.h>
 #include <linux/sysfs.h>
+#include <linux/temperature.h>
 #include <linux/workqueue.h>
 #include <uapi/linux/thermal.h>
 
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
