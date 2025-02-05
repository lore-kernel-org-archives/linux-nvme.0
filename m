Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8778CC02194
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2025 11:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oj2++TKJ7gfuLJ4eLGWCiN+vsJfI9kbLaudL6oXfpDI=; b=rgCuhGZWVAGp00TuuTRiMVz1Av
	p/RZkXWFt5h0GAR3NtDr35YQd8KeCM+bBnsoi2S3hYmSYJCmNWErU4BIWht8zIS1ohC+VQYSMrtPN
	UAPC0IHJkXI5JR4wcBccublDlZEO5zJ2xSPd6h5xsKCFVgHWWucX9neByNShq6pT76ZlYlcF+rxLe
	hO0Oq8Ocg4SO3lRld9cAEwAn6DUPmhuVFABnKD3mHL1FuZXe8GdIQWv4w49Lk2ON11JFuP9pB7P81
	LN4cHfi9GAikeLmn2yPs8yxkxsvlqh+IJzS4GjPtTEsVl8waktWft+HRTwRBLJvzOuvDmg09plFVw
	gYHS1j+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfdrN-0000000365p-3yJP;
	Wed, 05 Feb 2025 11:46:25 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfdrH-0000000365M-2nyl
	for linux-nvme@lists.infradead.org;
	Wed, 05 Feb 2025 11:46:21 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9483911FB;
	Wed,  5 Feb 2025 03:46:38 -0800 (PST)
Received: from [10.57.35.21] (unknown [10.57.35.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3FB13F5A1;
	Wed,  5 Feb 2025 03:46:12 -0800 (PST)
Message-ID: <3b3b66ec-8e40-49ef-941b-4d98a6d0ed91@arm.com>
Date: Wed, 5 Feb 2025 11:46:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] Add an option for devices to skip SWIOTLB
 pre-copy on read.
To: Jianxiong Gao <jxgao@google.com>, Keith Busch <kbusch@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Erdem Aktas
 <erdemaktas@google.com>, Vishal Annapurve <vannapurve@google.com>,
 Ryan Afranji <afranji@google.com>, linux-nvme@lists.infradead.org,
 iommu@lists.linux.dev
References: <20250204233630.3407878-1-jxgao@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250204233630.3407878-1-jxgao@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250205_034619_776192_C4CCD71E 
X-CRM114-Status: GOOD (  16.22  )
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

On 2025-02-04 11:36 pm, Jianxiong Gao wrote:
> Removes an extra memory copy that occurs during IO read
> operations through the SWIOTLB. During high throughput
> read workloads, this extra copy is causing a lot of stress
> on the SWIOTLB.
> 
> With high performance devices, for example NVMe devices,
> the device will be overwriting the entire buffer. In such
> cases the entire pre-copy is redundent, only to slow down
> the overall bounce buffering.
> 
> We propose to add a full_buffer_write flag to the
> device_dma_parameters flag. When the flag is set the pre-copy
> can be omitted to boost performance.

No. We already went through this a couple of weeks ago[1]. It's not 
about what the driver intends the device to do, it's about what happens 
if for whatever reason it then *doesn't* do that.

Thanks,
Robin.

[1] 
https://lore.kernel.org/lkml/9582878b-1ce7-4fc4-9b45-b72bba722f49@arm.com/

> 
> Jianxiong Gao (3):
>    add full_buffer_write flag to struct device_dma_parameters
>    skip swiotlb pre copy if the device does full buffer write.
>    set full_buffer_write for nvme devices.
> 
>   drivers/nvme/host/pci.c     |  1 +
>   include/linux/device.h      |  1 +
>   include/linux/dma-mapping.h | 15 +++++++++++++++
>   kernel/dma/swiotlb.c        |  3 ++-
>   4 files changed, 19 insertions(+), 1 deletion(-)
> 


