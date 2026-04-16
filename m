Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7512F8D770
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 19:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=s8H/6zEnO3ZJaSayFwbnZcraXQXltRJ+mv7JGfICnkY=; b=t0UhIZpZ3H5oy/
	D9mXqG43BonJ84zrXwsBWEiLK8337/AOyT89WwEh0bUh1cxd5G1oWiA54GY4dtzGi3tFiyGL23G+J
	UpKLpD4flTKFIS+QiZMQzSz9nBZRwuoq4QvpB4ecWvvOt4wJrHBKUnD+dM+bCVtKgjlaRvdv1EVAF
	bOI+i7qqPMBvQ4UQs5RG/sMRQ9Gg1fYuGT/4t4xBbmnm8SbkuZPs20z8LY3iJjIYartK49AnY1l6D
	vqx4khQgGCAYst41w+4Ly165s65eu+m+PXb1+HhouTqNzRi9Qa9hBV7/7I0KflqbUPllrcqlV6hBK
	Y/0TCk7FXDf3YYEf/g1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDSFw-00000002rTt-1UB6;
	Thu, 16 Apr 2026 19:20:04 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDSFv-00000002rTW-04HR
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 19:20:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1FE7260127;
	Thu, 16 Apr 2026 19:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB58DC2BCAF;
	Thu, 16 Apr 2026 19:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776367201;
	bh=7hNoPjfRYKU5U5iFcWqPcwkIIxa98Sc2JAWepvIltT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IqW3owkMCYpC4VANOth7b4iLnX67SMSdgN/LGZqxMp7xOAedDzpf3xu12rPA8Ak6/
	 tRec/6ySePzmOYTzWb90Matv2ow8wqorbNfAtjpiqHdmjZEdCgaCSN9/4uYzx8zP5T
	 ThORpsWD3AcUgn0etGdwb4B/RejGgkdMTdggaSzAHkzl+5VhYU0aNFS9Yr1UwEdxNB
	 l9Ur79FVrXdwayThGgTNAofyvuwifoajp83KRcOEKLYkiQxqc5sR/fZY2GjsHY0ptI
	 JmJI8yicWW19oZJJTwsthalHFkMuEHXkobZj+7YTUrycnmdDQUSHEMb1jfJdEdbRLe
	 rUizM4xVbcMrA==
Date: Thu, 16 Apr 2026 14:20:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/4] PCI: qcom: Indicate broken L1ss exit during resume
 from system suspend
Message-ID: <20260416192000.GA21992@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-l1ss-fix-v1-3-adbb4555b5ab@oss.qualcomm.com>
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

[+cc Rafael]

On Tue, Apr 14, 2026 at 09:29:41PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Qcom PCIe RCs can successfully exit from L1ss during OS runtime. However,
> during system suspend, the Qcom PCIe RC driver may remove all resource
> votes and turns off the PHY to maximize power savings.
> 
> Consequently, when the host is in system suspend with the link in L1ss and
> the endpoint asserts CLKREQ#, the OS must first wake up and the RC driver
> must restore the PHY and enable the refclk. This recovery process causes
> the strict L1ss exit latency time to be exceeded. (If the RC driver were to
> retain all votes during suspend, L1ss exit would succeed without issue, but
> at the expense of higher power consumption).

I don't think the link can be in L1.x if the PHY is turned off, can
it?  I assume if the PHY is off, the link would be in L2 (if aux power
is available) or L3.

L2 and L3 both correspond to the downstream device being in D3cold
(PCIe r7.0, sec 5.3.2), so I assume this is a reset as far as the
device is concerned, and we need all the delays associated with reset
and the D3cold -> D0 transition.

> This latency violation leads to an L1ss exit timeout, followed by a Link
> Down (LDn) condition during resume. This LDn can crash the OS if the
> endpoint hosts the RootFS, and for other types of devices, it may result in
> a full device reset/recovery.

What does "L1SS exit timeout" mean in PCIe terms?  Is there some event
(Message, interrupt, etc) that is triggered by the timeout?

> So to ensure that the client drivers can properly handle this scenario, let
> them know about this platform limitation by setting the
> 'pci_host_bridge::broken_l1ss_resume' flag.

I don't see how this means L1SS is broken.  If the device is
effectively reset, of course we can't go from L1.x to L0 because we
didn't start from L1.x.

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 67a16af69ddc..01afffd384f2 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1363,6 +1363,17 @@ static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>  
> +	/*
> +	 * During system suspend, the Qcom RC driver may turn off the PHY and
> +	 * remove votes to save power. If the endpoint asserts CLKREQ# to
> +	 * exit L1ss, the time required to wake the system and restore the
> +	 * PHY/refclk exceeds the strict L1ss exit timing, resulting in Link
> +	 * Down (LDn). Set this flag to indicate this limitation to client
> +	 * drivers so that they will avoid relying on L1ss during system
> +	 * suspend.
> +	 */
> +	pp->bridge->broken_l1ss_resume = true;
> +
>  	if (pcie->cfg->ops->host_post_init)
>  		pcie->cfg->ops->host_post_init(pcie);
>  }
> 
> -- 
> 2.51.0
> 
> 

