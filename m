Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BC2C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 13:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MnDyHs2MuOBTYTZqMG6fv0gi5HnIJHFVYwZNehBynVo=; b=uzAKc5wdCGxQL/Bn+KV8e2+EI1
	mB3I3uyq3gRYyyeKlJUBD3Nb8uWG8nYsCjEpRKi56Wj1OB+Ie1Gb/RFtBIasyTgG7+Q+wlRr/Bzzk
	rPd3lw3pAd62F7J6Sh6m5ky8l1TVsv82TIww6AmNda+tMoMr+hXucVLkohUaF2ZgAXz57C7s2Y7kN
	qammQSo5KcOuSAz66Xls0uVJJAwl1KSu6JvrFQ4Z2/lXVsi/PUEEk9o/34/v4CL3p6jICWaYPI+Do
	Yo3SDZfLIpb81AV4F33ickO0KjY8KpuifqX0JxJuP1XNGpeqF+GVAx5DtvPuZhdvHRnrXl2/BtKUH
	jgqJ/2vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrJam-002GLD-HX; Wed, 18 May 2022 13:19:56 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrJak-002GJJ-4f
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 13:19:55 +0000
Received: by mail-pj1-x1031.google.com with SMTP id
 l20-20020a17090a409400b001dd2a9d555bso2067916pjg.0
 for <linux-nvme@lists.infradead.org>; Wed, 18 May 2022 06:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MnDyHs2MuOBTYTZqMG6fv0gi5HnIJHFVYwZNehBynVo=;
 b=Gb7hlyWGSwEGvXPHTyrg47FBM/6vom5xkAKFHXURmg6UVnev5DicIGpI22deIiwRYe
 1vwNPVnl79uHsq2vfp+Zq+7YvnIMJz0lN1dbMOjQE56/Y0ZnghlxZ9FitoV0pbqCrSvK
 FFylVwCsKOTkWRJn0dVrNJml8UIkoXKFC3OCC/zdqorcZ5w76yWNSV7usc1Y6vunc6zF
 zL8e5wj0fQMpyd1qT9xC+ZwB/OkoFqs5qW0psjmBflEn4AuMyYyE2Apt+a4lFil+Z51W
 8p96EYZz/SXrqGueOtntDzUzxnXdpHt2oaK5/U1REC+dvLmHgk9cbreImvwT1EFx+/qK
 AynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MnDyHs2MuOBTYTZqMG6fv0gi5HnIJHFVYwZNehBynVo=;
 b=1eMLHnigndRfV+JfpH5jn0dj/TXikao9FWPkDI8q9jY9YUcUnx/AViwj6Kdd80uI6k
 JXtR9TvwXQSwVYptMY87i0yOF72wdQXjZMtK5X5XgHIqZK1DXByEn2Hg6G7FpMgkzVrD
 2X0LKfeW7raeF60EmJIj2s56uHpuXpszbOUo5kjh4+yrEYHXHJUYZoNsarOy8FbgMSy3
 8mXYes3Qa7R8PL5749PNTZy5nJsBe5/pp9qo7XUMJHgsBP8rFP6q2B0cBn4C7g0YLfle
 E8DU0cpkIdsJBsSihf44YNIIWCF/rxsnWaaGkmzqFs+uDTvHev2AikVTLFfeteCtK/Uu
 5+pw==
X-Gm-Message-State: AOAM532arrGtDM0QmtLNxj/STgt/jk6xCctYoUOI1FLeNyCrYZG5s691
 2RfZ6f5rRt5qSjLkzqoAZKV3esHE56of
X-Google-Smtp-Source: ABdhPJxTyC9sMCUpQo22UY5IOj1tKIEFt5bK4JNQ+ltl3bxoy1ym3mVWnjrTKA7ZEwahtkVXeCDyvw==
X-Received: by 2002:a17:902:e882:b0:15e:b9e8:ba1b with SMTP id
 w2-20020a170902e88200b0015eb9e8ba1bmr26942176plg.71.1652879990995; 
 Wed, 18 May 2022 06:19:50 -0700 (PDT)
Received: from localhost.localdomain ([117.217.181.192])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170903228500b0015e8d4eb27esm1663908plh.200.2022.05.18.06.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 May 2022 06:19:50 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 svarbanov@mm-sol.com, bjorn.andersson@linaro.org, axboe@fb.com,
 quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
 quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me,
 linux-pm@vger.kernel.org, rafael@kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/3] nvme-pci: Make use of "suspend_poweroff" flag during
 system suspend
Date: Wed, 18 May 2022 18:49:12 +0530
Message-Id: <20220518131913.26974-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518131913.26974-1-manivannan.sadhasivam@linaro.org>
References: <20220518131913.26974-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_061954_224557_BA79A747 
X-CRM114-Status: GOOD (  15.49  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On some platforms like Chromebooks based on Qcom SC7280, the power to the
PCI devices will be taken off during system suspend. For these platforms,
the PCI RC will set the "system_poweroff" flag to notify the PCI device
drivers of the poweroff scenario.

Hence, make use of the flag in the system suspend path and if set, properly
shutdown the device.

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Added Ack from Christoph
* Reworded the commit message to include SC7280

 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d817ca17463e..381bf0c7cf8d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3238,6 +3238,7 @@ static int nvme_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
 	struct nvme_ctrl *ctrl = &ndev->ctrl;
 	int ret = -EBUSY;
 
@@ -3257,7 +3258,7 @@ static int nvme_suspend(struct device *dev)
 	 * state (which may not be possible if the link is up).
 	 */
 	if (pm_suspend_via_firmware() || !ctrl->npss ||
-	    !pcie_aspm_enabled(pdev) ||
+	    !pcie_aspm_enabled(pdev) || bridge->suspend_poweroff ||
 	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
 		return nvme_disable_prepare_reset(ndev, true);
 
-- 
2.25.1


