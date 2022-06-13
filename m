Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092ABC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jun 2022 15:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gK+0Yvkyx4spXFE1QbTV5x+Zw2I0D6y5gOD66yZh9xs=; b=3/z8B7Pm/EPnCJdyD4RC9ShzMU
	9/gz7ZqJYfNb1CThsHAe5jxE0e9RrNLb3PYC67DElM1RdauLnu6Iv9KDP8bDl3kUhcoaMnrQa1t8+
	xZfkdS5WLJVodCtvpMT58UspnaDN1sB3DC3cPCIoKtubpNnwwzg+/l0oluLKfoQbHt5A6GBfPEXNI
	afFEiruzb7QhzYYwHkFFzTjdlF/P76ofDbVYed9uVsU5gXWvb9F7k23Tgx6vvBiKvPSVf9Jwt9Iuc
	ttxgU24G9PiF7BCul3PskgcDTMZJvJr9wzjsBnFttR3B2Yr4oPs6x36CD3+7Orskz3j4qynMyrKdy
	KxQFaqjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0lis-004RT4-Pl; Mon, 13 Jun 2022 15:11:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0lcN-004Oer-Ph
	for linux-nvme@lists.infradead.org; Mon, 13 Jun 2022 15:04:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B000168AA6; Mon, 13 Jun 2022 17:04:32 +0200 (CEST)
Date: Mon, 13 Jun 2022 17:04:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCHv2] nvme: add bug report info for global duplicate id
Message-ID: <20220613150432.GA6424@lst.de>
References: <20220607153029.157439-1-kbusch@fb.com> <YqdPaiDGtg+JuBug@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqdPaiDGtg+JuBug@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_080440_062075_CA221824 
X-CRM114-Status: GOOD (  13.13  )
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

On Mon, Jun 13, 2022 at 08:53:30AM -0600, Keith Busch wrote:
> This problem seems more widespread than expected, so I think it would help to
> apply this patch now.

Yes, that's the plan.  But as Jens was out for last week I didn't
bother with a pull request.

> And since this appears to be a gap in compliance testing, I feel I should
> report this. I think UNH is still handling compliance certification.

UNH provides the test suite, but the specs are handled in the nvme
interoperability workgroup.  I already asked them to test this, but
nothing happened, but I think you asking again is definitively a good
idea.

