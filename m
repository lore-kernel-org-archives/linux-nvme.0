Return-Path: <SRS0=bb4v=IL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D2BC433DB
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Mar 2021 02:33:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D1364F83
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Mar 2021 02:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D1364F83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=x9I1HEoi37dLY/3FRy/OVXw3amapccsDE3ZxPnXjNSU=; b=OF/lVPjNdML61uR/V5pJ7ZcNG
	OPwmRl8PG1235JCOHUJb5ZVHABkiUoR6LhTSekRms3Uo4lPQeC6vMSd3p6F09qQ1Xjmd9rKkuEWwB
	iWXs1U2UBgorE0QDI1+wHHNPHF8Q21MnT4vYE/27qAR7y6ikX44R7Q1BvEL3nCBAQbr7MgfSJhoQY
	NE2YCmKF5ERtzATtOkAu8YXeMJsWDVGQk+KQkPwpDlHNwW8GczdX8PZ68PZDHyEwZ3CX8pk7Vbqci
	P73YhrsPeyX76BzTL3MlkGqgl2BjtHGQfD0/kqsC5JwN6dWE5Cg2+2Dzncoy7JFG9nKmvNwdXLkaX
	8jeMhCwdw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKu5i-00Cid5-Me; Sat, 13 Mar 2021 02:33:22 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKu4s-00CiaO-K4
 for linux-nvme@lists.infradead.org; Sat, 13 Mar 2021 02:33:18 +0000
IronPort-SDR: IO+kk6f0kNAFEWKNTUoJsyxwuYOPggBRHqjjhp/VnnAngByZuH5J+XdaSqTuqK83+Cje2c7sdH
 9UuM9zqw+wgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="189008479"
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; d="scan'208";a="189008479"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 18:32:20 -0800
IronPort-SDR: BWPKoNFrC0CbvFbvqC7bofsQvJCNTBhJDT+7AoC9cufX1+KLu6FM5vOz8SA4xWlBa1sCU5vqVL
 Ls62JjUfG9ug==
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; d="scan'208";a="448805796"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 18:32:20 -0800
Date: Fri, 12 Mar 2021 18:32:20 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Ira Weiny <iweiny@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>
Subject: Re: [RFC PATCH v2 04/11] PCI/P2PDMA: Introduce
 pci_p2pdma_should_map_bus() and pci_p2pdma_bus_offset()
Message-ID: <20210313023220.GB3402637@iweiny-DESK2.sc.intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210311233142.7900-5-logang@deltatee.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210313_023309_142504_22744B83 
X-CRM114-Status: GOOD (  18.59  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 11, 2021 at 04:31:34PM -0700, Logan Gunthorpe wrote:
> Introduce pci_p2pdma_should_map_bus() which is meant to be called by
            ^^^^^^^^^^^^^^^^^^^^^^^^^
	    pci_p2pdma_dma_map_type() ???

FWIW I find this name confusing with pci_p2pdma_map_type() and looking at the
implementation I'm not clear why pci_p2pdma_dma_map_type() needs to exist?

Ira

[snip]

> +
> +/**
> + * pci_p2pdma_dma_map_type - determine if a DMA mapping should use the
> + *	bus address, be mapped normally or fail
> + * @dev: device doing the DMA request
> + * @pgmap: dev_pagemap structure for the mapping
> + *
> + * Returns:
> + *    1 - if the page should be mapped with a bus address,
> + *    0 - if the page should be mapped normally through an IOMMU mapping or
> + *        physical address; or
> + *   -1 - if the device should not map the pages and an error should be
> + *        returned
> + */
> +int pci_p2pdma_dma_map_type(struct device *dev, struct dev_pagemap *pgmap)
> +{
> +	struct pci_p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(pgmap);
> +	struct pci_dev *client;
> +
> +	if (!dev_is_pci(dev))
> +		return -1;
> +
> +	client = to_pci_dev(dev);
> +
> +	switch (pci_p2pdma_map_type(p2p_pgmap->provider, client)) {
> +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +		return 0;
> +	case PCI_P2PDMA_MAP_BUS_ADDR:
> +		return 1;
> +	default:
> +		return -1;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pdma_dma_map_type);

I guess the main point here is to export this to the DMA layer?

Ira

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
