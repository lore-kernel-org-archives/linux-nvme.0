Return-Path: <SRS0=GgRz=2F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6D7C3F68F
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Dec 2019 08:51:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B30C2253D
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Dec 2019 08:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DHkazRru";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFllsnGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B30C2253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=CSSLMPa/ytatXlMjLL/vDx/79oXnu0iuDZiNvsXiaVY=; b=DHk
	azRruqeoASMJPd7ei5aSsHjGNhjbPg/aDOvsVEBkNLRMzkO1E4+pfkU2jGGF15Z+GCmP4w9BneDhn
	fe8bxC3HINS8LWtm9FtIJgYfts1q6odr2U3nim5j1vboI/BphiB+k2P0Lvgb1ClcF5s5rzc3HJtAt
	lqxwOoqb8V/QQJX1Z8BtAUDNuK8Lpj6kmmVxkNStmmK5nOcosE4jdIWuVXTCtq7qIgs8soQ8O1aMX
	9EpYxfo+KE6koLtbTSmknF2qffhNELoL689oe58uRnlmomDUn9RRFsSGJEBDZgAT0nyNjyRzCuyHq
	6VNLu6ARq2oe3F4VjO01fEKdArXiIoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1igPcF-0000GI-Th; Sun, 15 Dec 2019 08:51:03 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1igMGr-0001Lu-TW
 for linux-nvme@lists.infradead.org; Sun, 15 Dec 2019 05:16:48 +0000
Received: by mail-pl1-x644.google.com with SMTP id z3so1485290plk.6
 for <linux-nvme@lists.infradead.org>; Sat, 14 Dec 2019 21:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=NG3H+s+fBBFZ6iq8D5+2rLQ1nI3ABlA+Ut9Zp7bqJfw=;
 b=fFllsnGvsEGyNBVt6BCMjcLIs9kK0YQmUxliyDazXC+jL/P/+h+E031C6MADa+BhaZ
 cPem5VxZc6Xui6mUJ2J+heoRkSdY1Tfr4MTSmtCZRK7GATNQ0SnZEGtE2dQAh3bA4em0
 6FjpBSRHNHHvvdNJCh9P7mhoscWbr4ZnvdhXZiCIBrUz+5bROc5rWPW9jbji03z6+1ks
 viwiAT2A0DY9a2/6FuRKgBll3PiZPA5uJtFLf90tssSpQVc1s44SgFV29BuOuz4zVmqH
 jtOCBkhp0T3zV3WUWq53EDbiDfNfQIqx3f4LqSjJN9Hl19b+cLzQxq/47p/UJDq6jxKM
 h5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=NG3H+s+fBBFZ6iq8D5+2rLQ1nI3ABlA+Ut9Zp7bqJfw=;
 b=OkrnPe5ZiLeo1nbwZBgZb/7s+xqAAoEkHbnfH7my8eN2IxggugeFIa7ueebXguAJi5
 XbgmchvWh9bR8xzFc6E6dYjBnq5zzWy/0jvNslbTzCrKcO9RRCV6llSSltT0tjrdxiIe
 /8AqD+8TFthfW6dvLE3cdbhCwCOInqX4J97mZ+2NAODzXCWc6Uac1YyVWr+Nb9PeVlHm
 t/LNoFFnUmCTzx2jZdBXk5ab4NqV9XMJVmhInGZczd6t79hSwiHkpDApnR7zneFTgoGd
 HD5sQwOtMXMyQhVT/ArJKmPPJrQhNpF/q6YGLWu9Nl9k1IaOjELOlGavkashi6sIncZ1
 WQfg==
X-Gm-Message-State: APjAAAWmChk7Fr/tIXuH42/LwNUWDOWrRlsy6K01SLOb1qXAwx75Zy6r
 6Heot4u7UFKu3oc4voSyc024hlwm8IwvqA==
X-Google-Smtp-Source: APXvYqxgtJdFVOCE8Ms0U4eceOkCGxZyfix7v1NLBAjvEFeByQtDfmu1KxfD+5ueGYi8ZtB7bBjehg==
X-Received: by 2002:a17:902:7896:: with SMTP id
 q22mr9010139pll.219.1576387002224; 
 Sat, 14 Dec 2019 21:16:42 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id u10sm16596528pgg.41.2019.12.14.21.16.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 14 Dec 2019 21:16:41 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org
