Return-Path: <SRS0=Bcfk=ED=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5B3C55178
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 09:14:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895EE2468F
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 09:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bZ1fdtuV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjVBgzX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895EE2468F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UkSHNc9Ux3Q9vBZU3KX6hYIoZzcHWxkn7+YMEPdYfg8=; b=bZ1fdtuVthi9dLdiWpzDUueJ+E
	AfQcodIgnasb1sI9QshiUSPVROdPWiCMLX/UR757KhEDkz5H789zSQPf5XOpKl+KQJrPxMwIrrN3i
	PyYnM+YpfIoJd+nimZYcOMxAiSZt1WnMiVjb0rs06d9kxZUj/9f1Y9qvQNG1uN3/7DLrTNlh86U+s
	1ZmlIaUNshwDApzypZqmN+j95/LL7ZX063wziu9JNY4H3/SIYiKmDlXTFAFn+amE/er/Jpovw4FMo
	2fo2xCJH7YRB3gaeZGE3TsWBf1kWVgJxLdOEdg1zLDHQPSemZic5u6QkFW+IZFZzOfsKKfgTjr6n4
	6xG0wrig==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXhXK-00007L-UR; Wed, 28 Oct 2020 09:14:30 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXhXI-00006a-73
 for linux-nvme@lists.infradead.org; Wed, 28 Oct 2020 09:14:29 +0000
Received: by mail-pf1-x442.google.com with SMTP id 133so2554141pfx.11
 for <linux-nvme@lists.infradead.org>; Wed, 28 Oct 2020 02:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=eWk+xuEMaHfrOGisaJcZDQbnFBzO+EQMbeijQobGVcc=;
 b=PjVBgzX+sh1RxzD3ktOd8/ozXdm5p9XLmy/oyVryGtVhQdVO9HwhyoudLy3mi7ueEL
 x5gw3EpaEShErO19sXzKxwBr63LNqptSi/jG2AHuVDsujI2tYilcT1MLqlORLAUX4CbC
 gDAIWeemVUf/hf1+PQbK2dAkyfnZmgseqXdAyn+sBOTf8GWg6ybTn7cSs+6I/rr8cOeE
 KPj2t2xUeyiljQO/wWiJ2s/Lb7Bszv/CVXm/VVyKsDwwOFzh0pbc9gzqvym44KiJNhfI
 CNMGP5+Of24kkDeR3bNvVU7/bhD5QjbKxZQs7fjZ6fgYLOWKWeEs8MwZiCI9GKDFljw6
 f3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=eWk+xuEMaHfrOGisaJcZDQbnFBzO+EQMbeijQobGVcc=;
 b=e/DNJsJcpQ4AJpr+sXO2sbWMNFII87WafHnSJJlv5qi/3kkCsAxFQ+vg49Fi6QyI4f
 KSLDNoefdNvAU1SusutED8eWsHabBWmiuK888ukxxmWJW3kF25JEfA9sme3A7LaS5xIz
 IupyagSyp3sIi6nUqDvIahgQgbiof0KYWDDvuLlHv0IFfv65xcua5vcQEmORZ3bdh23E
 NOQj2qJoEl894BtWFoo+ek3X17LdRW2tiHKj9jyDhNFWKo61F40AHgZkCYyOY7tdsjbW
 3lmn6qLe46uFhGvh5BkFE1mNqzkbHj++vhoLxxGdNmVuPv580+S82NFPuvhULlWHDCIZ
 Cclw==
X-Gm-Message-State: AOAM533lCfUZRssOy2dOasMgQ5ugBbLr3QDGxPzErNK5x8vGrB2XaNOK
 CeAcNC1E9tGiYKvVKZGg0xs=
X-Google-Smtp-Source: ABdhPJxVjWpSRS4Nb8Iu/QS0NZTm8+kPTdp6s2/OIIweLfLW5kHpDsNn1BRM/vpYVu7OUxUdHle35A==
X-Received: by 2002:a63:4d0f:: with SMTP id a15mr5431900pgb.250.1603876466122; 
 Wed, 28 Oct 2020 02:14:26 -0700 (PDT)
Received: from image-900X5T-900X5U ([220.120.123.224])
 by smtp.gmail.com with ESMTPSA id g16sm4621282pgm.38.2020.10.28.02.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 02:14:25 -0700 (PDT)
Date: Wed, 28 Oct 2020 18:14:21 +0900
From: Jongpil Jung <jongpuls@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running FW
 220TQ,22001
Message-ID: <20201028091421.GA667673@image-900X5T-900X5U>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201028_051428_321360_5D747B67 
X-CRM114-Status: GOOD (  23.52  )
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
Cc: jongpuls@gmail.com, gloria.tsai@ssstc.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, dj54.sohn@samsung.com,
 jongpil19.jung@samsung.com, jongheony.kim@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

