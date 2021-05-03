Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A464C433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 01:51:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0439161376
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 01:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0439161376
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=y1zgfgN68d5aHqYE5zVEXwaOByXdW2hirsW+gqWjMi0=; b=Lmyf3b/YAqLSmEifIEMwwSqX2
	bEh1vdTIGljOjWcgj3aanGcaNT1vTA9A1ClScs6EMp8OGPIT8nJHLc3UvLzJvxrj5E3qMBJXf/sLP
	dx/QOgf4AGHV+/FmxmsVByC2sbtAReEmAZ7pR3AmhgTQZLQohcxA3M1z3JpfCwaEQh+ZKUkXUF4/R
	uCa1Kn2N7UlEP0UtANkToMiNRWLYpky+laMwreZUsh3ZKXcAOgWjGtqufiIPkqOJmxMVDL5ZMsqI3
	wvhbhP+Ds+6uxv8rOWx7oNrXR+uLC/fAmNLvbj3h4LYL14r6Up8ZoQ0a7fKXlNLitYb0PftBiQVmd
	MywRQt/WQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldNjQ-00Ct8o-4K; Mon, 03 May 2021 01:50:44 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldNjK-00Ct7B-V2
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 01:50:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=hPaaXZktY2cFnw1P7z+m+ZmwSYuzdqwLrQD4QtpwOd0=; b=DkZX/6G9ezXy7RmrXjwx3OM4FI
 Isalt+0N7cqgZYsrwg3Nqci1/JMhevEpI5f2plQagQUZkZUuGPNtc8cK7QzIGfbBQB3HjHA3Dhikq
 cOHz1k4TYmTUf6Q0wun1DTt0W2lM5eO2qn/KmMeV9rI3Oh89Q1L8VNCYnq5TxB9EryAjhS58ZhOL6
 +d8oNHn76YFMcLy4nzlaNuYUwPn1M+HwTmxKYv7aJondx85Y9msRjGpBfnkjcdaAc7GWbDW9BC2YU
 uzq52E/tXkBSKyWxWIDr9bsudI9dVq53ub/Dyku46iTbuCzDMJNqgnqKKDVg2oPuoLYM8Ly+pchJK
 XRO9XQTg==;
