Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D868ECD5BD1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 14:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m12Vxo2H2d4KoGaA1BQJGaM3/ydK43e+ILXqW0gMDU4=; b=FEOkc2Rw3D1fKrwGJEsvWLimvw
	v6olSu1+A23xP/8SkuEhfoVvQBr7YPewJRevJi9VrGYisAC1c0sYvbXc60wUrxrbeEquL5aco5EcU
	OlcudpzlmNocKhciRPSl1B6KTNavp4WghurU0Boa49Am7+ngJAfjUNQ5SLYBzil7qeTWJsGMjb0Bj
	u3fNqXgq8FdvHUSh9NxQlZgICbS2N+Zoei+QHNqKei3N9pyq89UCDbsinLH/3M6HP4BPcfdfLUTds
	P5QpFXmBE618hPsF2UDZtKpxTZP1eIicJTgeiFA/ICVgtcyAkonTkgPpWS/pknF8wTL3JgIhw07X6
	RyYnwtkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU3xQ-0000000BJKw-1I6H;
	Mon, 01 Jun 2026 14:49:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU3xN-0000000BJKV-2nz7
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jun 2026 14:49:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8170868BFE; Mon,  1 Jun 2026 16:49:29 +0200 (CEST)
Date: Mon, 1 Jun 2026 16:49:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tianchu Chen <tianchu.chen@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, hare@suse.de, sagi@grimberg.me,
	kch@nvidia.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-auth: validate reply message payload bounds
 against transfer length
Message-ID: <20260601144929.GB5054@lst.de>
References: <f4aca9b14e74a7f7f8cd9620e13cc32a6a2b7746@linux.dev> <20260601071921.GB7582@lst.de> <c023c72aa183dd31fc9a2d7e9781c5551d5cdb9f@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c023c72aa183dd31fc9a2d7e9781c5551d5cdb9f@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_074933_872777_70BAB207 
X-CRM114-Status: GOOD (  19.51  )
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

On Mon, Jun 01, 2026 at 08:58:18AM +0000, Tianchu Chen wrote:
> I think the current patch doesn't actually allows overflow.
> 
> hl is a __u8 and dhvlen is a __le16. So the maximum value of
> sizeof(*data) + 2 * (size_t)data->hl + dhvlen
> is 66061, which is far below SIZE_MAX. It can't wrap.

True.

> 
> About rewritting using struct_size: we still need to check
> tl >= struct_size(data, rval, 0) first,

Yes, or the existing sizeof.

> which is exactly the same
> as just using sizeof(*data) in current patch. Because we have to
> confirm the header is fully present before we can even read
> hl / dhvlen, which are the values that determine the minimum
> required rval[] length.
> 
> So I believe the current patch already achieves the intended
> goal of validating the payload against the buffer size,
> using struct_size won't change the behavior.

I find untangling magic numbers a bit hard.  Now unlike more
conventional cases we're stuck with some of them, but trying
to make the expression as self-describing as possible would
still be nice.

> That said, I'm happy to send a v2 that uses struct_size(data, rval, 0)

For the anchor that's not all that useful.

Anyway, let's keep the original version for now.  I noticed there
is more of that 2 * magic in surrounding code, so we'll need to
address that separately instead of burdening it on you.