LiteON(SSSTC) CL1 device running FW 220TQ,22001 has bugs with simple
suspend.

When NVMe device receive D3hot from host, NVMe firmware will do
garbage collection. While NVMe device do Garbage collection,
firmware has chance to going incorrect address.
In that case, NVMe storage device goes to no device available state.
Finally, host can't access the device any more.

Quirk devices will not use simple suspend even if HMB is enabled.
In case of poweroff scenario, NVMe receive "PME turn off".
So garbage collection will not be happening.

Liteon(SSSTC) will fix the issue, that's why quirk apply on specific
vendor id and firmware version on specific platform.

Signed-off-by: Jongpil Jung <jongpuls@gmail.com>
---
 drivers/nvme/host/core.c | 43 ++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h |  4 ++++
 drivers/nvme/host/pci.c  |  6 +++++-
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 95ef4943d8bd..414775a77013 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -7,6 +7,7 @@
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/compat.h>
+#include <linux/dmi.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/hdreg.h>
@@ -2637,6 +2638,36 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
 		.vid = 0x14a4,
 		.fr = "22301111",
 		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
+	},
+	{
+		/*
+		 * This LiteON CL1-3D256 CR22001 firmware version has some
+		 * issue in simple suspend.
+		 * Simple Suspend issue will be fixed in future firmware
+		 */
+		.vid = 0x14a4,
+		.fr = "CR22001",
+		.quirks = NVME_QUIRK_NORMAL_SUSPEND_HMB,
+	},
+		{
+		/*
+		 * This LiteON CL1-3D256 CR220TQ firmware version has some
+		 * issue in simple suspend.
+		 * Simple Suspend issue will be fixed in future firmware
+		 */
+		.vid = 0x14a4,
+		.fr = "CR220TQ",
+		.quirks = NVME_QUIRK_NORMAL_SUSPEND_HMB,
+	},
+	{
+		/*
+		 * This SSSTC CL1-3D256 CR22001 firmware version has some
+		 * issue in simple suspend.
+		 * Simple Suspend issue will be fixed in future firmware
+		 */
+		.vid = 0x1e95,
+		.fr = "CR22001",
+		.quirks = NVME_QUIRK_NORMAL_SUSPEND_HMB,
 	}
 };
 
@@ -3007,10 +3038,18 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		 * could re-scan for quirks every time we reinitialize
 		 * the device, but we'd have to make sure that the driver
 		 * behaves intelligently if the quirks change.
+		 * For NVME_QUIRK_NORMAL_SUSPEND_HMB, need to check board
+		 * as well.
 		 */
 		for (i = 0; i < ARRAY_SIZE(core_quirks); i++) {
-			if (quirk_matches(id, &core_quirks[i]))
-				ctrl->quirks |= core_quirks[i].quirks;
+			if (quirk_matches(id, &core_quirks[i])) {
+				if (core_quirks[i].quirks == NVME_QUIRK_NORMAL_SUSPEND_HMB) {
+					if (dmi_match(DMI_BOARD_VENDOR, "Google") &&
+					    dmi_match(DMI_BOARD_NAME, "Kohaku"))
+						ctrl->quirks |= core_quirks[i].quirks;
+				} else
+					ctrl->quirks |= core_quirks[i].quirks;
+			}
 		}
 	}
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cc111136a981..2fde019dad8e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -144,6 +144,10 @@ enum nvme_quirks {
 	 * NVMe 1.3 compliance.
 	 */
 	NVME_QUIRK_NO_NS_DESC_LIST		= (1 << 15),
+	/*
+	 * Force noraml suspend/resume path for HMB enabled devices.
+	 */
+	NVME_QUIRK_NORMAL_SUSPEND_HMB		= (1 << 16),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index df8f3612107f..1b1221cfb257 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3014,10 +3014,14 @@ static int nvme_suspend(struct device *dev)
 	 * specification allows the device to access the host memory buffer in
 	 * host DRAM from all power states, but hosts will fail access to DRAM
 	 * during S3.
+	 *
+	 * If NVME_QUIRK_NORMAL_SUSPEND_HMB is enabled,
+	 * do not use SIMPLE_SUSPEND for HMB device.
 	 */
 	if (pm_suspend_via_firmware() || !ctrl->npss ||
 	    !pcie_aspm_enabled(pdev) ||
-	    ndev->nr_host_mem_descs ||
+	    (ndev->nr_host_mem_descs &&
+	     !(ndev->ctrl.quirks & NVME_QUIRK_NORMAL_SUSPEND_HMB)) ||
 	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
 		return nvme_disable_prepare_reset(ndev, true);
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
