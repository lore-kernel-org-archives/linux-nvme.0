Return-Path: <SRS0=zMYu=ZQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0B5C432C3
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Nov 2019 14:09:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E672073F
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Nov 2019 14:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qYGkL2QN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVHhFrNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E672073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=8ReQIKfr+82hZnZ2hAo2LNbFw+8lMGBvCAGvBqElprs=; b=qYG
	kL2QNHpWjM96oRbHVk80uB8++KecO3KYZVSvmVm+MnatKgnNeKSk0BBpj1DQD0WH9U2XmqWz+8IiE
	5VDLU74ssCU+1w8HmLAlk82+R1IiFh9sosS2vxh4FU+N04idabiQm6kpHzz1gCKUBpsbTZmCqUGtd
	eJMPl3hl/8zxhgNc8pB//7qaNhk9p1wqTWvafxqAflSGE8uCw8UacliVB7b/tDaJwa7aO/ZiXd0kO
	rYDKNgTCE1iJK5kl9pk9WKauNWke+ooW+ZecEZlct4oApKkRWUaHahRMOku7r4d7S9fkYyXc80AtN
	YCFJdjjAHp6Cldh+T4NHsmScqOMbkHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iYsZe-0003Dz-LU; Sun, 24 Nov 2019 14:09:14 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iYsZZ-0003DR-4g
 for linux-nvme@lists.infradead.org; Sun, 24 Nov 2019 14:09:11 +0000
Received: by mail-pl1-x641.google.com with SMTP id bb5so5277815plb.4
 for <linux-nvme@lists.infradead.org>; Sun, 24 Nov 2019 06:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=fytYybgFl7xuOSmQnvp6q1/Ea79YQjw0tWt4Bizw0mA=;
 b=GVHhFrNwoGoDRtY80N3KIXvLBkqiN+/S+ChGYbUMe8BwAr2Tr1j+hFE8Tmi9VxetkG
 Bmw3loe+8p46VnVE+5HUsdYV9BPGv0uFwcI2D5UZwibK9Lw46kOIoq9aZrC+Zzr+Cjcj
 gVEW/xdtdeM07YaDgT3aS2eQrXx1YRAwawXVfjdlohWo2t/F7ujcUBOxSVol0iJrFefT
 aXu9ud7QrK04QN4gvERRWXrv0Cu5w0JSp8oWnZhFs4wpLPpeXvOIzuEuI8w+IQk20mbu
 oG3J3H4daa5FOMXPnlZ6DO03N7Ozdcrpz/DAve7sEVECGUK+Hr/5GOMF9YzgZjUwOmE6
 3jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=fytYybgFl7xuOSmQnvp6q1/Ea79YQjw0tWt4Bizw0mA=;
 b=NFiQFCl6eSzCmtcA+VhKNvJOEqwRZ/2FIfcaZta1YCeTALrUrf3rR3hEQGzwAqFN+E
 vHrG+9YjYU3VNCkqq4cHN9V63U8XgzpWV8stUA5xnU9K/at07fCbyKG6N7ImyDIQCf6j
 szHkw6Q12PAy4rmh4YIFLCo7ystRGs5uUJyAg0DeLRMMAmHQSBG4MdwYEs1TGNuXS2E4
 PWnJmUD3wm2ZTcENQfJHqpF0fYPc+HJ4r5qjXbm4wP0y/tOuA8N0WuNIZqIqdiVxaJf+
 jktjUhsVuzCf/NXSp28YrzuAaUUZnOjv2Jh8WuXlMuefTODMLrEkbNJfWwQ/jWclc/Ij
 DhMQ==
X-Gm-Message-State: APjAAAW+fyXUG68v96x7M4r4IZqGpvoEkxaM3XJaSTwEGj+wOvjWFRrx
 XyTV5MruL69x1l9oVFTiYuCobAg/P4c=
X-Google-Smtp-Source: APXvYqyBSLTq/CtXVdy1kZ+42OQ1yYPI2w3yb9lfouKDp/CevSx3IwrqhzpBj4/MpiNWC/bSBrJqaQ==
X-Received: by 2002:a17:90b:30d7:: with SMTP id
 hi23mr31851724pjb.10.1574604547338; 
 Sun, 24 Nov 2019 06:09:07 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id a3sm4816326pgh.91.2019.11.24.06.09.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 24 Nov 2019 06:09:05 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] add header file for kelvin to/from Celsius conversion
 helpers
Date: Sun, 24 Nov 2019 23:08:42 +0900
Message-Id: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191124_060909_182280_642E827A 
X-CRM114-Status: GOOD (  10.54  )
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
functions for any drivers or subsystems, and switches all the users of
conversion helpers in <linux/thermal.h> to use <linux/temperature.h>
helpers.

Akinobu Mita (8):
  add header file for kelvin to/from Celsius conversion helpers
  ACPI: thermal: switch to use <linux/temperature.h> helpers
  platform/x86: asus-wmi: switch to use <linux/temperature.h> helpers
  platform/x86: intel_menlow: switch to use <linux/temperature.h>
    helpers
  thermal: int340x: switch to use <linux/temperature.h> helpers
  thermal: intel_pch: switch to use <linux/temperature.h> helpers
  nvme: hwmon: switch to use <linux/temperature.h> helpers
  thermal: remove kelvin to/from Celsius conversion helpers from
    <linux/thermal.h>

 drivers/acpi/thermal.c                             | 17 ++++++----
 drivers/nvme/host/hwmon.c                          | 13 +++-----
 drivers/platform/x86/asus-wmi.c                    |  7 ++--
 drivers/platform/x86/intel_menlow.c                |  8 +++--
 .../intel/int340x_thermal/int340x_thermal_zone.c   |  6 ++--
 drivers/thermal/intel/intel_pch_thermal.c          |  2 +-
 include/linux/temperature.h                        | 39 ++++++++++++++++++++++
 include/linux/thermal.h                            | 12 +------
 8 files changed, 68 insertions(+), 36 deletions(-)
 create mode 100644 include/linux/temperature.h

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
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
