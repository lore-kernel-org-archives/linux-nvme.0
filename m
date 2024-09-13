Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2990FA372A
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 08:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oEeV1sbzLAtDYxQWJxm7FS6uaKIISmSEVCYRh8rE8tE=; b=wHKZtvChuj/WloxMu61iqwIqEw
	8pZf2edc7W33VnkHRcplRJf7eojeU7V7qUFQhijin7Fj0rKUZKsnV1PFZPDJW5KAgfgyRfxNwNuuI
	4c8a051Y1Oqh6B8zUdHdQANGjsrvryytUA9kAORJJGp21rCoiddxeHBlOHualaPmQM9n04o2o39Fk
	UcDCUg1hr5YLOHUGqdIxqw2C6msyBuvU+vMJodOI3Mr2k+3O/ake3snS7oPy7pjemBTeIffj8yLQs
	nXoyW3LDk97ZA6zWQsC7f5xerNB/htR9FPnd3jIz7Uz602zIvVhgR5pnxoY/8oUr1vCyuQRw5ayGT
	yw/CFZlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp1Ml-0000000FIN0-2SpT;
	Fri, 13 Sep 2024 08:09:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp1Kd-0000000FHt4-0peD
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 08:07:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3DAE2227ABD; Fri, 13 Sep 2024 10:07:00 +0200 (CEST)
Date: Fri, 13 Sep 2024 10:06:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	jlayton@kernel.org, chuck.lever@oracle.com, bvanassche@acm.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com,
	vishak.g@samsung.com, javier.gonz@samsung.com,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v5 4/5] sd: limit to use write life hints
Message-ID: <20240913080659.GA30525@lst.de>
References: <20240910150200.6589-1-joshi.k@samsung.com> <CGME20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c@epcas5p3.samsung.com> <20240910150200.6589-5-joshi.k@samsung.com> <20240912130235.GB28535@lst.de> <e6ae5391-ae84-bae4-78ea-4983d04af69f@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6ae5391-ae84-bae4-78ea-4983d04af69f@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_010707_551786_7BEF29E9 
X-CRM114-Status: GOOD (  29.67  )
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

On Thu, Sep 12, 2024 at 10:01:00PM +0530, Kanchan Joshi wrote:
> Please see the response in patch #1. My worries were:
> (a) adding a new field and propagating it across the stack will cause 
> code duplication.
> (b) to add a new field we need to carve space within inode, bio and 
> request.
> We had a hole in request, but it is set to vanish after ongoing 
> integrity refactoring patch of Keith [1]. For inode also, there is no 
> liberty at this point [2].
> 
> I think current multiplexing approach is similar to ioprio where 
> multiple io priority classes/values are expressed within an int type. 
> And few kernel components choose to interpret certain ioprio values at will.
> 
> And all this is still in-kernel details. Which can be changed if/when 
> other factors start helping.

Maybe part of the problem is that the API is very confusing.  A smal
part of that is of course that the existing temperature hints already
have some issues, but this seems to be taking them make it significantly
worse.

Note: this tries to include highlevel comments from the discussion of
the previous patches instead of splitting them over multiple threads.

F_{S,G}ET_RW_HINT works on arbitrary file descriptors with absolutely no
check for support by the device or file system and not check for the
file type.  That's not exactly good API design, but not really a major
because they are clearly designed as hints with a fixed number of
values, allowing the implementation to map them if not enough are
supported.

But if we increase this to a variable number of hints that don't have
any meaning (and even if that is just the rough order of the temperature
hints assigned to them), that doesn't really work.  We'll need an API
to check if these stream hints are supported and how many of them,
otherwise the applications can't make any sensible use of them.

If these aren't just stream hints of the file system but you actually
want them as an abstract API for FDP you'll also need to actually
expose even more information like the reclaim unit size, but let's
ignore that for this part of the discssion.

Back the the API: the existing lifetime hints have basically three
layers:

 1) syscall ABI
 2) the hint stored in the inode
 3) the hint passed in the bio

1) is very much fixed for the temperature API, we just need to think if
   we want to support it at the same time as a more general hints API.
   Or if we can map one into another.  Or if we can't support them at
   the same time how that is communicated.

For 2) and 3) we can use an actual union if we decide to not support
both at the same time, keyed off a flag outside the field, but if not
we simply need space for both.

