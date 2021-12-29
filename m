Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBD4C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Dec 2021 17:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=75FwMcY0ckJ+ltyuPUJrP0b8bFYQ13tV1aDqc0mH4V4=; b=v6Nm/DsGsVjId8lK7JPILOYxvA
	qnJenYvcI2CeC3OuGCAQizKtdV5VlKZ4dzgBOvJjgH2KQhp5yLUdn+yFZNekmC3jYw0ixL8FBMFBQ
	SK68JfGGlv2diOeAFg79J9btuYTA/eLjWrAAAle7IgWz7IiGrZAljto85lhx9JWYQZKRPTWRwQXDv
	ziYEzlGH0hL6i4ljq+tbtK3M8MFhpQP88/NqVxwAbRIeSqMuXkk7pU0AU1GtBjTi25bgiI5ZKWAER
	HoZ/awI0Gr4R+BQ5ozgINz9QlXm6L4Ak3GOB9M1zf2Z5lrKazBpCQwWk+gLTNEkVU8xgylBdNpDxB
	6ywzib7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n2cxS-003Dvt-5H; Wed, 29 Dec 2021 17:41:50 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n2cwr-003DoL-9a
 for linux-nvme@lists.infradead.org; Wed, 29 Dec 2021 17:41:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7E8A968AFE; Wed, 29 Dec 2021 18:41:09 +0100 (CET)
Date: Wed, 29 Dec 2021 18:41:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCHv2 2/3] block: introduce rq_list_move
Message-ID: <20211229174109.GB28058@lst.de>
References: <20211227164138.2488066-1-kbusch@kernel.org>
 <20211227164138.2488066-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227164138.2488066-2-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211229_094113_518024_EC7BA054 
X-CRM114-Status: GOOD (  16.35  )
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

On Mon, Dec 27, 2021 at 08:41:37AM -0800, Keith Busch wrote:
> +/**
> + * rq_list_move() - move a struct request from one list to another
> + * @src: The source list @rq is currently in
> + * @dst: The destination list that @rq will be appended to
> + * @rq: The request to move
> + * @prv: The request preceding @rq in @src (NULL if @rq is the head)
> + * @nxt: The request following @rq in @src (NULL if @rq is the tail)
> + */
> +static void inline rq_list_move(struct request **src, struct request **dst,
> +				struct request *rq, struct request *prv,
> +				struct request *nxt)
> +{
> +	if (prv)
> +		prv->rq_next = nxt;
> +	else
> +		*src = nxt;
> +	rq_list_add(dst, rq);
> +}

Do we even need the nxt argument?  I think it should always be
rq->rq_next?

Also I'd spell out prev and next for a little more readability.

