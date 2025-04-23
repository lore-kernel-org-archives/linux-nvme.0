Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC89C369CB
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 13:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gz4ljP1Dp8Gazjscn5jRMXeEB4FtvE+v4QHn+/N3I4A=; b=Sba/DxEigvyTueR9fhqo93GMbm
	VsIobM6OxDZr8rxAJ5oqv/koi3MxKk1+EkNUVOishdIDLjfxOIm4pxt6k5jvmtbM6ZUfqJcRB/oPE
	58CttGy5BhcsifU0msIH1DCji/IYkyMfbIVQBKftOoEXwLL+c0Tmo0rfhEwiWcJdMSi/AA2reUdSU
	LP/zFJZmF2AyNOwEqHfALl9oI2HRRoj1cN3eO6xhmEwnnPTQVuNweFO1S+AYw2cm9rAGiL3iFlqny
	OWRTYEyvOqF7xgcTduzdidcBUrmBvXuMEuXTLx5FHnid1pwUGOsm3eYbJViS1jMHp5fIVzfuxO9jC
	oypDNtWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7aXb-0000000Ai9y-3Tur;
	Wed, 23 Apr 2025 13:53:31 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7aF0-0000000Acfo-2Rq3
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 13:34:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 00C64A4CF31;
	Wed, 23 Apr 2025 13:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C41EC4CEE2;
	Wed, 23 Apr 2025 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745415256;
	bh=ueUfGPiRe8CWFt/O1EQf5z5vxeIPa9k232U3/o+JgxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBTK9IV7mbg1F9P+I6yRAqsmiDAfQ8VwP0UPACt3x4Q58QN21dpx8SfxQMOhJ/Oae
	 u3bpfrgDsBMFmm//YSdnlxsTtAYc3YMXpsP1CbRTU468E0IVifsKRyhlql+rxVydF2
	 BAtOe4q+finogOh41KWxU3JrHBvKtzKrgny2a71XD0g+yXLSLoY7TKp4VxM4+ucMgg
	 7BDeSUIRQWhSsq//ZxZ8mDR199dZVnGpBfgXV+39fMFzf2gMHvWUf2T7TRcU4VvmoC
	 AuBFNONti3ADtZPvbU/gE7qsBUBP4rnH/pqvXaytDr6ai16jJn74lR9d6+FHfpU/j8
	 bG0i9iXLi3Fiw==
Date: Wed, 23 Apr 2025 15:34:09 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 1/2] PCI: endpoint: improve fixed_size bar handling
 when allocating space
Message-ID: <aAjsUXiK5PK7S6Jd@ryzen>
References: <20250422-pci-ep-size-alignment-v4-0-6bd58443fee9@baylibre.com>
 <20250422-pci-ep-size-alignment-v4-1-6bd58443fee9@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422-pci-ep-size-alignment-v4-1-6bd58443fee9@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_063418_759371_1A2D3488 
X-CRM114-Status: GOOD (  27.93  )
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

On Tue, Apr 22, 2025 at 04:54:19PM +0200, Jerome Brunet wrote:
> When trying to allocate space for an endpoint function on a BAR with a
> fixed size, the size saved in the 'struct pci_epf_bar' should be the fixed
> size. This is expected by pci_epc_set_bar().
> 
> However, if the fixed_size is smaller that the alignment, the size saved
> in the 'struct pci_epf_bar' matches the alignment and it is a problem for
> pci_epc_set_bar().
> 
> To solve this, continue to allocate space that match the iATU alignment
> requirement, saving it as .aligned_size, then save the size that matches
> what is present in the BAR.
> 
> Fixes: 2a9a801620ef ("PCI: endpoint: Add support to specify alignment for buffers allocated to BARs")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 21 ++++++++++++++-------
>  include/linux/pci-epf.h             |  3 +++
>  2 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 394395c7f8decfa2010469655a4bd58a002993fd..982db6c1fbe77653f6a74a31df5c4e997507d2d8 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -236,12 +236,13 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
>  	}
>  
>  	dev = epc->dev.parent;
> -	dma_free_coherent(dev, epf_bar[bar].size, addr,
> +	dma_free_coherent(dev, epf_bar[bar].aligned_size, addr,
>  			  epf_bar[bar].phys_addr);
>  
>  	epf_bar[bar].phys_addr = 0;
>  	epf_bar[bar].addr = NULL;
>  	epf_bar[bar].size = 0;
> +	epf_bar[bar].aligned_size = 0;
>  	epf_bar[bar].barno = 0;
>  	epf_bar[bar].flags = 0;
>  }
> @@ -264,7 +265,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  			  enum pci_epc_interface_type type)
>  {
>  	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
> -	size_t align = epc_features->align;
> +	size_t aligned_size, align = epc_features->align;
>  	struct pci_epf_bar *epf_bar;
>  	dma_addr_t phys_addr;
>  	struct pci_epc *epc;
> @@ -285,12 +286,17 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  			return NULL;
>  		}
>  		size = bar_fixed_size;
> +	} else {
> +		/* BAR size must be power of two */
> +		size = roundup_pow_of_two(size);
>  	}
>  
> -	if (align)
> -		size = ALIGN(size, align);
> -	else
> -		size = roundup_pow_of_two(size);
> +	/*
> +	 * Allocate enough memory to accommodate the iATU alignment requirement.
> +	 * In most cases, this will be the same as .size but it might be different
> +	 * if, for example, the fixed size of a BAR is smaller than align.
> +	 */
> +	aligned_size = align ? ALIGN(size, align) : size;
>  
>  	if (type == PRIMARY_INTERFACE) {
>  		epc = epf->epc;
> @@ -301,7 +307,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  	}
>  
>  	dev = epc->dev.parent;
> -	space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
> +	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
>  	if (!space) {
>  		dev_err(dev, "failed to allocate mem space\n");
>  		return NULL;
> @@ -310,6 +316,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  	epf_bar[bar].phys_addr = phys_addr;
>  	epf_bar[bar].addr = space;
>  	epf_bar[bar].size = size;
> +	epf_bar[bar].aligned_size = aligned_size;
>  	epf_bar[bar].barno = bar;
>  	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
>  		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 879d19cebd4fc6d8df9d724e3a52fa7fbd61e535..23b0878c2665db1c21e6e83543c33149ab1e0009 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -114,6 +114,8 @@ struct pci_epf_driver {
>   * @phys_addr: physical address that should be mapped to the BAR
>   * @addr: virtual address corresponding to the @phys_addr
>   * @size: the size of the address space present in BAR
> + * @aligned_size: the size actually allocated to accommodate the iATU alignment
> + *                requirement.

Nit: Since none of the other lines end with a full stop.
Perhaps add one for all lines, or continue not having it for all lines.

Regardless:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

