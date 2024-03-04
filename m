Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666A1C5475B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 02:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AwmaRBK9f4xeTr2KKIZaEkYuoxsnConkJ3QY8WkxaG4=; b=YNpOFD9/ivXKICKsimDOLn2Ib5
	KuAwY+C5GBmdzaVUmHP5km3PA/yGmexhKucUNsn1Bt6Ojh+cBsJfFWWVezuXIlri0vPiVncGaVxUe
	sWFhZUvVoojNBj7i9n/qgqcUSQFLnlJdxvPbyMHVTqqBlqN7lkqZPHy16Y1FWvjtucBdQTGI62vwC
	rb8aP+/Of384PYdcEO1hC4VtgjKmH+RkUiV26DvWQbMV1UTNWXWNAo0x2qcvsVlBqwceDYhywhZ0G
	LG59X4jZ/qIdSwkaddL6J12NLrXR8FiGug/IM8/VLPSeHkdB8AmLwsUCBBwBPBtkWMhjsnZAzRolo
	XeEgHKsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rgy3o-00000007Jkk-05yT;
	Mon, 04 Mar 2024 02:28:12 +0000
Received: from out-182.mta1.migadu.com ([2001:41d0:203:375::b6])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rgy3j-00000007Jir-1a8K
	for linux-nvme@lists.infradead.org;
	Mon, 04 Mar 2024 02:28:09 +0000
Message-ID: <22df55f8-cf64-4aa8-8c0b-b556c867b926@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709519282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AwmaRBK9f4xeTr2KKIZaEkYuoxsnConkJ3QY8WkxaG4=;
	b=GFbyjr7FhhwloIRGYJbvYR2kjPjcVdcWEeIEFJysy6dwcV7/jHlDBt/GAmHusvPsiaRlNZ
	UB7rrqP99IQeHRy17j5j5Kx45ucggNjfStR4c5A4+uGW1Gcy07R2jku2TzogQkWFWGB+PJ
	j/QAT+SkCeRTAFVbxsPeNebm/D8kfjk=
Date: Mon, 4 Mar 2024 03:27:52 +0100
MIME-Version: 1.0
Subject: Re: [LSF/MM/BPF TOPIC] [LSF/MM/BPF ATTEND] : Two stage IOMMU DMA
 mapping operations
To: Zhu Yanjun <zyjzyj2000@gmail.com>, Leon Romanovsky <leon@kernel.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>,
 Bart Van Assche <bvanassche@acm.org>, "kbusch@kernel.org"
 <kbusch@kernel.org>, Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Amir Goldstein <amir73il@gmail.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>, Christoph Hellwig
 <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
 "jack@suse.com" <jack@suse.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Chuck Lever <chuck.lever@oracle.com>
References: <97f385db-42c9-4c04-8fba-9b1ba8ffc525@nvidia.com>
 <20240227113007.GD1842804@unreal>
 <be75fe5b-9901-425c-8dbb-771dcb084e2e@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <be75fe5b-9901-425c-8dbb-771dcb084e2e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240303_182807_886092_8729450A 
X-CRM114-Status: GOOD (  11.80  )
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

在 2024/3/3 17:43, Zhu Yanjun 写道:
> On 27.02.24 12:30, Leon Romanovsky wrote:
>> On Tue, Feb 27, 2024 at 08:17:27AM +0000, Chaitanya Kulkarni wrote:
>>> Hi,
>>
>> <...>
>>
>>> In order to create a good platform for a concrete and meaningful
>>> discussion at LSFMM 24, we plan to post an RFC within the next two 
>>> weeks.
>>
>> The code can be found here 
>> https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=dma-split
> 
> Thanks a lot. I will delve into it. An interesting topic.

The commits should be the followings. I am interested in them.

5d8f8f35859c (HEAD -> dma-split, origin/dma-split) cover-letter: Split 
IOMMU DMA mapping operation to two steps
3beffcde0c12 vfio/mlx5: Convert vfio to use DMA link API
acdfef1ccbcb vfio/mlx5: Explicitly store page list
f16314362e66 vfio/mlx5: Rewrite create mkey flow to allow better code reuse
763e753cd6ed vfio/mlx5: Explicitly use number of pages instead of 
allocated length
7f58ebf0cfc4 RDMA/umem: Prevent UMEM ODP creation with SWIOTLB
f1c687fde096 RDMA/core: Separate DMA mapping to caching IOVA and page 
linkage
ffc81619c60d RDMA/umem: Store ODP access mask information in PFN
67038d9e24fd RDMA/umem: Preallocate and cache IOVA for UMEM ODP
ce141bccd409 iommu/dma: Implement link/unlink page callbacks
1dd12d4a44d1 iommu/dma: Prepare map/unmap page functions to receive IOVA
b9714667f54f iommu/dma: Provide an interface to allow preallocate IOVA
21dbfc7fc2f1 dma-mapping: provide callbacks to link/unlink pages to 
specific IOVA
52689a26b87a dma-mapping: provide an interface to allocate IOVA
34f8a8baecaa mm/hmm: let users to tag specific PFNs

Zhu Yanjun

> 
> Zhu Yanjun
> 
>>
>> Thanks
>>
>>>
>>> Required Attendees list :-
>>>
>>> Christoph Hellwig
>>> Jason Gunthorpe
>>> Jens Axboe
>>> Chuck Lever
>>> David Howells
>>> Keith Busch
>>> Bart Van Assche
>>> Damien Le Moal
>>> Martin Petersen
>>>
>>> -ck
>>>
>>> [1]
>>> https://lore.kernel.org/all/169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net
>>> [2] https://lore.kernel.org/linux-iommu/20200708065014.GA5694@lst.de/
>>>
>>>
>>>
> 


