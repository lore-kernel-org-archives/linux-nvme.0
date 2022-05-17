Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BA9C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 15:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cmLXabcPdJC5+Jr+geeae2kzppnXJw8ILHcl1Qm7vBw=; b=TtZug9Eb+Fp5EJCIJk3KSXERAJ
	CmKy7hfFa3Bx+SBsoZjVhAeD2FQT3dveuUfJwoXTyUkyHrJTSgWoem4hTeV89bS3tY0Rw3ssxAfOr
	8AfyCaX+BhH2m1tpvebm+ZqNW1QbsurwfrAU6tfL/0H0cw3TahsVWp1QvNHcgwvzuAvZw0aa75vet
	Xg9guAZyqV8Tkxv0PNivgbLcvg+7dw2oeU7MHZ4vF6K0APya0PuATxkaIEqNOeRe0VKuyV9KnJ443
	XeN8zghlRFpdY0VgFDbLsYa4NK9dwvBRiXeaADJykyFmRfsWR9Z50cxc7V1c+wrW+f9VUvu3l2jcz
	x+auFZ1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqyri-00EcJP-By; Tue, 17 May 2022 15:12:02 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqyrS-00EcC4-6H
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 15:11:49 +0000
Received: by mail-pl1-x636.google.com with SMTP id s14so17602155plk.8
 for <linux-nvme@lists.infradead.org>; Tue, 17 May 2022 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=cmLXabcPdJC5+Jr+geeae2kzppnXJw8ILHcl1Qm7vBw=;
 b=CMbAPHf6t+S5Kg1C4GszZxleCRPzPCJZatJ1Uhgf4vk0o6lS847ZRTFjB8hGXzHMWl
 ll+/Pk58qJPLoniMeyG8G08xqU5f8Y1cYHkaDkQ68EI4RSuceZvg8L88QzT3nG1ggMQh
 wpCPXtWUjd3VPVCZAzB0zNj9VYjpBbBGN0i5lSZugdLoFWYUYY403CgSeaPvbw/GJWfo
 KoWb+QmOkyIhZFiG13zp7J2QOwQr5UeggVUWxzffet1NnT0TxQlosvVe3iY8p187yVk4
 PGriacZsHbGjO6/cFvWrqRlURZJrIBSd0FdYh8B5fOKv/rRpHcFyySilRPJurX8HmkZ+
 GF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=cmLXabcPdJC5+Jr+geeae2kzppnXJw8ILHcl1Qm7vBw=;
 b=s1w47oly6xFlnJy1dWasAkyNLWVROUe9lhICSYYlOO2FmusgDdtIP2RBejcah/Yog7
 VCdKRk0vt0bbWORR99XbvJ6Ksf5whjO60l7MDftSdZCTso3RvjRHvTv7joWKYeZQC0ZG
 0RJVpLZEsj5iy70PpbT9hs1umOLIEqfLhL5pB446yA8a8i6dBpTscmWLHdf+/HQ9CxOF
 0wnuZTca4aODPADULOAw3LVHO0CHrDhHU9+cGPGHe33/ZG8emibUwii3Iati5ISq/pTC
 pI34gLpf+euoR4D0QtzssvWO6BLo156IX/6mgwo62wgz52jScpr1EIFwkQNg2fMGeumG
 sobA==
X-Gm-Message-State: AOAM533VKg0EBdEt+y6CpPakSXuS5QszI8WUqq8qkCGHp5GD28a9A1x5
 O8LTDPICRGHm0NjBhZKURaYB
X-Google-Smtp-Source: ABdhPJy/8+de+j926ut7sfC02FyPhUMi0LcfxLj34YwOAks7Rl82lL4Rj6Y5maOSEeF2PjT7605A/g==
X-Received: by 2002:a17:902:dad1:b0:161:9abb:fb75 with SMTP id
 q17-20020a170902dad100b001619abbfb75mr6145785plx.135.1652800303244; 
 Tue, 17 May 2022 08:11:43 -0700 (PDT)
Received: from thinkpad ([117.207.31.8]) by smtp.gmail.com with ESMTPSA id
 ja1-20020a170902efc100b001617e18e253sm4280263plb.143.2022.05.17.08.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 May 2022 08:11:42 -0700 (PDT)
Date: Tue, 17 May 2022 20:41:34 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
 hch@lst.de, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, svarbanov@mm-sol.com,
 bjorn.andersson@linaro.org, axboe@fb.com, quic_vbadigan@quicinc.com,
 quic_krichai@quicinc.com, quic_nitirawa@quicinc.com,
 vidyas@nvidia.com, sagi@grimberg.me
Subject: Re: [PATCH 2/3] PCI: dwc: qcom: Set suspend_poweroff flag for SC7280
Message-ID: <20220517151134.GB4528@thinkpad>
References: <20220513110027.31015-3-manivannan.sadhasivam@linaro.org>
 <20220516201950.GA1047412@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220516201950.GA1047412@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_081146_311175_822C701F 
X-CRM114-Status: GOOD (  25.06  )
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

On Mon, May 16, 2022 at 03:19:50PM -0500, Bjorn Helgaas wrote:
> On Fri, May 13, 2022 at 04:30:26PM +0530, Manivannan Sadhasivam wrote:
> > For aggressive power saving on SC7280 SoCs, the power for the PCI devices
> > will be taken off during system suspend. Hence, notify the same to the
> > PCI device drivers using "suspend_poweroff" flag so that the drivers can
> > prepare the PCI devices to handle the poweroff and recover them during
> > resume.
> 
> No doubt "power ... will be taken off during system suspend" is true,
> but this isn't very informative.  Is this a property of SC7280?  A
> choice made by the SC7280 driver?  Why is this not applicable to other
> systems?
> 

The SC7280's RPMh firmware is cutting off the PCIe power domain during system
suspend. And as I explained in previous patch, the RC driver itself may put the
devices in D3cold conditionally on this platform. The reason is to save power
as this chipset is being used in Chromebooks.

Thanks,
Mani

> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 6ab90891801d..4b0ad2827f8f 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -199,6 +199,7 @@ struct qcom_pcie_cfg {
> >  	unsigned int has_ddrss_sf_tbu_clk:1;
> >  	unsigned int has_aggre0_clk:1;
> >  	unsigned int has_aggre1_clk:1;
> > +	unsigned int suspend_poweroff:1;
> >  };
> >  
> >  struct qcom_pcie {
> > @@ -1220,6 +1221,10 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> >  	if (pcie->cfg->pipe_clk_need_muxing)
> >  		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
> >  
> > +	/* Indicate PCI device drivers that the power will be taken off during system suspend */
> > +	if (pcie->cfg->suspend_poweroff)
> > +		pci->pp.bridge->suspend_poweroff = true;
> > +
> >  	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
> >  	if (ret < 0)
> >  		goto err_disable_regulators;
> > @@ -1548,6 +1553,7 @@ static const struct qcom_pcie_cfg sc7280_cfg = {
> >  	.ops = &ops_1_9_0,
> >  	.has_tbu_clk = true,
> >  	.pipe_clk_need_muxing = true,
> > +	.suspend_poweroff = true,
> >  };
> >  
> >  static const struct dw_pcie_ops dw_pcie_ops = {
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்

