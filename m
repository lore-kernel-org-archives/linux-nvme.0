Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C88C3ABC0
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 13:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ipwPdBmfmhU5lcIC9pVO9sXX1pujGePehu5uG7mWAU=; b=Q8bjtAYhglACwVf+3W9n9iR+gv
	uSpeP4/wWz5yJUDnoC75JqlcLOs1ex1L/8/n3ey5PjDFxCWtzvIXsCwyIWrpslrTZkSp8eUdiIRGl
	oSc0TUnkAWZaVIdAnMpMoogh/quQh2DIcXO0IOMZ1iZfmk0euXU199YwgcGZTBSTgQsf7N0h6MqDp
	soZLoW6y8xbRvGgEyYNjiq8QY1Bh6TRKop78msegdv72tbE9pFweZsNT0fZ42EejN+U3kCK2rr6O7
	2Z5oGAEZTldpUt5cZCmR0uQz1e6DaDPZfKL9GHMZ4qHPN/4DVVwbaSHHyU3HUf4QBctciFCjie9VF
	AW/6Qw3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD0yH-00000000i0V-2TTC;
	Thu, 08 May 2025 13:07:29 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD0yG-00000000i0K-3xbP
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 13:07:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6324A629EF;
	Thu,  8 May 2025 13:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2361C4CEE7;
	Thu,  8 May 2025 13:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746709648;
	bh=0D3BsD1wjsLyfIhn60xxlld7IVhLkFviNSP5fgRfzDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MM9WV90Eq1aP1iARqMsLmMobvJbHcbKqFWdz/2LCwHga5Z1fmxP+ZCvxF4vODYBxf
	 r4x/gFR+QPcMRTyWJydOfOCsikWH9BpBZrERlurznrPb86p2f+uOUU5nZWWjotDd8t
	 IvHxojZb5CKhsaKXJeD88P7JuPHoN9vuq6Dek77bQS4p8HnmMpbyTTXBcxlIgbHM5C
	 74rh3OEBZWA5doq4RZHV/OBGaP2CqtHU1ej3c/bHSqC3zWq4TmjOq+kIDtb9l2gvBb
	 4VSg6lyDLkODhA0/nzuA7t1898cQpJVfCnzY0fPa62ITkWdKWEfE+K65+Zc0gBxSku
	 2yAwLXbGqySLQ==
Date: Thu, 8 May 2025 15:07:24 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 2/4] nvmet: pci-epf: Do not fall back to using INTX if
 not supported
Message-ID: <aBysjC5PEovQwgEs@ryzen>
References: <20250508065745.389199-1-dlemoal@kernel.org>
 <20250508065745.389199-3-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508065745.389199-3-dlemoal@kernel.org>
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

On Thu, May 08, 2025 at 03:57:43PM +0900, Damien Le Moal wrote:
> Some endpoint PCIe controllers do not support raising legacy INTX
> interrupts. This support is indicated by the intx_capable field of
> struct pci_epc_features. Modify nvmet_pci_epf_raise_irq() to not
> automatically fallback to trying raising an INTX interrupt after an MSI
> or MSI-X error if the controller does not support INTX.
> 
> Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Hm..

0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver") was first
included in v6.14-rc1.

4b313c69a38e ("PCI: endpoint: Add intx_capable to epc_features struct") was first
included in v6.15-rc1.

Perhaps add a:
Cc: stable+noautosel@kernel.org # depends on patch introducing intx_capable flag

So that it is not automatically backported.


> ---
>  drivers/nvme/target/pci-epf.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index d5442991f2fb..859953041da8 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -636,14 +636,16 @@ static void nvmet_pci_epf_raise_irq(struct nvmet_pci_epf_ctrl *ctrl,
>  	switch (nvme_epf->irq_type) {
>  	case PCI_IRQ_MSIX:
>  	case PCI_IRQ_MSI:
> +		/*
> +		 * If we fail to raise an MSI or MSI-X interrupr, it is likely

s/interrupr/interrupt/


> +		 * because the host is using legacy INTX IRQs (e.g. BIOS,
> +		 * grub). But we can fallback to the INTX type only if the

s/. But/, but/


> +		 * endpoint controller supports this type.
> +		 */
>  		ret = pci_epc_raise_irq(epf->epc, epf->func_no, epf->vfunc_no,
>  					nvme_epf->irq_type, cq->vector + 1);
> -		if (!ret)
> +		if (!ret || !nvme_epf->epc_features->intx_capable)
>  			break;
> -		/*
> -		 * If we got an error, it is likely because the host is using
> -		 * legacy IRQs (e.g. BIOS, grub).
> -		 */
>  		fallthrough;
>  	case PCI_IRQ_INTX:
>  		ret = pci_epc_raise_irq(epf->epc, epf->func_no, epf->vfunc_no,
> -- 
> 2.49.0
> 
> 

