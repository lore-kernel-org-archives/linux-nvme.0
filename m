Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B487DC54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DUdweC4GDAyOiPhdZj7J9g6BZ4MwdI+RnObnmDW0L9I=; b=mKrGbGWYHxFY1fqyTN2p76HqTt
	FRa6ZlREQzSwcpwAEr23TtiUc9LPkzIEP+2XQJ/yX1iczHiiWI8JWiTQ42y7IHJ75trFK8zesN/iP
	mTxMwD96Skmv/CXq9/5v2T6xlBlpBqmyCNuBT6PHdU/ZihairqtWCaOhypVjjUcuYuEhDJyxTJ89P
	KKQwrNUEXkRGfaWXEoIMBVHqt6+lb62dgMn5M5jSE9GRNgXmWbTQdVPUsRToXTJjMXbladqf1MkM4
	k6/Z+nSu+tavxa/Y+10Kc9B1Ia+YoWsH15Nj4WtdBqebiZ7GU2AzQWFeOj0y6R816JaxkD+pcG32c
	+l37lWGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ric2H-00000009p6U-1oY4;
	Fri, 08 Mar 2024 15:21:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ric2E-00000009p3a-22Ab
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 15:21:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4CA3C68BEB; Fri,  8 Mar 2024 16:21:13 +0100 (CET)
Date: Fri, 8 Mar 2024 16:21:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Chandan Babu R <chandanbabu@kernel.org>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 06/10] ext4: switch to using blk_next_discard_bio
 directly
Message-ID: <20240308152112.GA11963@lst.de>
References: <20240307151157.466013-1-hch@lst.de> <20240307151157.466013-7-hch@lst.de> <ZennjRhWR2PVtoGU@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZennjRhWR2PVtoGU@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_072122_691900_547DE339 
X-CRM114-Status: GOOD (  17.94  )
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

On Thu, Mar 07, 2024 at 09:13:01AM -0700, Keith Busch wrote:
> On Thu, Mar 07, 2024 at 08:11:53AM -0700, Christoph Hellwig wrote:
> > @@ -3840,12 +3840,16 @@ static inline int ext4_issue_discard(struct super_block *sb,
> >  	trace_ext4_discard_blocks(sb,
> >  			(unsigned long long) discard_block, count);
> >  	if (biop) {
> 
> Does this 'if' case even need to exist? It looks unreachable since there
> are only two callers of ext4_issue_discard(), and they both set 'biop'
> to NULL. It looks like the last remaining caller using 'biop' was
> removed with 55cdd0af2bc5ffc ("ext4: get discard out of jbd2 commit
> kthread contex")

Yeah.  I didn't really want to dig so far into code I don't know well
for this series, though :)

> > +		while (blk_next_discard_bio(sb->s_bdev, biop, &sector,
> > +				&nr_sects, GFP_NOFS))
> > +			;
> 
> This pattern is repeated often in this series, so perhaps a helper
> function for this common use case.

Well, it's 2-3 lines vs 1 line for a much better interface.

