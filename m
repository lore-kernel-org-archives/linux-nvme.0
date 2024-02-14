Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7EAC4829D
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Feb 2024 06:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jNE6boFDHoljvD3VXPHTGXxDgM70hmBWyy5AXkD1HFs=; b=AjvkK69qTtXJPnQupvwyklsdpP
	WIgXnNO+49pz3bpdKMrvIJD0Ut5ZlPKrnqtl0FScGkbyKPHRof5zhok5NexgzjNqNVmkm/3AfuXSv
	YvNsLK2U6yHqs2LFFzYDGPGzNe3o2/xoTCmWD5zMPHWFmXnHZeMAA3XImCaD1PlEPSkWj9by5tuwj
	INOoiYOsw2cF4nM9UVZ33s9nng5HzFW5AFqj2AebgfwhswOWPUVxx18o+v+xz6cuOlHzxyegsneHa
	D+RiQrt5jHvgmn8VKADT0b55lHK4lv71vwyz1eBIKmzO0SoB6XIIAcTLRBdi0wpbrjip8IxnzfeYW
	v6VgAXUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ra8Sw-0000000BvYx-0g5v;
	Wed, 14 Feb 2024 06:09:54 +0000
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com ([2a01:111:f403:2414::601] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ra8St-0000000BvXx-2UHD
	for linux-nvme@lists.infradead.org;
	Wed, 14 Feb 2024 06:09:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+0Z93BSNOfOoq0Gvi7zIAMabtOiSkI7syXWFneDRswzi3hSuCaNfs4O4oZsLPSMGnYGKAcizGJaaP6q99PzQ8zjR2wKbRk303WlU0vHcV2YwqIhqcvhN4OgHS2gR6e0iie7leW2rOj2Ce+F2TS8P8/pgO3mcBSNDNeSfGGoFEgSCmhb81yQSVvLPzlHSQAxOsOuw0ZKCxVsAHLN2ADsMQ+HbukmPYz0kbQJse4nhed0llZtgGYZ8BX7EiRdgI8jyqtId4iSUtOZRxAmAE2em+QfysZFOyIjB+52bgxv3XgLpepLL8RoRllQ41Ya5Zs2SrQD44rJGcDHxXHf25lMDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNE6boFDHoljvD3VXPHTGXxDgM70hmBWyy5AXkD1HFs=;
 b=cXhzIJ9vQlLP2LDwzRRU2+Slld1UBJENlcdzBtVvLBdb4O/p54cK0VUV43qemiWumhzRIKhDSVXjofmbjmjKmPQ8Ddd3HxwOu6k7heQFB1G1wVrcpYeb/NLuipHRnmp2VsentLbRWlZQ0a75do+gqKGDc6QTeGd7OcviwAfYXaLVqO1Jp1buQul0Wz3g6KdjX3v8ztAe8Ce+DRS8xeYIoG7B5aLnaViB8ZpQGgqr+PCdy1Z4Mva8fqagqV5uJSkyU8dpLAN6YmHMnJipJ5i4pR/xEgwEDxfqowH/iq/WJ5hZiioMjPYuYHzcUSeMt5WkMuiluUfHcolmuNoOeFct6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNE6boFDHoljvD3VXPHTGXxDgM70hmBWyy5AXkD1HFs=;
 b=Ri5UEm/aMYHexi9jW7/f5IVYR38yWHxbsZwIbtBEpyHzg0qVZ347ug7vQIsZUcZF75iHaG2DBczMSYr7lx1nT52gxFC55J6cL0rl0wk6Pc6QW0eEDkjEWKdPBp32jUac6++ty01RdTtIaRCzL8fKG6C5uurgFIWJTX1ronp8ivuI2WR9dBk4v30sRUTGYJrl9hsapRS1TldI4pYf4V7i26ZL9VYYuyhsZ6/x7XF/cD+CgPxEVLr11eekqFtP9DDR0SB/ykUm+JDaZHo6ztp7EV96X2gFS8+CugWjau9wWW8qdky7H4iNfySryPyFjsTTWH+gKaJAcVLOjQwkwdonAg==
Received: from MW4P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::23)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 14 Feb
 2024 06:09:34 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::61) by MW4P221CA0018.outlook.office365.com
 (2603:10b6:303:8b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Wed, 14 Feb 2024 06:09:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 06:09:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 13 Feb
 2024 22:09:22 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 13 Feb 2024 22:09:21 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Tue, 13 Feb 2024 22:09:21 -0800
Date: Tue, 13 Feb 2024 22:09:19 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: <sagi@grimberg.me>, <hch@lst.de>, <axboe@kernel.dk>, <will@kernel.org>,
	<joro@8bytes.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <murphyt7@tcd.ie>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 2/2] nvme-pci: Fix iommu map (via swiotlb) failures
 when PAGE_SIZE=64KB
