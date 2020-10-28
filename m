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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765C4C4363A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 07:40:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAFD222456
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 07:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SIUnfLsb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAzKVcpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFD222456
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=haknjFMz/EcFtUjrsHNINaFdmjPAefAQD3ZdCCCt8LQ=; b=SIUnfLsba9p2GBthIJarN0XLZ6
	CVuxnMJ5lFe8gRD/we51dYKJ9XF19lKPy58Sfioczb5H8RyM8ZNk8MZdqSgpFOiRBrzscGJE+4QAO
	iIG+b9Y7DSpF9wcaCbvWd96gtkUdTYIJFB4JKfXbaGrQVIXroCx5CgBPPiGzYp1Pfg12FNY6zZyYq
	2rgMWPg+Mq4mtD6yonioHYsjCRMEUjxWRs/dbp72Np4p02RIWAdHafvhjFVBsaTsnd2sg8sjMYtYc
	TPOEchDtVbMlaXncNFs2SJRiT0T39oyX2epegmCVog2pKHH7XhfF9IhPYTnYlJl9TG1ZSjiFMNbQ+
	FhaLakSA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXg4B-0003KF-Ui; Wed, 28 Oct 2020 07:40:20 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXg44-0003J6-OB
 for linux-nvme@lists.infradead.org; Wed, 28 Oct 2020 07:40:18 +0000
Received: by mail-pg1-x544.google.com with SMTP id x13so2270803pgp.7
 for <linux-nvme@lists.infradead.org>; Wed, 28 Oct 2020 00:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=uWpU6Cbk1aGPWbnOgnXvEXIQsry1Zp6WwkjkIQDF1pk=;
 b=TAzKVcpLBAdpInkYodiDIcerz0RCdZmucUXjIqnmqEga7wjsIAbASg9yjo8wLwKvwR
 sjkDQcyUUfh1glCmD9i9OmGYu6Fc9LqQNUtMS+K2gUsJFgkNvAOcTv4qqKElmX9IIyxs
 GJpzxx6koV2Unrzz5abr/Q910yATeGB1XNnM9McqEj+ZYb72E5O2U1RTde0g+MJ3CADC
 Iu/UHipclHoALN2UU22o27OsKjpAUhsakbZHKLJmX7gyykcNNmLaG7XJR+TxVzMYhJKI
 ZULgmwl+LRqq8m/7lLDAKm0vefJAcbdtoeCYyddoL/zk+MGz0+R+o2DIwXCaKpcCcxO5
 Ca4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=uWpU6Cbk1aGPWbnOgnXvEXIQsry1Zp6WwkjkIQDF1pk=;
 b=RJYAbm59/QUAdXMxyrk6cmbKOlYz8dD7X4jNB18d0kfp7fl7EK1ewF7AYA/SEoTsJ0
 t4kv3+G1nb1uGm33P99FBtF4W1Gnsl5WTTPcCVelDqLyEW/uCdDvMACniU2NKEMVCH1W
 6q4NYpwEwaIkPdPsq1+oWs7z+WloTjo4RoXZuebZ0Sf89DCWnmtYJMZtIq4BVZmEeLCH
 GyCU1QNMvlwAMSWvlW8rdEFeL8fHrdu88vSoipVOgMRmIH3unr8viyEOpsyHRSugptfa
 bqFKdcfN4zrTNjTurKuOhZZi0k8folYnE66zQFWTvu2fQto18chLhdSQ+oFrIFwBt1rn
 Uxtg==
X-Gm-Message-State: AOAM5334jUTzxwo3VTfev83YqTFtpfzTPtx/J8QYiPVsUGYle4yohLFf
 VaSQpsK9z7O755n/SNG/jOo=
X-Google-Smtp-Source: ABdhPJzNHDjPq12DKVOMMp7sPMfgvQDx3KtKAchmy91Ap7NTk+WyPBqbmnVih1DHbG+MWSBKNfwKIQ==
X-Received: by 2002:a63:845:: with SMTP id 66mr5191372pgi.318.1603870805475;
 Wed, 28 Oct 2020 00:40:05 -0700 (PDT)
Received: from image-900X5T-900X5U ([220.120.123.224])
 by smtp.gmail.com with ESMTPSA id e4sm4088830pgg.37.2020.10.28.00.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 00:40:04 -0700 (PDT)
Date: Wed, 28 Oct 2020 16:40:00 +0900
From: Jongpil Jung <jongpuls@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH V2 1/1] nvme: Add quirk for LiteON CL1 devices running FW
 220TQ,22001
Message-ID: <20201028074000.GA320668@image-900X5T-900X5U>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201028_034012_842614_60985377 
X-CRM114-Status: GOOD (  22.30  )
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
 drivers/nvme/host/core.c | 42 ++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h |  4 ++++
 drivers/nvme/host/pci.c  |  6 +++++-
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 95ef4943d8bd..b7b0b694ee21 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2637,6 +2637,36 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
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
 
@@ -3007,10 +3037,18 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
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