Received: from mail-bn8nam08on2073.outbound.protection.outlook.com
 ([40.107.100.73] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldNjI-002m6a-3W
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 01:50:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZXPADSvts+KVOa/h56iPblrfqYaV/jTDJE/i6uqzuUzG+isNh8VOFImluUJBRcu62zitzokQDOSt2Dcpb/BwI1lFvXrSgAlMbTkuZFmJcFooAFjxXRxHCBnDuuug2F06EIzKOgFxa6WVN3QhH8C1jV+HVkeTz/Vfsbmu7RWqWybK/XEqk5+smKJ99LLSmeeao2DRb6F7MZMsek9AAzYC0YoS2D6zTjOBbcwbt2DDKqBd0Rst3wqiDZaDfUfFrpTpultxd+z2Zw8z6zkCQRqlNRWbscCaSnLwInEffKD5JAyWZX3nupgE6LM0Pme2858ziP1idTBAT74t4i+Rc93zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPaaXZktY2cFnw1P7z+m+ZmwSYuzdqwLrQD4QtpwOd0=;
 b=J96+VaUXwlvqSRyOAe58twv0/11JB+OlSCN4UJ5uO2jMU/THttBJq4OB4uKzXGOHkGzkraFv+BI11/0bYo2sUqBOaxT9xI/xVZTpaAhSC35ZJOCgtpiQrisIeabWIpJnHoy7M1HrfiSKmyZbgRR5FcrFkKWDC6h3/IVdWJAAe35CKaCFKEq4mqbdiRL8uXkWEY/2YApidUvWijd7T7HcJzErVOLeXtkG9iOuY6yING8oZWDafmte8E5w0/YrXoNNf9SwtnOAm4oDbnx+31C99ml7Oo8jxWAllhCfyfzZYNxD3SeWLZhyZw/hz2yODSyPmeiMA5YYpDjaEgkgRekXmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPaaXZktY2cFnw1P7z+m+ZmwSYuzdqwLrQD4QtpwOd0=;
 b=adt7UUTyanIZoWiF86i6bJbhnsffW4SN+1i0TVwQmmECX9COL8F6cDGEDtSdepIIzYN4nd8as8yqpePKdwHPkQW1sWX7wF3ZNoqP1glRoTXkxRYKuvf6ZYdRTcVEKzeJqY4xxGJd/anH6p5BDFtwyU2Ov8YAy1ZQz7iK6YRHO49NCyZnuCvsBAD8Lzow0eDattGSA7XhNvxB7yTuAM5f8kE7PoHs+y6dEb3zUVPvk6w4fbbcuCt35d+kUYdZCT0ikRYGBbPk+WVr+X993tO10BbfYlqtdUMY+uZqRY1W7c87VwzocNqaja2XB4/Lb641tfAPK77KnwoucL9etMnT5A==
Received: from BN1PR14CA0009.namprd14.prod.outlook.com (2603:10b6:408:e3::14)
 by DM5PR12MB2519.namprd12.prod.outlook.com (2603:10b6:4:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Mon, 3 May
 2021 01:34:41 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::3a) by BN1PR14CA0009.outlook.office365.com
 (2603:10b6:408:e3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Mon, 3 May 2021 01:34:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 01:34:40 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 3 May
 2021 01:34:40 +0000
Subject: Re: [PATCH 13/16] nvme-pci: Convert to using dma_map_sg_p2pdma for
 p2pdma pages
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
 <20210408170123.8788-14-logang@deltatee.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <78a165e1-657b-c284-d31a-adc8c9ded55d@nvidia.com>
Date: Sun, 2 May 2021 18:34:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-14-logang@deltatee.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18d47ce8-ca5e-4948-a5ee-08d90dd39f37
X-MS-TrafficTypeDiagnostic: DM5PR12MB2519:
X-Microsoft-Antispam-PRVS: <DM5PR12MB251910DC88936F994FA68C04A85B9@DM5PR12MB2519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dWW56g6cN4bTUpBCZm4W+NYYzvUqB8Z4iBzqEIEMLSWrSD5H4fnsipYkW+sR6ur2l/6yzdgpsTys2WVHaIdVSkm57g3UbppJ1ejfSKurbFmY8NXV5HhwAXytV6domKoaH1iPUTq7YCQDJht/92HnR8/YiVIP3waNDlWH30XPP9JCgGhHNlgEjz+7RyH8+k/L2uk6DwFQOh3UYNQVwutzbCfhURq+Vau/egtMlRy3PaIKfsZeKSnjLhV5KH7P49j2GcRoEyXf7qPgOCpGW5JT3wIkk6BOTAWXCLFEoOP1pu0UM6G6VQpLWGzE19YTz0u7iwTg6vc9q79d7lZpv/rMqVVzZwoTVaVM2JuAs990cLUW7ltLKdanN/FEztQGyaM+GBsolDHzNW+Nk0l+357sZA+gc4XpM8VM8wxSK8OMQNZxR8WaFSr5CzVKpM7VLWEtjsrMR8WUh6XMTs/S2JDV4MiG4lTA/50c19Ma7UXESZqaGybeZmGKpcqEsKpdL3fYD9Js3rIvuSZpa74iGr8wbyxBJSLR9vjWL2sZdkpMVhtQb1emwePRMPskTY1EW4z3Inki1bGcRG7xBbIfxhCzBTA83ilO+N6JVVJyxGzcUY0V5QTR2QiQ+NLYmDfjwe/RnK6ACocLOS8ak8qpyage2nJbfZEM7wRL89prnutxd7A6ivaFEvQ/rWjBxEy5kYf+nk+sWE09jG1Ujo1vlU6EOA==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(36840700001)(46966006)(54906003)(36906005)(86362001)(82740400003)(2616005)(7416002)(356005)(2906002)(16576012)(316002)(16526019)(5660300002)(7636003)(36756003)(8936002)(83380400001)(70586007)(70206006)(426003)(336012)(47076005)(82310400003)(186003)(8676002)(36860700001)(110136005)(31696002)(31686004)(4326008)(26005)(478600001)(53546011)(2101003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 01:34:40.8361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d47ce8-ca5e-4948-a5ee-08d90dd39f37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2519
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210502_185036_161899_7C3155B9 
X-CRM114-Status: GOOD (  20.30  )
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
> Convert to using dma_map_sg_p2pdma() for PCI p2pdma pages.
> 
> This should be equivalent but allows for heterogeneous scatterlists
> with both P2PDMA and regular pages. However, P2PDMA support will be
> slightly more restricted (only dma-direct and dma-iommu are currently
> supported).
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/nvme/host/pci.c | 28 ++++++++--------------------
>   1 file changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 14f092973792..a1ed07ff38b7 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -577,17 +577,6 @@ static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
>   
>   }
>   
> -static void nvme_unmap_sg(struct nvme_dev *dev, struct request *req)
> -{
> -	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> -
> -	if (is_pci_p2pdma_page(sg_page(iod->sg)))
> -		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
> -				    rq_dma_dir(req));
> -	else
> -		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
> -}
> -
>   static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
>   {
>   	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> @@ -600,7 +589,7 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
>   
>   	WARN_ON_ONCE(!iod->nents);
>   
> -	nvme_unmap_sg(dev, req);
> +	dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));


Nice simplification!


>   	if (iod->npages == 0)
>   		dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
>   			      iod->first_dma);
> @@ -868,14 +857,13 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>   	if (!iod->nents)
>   		goto out_free_sg;
>   
> -	if (is_pci_p2pdma_page(sg_page(iod->sg)))
> -		nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
> -				iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
> -	else
> -		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
> -					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
> -	if (!nr_mapped)
> +	nr_mapped = dma_map_sg_p2pdma_attrs(dev->dev, iod->sg, iod->nents,
> +				     rq_dma_dir(req), DMA_ATTR_NO_WARN);
> +	if (nr_mapped < 0) {
> +		if (nr_mapped != -ENOMEM)
> +			ret = BLK_STS_TARGET;
>   		goto out_free_sg;
> +	}

But now the "nr_mapped == 0" case is no longer doing an early out_free_sg.
Is that OK?

>   
>   	iod->use_sgl = nvme_pci_use_sgls(dev, req);
>   	if (iod->use_sgl)
> @@ -887,7 +875,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>   	return BLK_STS_OK;
>   
>   out_unmap_sg:
> -	nvme_unmap_sg(dev, req);
> +	dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
>   out_free_sg:
>   	mempool_free(iod->sg, dev->iod_mempool);
>   	return ret;
> 

thanks,
-- 
John Hubbard
NVIDIA

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
