Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDF7C83F27
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jul 2025 06:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ehy6hUp1kz0pFsTwkR8JoJ2x3t/8iTZNHHHKGUSHiE8=; b=NxOUjYzd/zVv+pcNbbrDBMx4Nq
	WabYRXjFLSNqviwdVG2XrYZqBTiDfcD952EfJi+n3KboI4Ur7LIHQNIuzkowX9L0cTRTIOXLTlHlF
	0owbDrTjjyWXtz7fmL8zhxt9hGtzG9ZfI5QqcNU7FGJWc729rdb4p5zVAAyRN83KB0dFtordlNgLv
	YkEKbYG95gfrc2HgMkiOcYXSLmm0UMpBhB/3y5mGKqSkSIzN5KfK8ZK1MZEKEdbZjhRVAIFDXiSmc
	suWiQM2ND8Zc9tNg35rnw2p15nna8iRlWVd30BGLBDdqJ0feaUoq2Ct8977/eGmh3qpY9jWuwR8io
	2LKJrRBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udjye-0000000GMZB-3eh3;
	Mon, 21 Jul 2025 06:26:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udjyc-0000000GMWb-2pCi
	for linux-nvme@lists.infradead.org;
	Mon, 21 Jul 2025 06:26:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7425B68AFE; Mon, 21 Jul 2025 08:26:00 +0200 (CEST)
Date: Mon, 21 Jul 2025 08:26:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <joel.granados@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Klaus Jensen <k.jensen@samsung.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/8] nvme: Add Controller Data Queue to the nvme
 driver
Message-ID: <20250721062600.GA28867@lst.de>
References: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org> <20250714130230.GA7752@lst.de> <fjnpyvjn2kqlmlzagvuy43numc7u44ylls3nqxay4sh5qjayv5@xq2ty7wipbg5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fjnpyvjn2kqlmlzagvuy43numc7u44ylls3nqxay4sh5qjayv5@xq2ty7wipbg5>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250720_232618_853654_29054795 
X-CRM114-Status: GOOD (  22.90  )
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

On Fri, Jul 18, 2025 at 01:33:34PM +0200, Joel Granados wrote:
> > to win a point.  So for CDQs to be useful in Linux we'll need the
> > proper live migration still under heavy development.  With that I'd
> Do you mean in the specification body or patch series in the mailing
> lists?

Actual code.  As I said I very much expect CDQ creation and usage
to be kernel driven for live migration.

> > very much expect the kernel to manage the CDQs just like any other
> > queue, and not a random user ioctl.
> This is a great segue to a question: If CDQ is like any other queue,
> what is the best way of handling the lack of CDQ submission queues?
> Something like snooping all submissions for these CDQs and triggering a
> CDQ consume on every submission?

I don't understand this question and proposed answer at all all.

> I went with the ioctl as the faster way to get it to work;

Get _what_ to work?

> I might
> explore what having it as just another queue would look like.
> 
> > So what would be the use case for a user controlled CDQ?
> Do you mean a hypothetical list besides LM in NVME 2.2?

As out line in the last two mails I don't see how live migration would
work with user controlled CDQs.  Maybe I'm wrong, but nothing in this
thread seems to even try to explain how that would work.

