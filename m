Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8B8C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 03:34:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9DD961184
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 03:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DD961184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=48OV00itdnEYDdwgaSBuattAWAoHpptHq7OQtm5Y/y0=; b=ivEYHI7CXczQTm
	8bc8S4wEZNWzWlCifvznZMj37VIOCSw7OxGuyelXevxCBDKfNqMw/X2eij5R7ZxKf0PgAVrg/GGzf
	LwSqnCYUd5vuMK4rJ+NPICcNr9Y7c3qzUVvYyAs7LzelqVl3+vrEvFGJoGUZGSs5knzOuagSbKAUa
	N1Gk1d2DbXynJmiKU+aduPwGBmejZ0re3v22DnzU5xvsGn1g+eGMDWqor+YzKW2/iuuzE8k8r1ZVv
	tLDDQz5zhHHn6BdjKtvDmbTuBlRqGi3UNAWTdCJp3UqZyBDM3Img0QS2I/APvjyaMNmot3jhscFNM
	vURbLSd6PtbWht5/Q0Fw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljZRE-005lUt-1n; Thu, 20 May 2021 03:33:32 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljZR9-005lUX-TD
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 03:33:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=YkQ4ceXLTuoJdgsh3J+Fp8JdGg+suqM/P8mBDtwI5y4=; b=fEpET1s8opOAwJMzRDn3kF0/B3
 V6T958PilwApo+ezBVsdFGTeuiE11tXJQMWD3daJBfaOPy7CuK+5ovmFWdSFKFhZqqk6C2yr28ZWb
 NHjI6mncFRmb9wdTrqX/y1VfR3qVNhg9nTHzryJTsQwmjE9lLFsfG3L2qHPSl9Ot6L4K0lY0bDwM9
 stI24l7JAAGBvJFZ7NkD5SovQcuHVx2iIL1rRod+QWOiXdXBv3YcA5br16OyRGUKyyvdrT20oZIib
 WBV2GWa6eyn+yNVACeJK+3v5Czdb8QRYbXBw5dCDDbowYgq2vqzS/XPo1iy5H/agMbKHrXTZgliHb
 pJYQhPxg==;
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljZR7-00FuUR-8o
 for linux-nvme@lists.infradead.org; Thu, 20 May 2021 03:33:26 +0000
Received: from mail-pj1-f70.google.com ([209.85.216.70])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <koba.ko@canonical.com>) id 1ljZR1-0007ie-7f
 for linux-nvme@lists.infradead.org; Thu, 20 May 2021 03:33:19 +0000
Received: by mail-pj1-f70.google.com with SMTP id
 bo19-20020a17090b0913b029015d14c17c54so4251249pjb.0
 for <linux-nvme@lists.infradead.org>; Wed, 19 May 2021 20:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YkQ4ceXLTuoJdgsh3J+Fp8JdGg+suqM/P8mBDtwI5y4=;
 b=Dd60dgV0srYtj+p2lzLUKvf95YQHnGklbo9lBodw+GBM1RxKGxP8vIml7Ipf9LmuuI
 ND8CnShJmmZ9fr+N8B96C+q4X47o7iJAi/f/n5P1gGldW3dKBTwTZKwV4/YX7JZRvd6V
 JQmsY1H2+m6ReE5RJe4how+4WA9q8Vh9H5vFUQF8/+3qOedFqqJZ3jPbdTUpciFm4dg5
 +ZylhkBaMgNQwMp5tIo6w/7ezMxuQ7X6JsKvymqCD10rcz+sKUSAeUlt2fW/0Efv25oh
 5IhHIQ0jBX/vhy3XbnyyN9FGWueB+LUIKdEhyQQmN0GHoewp7lqQWIb3yZRxJUNRJmjg
 Xeug==
X-Gm-Message-State: AOAM530SZ/7GukfHgVzSeGhaytq2lvBnZr2vkYYsxEdWS8kh7g+iH7VZ
 PwkpJHL6nOZ2w2e4iD164R0fz/ey+q1kvaQQndnusu6J+4z5yBBAOlK7qagK9EMRv/3qW0woRDR
 Ty9Tmpn5177+Usm30FSruO5LsANPxQymVwzgB1HW3iXUr
X-Received: by 2002:a63:ba1b:: with SMTP id k27mr2391408pgf.381.1621481597720; 
 Wed, 19 May 2021 20:33:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEQdG/WIW+OBmm8n7TrD3C+K/NNVGnz6wyAx0m47BSdwHi2idQXGZs1SeQ5To8OtLR6AkvTg==
X-Received: by 2002:a63:ba1b:: with SMTP id k27mr2391389pgf.381.1621481597456; 
 Wed, 19 May 2021 20:33:17 -0700 (PDT)
Received: from canonical.com (61-220-137-34.HINET-IP.hinet.net.
 [61.220.137.34])
 by smtp.gmail.com with ESMTPSA id 66sm687565pgj.9.2021.05.19.20.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 May 2021 20:33:17 -0700 (PDT)
From: Koba Ko <koba.ko@canonical.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Henrik Juul Hansen <hjhansen2020@gmail.com>
Subject: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use npss.
Date: Thu, 20 May 2021 11:33:15 +0800
Message-Id: <20210520033315.490584-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_203325_328355_5604DD7F 
X-CRM114-Status: GOOD (  12.47  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

During suspend, if the device can't use npss, driver would put
controller to shutdown simply and let host to control power management.
After resume, host can't change power state of the closed controller
from D3cold to D0.
For these devices, just avoid to go deeper than d3hot.

Tested-by: Henrik Juul Hansen <hjhansen2020@gmail.com>
Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
 drivers/nvme/host/pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a29b170701fc..caaf52051689 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -26,6 +26,7 @@
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/sed-opal.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/pm_runtime.h>
 
 #include "trace.h"
 #include "nvme.h"
@@ -2958,6 +2959,15 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
+	if (pm_suspend_via_firmware() || !dev->ctrl.npss ||
+	    !pcie_aspm_enabled(pdev) ||
+	    dev->nr_host_mem_descs ||
+	    (dev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND)) {
+		pdev->d3cold_allowed = false;
+		pci_d3cold_disable(pdev);
+		pm_runtime_resume(&pdev->dev);
+	}
+
 	nvme_reset_ctrl(&dev->ctrl);
 	async_schedule(nvme_async_probe, dev);
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
