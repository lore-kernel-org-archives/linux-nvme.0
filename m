Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50178C282EC
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Mar 2025 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AdoZazn2un3OU27AezKp5mnIbog/P2nX729v1brHP88=; b=pzBo1DX43adSum/1zAnZfuXI6h
	mxpkXpbXa3ouxhpX5kcJhST+dhK+2XW56WplLWnvlrrWJQvYz5f6sS/+Ru7UG7so4YYKKNa9nSg8A
	FdMKH7KjpNlzRjHeDL0LC/k9BUTVePk87PfLY4ZCmMVXMLYAUcHvvXt6O2JhKdAwYq1YiPkiHUIRv
	0tZr7Hz588EF7Qlw2PQWT9P3Y+eaJjj6IgHeFzIvTzUuk8h3CcnlJ6DNpYbxTDznu0/5s7s+ykmY6
	IPOMrmtqOC8tr2zcSewrf8PM3LWZdBdKM1/7MGXqmY9QHPWvfKVFpgUfxp8g2AQyY9voqP1qkdWZu
	+X6BO0AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tt2fj-0000000DuMv-3Xdw;
	Fri, 14 Mar 2025 10:53:47 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tt2Mj-0000000Drad-2nls
	for linux-nvme@lists.infradead.org;
	Fri, 14 Mar 2025 10:34:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B4E7FA45403;
	Fri, 14 Mar 2025 10:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCCAC4CEE3;
	Fri, 14 Mar 2025 10:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741948448;
	bh=pQ1UwwMZFek7gZviyGO8vQeLxcoj0KyB9Ojnu+AwSK0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a3L4jFiUYIBnwkIlQovYkOwCBiu8JFcbFF4Swa4SCS7Z8Mk4ASxe2W6AXq1KWnYwO
	 fWIYknCwSm8pBtBtQG8O3vMIBsps9yHL0aI+ImDy8Fmu5OOTKFtIcm8qBuQeP51KDH
	 8D7BB7Nt4xCp1OGK2ck0yduSLFIDuqYzAO0BE83K0P3DUYxOmf4/d9+E8ek9KJfFao
	 m247X+FWk27j+oGXFuoZiRv4mbpo6fbM9ZqRPVjrqfDFPJpUVgsGF90SpVSrS5uTyd
	 pUM0powg3dyeTez24mXkPE+924KMG4J7HNGGQyxKYalTcM9KMBM7uO3Njrl+H8Uk9C
	 Y5Jd/5drgTmkg==
Message-ID: <bf6d9883-da33-4e52-9a67-aa0ee660caf2@kernel.org>
Date: Fri, 14 Mar 2025 19:34:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: pci-epf: Always configure BAR0 as 64-bit
To: Niklas Cassel <cassel@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20250314095858.1604764-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250314095858.1604764-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250314_033409_779010_6892A74F 
X-CRM114-Status: GOOD (  23.46  )
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

On 3/14/25 18:58, Niklas Cassel wrote:
> NVMe PCIe Transport Specification 1.1, section 2.1.10, claims that the
> BAR0 type is Implementation Specific.
> 
> However, in NVMe 1.1, the type is required to be 64-bit.
> 
> Thus, to make our PCI EPF work on as many host systems as possible,
> always configure the BAR0 type to be 64-bit.
> 
> In the rare case that the underlying PCI EPC does not support configuring
> BAR0 as 64-bit, the call to pci_epc_set_bar() will fail, and we will
> return a failure back to the user.
> 
> This should not be a problem, as most PCI EPCs support configuring a BAR
> as 64-bit (and those EPCs with .only_64bit set to true in epc_features
> only support configuring the BAR as 64-bit).
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Hello Damien,
> 
> please test on your platforms as well.

Will test. But I think this needs a Fixes tag:

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")

> 
> I think this is the way to go, as most real NVMe drives in the wild have
> BAR0 as a 64-bit BAR.
> 
>  drivers/nvme/target/pci-epf.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 0136df45ca275..a24f6549c0d15 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -2096,8 +2096,15 @@ static int nvmet_pci_epf_configure_bar(struct nvmet_pci_epf *nvme_epf)
>  		return -ENODEV;
>  	}
>  
> -	if (epc_features->bar[BAR_0].only_64bit)
> -		epf->bar[BAR_0].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> +	/*
> +	 * While NVMe PCIe Transport Specification 1.1, section 2.1.10, claims
> +	 * that the BAR0 type is Implementation Specific, in NVMe 1.1, the type
> +	 * is required to be 64-bit. Thus, for interoperability, always set the
> +	 * type to 64-bit. In the rare case that the PCI EPC does not support
> +	 * configuring BAR0 as 64-bit, the call to pci_epc_set_bar() will fail,
> +	 * and we will return failure back to the user.
> +	 */
> +	epf->bar[BAR_0].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
>  
>  	/*
>  	 * Calculate the size of the register bar: NVMe registers first with


-- 
Damien Le Moal
Western Digital Research

