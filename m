Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA09C19F2D
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Aug 2022 07:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sGDXqPLn0OG2A/4gLSPl1aJYFkbcvETN9DO0aCUrFI8=; b=yHa5Rqfyj41VJI/hLP50E8WO0Q
	txg/sMbhv8IKdxHuXWveUDcD7l/YIjal8MYm6d2xgnrU93cgFIVG7IE7orzvTymMf2pEdwCTptlG2
	AuHLNJENmm87erZQBWltDuq+7YtpXJJUYZZ1yyQHJeWmvStztJoQOjhgN1Y3LubYb5DeNJsDWr6Zi
	2MJnWwQNXlCMLTzpAzH+an8JLkz/krNMHQLydE95nfQUwdvr70UtnQV4SAF3aQcIzCrEc5yDR+LsH
	7glnlDDELh4sfm/IGkWVuxmMbDbJa6As07GY08RbyUwZotIei7WEKHaGjeg6ybt1Z7vBaSvO0oFgS
	qZiwR3lQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM2Wg-008Nw7-RY; Thu, 11 Aug 2022 07:22:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM2Wd-008Nk4-RE
	for linux-nvme@lists.infradead.org; Thu, 11 Aug 2022 07:22:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5F78068AA6; Thu, 11 Aug 2022 09:22:32 +0200 (CEST)
Date: Thu, 11 Aug 2022 09:22:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@fb.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk, Alexander Viro <viro@zeniv.linux.org.uk>,
	Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCHv3 0/7] dma mapping optimisations
Message-ID: <20220811072232.GA13803@lst.de>
References: <20220805162444.3985535-1-kbusch@fb.com> <20220809064613.GA9040@lst.de> <YvKPTGf56v/3iSxg@kbusch-mbp.dhcp.thefacebook.com> <20220809184137.GB15107@lst.de> <YvPzUSx87VkwSH2C@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvPzUSx87VkwSH2C@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_002240_074401_33094506 
X-CRM114-Status: GOOD (  25.18  )
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

On Wed, Aug 10, 2022 at 12:05:05PM -0600, Keith Busch wrote:
> The functions are implemented under 'include/linux/', indistinguishable from
> exported APIs. I think I understand why they are there, but they look the same
> as exported functions from a driver perspective.

swiotlb.h is not a driver API.  There's two leftovers used by the drm
code I'm trying to get fixed up, but in general the DMA API is the
interface and swiotlb is just an implementation detail.

> Perhaps I'm being daft, but I'm totally missing why I should care if swiotlb
> leverages this feature. If you're using that, you've traded performance for
> security or compatibility already. If this idea can be used to make it perform
> better, then great, but that shouldn't be the reason to hold this up IMO.

We firstly need to make sure that everything actually works on swiotlb, or
any other implementation that properly implements the DMA API.

And the fact that I/O performance currently sucks and we can fix it on
the trusted hypervisor is an important consideration.  At least as
importantant as micro-optimizing performance a little more on setups
not using them.  So not taking care of both in one go seems rather silly
for a feature that is in its current form pretty intrusive and thus needs
a really good justification.

> This optimization needs to be easy to reach if we expect anyone to use it.
> Working with arbitrary user addresses with minimal additions to the user ABI
> was deliberate. If you want a special allocator, we can always add one later;
> this series doesn't affect that.
> 
> If this has potential to starve system resource though, I can constrain it to
> specific users like CAP_SYS_ADMIN, or maybe only memory allocated from
> hugetlbfs. Or perhaps a more complicated scheme of shuffling dma mapping
> resources on demand if that is an improvement over the status quo.

Or just not bother with it at all.  Because with all those limits it
really does not seems to be worth to an entirely need type of bio
payload to the block layer and a lot of boilerplate to drivers.