Message-ID: <ZcxZD2GXmR5+vC/k@Asurada-Nvidia>
References: <cover.1707851466.git.nicolinc@nvidia.com>
 <60bdcc29a2bcf12c6ab95cf0ea480d67c41c51e7.1707851466.git.nicolinc@nvidia.com>
 <Zcv7uI6VrMc2EuGT@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zcv7uI6VrMc2EuGT@kbusch-mbp>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: ca0eb04f-75d9-40f8-9dc7-08dc2d238415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WrfDVmzEqGcn8eKt44tMbccA2drpHTKovplIu6tGh+kB2YQaD0f4j2GelOXJJGbJtNb1AqoJOcJPBGwwyqx91Yg7nQRvFix9aGkYMiE4LcP0KgQvP7csQO8PLN6/jcGAqe6P7OumtvtS9TIZFOVyDJAvv0A5zwibOd5jOWMwDfIUx8Jm2lvchVPf94vn1Ztv1tyHtnn9CIMkXU/A/7yDIVTklCYmX7fhum85LS2dLPfSn94shxn9Y5daJTovWzIszR4pHG+UKzG/nIZsbB6xad+zqJvi3haM/mMa6s3wn/ukxBmfVbMyygCjJDi6Vx/kWTGk3PQxzgPOBFh5jvhJKnWLTWTa8PJSCG+1W5gJ4i6XAjLR51Dop7O37ZtDfISjDf73sLYBGCwKLivtSHAuglg2pHOh3U1mYKXE2KKgQc7/JYEs9vilbjW3L9/+ssMNz0GbJ2xZKcqyZx9QQwDK13LGzPBiZtqHrQcoddZxwE9dsgiAQ50Hp9aucEX6uLKMjFoWm6GWzvFQjSDVQ7m1BDpceonN4Ovz5ZhMT3Hp5xT7MMVc9G+CWOjFgrVv38yDwcY9YU01+8nHQ2AaVgCltdhJU51SWuim/JG+XuHPTsQ=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(36840700001)(40470700004)(46966006)(426003)(478600001)(26005)(336012)(55016003)(9686003)(86362001)(70586007)(4326008)(6916009)(8936002)(54906003)(7636003)(82740400003)(70206006)(8676002)(316002)(356005)(7416002)(41300700001)(33716001)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 06:09:34.1944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0eb04f-75d9-40f8-9dc7-08dc2d238415
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240213_220951_660296_46C76891 
X-CRM114-Status: GOOD (  11.57  )
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

On Tue, Feb 13, 2024 at 04:31:04PM -0700, Keith Busch wrote:
> On Tue, Feb 13, 2024 at 01:53:57PM -0800, Nicolin Chen wrote:
> > @@ -2967,7 +2967,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
> >               dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
> >       else
> >               dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> > -     dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
> > +     dma_set_min_align_mask(&pdev->dev, PAGE_SIZE - 1);
> >       dma_set_max_seg_size(&pdev->dev, 0xffffffff);
> 
> I recall we had to do this for POWER because they have 64k pages, but
> page aligned addresses IOMMU map to 4k, so we needed to allow the lower
> dma alignment to efficiently use it.

Thanks for the input!

In that case, we might have to rely on iovad->granule from the
attached iommu_domain:

+static size_t iommu_dma_max_mapping_size(struct device *dev)
+{
+       struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+       if (!domain || !is_swiotlb_active(dev) || !dev_is_untrusted(dev))
+               return SIZE_MAX;
+       return ALIGN_DOWN(swiotlb_max_mapping_size(dev),
+                         domain->iova_cookie->iovad.granule);
+}

With this in PATCH-1, we can drop PATCH-2.

Thanks
Nicolin

