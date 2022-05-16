Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB48C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 16 May 2022 20:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=OcsXhh/87UoXxZUiipIVEFaVSpAn3rbwLYq3DRWmEqM=; b=b4vq0tpxYMtWW3
	8OPYtDMEKa+/uXx6EG27FEu0BREZfRJKh4UHga3TAQGeuAcW73lUMN7wi9245h2MGumvEqLhIy+jn
	NnOcrRi4o1JGAweVgU95LAx6qSuWSoUv7RIDC3on1RitTFtPaRS22Wq3lUIRr/YlX2lu/QGwluiUz
	y08OOby/SWWANoZsqLzF9X5/kX4uudpTeKjBPU4tqiWfKr+JofY9yM0QmB2N0VSvFk/cZvFK0q3Di
	Uzbe6VmWN73cWs6QaFS+I8llrc1zJ0IZZ7hwyln1KLu4nhruyy8UvGcp6PdQADNlFq3BT+PqOS0we
	RLRQFzpUTj8m2hW4Hn3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqhCA-00A26o-Ht; Mon, 16 May 2022 20:19:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqhC7-00A25b-BW
 for linux-nvme@lists.infradead.org; Mon, 16 May 2022 20:19:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D20666124C;
 Mon, 16 May 2022 20:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B73C34100;
 Mon, 16 May 2022 20:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652732394;
 bh=SHhiQGhVcUE0vHNCt6nUYr9ak3tUjCBNu2xVT+ZMvnk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=EHGLL0p67u5Tt7xDUhDyvi/TAxlteDKDzicHOufHj+R8QMP66W6j0/Yi5ak/tM3J7
 nv3zbzvcU2XV82k0yDfDcn8X7qvOLFbUcvYsbCnbOlkPtbhCpX1keGPxZsjsH+TlGO
 k5rTXoTDPci4VnUjAAarqDNMD2zQ28U8QqkvRdfoS87Sf8R/pii2VzQppCjs/lNOkS
 C+zTIEkzohAE4FB0HlQBZjA0f7UX6ZPiG6NELfw6TjsWrN3B1i4rgjiznUqx0EJEwM
 3nQsLdMCbXwwLATjCErNnujmwiIxLRW3/+MYfVKAFFVctcsp5Mx1Ud+dGemtODSt5U
 Op7PYa/bRtUiQ==
Date: Mon, 16 May 2022 15:19:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
 hch@lst.de, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, svarbanov@mm-sol.com,
 bjorn.andersson@linaro.org, axboe@fb.com, quic_vbadigan@quicinc.com,
 quic_krichai@quicinc.com, quic_nitirawa@quicinc.com,
 vidyas@nvidia.com, sagi@grimberg.me
Subject: Re: [PATCH 2/3] PCI: dwc: qcom: Set suspend_poweroff flag for SC7280
Message-ID: <20220516201950.GA1047412@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513110027.31015-3-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_131955_469459_F1449EB1 
X-CRM114-Status: GOOD (  20.21  )
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

On Fri, May 13, 2022 at 04:30:26PM +0530, Manivannan Sadhasivam wrote:
> For aggressive power saving on SC7280 SoCs, the power for the PCI devices
> will be taken off during system suspend. Hence, notify the same to the
> PCI device drivers using "suspend_poweroff" flag so that the drivers can
> prepare the PCI devices to handle the poweroff and recover them during
> resume.

No doubt "power ... will be taken off during system suspend" is true,
but this isn't very informative.  Is this a property of SC7280?  A
choice made by the SC7280 driver?  Why is this not applicable to other
systems?

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6ab90891801d..4b0ad2827f8f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -199,6 +199,7 @@ struct qcom_pcie_cfg {
>  	unsigned int has_ddrss_sf_tbu_clk:1;
>  	unsigned int has_aggre0_clk:1;
>  	unsigned int has_aggre1_clk:1;
> +	unsigned int suspend_poweroff:1;
>  };
>  
>  struct qcom_pcie {
> @@ -1220,6 +1221,10 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	if (pcie->cfg->pipe_clk_need_muxing)
>  		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
>  
> +	/* Indicate PCI device drivers that the power will be taken off during system suspend */
> +	if (pcie->cfg->suspend_poweroff)
> +		pci->pp.bridge->suspend_poweroff = true;
> +
>  	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
>  	if (ret < 0)
>  		goto err_disable_regulators;
> @@ -1548,6 +1553,7 @@ static const struct qcom_pcie_cfg sc7280_cfg = {
>  	.ops = &ops_1_9_0,
>  	.has_tbu_clk = true,
>  	.pipe_clk_need_muxing = true,
> +	.suspend_poweroff = true,
>  };
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
> -- 
> 2.25.1
> 

