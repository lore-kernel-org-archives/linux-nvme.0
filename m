Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C07CC71135
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 07:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OEYABVLB6BoQXSTJwC3FWQnSOQAuxEsfOZA62U3eEEU=; b=pzzH9Xe2+IWr6u
	sqZhyBIvZuWThGZ98ShPzbvmy+8q4tOF/jC8L6Eg0VpsqDmXiEa2an58c35aHT3W/JQkjJ0VMJim/
	BmAgjUEyi3hmL3Hze9qQqtTQ8KJtNiCjI4KoUCrXUcAzqvl8zqlWGDI/6u/QdGkSkX2GMGuSybRpN
	Pjjkfr5YQrOXfZ1VSiDBCmTpTobrX1LE5IiWLT3+U3grd43p/K3hZ97isJJlkkFAYYf2unpI9cPbd
	QMYsbXI/1JPs1kWVjDv/H1WViU2YvR0gtdXHG6lwL7jp9gIDgsFZd9Xq/MJLyFIYecM/Hbu7VQvL7
	RMzGhzkbBOC8g2xwd3dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR4Yd-00000003h3g-0RYY;
	Mon, 16 Jun 2025 07:47:07 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR4T1-00000003flS-3efA
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 07:41:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4B3A26115E;
	Mon, 16 Jun 2025 07:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF93C4CEEA;
	Mon, 16 Jun 2025 07:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750059679;
	bh=4qU8ClQ4yBhkxU4l0YkzThkfCL5eedXdhm9zUwLsjLI=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZJszM4j2hv9Uil+UZI6LuhLWN1rAsEhNnJzlcBky+ZwyAHyBu0gRXw6mZNTVNGYqI
	 /38AZCNfLxnNdA+vMoc7Nr7aqr/Wd2BfCdASh+yne76rfMSNK8pmqm5ZNJFNVIyZyW
	 9+f4zHKbG9bMQavXY5TuCDGapLgVH4S8rMb8jeiDlkiLPOE1TFL57zU099YZI+Gna+
	 TxDHzRKXqw7+CxCbZSXSlDLtD3qbZxV3VoLSjG9MDgzEu/CEuU89eDILrKJFt6kXLw
	 CGObaJdoKSgWabBQgmWjhsdlrEgljzgBTJp0hpE3NCdgULLaMhL4RGF5vGBrVDsFUa
	 fbe1Z30hcagKw==
Message-ID: <4af8a37c-68ca-4098-8572-27e4b8b35649@kernel.org>
Date: Mon, 16 Jun 2025 09:41:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Leon Romanovsky <leon@kernel.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Logan Gunthorpe
 <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-8-hch@lst.de>
 <5c4f1a7f-b56f-4a97-a32e-fa2ded52922a@kernel.org>
 <20250612050256.GH12863@lst.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250612050256.GH12863@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/06/2025 07.02, Christoph Hellwig wrote:
> On Wed, Jun 11, 2025 at 02:15:10PM +0200, Daniel Gomez wrote:
>>>  #define NVME_MAX_SEGS \
>>> -	min(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc), \
>>> -	    (PAGE_SIZE / sizeof(struct scatterlist)))
>>> +	(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc))
>>
>> The 8 MiB max transfer size is only reachable if host segments are at least 32k.
>> But I think this limitation is only on the SGL side, right?
> 
> Yes, PRPs don't really have the concept of segments to start with.
> 
>> Adding support to
>> multiple SGL segments should allow us to increase this limit 256 -> 2048.
>>
>> Is this correct?
> 
> Yes.  Note that plenty of hardware doesn't really like chained SGLs too
> much and you might get performance degradation.
>

I see the driver assumes better performance on SGLs over PRPs when I/Os are
greater than 32k (this is the default sgl threshold). But what if chaining SGL
is needed, i.e. my host segments are between 4k and 16k, would PRPs perform
better than chaining SGLs?

Also, if host segments are between 4k and 16k, PRPs would be able to support it
but this limit prevents that use case. I guess the question is if you see any
blocker to enable this path?