Subject: [PATCH v4 00/12] add header file for kelvin to/from Celsius
 conversion helpers
Date: Sun, 15 Dec 2019 14:16:03 +0900
Message-Id: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191214_211645_993759_9A508B8F 
X-CRM114-Status: GOOD (  13.21  )
X-Mailman-Approved-At: Sun, 15 Dec 2019 00:51:02 -0800
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
functions for any drivers or subsystems, and switches all the users of
conversion helpers in <linux/thermal.h> to use <linux/units.h>
helpers.

* v4
- add Reviewed-by and Acked-by tags
- change include order
- keep the line over 80 characters because this change doesn't make it longer
- remove "wireless: " in the title

* v3
- rename new header name from <linux/temperature.h> to <linux/units.h>
- add milli_kelvin_to_millicelsius() and millicelsius_to_milli_kelvin() and
  use them for implementing other helpers
- add MILLIDEGREE_PER_DEGREE and MILLIDEGREE_PER_DECIDEGREE and replace
  the hardcoded constants
- add kelvin_to_celsius() and celsius_to_kelvin() in <linux/units.h>
- add Reviewed-by tags
- switch iwlegacy driver to use <linux/units.h> helpers
- switch iwlwifi driver to use <linux/units.h> helpers
- remove unused TO_MCELSIUS macro in armada thermal driver
- switch qcom-vadc-common module to use <linux/units.h> helpers

* v2
- add deci_kelvin_to_millicelsius_with_offset() in linux/temperature.h
- stop including linux/temperature.h from linux/thermal.h
- include <linux/temperature.h> explicitly from thermal drivers
- fix s/temprature/temperature/ typo in commit log
- use deci_kelvin_to_millicelsius_with_offset() in ACPI thermal zone driver
- don't mix up another fix (format string for cellsius value)
- add Acked-by and Reviewed-by tags

Akinobu Mita (12):
  add helpers for kelvin to/from Celsius conversion
  ACPI: thermal: switch to use <linux/units.h> helpers
  platform/x86: asus-wmi: switch to use <linux/units.h> helpers
  platform/x86: intel_menlow: switch to use <linux/units.h> helpers
  thermal: int340x: switch to use <linux/units.h> helpers
  thermal: intel_pch: switch to use <linux/units.h> helpers
  nvme: hwmon: switch to use <linux/units.h> helpers
  thermal: remove kelvin to/from Celsius conversion helpers from
    <linux/thermal.h>
  iwlegacy: use <linux/units.h> helpers
  iwlwifi: use <linux/units.h> helpers
  thermal: armada: remove unused TO_MCELSIUS macro
  iio: adc: qcom-vadc-common: use <linux/units.h> helpers

 drivers/acpi/thermal.c                             | 34 ++++-----
 drivers/iio/adc/qcom-vadc-common.c                 |  6 +-
 drivers/iio/adc/qcom-vadc-common.h                 |  1 -
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |  3 +-
 drivers/net/wireless/intel/iwlegacy/4965.c         | 11 +--
 drivers/net/wireless/intel/iwlegacy/common.h       |  3 -
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h       |  5 --
 drivers/net/wireless/intel/iwlwifi/dvm/devices.c   |  6 +-
 drivers/nvme/host/hwmon.c                          | 13 ++--
 drivers/platform/x86/asus-wmi.c                    |  7 +-
 drivers/platform/x86/intel_menlow.c                |  9 ++-
 drivers/thermal/armada_thermal.c                   |  2 -
 .../intel/int340x_thermal/int340x_thermal_zone.c   |  7 +-
 drivers/thermal/intel/intel_pch_thermal.c          |  3 +-
 include/linux/thermal.h                            | 11 ---
 include/linux/units.h                              | 84 ++++++++++++++++++++++
 16 files changed, 137 insertions(+), 68 deletions(-)
 create mode 100644 include/linux/units.h

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
-- 
2.7.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
