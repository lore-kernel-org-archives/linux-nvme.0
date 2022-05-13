Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA51BC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 13 May 2022 11:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rZc+ZqV9Fkq91rBB6JPn5eaAWDfpttSNOSYA1C21ZVY=; b=RwlNV+65Hgnlut0YYBewcKqkHL
	f346KlA6pZKTaROt6OGIWt8mj6sB1hxvwb6n1tAp/9dJJT6XvWdcKAJiun5kTPHI5n/SySCzn9CBG
	+NV8BpwJ9JAyfHpj2O0Mlx4eVuMjS0zRAIxK9exeROh8ijBcXJNJUQFnHcJhFh68OqhvKAtJEJLL1
	tbpWKOio71eT3KlLCt5IHpvEbM22xWu+NcrY6YP584VoPWWTuEhaPm2u/yKFBhCfEVcfIgHBEEDS2
	M9mxr0CZEZdC3CFvaf8pZaehRE7to9JiwAioBUWXDIMCE8rbq4x8FrEos0vlTmkHyEAWZKuWqSJId
	+0iD90lQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1npT2y-00FgiP-Bs; Fri, 13 May 2022 11:01:24 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1npT2k-00FgZg-HB
 for linux-nvme@lists.infradead.org; Fri, 13 May 2022 11:01:11 +0000
Received: by mail-pl1-x629.google.com with SMTP id n18so7594296plg.5
 for <linux-nvme@lists.infradead.org>; Fri, 13 May 2022 04:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rZc+ZqV9Fkq91rBB6JPn5eaAWDfpttSNOSYA1C21ZVY=;
 b=pPqBmjnZOoOPlVo0vS3Kq5A1Li96cT/0G84V1o8+RlSNVv7m0HEuPeYvCLSi1nkYoC
 gwTrsOZWLoI+dCHJyxAVf1jg/Hd4WNlFvDvYxmSNF6G6A6m1W3OpWNA5nH8SwZDn0ZGB
 WkTWI60LUZ6oZUKzdcUm0jJIUhayWiBdAR8zv2fsdYbsyNVpkbOowyf/peNBHj3ShshC
 hzONZ0Y92wEv13CmZ1vpoL2VdNLp7mf+h8rkZPXzOK2F5NY/bNIjJqQPbmUtg6RrFI+W
 ClCWj6S5Md5mPvHMMsA9g5485z2ewbeXK1NmqZCNpto4oV04yglFWSJVHnqziIA+yV0A
 spqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rZc+ZqV9Fkq91rBB6JPn5eaAWDfpttSNOSYA1C21ZVY=;
 b=AnV5AdUyUUD2YoJQVheJ3sbqfNI64sTdWbYb/eZYbzplO+kfs+LCEK2z0XVecxBGA8
 9okSJXfpKQ43mIEh8/NsJljf5HflGbMX0dq3eQNwIj/dIr/2M451NLsTO5bM9lFPABBy
 +ifLyzAq0QjbLbehkA2jreVRgT3AujIeO5k6uVWUPlbYvhKJCm9m0P8B5MhDY1Jsxmo9
 /OxMJYjKSI3f389X+ycdQPGJ8hErnqE6ICM/9NG8BaZM4rbj6FRW1O98oQjnlejg8f70
 IjH0WRXN0C40i93Z378eovPGm8vgNRgnWeSNAhoU6+mSTbkld4fB0DoNwbzlxLgzusU3
 rV8Q==
X-Gm-Message-State: AOAM532eg2HU89BlIHY291UadmRSafgMFaJoDTbe1kA6iY9LcG8Mh1np
 AlRQtTrGuJOHUCvsQwdiJP/G
X-Google-Smtp-Source: ABdhPJwD0Z+7FM+VHC2wrC77McNhcou7ndf9igJr4nAQPy42aOvFNAEgKU/2wJsekaBdW4P9tQhvCQ==
X-Received: by 2002:a17:90b:1bc2:b0:1de:dac7:6124 with SMTP id
 oa2-20020a17090b1bc200b001dedac76124mr8423475pjb.162.1652439668454; 
 Fri, 13 May 2022 04:01:08 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.202])
 by smtp.gmail.com with ESMTPSA id
 u36-20020a631424000000b003db0f2d135esm1322120pgl.49.2022.05.13.04.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 May 2022 04:01:08 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 svarbanov@mm-sol.com, bjorn.andersson@linaro.org, axboe@fb.com,
 quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
 quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/3] nvme-pci: Make use of "suspend_poweroff" flag during
 system suspend
Date: Fri, 13 May 2022 16:30:27 +0530
Message-Id: <20220513110027.31015-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513110027.31015-1-manivannan.sadhasivam@linaro.org>
References: <20220513110027.31015-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220513_040110_613166_74985EF5 
X-CRM114-Status: GOOD (  14.48  )
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

On some platforms, the power to the PCI devices will be taken off during
system suspend. For these platforms, the PCI RC will set the
"system_poweroff" flag to notify the PCI device drivers of the poweroff
scenario.

Hence, make use of the flag in the system suspend path and if set, properly
shutdown the device.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
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


