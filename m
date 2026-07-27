Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A12C53209
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 19:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V6q7CtGOOXMQTu5vNg7sea9a4Y5hhuIlF+3IDYB5PdI=; b=BqqotgLd/QAZx1Pu2ETk5kSxCe
	ZMKCjTQjPWCiWm4Ak8izAyzt9+i94jXNqtaVRA728fNDjnf/FgIwK6XRC+E6Giu3kLWSJM/47mg7+
	q6+uMvL7HkiruxVeSKd3z5fjmYE8QO+DohR+r01oIvAM66Xejbz5f5MMm/bvWtyt0yMO+lzxUzsjL
	swZnFGbdix2iy5mi2BV0d0EyXCIN5myUkISWR890g6T18SEIs3JO6nP8oReuf+6Z0MlVF+bxeY4tI
	jyVm6nF2Va0mmi6PFnFG82uuDscEhf0OxE1sq6Iad+Oqmqyxl4VYGFEc8p2CnOi+pPw3gvNGxyUG2
	zLqZ2Yuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woQrV-00000003kJt-1Krq;
	Mon, 27 Jul 2026 19:19:41 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woQrU-00000003kJk-2DZu
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 19:19:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 28EC942A06;
	Mon, 27 Jul 2026 19:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C01C1F000E9;
	Mon, 27 Jul 2026 19:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785179980;
	bh=V6q7CtGOOXMQTu5vNg7sea9a4Y5hhuIlF+3IDYB5PdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WZs5+wd3ep+px3IOCgx12eVRKM1PP9E2Sfr9fhBlr9vz77DoiAhZvHOmWylhSicJ/
	 BgvpjJquBih399wjk5Jf6oX9GBVrA44Z29Mk+EeGwBuzVYNqyPtzJ6ORIg430U/xXw
	 PrMXjsmOaTFW+Le8Xk2/CsYQuAIxTJhR02ljc7v4=
Date: Mon, 27 Jul 2026 21:19:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Hari Mishal <harimishal1@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: drop WARN_ON_ONCE on write_stream bounds check
Message-ID: <2026072748-unpopular-onlooker-4a2b@gregkh>
References: <20260725135111.14041-1-harimishal1@gmail.com>
 <20260725135111.14041-3-harimishal1@gmail.com>
 <amdqKEI44SKwq-K2@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amdqKEI44SKwq-K2@kbusch-mbp>
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

On Mon, Jul 27, 2026 at 08:24:40AM -0600, Keith Busch wrote:
> On Sat, Jul 25, 2026 at 03:51:11PM +0200, Hari Mishal wrote:
> > write_stream is validated against bdev_max_write_streams() in both
> > generic block direct I/O (block/fops.c) and F2FS before a bio
> > carrying it is ever built, so write_stream > nr_plids shouldn't be
> > reachable through any current legitimate path. The remaining users
> > of bio->bi_write_stream elsewhere in the block layer only copy an
> > already-validated value between bios (bio.c, blk-crypto-fallback.c)
> > or compare it for merge eligibility (blk-merge.c); none of them
> > introduce a new, unvalidated value.
> > 
> > Using WARN_ON_ONCE as the backstop for that assumption isn't worth
> > it given how many deployed systems run with panic-on-warn enabled;
> > the existing graceful return BLK_STS_INVAL already handles it on
> > its own.
> 
> That's not a very good reason to remove a WARN_ON. You've left the check
> in for a condition that should never happen, so when it does happen,
> it'll be impossible to debug without the WARN.
> 
> And the WARN also annotates the branch as unlikely, which is desirable
> for this case.

But, if it ever does happen, a WARN_ON will reboot the box, given that
billions of Linux systems have panic-on-warn enabled.  So if this can
ever happen, just properly handle it and recover and don't loose user
data.

thanks,

greg k-h

