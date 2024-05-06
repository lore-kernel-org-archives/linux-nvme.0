Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E708C4345F
	for <linux-nvme@archiver.kernel.org>; Mon,  6 May 2024 07:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VNICsQwAZLEIq4FagMWJtT9l3ne94Q3HOggFLnvinbw=; b=mRCQKChbX6gaOtFTkWihAedspy
	xr1uaptU7i/Ylg8bC2K99OgTLzfBdwePGrnI03qsv3NruvWDRBljtedTpW2h9Kp2+7JJs6tJ6Q0TX
	vQk9JPYMYeLw8KwDK8+FgcGVVYQGIfSSojpv3k594qrgJkUdLPdiWlftgvpS4mXDejut2ld67wfCx
	E3AZNeU9B1vDPPf2z1p2ELxICC1DdI+nxBhNX/Qg8UVbryD3nmQKfsGbda/yQBEG4oCtwmY0YI931
	ocpEw6cBzVQgB9G6L3mo15XXJkJNAT6JS3lKtFcJ1nSOUhRBbOxxCMyhKJheWrBK3MxGtrcEU1rZe
	H0FepztQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3slw-00000006SJj-2NAg;
	Mon, 06 May 2024 07:28:28 +0000
Received: from out-189.mta1.migadu.com ([2001:41d0:203:375::bd])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3sis-00000006RYa-3wxN
	for linux-nvme@lists.infradead.org;
	Mon, 06 May 2024 07:25:20 +0000
Message-ID: <1615fe92-d4ff-4ef2-9bd0-199aa9e3a426@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714980307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNICsQwAZLEIq4FagMWJtT9l3ne94Q3HOggFLnvinbw=;
	b=nZznPeyzXvBnkwuymZAd7H5uP6FsRpvl2JfkIEHhVLGTRXN2z1loonY6p/619WY28zpwEl
	Bogs2+q+8zcc500vR6DNiQHdd+mPtphq8OjqAyhbN7IEoPG5hcFcOxw9uMk2A927K9UGj9
	Kf4xW9Sd1i3DF1NmDYSRbBRBNofkxMI=
Date: Mon, 6 May 2024 09:25:01 +0200
MIME-Version: 1.0
Subject: Re: [RFC RESEND 16/16] nvme-pci: use blk_rq_dma_map() for NVMe SGL
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 Bart Van Assche <bvanassche@acm.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Amir Goldstein <amir73il@gmail.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 Dan Williams <dan.j.williams@intel.com>, "jack@suse.com" <jack@suse.com>
References: <cover.1709635535.git.leon@kernel.org>
 <016fc02cbfa9be3c156a6f74df38def1e09c08f1.1709635535.git.leon@kernel.org>
 <c9f9e29e-c2e1-4f99-b359-db0babd41dec@linux.dev>
 <20240505132314.GC68202@unreal>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240505132314.GC68202@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240506_002519_132199_05BBAC19 
X-CRM114-Status: GOOD (  17.21  )
X-Mailman-Approved-At: Mon, 06 May 2024 00:28:27 -0700
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


On 05.05.24 15:23, Leon Romanovsky wrote:
> On Fri, May 03, 2024 at 04:41:21PM +0200, Zhu Yanjun wrote:
>> On 05.03.24 12:18, Leon Romanovsky wrote:
>>> From: Chaitanya Kulkarni <kch@nvidia.com>
> <...>
>
>>> This is an RFC to demonstrate the newly added DMA APIs can be used to
>>> map/unmap bvecs without the use of sg list, hence I've modified the pci
>>> code to only handle SGLs for now. Once we have some agreement on the
>>> structure of new DMA API I'll add support for PRPs along with all the
>>> optimization that I've removed from the code for this RFC for NVMe SGLs
>>> and PRPs.
>>>
> <...>
>
>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>> index e6267a6aa380..140939228409 100644
>>> --- a/drivers/nvme/host/pci.c
>>> +++ b/drivers/nvme/host/pci.c
>>> @@ -236,7 +236,9 @@ struct nvme_iod {
>>>    	unsigned int dma_len;	/* length of single DMA segment mapping */
>>>    	dma_addr_t first_dma;
>>>    	dma_addr_t meta_dma;
>>> -	struct sg_table sgt;
>>> +	struct dma_iova_attrs iova;
>>> +	dma_addr_t dma_link_address[128];
>> Why the length of this array is 128? Can we increase this length of the
>> array?
> It is combination of two things:
>   * Good enough value for this nvme RFC to pass simple test, which Chaitanya did.
>   * Output of various NVME_CTRL_* defines

Thanks a lot. I enlarged this number to 512. It seems that it can work. 
Hope this will increase the performance.

Best Regards,

Zhu Yanjun

>
> Thanks

-- 
Best Regards,
Yanjun.Zhu


