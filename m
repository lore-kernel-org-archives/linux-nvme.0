Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B44C3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jul 2024 17:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uLk5AYcnqTui0+7pP8Xrn3qN9bM9SJWOSw8c/tbWTZQ=; b=d5DJaYbGHqhU8FXMcAdTJYxiu8
	4jkPJuWZyFkOeNfafBW2ZUqyb1gOCpbnQ2NsNIMetJJ82dg5n/8ZBDrZMcWdYEjIyeD8JK+p09FK7
	yh+MmDqRAJkoq27Eg8bEcZ/77x/jv1697Ehmal1TQ3tgROLx8cILDCEI1LQsg3sKtDP2K+8tIIcHD
	AskLM9DBOsVYCnCte6GaMzHuOEGbK303wzjfJOaIMWOrdjtEZ2u9/wSg+2awmwes12txkh1FArzz3
	VH047BYIPF4NdsLxVI99jdQNNdit2M/mCkk6gOZ55xe+NTuWKz3EhdL7fSi85QIs2Px51pX5oqrvy
	slBezDiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYqj1-0000000G2Af-3Qb9;
	Tue, 30 Jul 2024 17:33:27 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYqiy-0000000G2A1-00Mk
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jul 2024 17:33:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2411DCE10FC;
	Tue, 30 Jul 2024 17:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D5BC4AF0A;
	Tue, 30 Jul 2024 17:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722360801;
	bh=4KMuEZm5R4J/RzKmjWI6KHgNwuAYrDoI9sUkj0rxfew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dny4sCfxXZS+GgDPf7YE0V1Vhv4OT50CxYykBZt86KqVJjnB7cGUkybQkgsIQQoCn
	 b1DQk4BeYoKdUTugLfF3AQLJ+TmMKWdtYiAaHItqGjH3cBY3zFzhKiM1qmzLuxjZcY
	 z3tuHTlvVYXE1SBTWcfYjO48/gl/L3TOtzig1lkigx6xRdDFKwYrX3meqwCLe7mmeJ
	 8D+iK3W0xZDVv73FAtROahJSaQZsLVeOJP4NXtcPJyvwPW/6yYzu2/siFXLPAd4GKc
	 iB9OBxOnkwyKI84GY7TvkJxMuvkMMzr3bsvaUWeGIf8sprhjA0I13ttD0zJ4ePqJmE
	 e+jg4j2KvI+FA==
Date: Tue, 30 Jul 2024 11:33:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leonro@nvidia.com>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add missing condition check for existence of
 mapped data
Message-ID: <Zqkj3hUnsjGgzBE4@kbusch-mbp>
References: <23e8ca814177474160a516e09b562af339cec837.1721816805.git.leon@kernel.org>
 <ZqkeMJ5PPETMb5d3@kbusch-mbp>
 <20240730172111.GA32320@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730172111.GA32320@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240730_103324_240259_E528C94C 
X-CRM114-Status: GOOD (  19.31  )
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

On Tue, Jul 30, 2024 at 07:21:11PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 30, 2024 at 11:09:04AM -0600, Keith Busch wrote:
> > > +	if (blk_rq_nr_phys_segments(req))
> > > +		nvme_unmap_data(dev, req);
> > 
> > This is already applied, but it is kind of strange. We get here only if
> > metadata mapping fails. Is there actually a command that has metadata
> > without data?
> 
> Well, passthrough can always set metadata to map without data even
> if there is no NVMe defined command that works that way, so we should
> handle the error.

That's what I initially thought too, but nvme passthrough maps metadata
only if there's also user data. It doesn't look like you can even build
a request to have metadata if it doesn't have user data: where does the
bio come from in that case?

And generic block stack maps it only for READ or WRITE commands, which
must have payloads too, so I didn't find a path to reach this condition.

Not a big deal, the patch is fine, but I was wondering if we need to
change something else to allow the conditions it proposes to fix.

