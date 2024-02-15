Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B600C4829E
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Feb 2024 12:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r9t1e+ZKJlLbNNcW5ux2gKo9slNURLzHZ1bP9J0LvY0=; b=RD4HuSISxJFFsl64D+R1pC7cvt
	5bZZ05hJOu0ppSi6cMSr5OSVrPWoIn322cF8xUcXTQYWbPROuLLeMOAg9m4Lv5nXrb5VFC0qeyC9J
	QLUaPkUTHIzS88GNLIYA+s96NIor0KDQe8eWYYXp5z86rYc/Wk9QBGcy521eBvNdkwYfwPE+K905H
	Ba68BExLnNT6EIQEFDhzp/91dQ5cLxtVMveWQAadU4ETSPobZz3uiUtP27HqKRyvHDe3C4uYs7rKL
	S/WXnZX4BraE4Jq0soUDRQciK6srC+AgNC7qUk534or4Ab1AdP9dbGJFS7unLuxiAdgvae/h/bJgl
	AD3cn3Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raaQy-0000000G9oC-15ZN;
	Thu, 15 Feb 2024 12:01:44 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raaQv-0000000G9mt-1RQs
	for linux-nvme@lists.infradead.org;
	Thu, 15 Feb 2024 12:01:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B836F1FB;
	Thu, 15 Feb 2024 04:02:18 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 559813F766;
	Thu, 15 Feb 2024 04:01:36 -0800 (PST)
Message-ID: <7f14727d-3ca6-45ec-9251-f166f74a8f7c@arm.com>
Date: Thu, 15 Feb 2024 12:01:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] nvme-pci: Fix iommu map (via swiotlb) failures
 when PAGE_SIZE=64KB
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>, Keith Busch <kbusch@kernel.org>
Cc: sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, will@kernel.org,
 joro@8bytes.org, jgg@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, murphyt7@tcd.ie,
 baolu.lu@linux.intel.com
References: <cover.1707851466.git.nicolinc@nvidia.com>
 <60bdcc29a2bcf12c6ab95cf0ea480d67c41c51e7.1707851466.git.nicolinc@nvidia.com>
 <Zcv7uI6VrMc2EuGT@kbusch-mbp> <ZcxZD2GXmR5+vC/k@Asurada-Nvidia>
 <Zc1qpr4zCy1N0OND@kbusch-mbp> <Zc2XHbcXZzV2a61n@Asurada-Nvidia>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Zc2XHbcXZzV2a61n@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240215_040141_478069_83B2FFF3 
X-CRM114-Status: GOOD (  17.29  )
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

On 15/02/2024 4:46 am, Nicolin Chen wrote:
> On Wed, Feb 14, 2024 at 06:36:38PM -0700, Keith Busch wrote:
>> On Tue, Feb 13, 2024 at 10:09:19PM -0800, Nicolin Chen wrote:
>>> On Tue, Feb 13, 2024 at 04:31:04PM -0700, Keith Busch wrote:
>>>> On Tue, Feb 13, 2024 at 01:53:57PM -0800, Nicolin Chen wrote:
>>>>> @@ -2967,7 +2967,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
>>>>>                dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
>>>>>        else
>>>>>                dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>>>>> -     dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
>>>>> +     dma_set_min_align_mask(&pdev->dev, PAGE_SIZE - 1);
>>>>>        dma_set_max_seg_size(&pdev->dev, 0xffffffff);
>>>>
>>>> I recall we had to do this for POWER because they have 64k pages, but
>>>> page aligned addresses IOMMU map to 4k, so we needed to allow the lower
>>>> dma alignment to efficiently use it.
>>>
>>> Thanks for the input!
>>>
>>> In that case, we might have to rely on iovad->granule from the
>>> attached iommu_domain:
>>
>> I explored a bit more, and there is some PPC weirdness that lead to
>> NVME_CTRL_PAGE_SIZE, I don't find the dma min align mask used in that
>> path. It looks like swiotlb is the only user for this, so your original
>> patch may be just fine.
> 
> Oh, that'll be great if we confirmed. And I think I forgot to add
> CC line to the stable trees: the two patches should be applicable
> cleanly to older kernels too. Let's wait for some day, so people
> can give some tests and reviews. Then I will respin a v2 with the
> CC line.

Hmm, as far as I understand, NVME_CTRL_PAGE_SIZE represents the 
alignment that NVMe actually cares about, so if specifying that per the 
intended purpose of the API doesn't work then it implies the DMA layer 
is still not doing its job properly, thus I'd rather keep digging and 
try to fix that properly.

FWIW I have a strong suspicion that iommu-dma may not be correctly doing 
what it thinks it's trying to do, so I would definitely think it 
worthwhile to give that a really close inspection in light of Will's 
SWIOTLB fixes.

Thanks,
Robin.

