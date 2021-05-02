Return-Path: <SRS0=wOI1=J5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F5BC433B4
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 22:47:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1746610FC
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 22:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1746610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=i55s1sVJcB9eMIunCJnlbesLg2K4bevt7BMExxzXH2A=; b=gWLgEu7dccxw2H1r4MbDGWHZ7
	VdB8Fw1RWYzt3lfXQHkTxQNcM6h2tAvKIAvM7lLeRMAC9kRjG/kcSbez2LMmgaBhPaLM66lRNFdcp
	9M+x4dp2YchBZcFFW7DUy8eg2HsVxeOHFXAwAYPTKKGJq3XB6WG77oG32GQ/gKj0sTTKfeB5lCPXH
	gf4Qbjmo40kneTfLYWXg9+dFmzpiWNjQ7KkOkvzhqnTtoe11TgrK8RSTebdrDZwRWdDvbQQ0qyQAG
	8NktZYM63THmvOEVw6vDKXCPaEayTlFXW/PR/82G6+oB37+D3/oO1avC1f/J5V7mssWMNz6+4DgT1
	DDgEk1aqg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldKrS-00CeFk-8U; Sun, 02 May 2021 22:46:50 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldKoz-00Cdy6-AW
 for linux-nvme@desiato.infradead.org; Sun, 02 May 2021 22:44:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=u1HmLh1Qq4QaallYKPWBKuHrgDty2mcLs90FONusoM4=; b=wknEmGFD+lDn4hzKjR8lP4NIgA
 32gcY4zc6gKWsJBod+r+vuG2A5GC/piW2hq10eAwTXUWkItoAF7ltjvgPp5cVIjA4WQ76mSxxwyXf
 ZJwCpQ3yz2tniAbA6rGzEu9tpCCPsDLcRUr5wjleC/tnaoYUDzoFG+ZykPNZ+UyOkqHeY+Jvjl3fV
 1P0+tGUf42Ii/qX6oxeKYZw54cCvUk7p1xQiqmixdOLYiDRF53oUmKzv6PDEcsdF4bdNbEXwQNmlW
 461zhcpNNHf3fURO+wkozRuFKCI/ycghssgzdOr7DVmRQFq/k6kGyPlKiTZNyizNuQ8ngW/y/kgyi
 cAZPKsZw==;
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com
 ([40.107.94.88] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldKow-002iVx-EG
 for linux-nvme@lists.infradead.org; Sun, 02 May 2021 22:44:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faQ5fyVxSuTKAAhS3hWhwTDeaAmAV0JJRMyk4hWsZIy73jJzhzlow0NzAoviHgpLft9UcHcZkOH3hwWOElg8QxpFIN3pY5gF8qYMAGyle8StwkM9YW+mOGDfx/YjMFlFgHzWRNi+6n3j8EfnXelEXJdCSxZNHjLepHUkm0Owri1tl/u7sEaOiSdJXGGq4n6YgOzxMLejLII1pYEcvUzevBVvOih58e2ozjLIWHtgCNhxs922Ibegxlgmlbqt0FJOldWfL7xbmpyACgqMGoPD/pPEH26Bv3GA7NWEJ6bwFcaVyQD/IbjGCkpP+C1Lvuz16qo2p3NG0wi18kF1u9e4bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1HmLh1Qq4QaallYKPWBKuHrgDty2mcLs90FONusoM4=;
 b=LJfeOA759WvyOLK05BXC1tjLilYbPwCIfxW3I7CcY6Wvax/LKXWmtRe3Reyti1thC2UDQeedl3y1+Gku6q6YaebCAbByt9QGjIYkTSAkaAWCqOSerayr4XnBOXoqjn5dv2F9B0H7zqJTttgCbO7Eq0ZtDbMhyqhoCFHYXf7jxdSeksSWe6psTpzFdzTha672NcQIJeRHnjo33LmRBx9KNqn3d2hRlq2/Re08OkvphsEZH4N0DO9/reLp7dAUbaxhC9Od5iv60sXB4evIFTIM2XBYTUc2q66bW3KDDy2QuIt3JhwDNNX/EAnDk4BUh2lOIl78X0euQnBkFoyx4hok/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1HmLh1Qq4QaallYKPWBKuHrgDty2mcLs90FONusoM4=;
 b=PWyVgJTOhIAZZDqsFQska/Vb7caAFlC2487QztZR321Je2WXxckM09AFaVOkFV+gNYnbhOgqi2sL2uurD1Q4uoKBuG7X7Bhj7aZkAWXZqREno2IlaCnE5nL2ymVgdhJrmqnHz3gHkqH2p9Uz4OVMp/KWNi8drA1I3p3CPsNNuBm3cXcnxCs9v/5Ghkm8rxlV94F3YQrSMlsMCrp3MY6wX0TW+uYoESMKiboztP6xkYNpXKOMpQqU6bhDqbrIY0hMsHv/pwjPB5UH9e1elDVtQfE0GpPES4OC+SR4Eege+T27t7xY3EY/LJs4m7oalDMekVTnFiU89jqo3efyJ+Y+GA==
Received: from MW2PR16CA0056.namprd16.prod.outlook.com (2603:10b6:907:1::33)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Sun, 2 May
 2021 22:44:10 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::fb) by MW2PR16CA0056.outlook.office365.com
 (2603:10b6:907:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Sun, 2 May 2021 22:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Sun, 2 May 2021 22:44:09 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 2 May
 2021 22:44:07 +0000
Subject: Re: [PATCH 07/16] PCI/P2PDMA: Make pci_p2pdma_map_type() non-static
To: Logan Gunthorpe <logang@deltatee.com>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-mm@kvack.org>,
 <iommu@lists.linux-foundation.org>
CC: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>, Dan
 Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Don Dutile
 <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>, Jason Ekstrand
 <jason@jlekstrand.net>, Dave Hansen <dave.hansen@linux.intel.com>, Xiong
 Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>, Ira
 Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-8-logang@deltatee.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <c2712ed0-6d44-014a-f669-dfda63d1c861@nvidia.com>
Date: Sun, 2 May 2021 15:44:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-8-logang@deltatee.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24c147a1-08d6-4069-2ce0-08d90dbbcd08
X-MS-TrafficTypeDiagnostic: DM6PR12MB4450:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44501C79D59F83D18A214EB6A85C9@DM6PR12MB4450.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6mWJ0cgwj8hLLViPSgAuVFcDKClp1ha40VHCug/NRhfw954qItd9q9Md1Jni52LpWze0epTOQLJA9O1tEceRUEHI4S9nT58WAc7AkZdJDlqNyC2GWSOAoswpOUXf6wT5Mi9nS8yVdzsl8zbs25B+Rv0IEO89/m9A67snpnqnaRlbgs05AOm9JKkuGimS0usViw5BrMYO4AelclH9fIsRTot3qLsDFbUC8D/MVn0YQn4epFkIsv1ZI10jp9xVdgHI0dF3d9J+QQ8Zf36+a528fWGvof+Obp5rrJFpj1WbHLoe0tg2aLbtduEXIE2OA4RbW4CH20PYaR502CZtFb7fYCFtWItQd9PcybJS0ocsVTV8XVX+q/M6VsnRS7VWRNMB6YvqXqJlC1V06mGq2l6Q14e9+/BV5fzH7Y7nN79T2a7fBib0Q9ZDt85Bw9yzhEYzfRO5t6p2H5CVxAnGL+qMAqkgcY29vxjETwK1pSqy0SPAp7nQ/xdWQbafDYrPfLK9+z3Q3Xld+r67aftAlnSWdlLzsONJDJxU/JfBJp9xf7GV8t6QFXAKpLWVGI3XWmMrgZAtZbd1FeNqvwu8OGXfvv/jkQ3Cn0JWBB2qlh4H+yCcUQoJSotoPsnfAHAKHzQy2qEHXw4ks6sqAjFUKLd8IYzgfP9v9MwmXI4d2quoAYJVc/MAuF/4jjL1mNVRWHAF6QhT/kRzhrASWL76xj/Asw==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(36840700001)(46966006)(110136005)(8936002)(36756003)(26005)(36860700001)(16576012)(54906003)(83380400001)(31696002)(356005)(82310400003)(82740400003)(31686004)(7636003)(70206006)(316002)(5660300002)(47076005)(53546011)(36906005)(70586007)(4326008)(86362001)(336012)(478600001)(426003)(186003)(2906002)(7416002)(16526019)(2616005)(8676002)(2101003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2021 22:44:09.8546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c147a1-08d6-4069-2ce0-08d90dbbcd08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210502_154414_526307_D6E0DD4D 
X-CRM114-Status: GOOD (  30.35  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
> pci_p2pdma_map_type() will be needed by the dma-iommu map_sg
> implementation because it will need to determine the mapping type
> ahead of actually doing the mapping to create the actual iommu mapping.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/pci/p2pdma.c       | 34 +++++++++++++++++++++++-----------
>   include/linux/pci-p2pdma.h | 15 +++++++++++++++
>   2 files changed, 38 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index bcb1a6d6119d..38c93f57a941 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -20,13 +20,6 @@
>   #include <linux/seq_buf.h>
>   #include <linux/xarray.h>
>   
> -enum pci_p2pdma_map_type {
> -	PCI_P2PDMA_MAP_UNKNOWN = 0,
> -	PCI_P2PDMA_MAP_NOT_SUPPORTED,
> -	PCI_P2PDMA_MAP_BUS_ADDR,
> -	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
> -};
> -
>   struct pci_p2pdma {
>   	struct gen_pool *pool;
>   	bool p2pmem_published;
> @@ -822,13 +815,30 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
>   }
>   EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
>   
> -static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
> -						    struct device *dev)
> +/**
> + * pci_p2pdma_map_type - return the type of mapping that should be used for
> + *	a given device and pgmap
> + * @pgmap: the pagemap of a page to determine the mapping type for
> + * @dev: device that is mapping the page
> + * @dma_attrs: the attributes passed to the dma_map operation --
> + *	this is so they can be checked to ensure P2PDMA pages were not
> + *	introduced into an incorrect interface (like dma_map_sg). *
> + *
> + * Returns one of:
> + *	PCI_P2PDMA_MAP_NOT_SUPPORTED - The mapping should not be done
> + *	PCI_P2PDMA_MAP_BUS_ADDR - The mapping should use the PCI bus address
> + *	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE - The mapping should be done directly
> + */
> +enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
> +		struct device *dev, unsigned long dma_attrs)
>   {
>   	struct pci_dev *provider = to_p2p_pgmap(pgmap)->provider;
>   	enum pci_p2pdma_map_type ret;
>   	struct pci_dev *client;
>   
> +	WARN_ONCE(!(dma_attrs & __DMA_ATTR_PCI_P2PDMA),
> +		  "PCI P2PDMA pages were mapped with dma_map_sg!");

This really ought to also return -EINVAL, assuming that my review suggestions
about return types, in earlier patches, are acceptable.

> +
>   	if (!provider->p2pdma)
>   		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
>   
> @@ -879,7 +889,8 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>   	struct pci_p2pdma_pagemap *p2p_pgmap =
>   		to_p2p_pgmap(sg_page(sg)->pgmap);
>   
> -	switch (pci_p2pdma_map_type(sg_page(sg)->pgmap, dev)) {
> +	switch (pci_p2pdma_map_type(sg_page(sg)->pgmap, dev,
> +				    __DMA_ATTR_PCI_P2PDMA)) {
>   	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>   		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
>   	case PCI_P2PDMA_MAP_BUS_ADDR:
> @@ -904,7 +915,8 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>   {
>   	enum pci_p2pdma_map_type map_type;
>   
> -	map_type = pci_p2pdma_map_type(sg_page(sg)->pgmap, dev);
> +	map_type = pci_p2pdma_map_type(sg_page(sg)->pgmap, dev,
> +				       __DMA_ATTR_PCI_P2PDMA);

These areas might end up looking a bit different, if my suggestion about
applying pci_dev type safety throughout are accepted.

The patch looks generally correct, aside from these details.

thanks,
-- 
John Hubbard
NVIDIA

>   
>   	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
>   		dma_unmap_sg_attrs(dev, sg, nents, dir, attrs);
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index 8318a97c9c61..a06072ac3a52 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -16,6 +16,13 @@
>   struct block_device;
>   struct scatterlist;
>   
> +enum pci_p2pdma_map_type {
> +	PCI_P2PDMA_MAP_UNKNOWN = 0,
> +	PCI_P2PDMA_MAP_NOT_SUPPORTED,
> +	PCI_P2PDMA_MAP_BUS_ADDR,
> +	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
> +};
> +
>   #ifdef CONFIG_PCI_P2PDMA
>   int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>   		u64 offset);
> @@ -30,6 +37,8 @@ struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
>   					 unsigned int *nents, u32 length);
>   void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
>   void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
> +enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
> +		struct device *dev, unsigned long dma_attrs);
>   int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>   		int nents, enum dma_data_direction dir, unsigned long attrs);
>   void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
> @@ -83,6 +92,12 @@ static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
>   static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
>   {
>   }
> +static inline enum pci_p2pdma_map_type pci_p2pdma_map_type(
> +		struct dev_pagemap *pgmap, struct device *dev,
> +		unsigned long dma_attrs)
> +{
> +	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
> +}
>   static inline int pci_p2pdma_map_sg_attrs(struct device *dev,
>   		struct scatterlist *sg, int nents, enum dma_data_direction dir,
>   		unsigned long attrs)
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
