Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429CFC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Feb 2022 11:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mDC/zuUjirZw3tp+IFb2YFRPN57xPPpR/nhYCs7Tn10=; b=hOjhxG+8aCmtoqNmo2VR6PrpMP
	WmMsyh2pVQFBNCQevSNGfTJbhfjujp410OrpcbnOC7ioVBpde101ZlwKXbDRqyK5eSNdAtpoRt11d
	uNC+e6ihdCFn80pc+uIa2tDLpnPsrmWUgTiVnvJa0kz++V+olskuJh5yPYqu0YEAh/3aoNffEjQF6
	9l67EAohB4RAJdQ1QTDQMkakt2ZFysoAuU8GNYUjS5TPvtN76BzA3xHbo9+QMjx7PjE3EBm7EbC87
	etwR6ygWRJPPOU2Pu8Pl7JYK+isBhLA4rvaqm6zzMQBfcpNHMNk1ld2ZnrnGzlAq1KbyQyeatZfqQ
	qBLcBhPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIUCw-006uPx-C0; Fri, 11 Feb 2022 11:35:22 +0000
Received: from foss.arm.com ([217.140.110.172])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIUCt-006uOi-3N
 for linux-nvme@lists.infradead.org; Fri, 11 Feb 2022 11:35:21 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EE7911D4;
 Fri, 11 Feb 2022 03:35:18 -0800 (PST)
Received: from [10.57.70.89] (unknown [10.57.70.89])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72E0B3F73B;
 Fri, 11 Feb 2022 03:35:16 -0800 (PST)
Message-ID: <a0d3b1f7-986f-591d-2675-8ee753d2e7db@arm.com>
Date: Fri, 11 Feb 2022 11:35:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Error when running fio against nvme-of rdma target (mlx5 driver)
Content-Language: en-GB
To: Martin Oliveira <Martin.Oliveira@eideticom.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Kelly Ursenbach <Kelly.Ursenbach@eideticom.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "Lee, Jason" <jasonlee@lanl.gov>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Logan Gunthorpe <Logan.Gunthorpe@eideticom.com>
References: <MW3PR19MB42505C41C2BA3F425A5CB606E42D9@MW3PR19MB4250.namprd19.prod.outlook.com>
 <62fd851d-564e-e2f3-1a40-b594810d9f01@nvidia.com>
 <MW3PR19MB4250DFC4E2AEB8184299A4BBE42F9@MW3PR19MB4250.namprd19.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <MW3PR19MB4250DFC4E2AEB8184299A4BBE42F9@MW3PR19MB4250.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220211_033519_221216_F0195719 
X-CRM114-Status: GOOD (  13.48  )
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

On 2022-02-10 23:58, Martin Oliveira wrote:
> On 2/9/22 1:41 AM, Chaitanya Kulkarni wrote:
>> On 2/8/22 6:50 PM, Martin Oliveira wrote:
>>> Hello,
>>>
>>> We have been hitting an error when running IO over our nvme-of setup, using the mlx5 driver and we are wondering if anyone has seen anything similar/has any suggestions.
>>>
>>> Both initiator and target are AMD EPYC 7502 machines connected over RDMA using a Mellanox MT28908. Target has 12 NVMe SSDs which are exposed as a single NVMe fabrics device, one physical SSD per namespace.
>>>
>>
>> Thanks for reporting this, if you can bisect the problem on your setup
>> it will help others to help you better.
>>
>> -ck
> 
> Hi Chaitanya,
> 
> I went back to a kernel as old as 4.15 and the problem was still there, so I don't know of a good commit to start from.
> 
> I also learned that I can reproduce this with as little as 3 cards and I updated the firmware on the Mellanox cards to the latest version.
> 
> I'd be happy to try any tests if someone has any suggestions.

The IOMMU is probably your friend here - one thing that might be worth 
trying is capturing the iommu:map and iommu:unmap tracepoints to see if 
the address reported in subsequent IOMMU faults was previously mapped as 
a valid DMA address (be warned that there will likely be a *lot* of 
trace generated). With 5.13 or newer, booting with "iommu.forcedac=1" 
should also make it easier to tell real DMA IOVAs from rogue physical 
addresses or other nonsense, as real DMA addresses should then look more 
like 0xffff24d08000.

That could at least help narrow down whether it's some kind of 
use-after-free race or a completely bogus address creeping in somehow.

Robin.

