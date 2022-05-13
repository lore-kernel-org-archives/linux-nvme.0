Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F9BC4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 13 May 2022 11:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uGswQ0aP97Suern/pqvhLGTEOIpF5J5h2MoXW5LuuBU=; b=SxM2iXXdUWaulY2dQHXwAPAVLq
	FljTWQILyM10pbg9qCQeeLPTSp24UOHNEFThWmvvIBk3oM3U6SKCueAMnq0ToM97vIuP235jakdAd
	5/cZQVZZS/3GlcQOnZ12M6MVxpLJUHROU6p/RwsrlQqGXskuFJH+2haaa9SXSfLxS4LA+8VpjUxw7
	91k3dvO5mSlaAwa+9iPoYGQXRLjZlE6NYowavH5PqxWLYiTzCTAABVrtRJsmNeUBFZK4UtLKhedve
	9iIfoX11W9eGrGy5KaKLCf597D5poby+CUVR/sYruqsP4EKOEgflmJkE9LmrIaot31X37sUR4T5KF
	lKMklFyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1npT2e-00FgWv-H7; Fri, 13 May 2022 11:01:04 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1npT2Y-00FgSY-9M
 for linux-nvme@lists.infradead.org; Fri, 13 May 2022 11:00:59 +0000
Received: by mail-pl1-x631.google.com with SMTP id i1so7590850plg.7
 for <linux-nvme@lists.infradead.org>; Fri, 13 May 2022 04:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uGswQ0aP97Suern/pqvhLGTEOIpF5J5h2MoXW5LuuBU=;
 b=ZF7r2l+HwxQm5PA8mve2cF+rBwKjnM+0fSfGGdoNA3T0LJdycXkCGWLrykpa8sL/oD
 08lIP8dZt0wAe2tK+75oTRz1risNDIOCOSiRaW+GZokpCuhe+9MrL2YynteMMnYHDR3H
 ItIDcdINQ82V0AG+st+raJapxxBHOih2yAPagaFk64puhsJ/iztuWI2Rf4eKJ19ZFuSX
 YL/pLIatMsl2o8QBgjy0eNGResBVvt2NP3Y80kDYZiv7AA+gsRPYm0wGgSd7CPa4mYRN
 F4q7pPFCxNNeVHCsbD+3J+hjPwmsRQyClY9uud0L4zXlaFzZ+hz0uXVv3kgKtKaDXw60
 Pa+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uGswQ0aP97Suern/pqvhLGTEOIpF5J5h2MoXW5LuuBU=;
 b=EFVOq3/ci0FKP2fuMb5h/PqKPy3eKAI4Q0RJ0eW3pynhl0BgXCivHaAxUKCMZBGW2J
 Bsmv6t6LTWYvh+nGEOTjcbbTBRwyDQP4juYbiT34UofBml/cmUX12XafMTT6aKCxect4
 YjAC/MT1Sp980cm9BrP52Qw6nHBYQyMJ42jmh7T7vdyocRKPsUO+ySjjsFsOFhD+EE2P
 eAfAJxb/WKzoNt3Fghdzsym3Veh/b57krS6N+Xc5hQDl2c5DOKwl/bRywxlXnbJ57/LU
 ATNZQDpgZdLqlxFa920hUkCobTteBd+h4TDYxoetBcvMcO/EiGAKAJN1EYTT2pCnHNwQ
 lf9w==
X-Gm-Message-State: AOAM532ogMO/4/4U51pzARpoOoPUlTrSdZwudBxb+pcoyvT0Q+/Alsm6
 KGYpzaxz6oc9GMd4hBJrx47J
X-Google-Smtp-Source: ABdhPJyTPQtQvf4t/ey8cvG54O7pCIiYbK85D35VbK5tYExzPBijKVc7qymid6BgehggfTgPgOcVnw==
X-Received: by 2002:a17:902:7586:b0:15e:c2fe:bad0 with SMTP id
 j6-20020a170902758600b0015ec2febad0mr3948667pll.72.1652439654573; 
 Fri, 13 May 2022 04:00:54 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.202])
 by smtp.gmail.com with ESMTPSA id
 u36-20020a631424000000b003db0f2d135esm1322120pgl.49.2022.05.13.04.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 May 2022 04:00:54 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 svarbanov@mm-sol.com, bjorn.andersson@linaro.org, axboe@fb.com,
 quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
 quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/3] PCI: Add a flag to notify PCI drivers about powerdown
 during suspend
Date: Fri, 13 May 2022 16:30:25 +0530
Message-Id: <20220513110027.31015-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513110027.31015-1-manivannan.sadhasivam@linaro.org>
References: <20220513110027.31015-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220513_040058_370034_43A62D81 
X-CRM114-Status: GOOD (  13.02  )
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

On some systems like Chromebooks based on Qcom chipsets, the OS may
powerdown all PCIe devices during system suspend for aggressive
powersaving. In that case, the PCI host controller drivers need to notify
the PCI device drivers that the power will be taken off during system
suspend so that the drivers can prepare the devices accordingly.

One prime example is the PCI NVMe driver. This flag can be used by the
driver to shutdown the NVMe device during suspend and recover it during
resume.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 include/linux/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60adf42460ab..069caf1fe88d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -578,6 +578,7 @@ struct pci_host_bridge {
 	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
 	unsigned int	size_windows:1;		/* Enable root bus sizing */
 	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
+	unsigned int	suspend_poweroff:1;	/* OS may poweroff devices during system suspend */
 
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
-- 
2.25.1


