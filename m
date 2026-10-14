Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B171CC6B1A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=RYProyi5xNxC6zBZwCH3uv9Z1jW/dCeSE4umfM39R84=; b=CZWMC8nYq00dPk
	7U4j0eM1arNCSbf749OPxpOWtLdkxv2c83PV018w1AUKYc271kj6tcxiEFfElQdMXErHRjvQj4Y8a
	D+Eaa5SEwIDQSBOyNMaU73PZZTB/9xEDM0ESM8H26IEivzcIS/h1n3jx5q+Rb7NFp479nj5YljOO+
	2nKng1P1qaUwZRBs9KCB5h/6MO+dssi3JpcjUhOSfpvtxtMqFmIBVvIJ1UPT0cVFcSGbhpQY7fwO/
	+/mwetQN+7vYNVE6nA+Jq5Y6Evzhf1J40IWUe/XL++lE88zZnsC9GbmoeFucLhTCUQmZZW/GoDqFd
	st0e49gQAoxCWwwLkJQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH2on-0000000G54p-3gdE;
	Wed, 14 Oct 2026 17:31:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH2om-0000000G54d-1bc4
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 17:31:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C28304373E;
	Wed, 14 Oct 2026 17:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748B41F000C4;
	Wed, 14 Oct 2026 17:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791999067;
	bh=RYProyi5xNxC6zBZwCH3uv9Z1jW/dCeSE4umfM39R84=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Ew9E9YA62Gv9M0AW8R0KVP6Iv2ggUxLjrY92VDMPj8bwdHOGNAzvuC3xiynzgK3Vr
	 CDsgLHyhDz11zSR8EaG8JjGG1LsFm5htvVBi0bVYadhyPq0ppl5yljuQaF/rpt9yS/
	 iuqFs3rysJ+WbjBU1H3B3R1lxNdVSW5Eosi35f80C/avRVyoKJ7sB/BR5fdlvxD7FN
	 BEuOMX+tMn/vQdipaTpTUMyoLSpOj9GLCMqMGnVt2SXBbU8BjVSTlDDhvbPo1ZkRM6
	 bsZQkKK6dEAqmJzVLdn3F8tzpuqjVlk+feF69lTCMCP6ciiZDHzdgygaioUaqpeKxh
	 WFBfAQe810rNA==
Date: Wed, 14 Oct 2026 12:31:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, changfengnan@bytedance.com,
	linux-pci@vger.kernel.org, tglx@kernel.org,
	namjain@linux.microsoft.com, Keith Busch <kbusch@kernel.org>,
	Luigi Rizzo <lrizzo@google.com>
Subject: Re: [RFC PATCH 2/3] PCI/MSI: Implement irq_mask_nowait() for MSI-x
Message-ID: <20261014173106.GA1643226@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013223543.395054-3-kbusch@meta.com>
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

[+cc Luigi, cover letter at
https://lore.kernel.org/all/20261013223543.395054-1-kbusch@meta.com]

On Tue, Oct 13, 2026 at 03:35:42PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Skip the read-back that flushes the MSI-x mask write. Parent domains
> that mask on behalf of PCI/MSI continue using their own irq_mask().
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

I assume Thomas will review/ack the pci/msi/ parts.

Cc'd Luigi since I know he's interested in interrupt moderation in
general.

> ---
>  drivers/irqchip/irq-msi-lib.c | 1 +
>  drivers/pci/msi/irqdomain.c   | 6 ++++++
>  drivers/pci/msi/msi.h         | 8 +++++++-
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
> index 45e0ed3134ce1..bff622b4839aa 100644
> --- a/drivers/irqchip/irq-msi-lib.c
> +++ b/drivers/irqchip/irq-msi-lib.c
> @@ -126,6 +126,7 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
>  	 */
>  	if (info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT) {
>  		chip->irq_mask		= irq_chip_mask_parent;
> +		chip->irq_mask_nowait	= NULL;
>  		chip->irq_unmask	= irq_chip_unmask_parent;
>  	}
>  
> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> index 6e65f0f44112e..92a53c2772659 100644
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -162,6 +162,11 @@ static void pci_irq_mask_msix(struct irq_data *data)
>  	pci_msix_mask(irq_data_get_msi_desc(data));
>  }
>  
> +static void pci_irq_mask_nowait_msix(struct irq_data *data)
> +{
> +	pci_msix_mask_nowait(irq_data_get_msi_desc(data));
> +}
> +
>  static void pci_irq_unmask_msix(struct irq_data *data)
>  {
>  	pci_msix_unmask(irq_data_get_msi_desc(data));
> @@ -182,6 +187,7 @@ static const struct msi_domain_template pci_msix_template = {
>  		.irq_startup		= pci_irq_startup_msix,
>  		.irq_shutdown		= pci_irq_shutdown_msix,
>  		.irq_mask		= pci_irq_mask_msix,
> +		.irq_mask_nowait	= pci_irq_mask_nowait_msix,
>  		.irq_unmask		= pci_irq_unmask_msix,
>  		.irq_write_msi_msg	= pci_msi_domain_write_msg,
>  		.flags			= IRQCHIP_ONESHOT_SAFE,
> diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
> index 0b420b319f50f..337ff9d9da0ed 100644
> --- a/drivers/pci/msi/msi.h
> +++ b/drivers/pci/msi/msi.h
> @@ -40,10 +40,16 @@ static inline void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
>  		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>  }
>  
> -static inline void pci_msix_mask(struct msi_desc *desc)
> +/* Posted write only: the device may still send an interrupt after return */
> +static inline void pci_msix_mask_nowait(struct msi_desc *desc)
>  {
>  	desc->pci.msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
>  	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
> +}
> +
> +static inline void pci_msix_mask(struct msi_desc *desc)
> +{
> +	pci_msix_mask_nowait(desc);
>  	/* Flush write to device */
>  	readl(desc->pci.mask_base);
>  }
> -- 
> 2.52.0
> 

