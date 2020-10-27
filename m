Return-Path: <SRS0=wn7D=EC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C221C388F9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 15:55:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728F820678
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 15:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NkzWzlQN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/S7PhtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728F820678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HNcdmZIKMsKgAunBBuof+Ph/aHr+Q83WZks1L9oMmuA=; b=NkzWzlQN5j85zn/lRzZnQKJpyr
	ZTRH0t5ATEVSv4M1FLa0AsYdq6vr95o574MJdG/y1LWzpe6CWetRJMUQhy5R/FrSUXqrPnv22WAOd
	afulZXTNhb/8P8evmc0w0yR+CJE4TSSWozPAIKEw/NYeuHmrVGA4eskn3J3Ts0/zWGstk3FTS0xew
	XPpvXUfsbFWhxUIUmqREZ27nsNBuXlkrELh3xq0N2LJhi5nQLQcVNiTt1JqojzeUfSGMv1SwSakHO
	nY/bp4hEQonzo80hLCDNWoE2Qi4LHh+5UOAa1XSHele5nqteh+7K3u6/z1dPvSKUdWtAgjO2LPROA
	Kj2xA77Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXRJI-0006JP-MU; Tue, 27 Oct 2020 15:54:56 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXRJD-0006H1-KL
 for linux-nvme@lists.infradead.org; Tue, 27 Oct 2020 15:54:52 +0000
Received: by mail-pg1-x542.google.com with SMTP id r10so1019010pgb.10
 for <linux-nvme@lists.infradead.org>; Tue, 27 Oct 2020 08:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=/dJcq9QxKtdJNhx+nsVsOcHkLZ97Ve8VpsG6zN36Ipk=;
 b=C/S7PhtNmV1VV1Buz0pxqAyvprR9/Ls4erwM4MRF9n8KpZAEi/mLwb/86fwREdEu4s
 z/W5AS4Co+D9EwVOnm1Zi52qThoB/mWxHIiSrqujKGzwCE2jkEpsTdFLqrKYKNbqpXpK
 A4XWshQNqcVuwWH05AY6/UJflMn/V/qRH+r7TlYmDqawiulhrv4FlKOmUIkSbg4whLxj
 yX37UWUK96D8xi3tP/1tGJs3Cs3fdKU350v3sm1jwQ2cyUNLnXfwVulIwYgvqjZ5+fDJ
 Q980dOc+cnWzCj/xzH76Wd0rQdRyfu+BzXqnmKznpZJ58PipZ8k4AdO/ep5a9cygsptF
 2n8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=/dJcq9QxKtdJNhx+nsVsOcHkLZ97Ve8VpsG6zN36Ipk=;
 b=CykWCfAa4FN4UOZOk6Q2KWEyJ5VbJFzBruqlArQlDEyIOR72dVJ4VIcts+XLPXii/l
 hz36B+pJt48so0wCwuXt9Q57IaClSng4QLQXZebMviFmsXbPi5i+k9wo+MIlCxRtXT50
 Z67u5U/20yAWyJv9kdOn0T+NPuvo3AlYgqqyBduHrlf6O/QBp1DJDJ06WawoH2PzOlb6
 Q2wVfzuQZN8Y2IaerqNazOFQ1Q9GikIPfv2lL03N/eOv1yf8EGxkL4fHWY4LGrdCddjM
 j2fD+Rq7J1uW64BcccaJB3jsTnKuX/NUdfQSbaS2ezdkNYfkXPfhlXO7yIgZqUb45VOm
 7nsA==
X-Gm-Message-State: AOAM532atR3N8St3TnV99zre9qqiSe2Xn/4jUn/moCKgq8RsXBSPgRLN
 53+IcrE+sMOd0ySTJA8SPMA=
X-Google-Smtp-Source: ABdhPJyHYznHpvc+E8BSBlMuIUcC1nlcg9Aq3NhIkbVP3ZvsTbtcrs7iw0iWnaW/iuROZu55nPrrdg==
X-Received: by 2002:aa7:8652:0:b029:164:1346:7fe4 with SMTP id
 a18-20020aa786520000b029016413467fe4mr3050522pfo.65.1603814083876; 
 Tue, 27 Oct 2020 08:54:43 -0700 (PDT)
Received: from jongpil-desktop ([39.117.32.248])
 by smtp.gmail.com with ESMTPSA id y3sm2527759pfn.167.2020.10.27.08.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 08:54:42 -0700 (PDT)
Date: Wed, 28 Oct 2020 00:54:38 +0900
From: Jongpil Jung <jongpuls@gmail.com>
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Subject: [PATCH 1/1] nvme: Add quirk for LiteON CL1 devices running FW
 220TQ,22001
Message-ID: <20201027155438.GA111754@jongpil-desktop>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201027_115451_800532_AF9BA42A 
X-CRM114-Status: GOOD (  19.55  )
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
Cc: jongpil19.jung@samsung.com, gloria.tsai@ssstc.com, jongpuls@gmail.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
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
vendor id and firmware version.

Signed-off-by: Jongpil Jung <jongpuls@gmail.com>
---
 drivers/nvme/host/core.c | 30 ++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  4 ++++
 drivers/nvme/host/pci.c  |  6 +++++-
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 95ef4943d8bd..9ee520aa0100 100644
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
