Return-Path: <SRS0=peCB=2B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70589C3F68F
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:39:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41EC12173E
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pwLdq6vr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzSx4/i2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41EC12173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=VtJY5j7WCeZDZROIYI8BLtCAj00xcZIpZLHzs6tNPAg=; b=pwL
	dq6vroMz7hsuozHCesI0wW6ct3axgP5y6tz6MZeP31lhiVoDSyXlfMtCFaaV7sOSJPVk3YDY1Lrgq
	zBaHJnK0L4tMSrXQpZ786Zu7KGrziwQlfCo4hferjY9h0ax2AKKLdHcgT4CHOmzACk3vUvwmRctAR
	wogYWXs7uuha2x0vqIIIIs3lavuaCu555xA+ZzmwJQKs2521G/UZG2Q+9vvYmwN+qpt3usRMNxgVC
	6CkeBETr+BdW6bFHc/QowsCt7pg0AXgTXqognCPGFsfs2nEQ8Sl29FOJilu5QbNdA3BKLsjJii1Ti
	7iEH1iTKhZ9oc+0rhDGzT4GcjfVEX8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1if38k-0006FG-3k; Wed, 11 Dec 2019 14:38:58 +0000
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1if38b-00063q-Ry
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 14:38:52 +0000
Received: by mail-pj1-x1041.google.com with SMTP id l4so9014766pjt.5
 for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2019 06:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=5BPDmN/kK4qF1FFBcFUC5NrEjFOAwbeaBcO9T8TsnoI=;
 b=TzSx4/i24RD3Dd71O89+B4fIq62OZ0UUbisqw9pRgyfOm6sUDMjMhyYszrxOBIjwT4
 37vUbBF8dWFFXKS+lRjeSxxMBNOcfYT4rQNinX79d19OHoarteMsTt/0CPgLWSe53zUY
 vMHpInIAOOfF8hLhjxAMAdtA2xrdHKzHZ9BTeukIb5Pv5vuC+Rgkj6L2H3joKWh7cXWK
 LzgxV73ohhGvP7di7NCaWQBtfYXXkI6EJ46I/fHfYIEw7BmTXtJtK0h04kOi1Ta0bWbh
 WXtoO+s9g2EzdiAOc3ODQ/0fgcf3A7+UzpFNYara7eRAe6vUcLv8LXM5ug3xjjL6cBTE
 18Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=5BPDmN/kK4qF1FFBcFUC5NrEjFOAwbeaBcO9T8TsnoI=;
 b=PPNBkD2pgwPyQxwpVqgIdLulQCPvVXVmBtEd3cYcdiqpP2hc2DrDS0qVGV4Y5NUIxO
 uISXxohI3SzW8m+7lV7TlurhRi87zRVCed7+0SXnKf7+e0J1Tv4uJGDhEhil1GGm6WJK
 SoDEn41V9hnm1oJ12Nt+EGssIkAvVpiOpax0mgXECOIHKEpfUoYaIZZ/k6P8cQEPENKi
 OTEhqjnErLumUuTDWQJH9EUxSx20NWvkt/BNeV4giu8jY2Ev1Z19J88U+KjCMYiL86lc
 BbRzVWVhtSePIJIWYWPSc8YhkHsRyt1FW7NQ02ZGPIne09pJWn5+vGNEr627vrcMQVIh
 TLmQ==
X-Gm-Message-State: APjAAAWbcouuzYnm5z6XRoYOafFUvmbdyCQ1ZlaodjaFWBFyLSKilL4/
 SYO2tXiTBzEZE6m80g5lOhJmlbNgLno=
X-Google-Smtp-Source: APXvYqxuBwnuR3LZbqfQuvFGH0wM9ioq0vUjfYErg4Lo+js0qm5mN9zlNsQwib7u5AlkkyMPa7zmWQ==
X-Received: by 2002:a17:90a:94cc:: with SMTP id
 j12mr3766553pjw.3.1576075127838; 
 Wed, 11 Dec 2019 06:38:47 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.38.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 11 Dec 2019 06:38:46 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/12] add header file for kelvin to/from Celsius
 conversion helpers
Date: Wed, 11 Dec 2019 23:38:07 +0900
Message-Id: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191211_063849_965765_AE07DA4B 
X-CRM114-Status: GOOD (  13.76  )
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
  wireless: iwlegacy: use <linux/units.h> helpers
  wireless: iwlwifi: use <linux/units.h> helpers
  thermal: armada: remove unused TO_MCELSIUS macro
  iio: adc: qcom-vadc-common: use <linux/units.h> helpers

 drivers/acpi/thermal.c                             | 36 +++++-----
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
 16 files changed, 139 insertions(+), 68 deletions(-)
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
