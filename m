Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCD4C71157
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jun 2025 17:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WUhlHhn8L8nWxdK1+UOlJk7VSY+qO/g4yPj+QbYI+qc=; b=PlNTIpGmFxV4gX
	osdM1NWQEzesJBuTUoAuZcsZSkJdO0swfof6mNbswt6WNblZUkp+4sI7PHxV2z3eDxdRLXcYID195
	WZjzzw2kfkyIh4n43x5AV1q/4JpAd1PL0/TBm+TC14OyCT64lT8ASH/FhgHvbA0DU25MlpldUqwoB
	LnY9OERvhZwuwmKUEp6anOCbSKPgZo3VPNsaT3l0xGonIyUN5T1WVIlGPS4uP0RSD3DfFJkLgmUsn
	V8yr5Gj1q3UYimaq5tDhQEG+XodwcSQQuVKjAjgof4rewlPjjpYQwwMUSmfYKxxyUKwXaxdq+p40R
	BHN8zETAfiQFPu4oTjtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRaLM-000000084k9-2jT2;
	Tue, 17 Jun 2025 17:43:32 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRaLK-000000084jY-3YyH
	for linux-nvme@lists.infradead.org;
	Tue, 17 Jun 2025 17:43:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7CD18449BC;
	Tue, 17 Jun 2025 17:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495F1C4CEE3;
	Tue, 17 Jun 2025 17:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750182210;
	bh=tL4Obeun7WLXku3bH1nDHcp84HwzWMUN+lnTlkMMSaM=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G3KJB7CYWESu9oKkyxh952HvUEkc2yvJy7mVv7U1sQ53lysK+HIcOn200qbVO4eiO
	 SmqEMiuxrTy0gVYVtIXAkPx6iBgsSKLIH1GOtYak2EXgGOMiS3mKiFjcWwmX3nHzQh
	 hS2Agh/lVKp1SjC5lnYKL1RpLYFaZgzJDolq7XArOOZMOByIul5BqEmtEPN/45emWr
	 /3bmhJcLjahZqv0n7CFMn9smTftFNlTzxono7jas7ElmGaW0M9UYxX4VZD7QWwEZPd
	 irs/7gCLn5w00nzfo/CJVVgMYT/DJFy5J5JkPciY08RjWauefhr1dRDXkt2kYdaVbo
	 hp6lfnJhGakQg==
Message-ID: <edf056c9-ab8d-4b55-9e61-25a29916d55c@kernel.org>
Date: Tue, 17 Jun 2025 19:43:26 +0200
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
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250617_104330_905898_A3F030B4 
X-CRM114-Status: UNSURE (   9.76  )
X-CRM114-Notice: Please train this message.
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

SGLs don't have the same MPS limitation we have in PRPs. So I think the correct
calculation for NVME_MAX_SEGS is PAGE_SIZE / sizeof(struct nvme_sgl_desc).

