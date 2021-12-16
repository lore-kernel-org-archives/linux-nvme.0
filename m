Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9C9C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 16:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WlhizxSLgT5efNt7Y+j1gKxLFWAt+hl7g1lx9qTqfFg=; b=qVnVKa0JEmguwVUNcT/ZtCag64
	Y/0QY18va6o8J8cHS3zKE3CyJ3UTtQmqLSln2c+74/+6e6t7m8001jv3d88bjxlhbmHKr4/C0jtT4
	siVMbjXn9+qKFENevqkXao6JLRc8tWpzTLVcyC9TdHhcha/q4g9UAJ0L9Kc0+YkNEAN8fBakS8zwi
	8QYnv5v17D3zLGjeQEehWYyyEPfwUf9ciVlD83Do566nN2o9NDYMGj89eRMFG7iYJit/htH7U99YI
	dAw0qBjieK4CsNbJ2hUu/But2vr2nptsEhUvHkQtnZyQ6mxkPbhm1/8rAoCzdwFgwfNiVx2eb3KqH
	KA11yUhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxtbA-006bt0-0y; Thu, 16 Dec 2021 16:27:16 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mxtQE-006Xq4-Qi; Thu, 16 Dec 2021 16:15:58 +0000
Date: Thu, 16 Dec 2021 08:15:58 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
Message-ID: <YbtmPjisO5RIAnby@infradead.org>
References: <20211215162421.14896-1-axboe@kernel.dk>
 <20211215162421.14896-5-axboe@kernel.dk>
 <YbsB/W/1Uwok4i0u@infradead.org>
 <83aa4715-7bf8-4ed1-6945-3910cb13f233@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83aa4715-7bf8-4ed1-6945-3910cb13f233@kernel.dk>
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

On Thu, Dec 16, 2021 at 08:45:46AM -0700, Jens Axboe wrote:
> On 12/16/21 2:08 AM, Christoph Hellwig wrote:
> > On Wed, Dec 15, 2021 at 09:24:21AM -0700, Jens Axboe wrote:
> >> +	spin_lock(&nvmeq->sq_lock);
> >> +	while (!rq_list_empty(*rqlist)) {
> >> +		struct request *req = rq_list_pop(rqlist);
> >> +		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> >> +
> >> +		memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
> >> +				absolute_pointer(&iod->cmd), sizeof(iod->cmd));
> >> +		if (++nvmeq->sq_tail == nvmeq->q_depth)
> >> +			nvmeq->sq_tail = 0;
> > 
> > So this doesn't even use the new helper added in patch 2?  I think this
> > should call nvme_sq_copy_cmd().
> 
> But you NAK'ed that one? It definitely should use that helper, so I take it
> you are fine with it then if we do it here too? That would make 3 call sites,
> and I still do think the helper makes sense...

I explained two times that the new helpers is fine as long as you open
code nvme_submit_cmd in its two callers as it now is a trivial wrapper.

