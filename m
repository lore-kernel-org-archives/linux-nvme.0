Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8C7C47258
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 14:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tnWyCzUSSVqrCzYFEgaT7j+ymM/hCBvboycxs0I+cSI=; b=ovneK5UKomoNPwNFsGcj/jAiiK
	HW/9YCVEU0zQ5d7rPeiIAC0UGPvbPhn06jXR7WUzonR6z4vniBgYblK2AjjbtE+2B1bzBSQao/hOQ
	H7o9vzbq3xFTosGpzFJ6kWZOfsLrJr2LT8ePNIC7LxCNvz57BnK7FZmfzlPqH6dJRvYNd39WhUzdY
	d3/8vYi7fSoRXDDY6Yy4coGqDjh0MsO+QirOHwvZDHM34b3j+8uVtcMru1C5UBQ71mA1K9IKQdoab
	SkR9RX05UbBu0lj1yKKxsw+45bz603I1pqLmrR8CNHyuTs8B9kfPx8t2DzdTo0tZO2+eAAgYNRvZN
	ENWsCt7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT0md-00000000Nwe-06go;
	Thu, 25 Jan 2024 14:32:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT0mY-00000000NvJ-3iMr
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 14:32:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B10BD67373; Thu, 25 Jan 2024 15:32:34 +0100 (CET)
Date: Thu, 25 Jan 2024 15:32:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 08/15] block: pass a queue_limits argument to
 blk_alloc_queue
Message-ID: <20240125143234.GA17817@lst.de>
References: <20240122173645.1686078-1-hch@lst.de> <20240122173645.1686078-9-hch@lst.de> <43b6b9ce-bbc8-4c36-abcb-85ed8c1eb40f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43b6b9ce-bbc8-4c36-abcb-85ed8c1eb40f@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_063243_111388_E164028B 
X-CRM114-Status: GOOD (  22.37  )
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

On Thu, Jan 25, 2024 at 09:45:20AM +0000, John Garry wrote:
>> +struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
>>   {
>>   	struct request_queue *q;
>> +	int error;
>>     	q = kmem_cache_alloc_node(blk_requestq_cachep, GFP_KERNEL | 
>> __GFP_ZERO,
>>   				  node_id);
>> @@ -404,13 +405,26 @@ struct request_queue *blk_alloc_queue(int node_id)
>
> Is there actually an issue in that blk_alloc_queue() can return NULL, and 
> we should be checking IS_ERR_OR_NULL() in the callers?
>
> I don't think that IS_ERR() picks up on NULL pointers, right?
>
> Or make this change:

Yes, that's the right thing to do, I'll add it.

> nit: This is only ever going to return -EINVAL or 0 by its very nature, 
> right? I suppose that it could return a bool and we do the conversion to 
> EINVAL here. It's a personal taste thing, I suppose.

I actually had that during most of the development, but then the callers
had to convert it.  Either way works, but this seemed a bit cleaner.

>> +		if (error)
>> +			goto fail_q;
>> +		q->limits = *lim;
>
> nit: It might be neater to do this in blk_validate_limits()

The limits assigment?  I'd really like to keep blk_validate_limits limited
to only look at the passed in queue_limits and never look at a live
object.

