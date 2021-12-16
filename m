Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565ECC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 09:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h/AKyVJpvvulYpJylUQM8JxzavXlAuaKFGs3SV1295k=; b=beSzwM7hUY/AwuO7WmyQpSzhg/
	Rco59Z5csvWH7o2QAhLIr7akjTUYSbdj8HXjhiiKzfkqC4ZvsdqLHmqdH/qD+C+q2m3CEy+4EQWcR
	Jon7ColXPtY5dR6SKrp4F9gi2pncY/FopGX/iTQ/0GwE3hm1PJKdbJDO/YMq93EmNFx395obmUFFE
	noNsTcw6bnkpIKZinmFUVG0AuJCv7sJTqDRw6Tdc03V1RCa8fGsjd0Dt/4qaLtOKUqoNGR5geU1F+
	56aAq8R0ROOS1th4BQI2uEiao3diRJ13Ppyhmsy6Dt0k+tyo/E8aUHx2c5XVPcFK9am2G3I0AXqo2
	QMsjFM5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxmxL-004Pa6-8u; Thu, 16 Dec 2021 09:21:43 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mxmkH-004JLF-Ck; Thu, 16 Dec 2021 09:08:13 +0000
Date: Thu, 16 Dec 2021 01:08:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
Message-ID: <YbsB/W/1Uwok4i0u@infradead.org>
References: <20211215162421.14896-1-axboe@kernel.dk>
 <20211215162421.14896-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215162421.14896-5-axboe@kernel.dk>
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

On Wed, Dec 15, 2021 at 09:24:21AM -0700, Jens Axboe wrote:
> +	spin_lock(&nvmeq->sq_lock);
> +	while (!rq_list_empty(*rqlist)) {
> +		struct request *req = rq_list_pop(rqlist);
> +		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +
> +		memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
> +				absolute_pointer(&iod->cmd), sizeof(iod->cmd));
> +		if (++nvmeq->sq_tail == nvmeq->q_depth)
> +			nvmeq->sq_tail = 0;

So this doesn't even use the new helper added in patch 2?  I think this
should call nvme_sq_copy_cmd().

The rest looks identical to the incremental patch I posted, so I guess
the performance degration measured on the first try was a measurement
error?

