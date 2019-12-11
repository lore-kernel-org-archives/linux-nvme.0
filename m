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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9BDC43603
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:39:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E4320836
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z4FMKNAt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/zyW7ze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E4320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=BH+UMkRgM4PvxxHX27NaUkV3run4xl6gnkT/RBL7kGU=; b=Z4FMKNAttBGtYc8yOFf8zqHqSX
	ZTnM3ZZFVuCNXrP2zXC1t52hptGpq4Sib9frPw+RZy3s9b9Mn+aVAnP9Y/QvGHjYK4zyr445+0tDU
	tKP9O88elRvaSIXiLuGu+iSOYHWG7PgFE1zQDHMexYGNi93RcgGpS+1kV4O+vjp1c9z9tlMgCE+8K
	/ngnMdNqkv7qZcleYW4MQKRNDU7QnuUgwHytdd2ckYfRUP2+IyGs8WS+tfDS7pao1edeOnBFKNtzD
	KQKXQlyX4HTaO66GSfn7Hu6dGbxCDkDaepYxMU0pssCEl3LeJlYg9NPQAYntPaJ+j4Id7SZrh6jXu
	6SHGnK5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1if38t-0006Qt-02; Wed, 11 Dec 2019 14:39:07 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1if38i-0006D9-L1
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 14:38:58 +0000
Received: by mail-pg1-x544.google.com with SMTP id q127so10876397pga.4
 for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2019 06:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=l0g2yitOap2PZ563u5lrVGdcbHo44KhhJk/TqjJ9Bls=;
 b=n/zyW7zeFhMU5gj3nvHALhoD0Cni+mTg66+JciqG64jKfxuDYWCuHFshRuKw9PzcVR
 UPAhcWK8PMXQJvYTKwWVJxtE93sBSkxt97rrtEQIGwWkoZ1GYIbhP1dc6cBA47HAr7fq
 7HZyBS8L+8zimgtYc0u2Qxogpoe9wos3NUr+I8uQNBQ2QVMH43qaylcRH6Fy7GLt4cV7
 Q3DztC7PRqjIfQG8uHRpfhPlvaIVfJ23nQyyG/nE6Xu/em+ek7hvnX2atXSHwTL/ryKg
 m776Nu2T7ruyegOFT76AFo2uyLAC2UWE0ZgYTo6SUra3dBBLtNc3N/WoplLyovVh9w/h
 MbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=l0g2yitOap2PZ563u5lrVGdcbHo44KhhJk/TqjJ9Bls=;
 b=iFiuRT/BWupZy1mzaN1XyEwXkFq7gDg1+77V2JE9w4vQzR5kZe4WqzBAGEsSh//kPD
 uBh0TUnizCOv/O2+wNQZdfFhGT7oAURTvAckC3mDz2E+cr5V64OJPYCj66pa9YfyGU+9
 lnkJyono5mSHOcwB+AdmJiR+RA3Zq3xIeXQpW5wRkwsYXgHSdhpnX9px0HHFk7r7ltIF
 lTA5ixIbc80W773bcu06ywjZkqOBo4HFOJtfsAPya+2v84wzc7c0cu3qYWG5BoXS9d0O
 ZvjnG9lPXWFHqHVgQuZ9CJjMXpDR6C2j+wmAUaJDw4m4QKqASO/m84eIPjQQ6R+GwPwa
 7azQ==
X-Gm-Message-State: APjAAAVe+4RI5VWX4Xfkk5fiEGBqUp2oqkqLQf4T7HFjxrP6Te1VDcWZ
 CcEREPLkpPlgiaUb9jtEOMR7ohcO+3ccPg==
X-Google-Smtp-Source: APXvYqy05/Tn9Tceh/n1VRnGu0o9MXcVLllz85EXFJwN51RkIZCmg7WXWcX4MikbeZCoqWs2pOFXqQ==
X-Received: by 2002:a63:ea17:: with SMTP id c23mr4526029pgi.85.1576075135462; 
 Wed, 11 Dec 2019 06:38:55 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.38.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 11 Dec 2019 06:38:54 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/12] add helpers for kelvin to/from Celsius conversion
Date: Wed, 11 Dec 2019 23:38:08 +0900
Message-Id: <1576075099-3441-2-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191211_063856_717879_9CC53A6E 
X-CRM114-Status: GOOD (  16.06  )
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
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
 Stanislaw Gruszka <sgruszka@redhat.com>,
 Luca Coelho <luciano.coelho@intel.com>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Christoph Hellwig <hch@lst.de>,
 Amit Kucheria <amit.kucheria@verdurent.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Sagi Grimberg <sagi@grimberg.me>,
 Sujith Thomas <sujith.thomas@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Darren Hart <dvhart@infradead.org>,
 Zhang Rui <rui.zhang@intel.com>, Guenter Roeck <linux@roeck-us.net>,
 Jean Delvare <jdelvare@suse.com>, Johannes Berg <johannes.berg@intel.com>,
 Intel Linux Wireless <linuxwifi@intel.com>,
 Akinobu Mita <akinobu.mita@gmail.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Kalle Valo <kvalo@codeaurora.org>,
 Andy Shevchenko <andy@infradead.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

