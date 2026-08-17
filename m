Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE2BC5CFC1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 08:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=au17TapoUPXBx6NRpGvSoDmpo3PyK/4BzjAss2YwetY=; b=KcJ4umaWejyEqVh3pUn7mJsssX
	cW2h1ariqLTudST2HSv7qXz5A/Pv0eFSzf21+vUvBL3oZ/Lboyila5n6N62yGXROTPM62ZPx6/9Il
	ep4qnPrEJg/WcFMlZR9935Ln9xL9U+VPjyee7XAVP+RDa0CD3ZsToeoM3E3MwwEM3RHpscfCIpRjk
	/1I1fqbSoJwIKh1vv67TYH8aBtU3IFZSZ7ZCvHMjNnGCa8qcXgIOMpH27x0ruuoA3IIyhbjt0DMIm
	JvfthFce7gkmQ8uZpcRNf80jYtv3Y7uFuPWUWLbvOe7ULAqvJoBmOtHj4z5c1VAKYXEypc5YKwlxs
	RpSgP+fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvsQM-00000005dCE-361C;
	Mon, 17 Aug 2026 08:10:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvsQJ-00000005dBh-3utR
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 08:10:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4728568D07; Mon, 17 Aug 2026 10:10:18 +0200 (CEST)
Date: Mon, 17 Aug 2026 10:10:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yao Sang <sangyao@kylinos.cn>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 3/4] block: factor out path limit stacking
Message-ID: <20260817081017.GC21461@lst.de>
References: <20260806024658.4193386-1-sangyao@kylinos.cn> <20260806024658.4193386-4-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806024658.4193386-4-sangyao@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_011024_144255_CD15CC6E 
X-CRM114-Status: GOOD (  13.34  )
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

On Thu, Aug 06, 2026 at 10:46:57AM +0800, Yao Sang wrote:
> +static void blk_stack_path_limits(struct queue_limits *t,
> +		const struct queue_limits *b)

I find the path limits name a bit confusing, but I don't really
have a much better suggestion.

> +	t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);

overly long line here.

I wonder if we sould have a helper macro that encapsulates the

	t = min_not_zero(t, b)

pattern to make all these lines a bit easier to read while we're
at it?

>  	t->max_sectors = min_not_zero(t->max_sectors, b->max_sectors);
>  	t->max_user_sectors = min_not_zero(t->max_user_sectors,
>  			b->max_user_sectors);
> -	t->max_hw_sectors = min_not_zero(t->max_hw_sectors, b->max_hw_sectors);
> -	t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);
>  	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
>  					b->max_write_zeroes_sectors);
>  	t->max_user_wzeroes_unmap_sectors =

I'm also not sure why some limits are included in the path limits
and other not.  E.g. wy not max_write_zeroes_sectors?


