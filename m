Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D41EC3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jan 2024 08:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o2Bbwcds8+fk8r2Yt3WiywKU7P86nVhtJa1+6V9UCB4=; b=u2Ehn6GEj+ITcvS/yLiQwN3mUu
	1PocPWy1xF61yEU45UJz1UJwa93LIkHlYaVifdkpDkmzs1oYNuHuxQ59b1GmLn2HPKKTzFChhaZBC
	eyCvQ2qnGgxTGhFd6Z9O1HZdMsbYbFIv3HOee/MFqXhcqI6De6Ak+DNmybCTqAdfcZBOj5U6ezW0v
	hS1KgmXKH2BFyrGeLBzL1fJfW6Bl+DMAG2OA6oA54Ug807fJpTn4BWbxoL1alYAq0zYSJMt3pd2qP
	DEGmPDYLd2M/E6We7b0oncotzIA8pu1EE1uJVN9LljuUoQCf3kWtFwomQXcfXYcWIzivYPdHfIOcO
	QgoOKkkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMkyN-004IeP-1c;
	Mon, 08 Jan 2024 08:27:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMkyK-004Idl-1G
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jan 2024 08:27:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C617468AFE; Mon,  8 Jan 2024 09:26:57 +0100 (CET)
Date: Mon, 8 Jan 2024 09:26:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH] nvme: respect user max_discard_sectors setting
Message-ID: <20240108082657.GA4677@lst.de>
References: <20240104191244.737208-1-kbusch@meta.com> <20240105043401.GA23760@lst.de> <ZZgpTPl20kNebsFH@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZgpTPl20kNebsFH@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_002700_568394_12DBB3EE 
X-CRM114-Status: GOOD (  20.20  )
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

On Fri, Jan 05, 2024 at 09:07:40AM -0700, Keith Busch wrote:
> > blk_queue_max_discard_sectors updates the hardware and user limit.
> > It's a bit of a mess, but Jens didn't quite like my half-hearted fix
> > last time.  If we want to do this properly we probably need a separate
> > user limit and recalculate the effective limit when either the hw or
> > user limit changes.  For early in the 6.9 merge window I plan to redo
> > how all the limits are set, and that should give us a better opportunity
> > for these kinds of things
> 
> Cool, I look forward to seeing what improvements you have in mind for
> this error prone area. In the meantime, is this patch okay with you or
> is that a 'Nak'?

It's not a hard NAK, but I think this actually leaves us in a slightly
worse position than before.  So in doubt I'd not merge it.