There are several helper macros to convert kelvin to/from Celsius in
<linux/thermal.h> for thermal drivers.  These are useful for any other
drivers or subsystems, but it's odd to include <linux/thermal.h> just for
the helpers.

This adds a new <linux/units.h> that provides the equivalent inline
functions for any drivers or subsystems.  It is intended to replace the
helpers in <linux/thermal.h>.

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
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: Luca Coelho <luciano.coelho@intel.com>
Cc: Intel Linux Wireless <linuxwifi@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v3
- rename new header name from <linux/temperature.h> to <linux/units.h>
- add milli_kelvin_to_millicelsius() and millicelsius_to_milli_kelvin() and
  use them for implementing other helpers
- add MILLIDEGREE_PER_DEGREE and MILLIDEGREE_PER_DECIDEGREE and replace
  the hardcoded constants
- add kelvin_to_celsius() and celsius_to_kelvin() in <linux/units.h>

 include/linux/units.h | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 include/linux/units.h

diff --git a/include/linux/units.h b/include/linux/units.h
new file mode 100644
index 0000000..aaf7163
--- /dev/null
+++ b/include/linux/units.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UNITS_H
+#define _LINUX_UNITS_H
+
+#include <linux/kernel.h>
+
+#define ABSOLUTE_ZERO_MILLICELSIUS -273150
+
+static inline long milli_kelvin_to_millicelsius(long t)
+{
+	return t + ABSOLUTE_ZERO_MILLICELSIUS;
+}
+
+static inline long millicelsius_to_milli_kelvin(long t)
+{
+	return t - ABSOLUTE_ZERO_MILLICELSIUS;
+}
+
+#define MILLIDEGREE_PER_DEGREE 1000
+#define MILLIDEGREE_PER_DECIDEGREE 100
+
+static inline long kelvin_to_millicelsius(long t)
+{
+	return milli_kelvin_to_millicelsius(t * MILLIDEGREE_PER_DEGREE);
+}
+
+static inline long millicelsius_to_kelvin(long t)
+{
+	t = millicelsius_to_milli_kelvin(t);
+
+	return DIV_ROUND_CLOSEST(t, MILLIDEGREE_PER_DEGREE);
+}
+
+static inline long deci_kelvin_to_celsius(long t)
+{
+	t = milli_kelvin_to_millicelsius(t * MILLIDEGREE_PER_DECIDEGREE);
+
+	return DIV_ROUND_CLOSEST(t, MILLIDEGREE_PER_DEGREE);
+}
+
+static inline long celsius_to_deci_kelvin(long t)
+{
+	t = millicelsius_to_milli_kelvin(t * MILLIDEGREE_PER_DEGREE);
+
+	return DIV_ROUND_CLOSEST(t, MILLIDEGREE_PER_DECIDEGREE);
+}
+
+/**
+ * deci_kelvin_to_millicelsius_with_offset - convert Kelvin to Celsius
+ * @t: temperature value in decidegrees Kelvin
+ * @offset: difference between Kelvin and Celsius in millidegrees
+ *
+ * Return: temperature value in millidegrees Celsius
+ */
+static inline long deci_kelvin_to_millicelsius_with_offset(long t, long offset)
+{
+	return t * MILLIDEGREE_PER_DECIDEGREE - offset;
+}
+
+static inline long deci_kelvin_to_millicelsius(long t)
+{
+	return milli_kelvin_to_millicelsius(t * MILLIDEGREE_PER_DECIDEGREE);
+}
+
+static inline long millicelsius_to_deci_kelvin(long t)
+{
+	t = millicelsius_to_milli_kelvin(t);
+
+	return DIV_ROUND_CLOSEST(t, MILLIDEGREE_PER_DECIDEGREE);
+}
+
+static inline long kelvin_to_celsius(long t)
+{
+	return t + DIV_ROUND_CLOSEST(ABSOLUTE_ZERO_MILLICELSIUS,
+				     MILLIDEGREE_PER_DEGREE);
+}
+
+static inline long celsius_to_kelvin(long t)
+{
+	return t - DIV_ROUND_CLOSEST(ABSOLUTE_ZERO_MILLICELSIUS,
+				     MILLIDEGREE_PER_DEGREE);
+}
+
+#endif /* _LINUX_UNITS_H */
-- 
2.7.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
