Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454F9CD5BD5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 13:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pMBavffiZSnRm2SoY87F2ixUkUHdGCw3hRW7BgBJuUs=; b=Tzxnd+76kQEieau9d7FdObaYX/
	wkIYs8l4z8DuYB3pWnzHQP3loU+W11LcljnLwpT30KDr9Qib6QBwTP61Bmm9bbYgzoRjDeRuo1Niw
	EXmZX80k5WrHaefYY+oYseMFWiul/l9jM0qIv3GNkElyGJ4xpc4pctA4nFgKK51n/Kg0ZK25/rNda
	25oVR5dARUIqpnmZh5nWIMdJ1mPtBmijjPzrlnrs1xErbPzfq1uFgfilAvHeNh1ZfCXaJfvNGCQNK
	iRAbxJ8ZSK9zWT/un1NRLr6hNLKQLjbxBI7M5INVOSoi/07JoZawkicT25WgwuHVq5qXz/YjEZ7Tk
	Vkq5NW5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSED8-00000004BFb-3wyk;
	Wed, 27 May 2026 13:22:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSED8-00000004BFV-23Hd
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 13:22:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7B4C36012B;
	Wed, 27 May 2026 13:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E330E1F000E9;
	Wed, 27 May 2026 13:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779888133;
	bh=pMBavffiZSnRm2SoY87F2ixUkUHdGCw3hRW7BgBJuUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N0KDI8oIyMcqZYtRTHjWMP4UhTdnoLGBE4fLS+2hbONXogf3hE9PuhV9xWFqqL1rz
	 kVyIoj9EQzTcPHpgptYVoSrQNhbi+5lGEtAHkAMz/oRSdZFisVvb5uf/8lbwuUJs//
	 8cqleVo66V6WibUhqORZyFNoVeJxjLtCSSRRo/6W/4fywp0/kefH92F/2BxH1qXTzU
	 WJ1gVg3bb57Z1HuqawKHRv0Z604RrIhdotPDkjxNZpeUlk9unFz6EpTGMcqUSldFHP
	 YK8+AlJUVeTZw0Uc1wwp1PtXpLZcbMdaMrh3QEFwF8FNSyTP2uDQt7roInS2lHHCzS
	 YUguD3lguAuKQ==
Date: Wed, 27 May 2026 07:22:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	nilay@linux.ibm.com
Subject: Re: [PATCHv2 1/2] block: export passthrough stats enabled
Message-ID: <ahbwAxG1Pj2z3Q21@kbusch-mbp>
References: <20260526153921.2402015-1-kbusch@meta.com>
 <20260526153921.2402015-2-kbusch@meta.com>
 <20260527131458.GA10351@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527131458.GA10351@lst.de>
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

On Wed, May 27, 2026 at 03:14:58PM +0200, Christoph Hellwig wrote:
> > +static inline bool blk_rq_passthrough_stats(struct request *req,
> > +					    struct request_queue *q)
> 
> The kerneldoc requested last time would be really nice to have.
> Also, now that this is a public API killing the q argument and
> just using req->q would make the API easier to understand.

Oh, my missing kerneldoc is clearly a problem. We need a separate
argument for the request_queue because the q we want to count stats for
may not be the one providing the request. For nvme multipath, we want to
count stats against the head's request_queue, but the request comes from
the ns path, so we need both args.

