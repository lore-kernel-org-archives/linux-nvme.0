Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA271C4321E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 14:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6hEvQDUSxrqhn6LM+vjy2tZXkvNTFGwc8V+4FoqFekI=; b=Hy+TRrGB3+0N2QGMkIlS4ulW4w
	ziHux1En7DUqfM7p6H9IdP51amyWKknCGhEqBBerdj17DHPJWX/y4M3L/b16Sbxidc1kFr9WZORyu
	a03QRPzat09J5SRth5JGPI7sYDeKugkTzd1bx/tjB/yRIlkB2yiPlsLSKIjtSUZab+1RhaqmgfxZY
	vvFobc4jzR5f4YepffsPaEarwclIYddLjlhB44Vff+3tVuuap17xIT4ES6JH6DxCM8Nef2dY7vcy8
	bVV4RnC/SQnUYInC/da3DBMOLrAljJOlXRG+aJFJIPPlipTSPBCqV87Zp73Ig8DqHKpMudSqaQ0dU
	fMKe6aSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p01p7-009Mrq-U8; Tue, 29 Nov 2022 14:43:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p01p3-009Mpo-Vf
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 14:42:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4CA6D6177F;
	Tue, 29 Nov 2022 14:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE73C43470;
	Tue, 29 Nov 2022 14:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669732977;
	bh=VXD0nauJaAQS0YyJR7h8BNQEX7ug9rVJXczcarKiYZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IqtociGSDWjHyQw+uvquNwbRQ1W8NVgFLAEG7PMCxu6CkpqatUVv8xzF8A/aYCEJ4
	 kZuJccUvrkSQ7T4C/zCxtMcCHRr+r64uFQZ4PIZ/J00hVWEoMGpMgDFdr2K/GPtiVX
	 G8Xqz5IUWd24KSsVTzNNoEZf9JRowGc8p93E4Czbzu1Qh2GMxC423UgKU4ZOeijNbn
	 Czc/6uu6Lpg3r4LZjHAYgybzlGmUjpIL2Dg7WZquyXOVN9iFcGFsW0/6SG6Hqz2FiA
	 iPGLzrIhyUsGat47RAGWeFOqXedYAblrWJz6lq4RHeY4v1YLpJfCvLTGTZ06zlbdFi
	 jlfxqgZZ9ExPA==
Date: Tue, 29 Nov 2022 07:42:53 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nvme: support io stats on the mpath device
Message-ID: <Y4YabR09emDGRRpP@kbusch-mbp.dhcp.thefacebook.com>
References: <20221003094344.242593-1-sagi@grimberg.me>
 <20221003094344.242593-3-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003094344.242593-3-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_064258_088241_6CBFEFD9 
X-CRM114-Status: GOOD (  19.29  )
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

On Mon, Oct 03, 2022 at 12:43:44PM +0300, Sagi Grimberg wrote:
> Our mpath stack device is just a shim that selects a bottom namespace
> and submits the bio to it without any fancy splitting. This also means
> that we don't clone the bio or have any context to the bio beyond
> submission. However it really sucks that we don't see the mpath device
> io stats.
> 
> Given that the mpath device can't do that without adding some context
> to it, we let the bottom device do it on its behalf (somewhat similar
> to the approach taken in nvme_trace_bio_complete).
> 
> When the IO starts, we account the request for multipath IO stats using
> REQ_NVME_MPATH_IO_STATS nvme_request flag to avoid queue io stats disable
> in the middle of the request.

An unfortunate side effect is that a successful error failover will get
accounted for twice in the mpath device, but cloning to create a
separate context just to track iostats for that unusual condition is
much worse.

Reviewed-by: Keith Busch <kbusch@kernel.org>

> +void nvme_mpath_start_request(struct request *rq)
> +{
> +	struct nvme_ns *ns = rq->q->queuedata;
> +	struct gendisk *disk = ns->head->disk;
> +
> +	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
> +		return;
> +
> +	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
> +	nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0,
> +					blk_rq_bytes(rq) >> SECTOR_SHIFT,
> +					req_op(rq), jiffies);
> +}
> +void nvme_mpath_end_request(struct request *rq)
> +{
> +	struct nvme_ns *ns = rq->q->queuedata;
> +
> +	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
> +		return;
> +	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
> +		nvme_req(rq)->start_time);
> +}

I think these also can be static inline.

