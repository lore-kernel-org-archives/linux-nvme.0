Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1BEC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Dec 2021 17:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m/VGWZ9OkcQbtrCA/iIKZvijP8Il/IPv3WsY2034dds=; b=aWrH/X3M6634/TAZkQchsl/5C/
	lgaGbnAnC4cxXqHKL54g3DuB7zQ3W+hLrcbmSAJpXvQ/1qvVWhbR4uhyBAfazb1vR/PGS2ar0NSA2
	WpZBn4FRVGz1mh+UopiDS3JIhjNmSufSWnjPO6UZLEDm6dUvEy1cVhII4CABOVHshxJFC+KHQ22QT
	zp+oxNvA2Q/05NJF+Pj0YCv5l8UVIJReH15arqiA/hT1xYIWv5gw74ot82JCt/ukRRCtivG6Ad+sl
	nL7WjXCAKxPPKAiBcYkmhyJhlUEP0DLNq8eFzYoxeoRJabKybT4dDvThM+s4HJ7qRoa7c60O3Y8qn
	jcYCRlfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxY6D-0026Fg-9i; Wed, 15 Dec 2021 17:29:53 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxY6B-0026F3-6p
 for linux-nvme@lists.infradead.org; Wed, 15 Dec 2021 17:29:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 401F161A08;
 Wed, 15 Dec 2021 17:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE16DC36AE2;
 Wed, 15 Dec 2021 17:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639589390;
 bh=Oq36IKLRKTieTX3kamPtv/WXJ0MMVlcCdINBXZEfdqA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RrIAW7vTfPkrHs/Y1/uZ4YStT5dr1Oi0tmNY+i23WG8OV1h79RHesXA1Gy2s9Sn6h
 Fa0+APuuW22Nlwgih4hWDTDMPe2z1aliqgYzzLwR50rkHdyTo7tbTW7r0vljP9Gf1F
 vUCvXcnqXEC1YE9hOhJCNaZGddpOFHTzs3TFlXP/jp5RxFlKlhkZw8XZxv0sZSUwqP
 tJrcBDdgFHLXDWT5KL4bKhfXncXdGgdECqAeKF6OYWEMxsCBKEk9gePBK1wwMxrg8B
 cUyj7dgDBfmsNnljW1tfF7txwC+e2HtctbUsSksXBzM7PKSETT2mCotDKHF9rgu7Mj
 RSOzXlHRA3/MA==
Date: Wed, 15 Dec 2021 09:29:47 -0800
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
Message-ID: <20211215172947.GB4164278@dhcp-10-100-145-180.wdc.com>
References: <20211215162421.14896-1-axboe@kernel.dk>
 <20211215162421.14896-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215162421.14896-5-axboe@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211215_092951_350425_BE7661A0 
X-CRM114-Status: GOOD (  18.02  )
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
> +static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
> +{
> +	/*
> +	 * We should not need to do this, but we're still using this to
> +	 * ensure we can drain requests on a dying queue.
> +	 */
> +	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
> +		return false;

The patch looks good:

Reviewed-by: Keith Busch <kbusch@kernel.org>

Now a side comment on the above snippet:

I was going to mention in v2 that you shouldn't need to do this for each
request since the queue enabling/disabling only happens while quiesced,
so the state doesn't change once you start a batch. But I realized
multiple hctx's can be in a single batch, so we have to check each of
them instead of just once. :(

I tried to remove this check entirely ("We should not need to do this",
after all), but that's not looking readily possible without just
creating an equivalent check in blk-mq: we can't end a particular
request in failure without draining whatever list it may be linked
within, and we don't know what list it's in when iterating allocated
hctx tags.

Do you happen to have any thoughts on how we could remove this check?
The API I was thinking of is something like "blk_mq_hctx_dead()" in
order to fail pending requests on that hctx without sending them to the
low-level driver so that it wouldn't need these kinds of per-IO checks.

