Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4010C71136
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jun 2025 17:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ymAwbz+mZmPMUiLZlQWSM9Cpmk3+33Osqa8+i60lTZM=; b=rxWL0lwzb0WawG
	Ncn/eDIA8oeLfITa7kdT1BSfyp9Pjyf7ia1XUDCIONWPxfQc4dwbzRD2l4rD9lCzvKUWssh4YQCKh
	VXu1cU8MXk+a9knaGFkoYUQkeYObIqYFZbNOtqPB3P75ZP7xNUfd0Tn79vJf5YgdFRZLerYHDQiMr
	NWadg/ki95Bgo4grfBq6OnHnDsmyINFPppI7fs7KJrJ9/REui8nqtLP3qj7miXMVBGrRkb92H9pwp
	9c3sKLknlXTM/9Ozk/YsPyEXuoIwhVZ/5/j8JD6zy0g0saswCf1Z5+w1Q/MSYF8ksCtxnRsdJ3sC8
	A7py1esibEi5eYuhnYPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRaN3-0000000857U-0fcm;
	Tue, 17 Jun 2025 17:45:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRaN1-0000000856n-0Lbh
	for linux-nvme@lists.infradead.org;
	Tue, 17 Jun 2025 17:45:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C7A965C6368;
	Tue, 17 Jun 2025 17:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FBEC4CEE3;
	Tue, 17 Jun 2025 17:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750182314;
	bh=mwuIS3TH6Iy2vwJYNmaVexGdaQqfvGHQnUF4HVL6WXY=;
	h=Date:Reply-To:Subject:From:To:Cc:References:In-Reply-To:From;
	b=c4nzq0Hlzi9wxXW6ihJTpfUwpXJVjDnWYqP7qGYT2jvZoS6oyXzhOOHm2dUnbiqQW
	 1PFbYsfW1pG/d1RfuVapbQQYoxCfOAYulxUX/rpXFDt8khZ8/4nnF/asTQ4rWTvYYb
	 bdSpDDJJocUpEq3NQ3W3gddAmlvPSoPntEyPQOBdHa0erzhXBNq1fnZbxojgRdNWBn
	 kjnhJ1zfWfXD8rC6koeRkaxE0pLQ9yPY7dPqrqXBaAT6EUKBdfMtpULEFf+r2G6hyT
	 pSQBFnWBqL+T+0k7CPePUWDy4DIVosFTHSvI/z49yfevdQ7IM8b04L7NCvCgCpd7oE
	 UW0lUVBDc5A+A==
Message-ID: <4e3eec2b-bd74-452f-880f-b1ad4f35bd79@kernel.org>
Date: Tue, 17 Jun 2025 19:45:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
From: Daniel Gomez <da.gomez@kernel.org>
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
 <edf056c9-ab8d-4b55-9e61-25a29916d55c@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <edf056c9-ab8d-4b55-9e61-25a29916d55c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250617_104515_168142_4406BAD8 
X-CRM114-Status: GOOD (  10.64  )
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



On 17/06/2025 19.43, Daniel Gomez wrote:
> On 12/06/2025 07.02, Christoph Hellwig wrote:
>> On Wed, Jun 11, 2025 at 02:15:10PM +0200, Daniel Gomez wrote:
>>>>  #define NVME_MAX_SEGS \
>>>> -	min(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc), \
>>>> -	    (PAGE_SIZE / sizeof(struct scatterlist)))
>>>> +	(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc))
>>>
>>> The 8 MiB max transfer size is only reachable if host segments are at least 32k.
>>> But I think this limitation is only on the SGL side, right?
>>
>> Yes, PRPs don't really have the concept of segments to start with.
> 
> SGLs don't have the same MPS limitation we have in PRPs. So I think the correct
> calculation for NVME_MAX_SEGS is PAGE_SIZE / sizeof(struct nvme_sgl_desc).
> 

Please, ignore. I forgot I already made this point.

