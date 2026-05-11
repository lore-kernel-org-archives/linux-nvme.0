Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4B2CD37AC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 08:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fSr+jG7w28PBK0QLpfOlYmN+owMnjbiSdp6FTfFlFWg=; b=wDmjDaaLmjXxgFQgiAGRLqmyan
	c+qUpF5vxbCrqOFJWZE7Q3gajA9xam5QofTLCn5gYPRRYU84UXAZLz16TyJEY6C/qH7Td039NhcR3
	gDHeD7E3RKIFycVT6LYKIBK/C65snuzqp479QqWLuXRON5maJ4nIfvcpSH4L50MoTBTAnJuBkfA+Q
	R1D3shTYI5t91lHkJL7ET7jQ7/PIgm3CQ75Y6Xibym+KuxqHzABj4xWc8EvGyfkizDSnEcbQfxWaQ
	mITa3dlfM+bZEcMZLBtv6fvCkMcp7nErFroi6Zj2n0LwDfbRHWowQr89jOQ8aLeX+TwTHN9UniWpq
	dWpuTYtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLn1-0000000Cj9q-1FNM;
	Mon, 11 May 2026 08:14:59 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLmz-0000000Cj9J-0KXt;
	Mon, 11 May 2026 08:14:57 +0000
Date: Mon, 11 May 2026 01:14:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Rohit Chavan <roheetchavan@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: use str_enabled_disabled() for digest mismatch
 messages
Message-ID: <agGQAU0K_9PBj6k7@infradead.org>
References: <afwj1aZteJRqnKxs@infradead.org>
 <20260508094734.2032284-1-roheetchavan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508094734.2032284-1-roheetchavan@gmail.com>
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

On Fri, May 08, 2026 at 03:17:33PM +0530, Rohit Chavan wrote:
> Hi Christoph,
> 
> Thank you for the feedback.
> 
> My intent was to align the code with the standardized string helpers 
> recently introduced in the kernel to reduce open-coding. However, 
> I respect your preference for keeping the ternary form in the 
> NVMe subsystem.

I guess it's more of a question for the people adding the helpers, but it
should also be in any place converting to it:  what's the point?

The helpers don't reduce the code size, but increase cognitive load.  Not
a good trade-off as far as I can tell, but maybe I'm missing something?


