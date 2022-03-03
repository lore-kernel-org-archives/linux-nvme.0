Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA0AC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Mar 2022 17:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8GmHcp7UYM5jzfE82mCmFQrySmVJI5kO5vBihkm3jYM=; b=OC4jbjCNzLhCwxummcJK3O6VDU
	5FnMHU/SVQbaie0ntY5Kh/tuT9Yu5aDhqAkZPsS4ZTyYa1O6nhlC3gyB0PQrZLNXLPH8DjRmy4tqi
	hXZT/dgDIVPNRtUHmKNanhkV6kAltW1xfM8YMxjVBZuHNRP/cw/FPS1K0y3Ucf0UedSVYO0drgnPE
	yv2cfoU5Bq2fqgJqOk8xO32uzirCz1yOgLjJtH2Xyd+/M6h+1i4F4RCB3xYUW5dnEm57gPLVuo4nQ
	q2degp++ZzHAM7gxsd4jRrYOG/Hg/VZw2E3tpFUD/HCuSoCuDsVVgLp8FqeeGUKV1Wb31O8o6awBo
	SkUb8G0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPphU-007PQj-8P; Thu, 03 Mar 2022 17:57:16 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPphR-007PQP-Mt
 for linux-nvme@lists.infradead.org; Thu, 03 Mar 2022 17:57:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6B78668AFE; Thu,  3 Mar 2022 18:57:08 +0100 (CET)
Date: Thu, 3 Mar 2022 18:57:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: remove support or stream based temperature hint
Message-ID: <20220303175708.GA21793@lst.de>
References: <20220303105049.315987-1-hch@lst.de>
 <20220303144208.GA2367645@dhcp-10-100-145-180.wdc.com>
 <c7be737d-9cf1-83b7-94f8-f4f0e3786eac@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7be737d-9cf1-83b7-94f8-f4f0e3786eac@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220303_095713_940783_5DA6533E 
X-CRM114-Status: GOOD (  15.70  )
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

On Thu, Mar 03, 2022 at 07:50:05AM -0700, Jens Axboe wrote:
> > And without nvme, there doesn't appear to be a real user for the
> > write_hint anymore. All you can really do with it now is prevent
> > merging, which doesn't seem useful.
> >
> 
> Yes, I would suggest that we just prune the write hint and just leave
> the fcntl() ops as stubs as a followup patch.

So we need to keep i_write_hint anyway for f2fs, but the block layer
removal is easy.  It has some conflicts with other work, what tree
would you like it against?

