Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2590EC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 13 May 2022 11:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZsD7LJRkuECyYX1jGlfTiXHU1Ijh0jPTLQ2k9fUhrL4=; b=1eEGTv3cCFCToEjUnxDzfeU9n/
	pRfaaaf4jGPNJgD6th3T24X0NNn9sUReYvfNi+TJXx5HDFhELz+BUxMInCdiXVqE+a5uUqzYxTZxp
	Z2mESqQ4HFEBe3SOOrV/RbwYfSmEpC6NCtzdXnIHdk7nhYH030mJfLHLbJcxhtgvzbuXHmKcIUEsV
	yTOsI+uP5wJEYlxLHCBWWywJL23MyEEE2ntOA2DWFaPL+3CRO6YywLQj2KalIPKq7XjukjyUGIVCp
	nK3ZYCd7qfv1YE187DAwdNcdT/sJOkwTkRKGGX6FhvAfaXAyA6YhhlIY7T77IgtVw2XJBUHoVk4Kn
	tMiDKqNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1npT2n-00FgcI-6A; Fri, 13 May 2022 11:01:13 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1npT2e-00FgVw-FT
 for linux-nvme@lists.infradead.org; Fri, 13 May 2022 11:01:06 +0000
Received: by mail-pf1-x429.google.com with SMTP id p12so7432548pfn.0
 for <linux-nvme@lists.infradead.org>; Fri, 13 May 2022 04:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZsD7LJRkuECyYX1jGlfTiXHU1Ijh0jPTLQ2k9fUhrL4=;
 b=QiA79YYEX5J9Cz/ubTy3uRnX00TKZfSieKIylSPlqoMh6cybvG0v6NWiRbpuIbSfd4
 Sg6gFMhz4XRhjovPrMvP4JHa9cpy1RtHVD3W8ZH5nonlK8GBPfG8TZM1Oigbjd8ktjPu
 I5ajvo1NSSx0d6NQj58DvBg+rOuoKgiDFSFGVMJLmenRCGPLdU/EjXWFZJlTcNUvWUK/
 4nvf5UFYfVAZPPDC1sApcVOtsIfEl16Wn32QPMG9AxzU3sBwVPoi6wTjYWscLKHSqWCF
 GJjkosFZBfUJYOhl5VXrovgcrSniLe7jdBcmGv4ChD7xvrbSJSnxKcsgLoV67XeoRTD/
 4gTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZsD7LJRkuECyYX1jGlfTiXHU1Ijh0jPTLQ2k9fUhrL4=;
 b=WyXrKPbSFsGsqoTV5ONuy2B3WoadxoVxeRxHH5m/zQokzpqvgrPTRaE1IxkhCBk+mz
 dFNgRE1dKvY+krLJ03PRFWeA36YDr6quiPyIIyjqjq+HZWQa6T8pNbr0ibAkpZ3YYvd+
 5PUmMdnJde6c5wsZqTfiuVt6J6Mo6kF37uQE7aNS3odkq+rD2OVYiSVAI1VePL6FNsmo
 yUFzuy3gmjQxAubX0WPv5YU9vhAHhq+MC3w3Sj+5LfuPUXky+Q83X5L8E3AdAyu8yw3U
 8euMdZbxCWbgYYWnibpACHzPwFHHpcjmsfnuDCmUiFrxAl7ujMEKAdb2kdY4I0SeQIPa
 xjcA==
X-Gm-Message-State: AOAM532Y/5I7rrSoWAHA2p+TBOuHIkW8A46OzlfTKMZW5bNxLz+X/smb
 1r75sfLIFL+b6WHtkcn4/IJG
X-Google-Smtp-Source: ABdhPJy6supPwd4jHaESPrjZJsyad5J2wl3TDO2EQ8PzZO62JGRs3jBDxNtnqMckk0JHMD7+cNctsA==
X-Received: by 2002:a63:8143:0:b0:3da:eb5e:2833 with SMTP id
 t64-20020a638143000000b003daeb5e2833mr3514458pgd.426.1652439661640; 
 Fri, 13 May 2022 04:01:01 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.202])
 by smtp.gmail.com with ESMTPSA id
 u36-20020a631424000000b003db0f2d135esm1322120pgl.49.2022.05.13.04.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 May 2022 04:01:01 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 svarbanov@mm-sol.com, bjorn.andersson@linaro.org, axboe@fb.com,
 quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
 quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/3] PCI: dwc: qcom: Set suspend_poweroff flag for SC7280
Date: Fri, 13 May 2022 16:30:26 +0530
Message-Id: <20220513110027.31015-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513110027.31015-1-manivannan.sadhasivam@linaro.org>
References: <20220513110027.31015-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220513_040104_565301_4D1F18D8 
X-CRM114-Status: GOOD (  12.53  )
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

For aggressive power saving on SC7280 SoCs, the power for the PCI devices
will be taken off during system suspend. Hence, notify the same to the
PCI device drivers using "suspend_poweroff" flag so that the drivers can
prepare the PCI devices to handle the poweroff and recover them during
resume.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6ab90891801d..4b0ad2827f8f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -199,6 +199,7 @@ struct qcom_pcie_cfg {
 	unsigned int has_ddrss_sf_tbu_clk:1;
 	unsigned int has_aggre0_clk:1;
 	unsigned int has_aggre1_clk:1;
+	unsigned int suspend_poweroff:1;
 };
 
 struct qcom_pcie {
@@ -1220,6 +1221,10 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	if (pcie->cfg->pipe_clk_need_muxing)
 		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
 
+	/* Indicate PCI device drivers that the power will be taken off during system suspend */
+	if (pcie->cfg->suspend_poweroff)
+		pci->pp.bridge->suspend_poweroff = true;
+
 	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
 	if (ret < 0)
 		goto err_disable_regulators;
@@ -1548,6 +1553,7 @@ static const struct qcom_pcie_cfg sc7280_cfg = {
 	.ops = &ops_1_9_0,
 	.has_tbu_clk = true,
 	.pipe_clk_need_muxing = true,
+	.suspend_poweroff = true,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
-- 
2.25.1


