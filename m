Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6EDD1CDA0
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 06:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TxRu51uOjMTFwCNK15sTcL7CXnKMlXhIeygx7d6Eq/w=; b=ffvDFGx1YPQDhxnB6Pk/ZIfl+Q
	sgd26ozYH+rCgWYexuadSegdE96fyF1nXh+mFpMFzfruQbP+bikUhrOVbfNbELBKYUteiZky9+qPY
	hs1aL0YZx4iISBBShK9W1lmJIqM1XHtuE61PQIHzm/JbOwpeROcQJhQp/z3GUHE0SpumXE3CPFSyz
	Odkua2GqYrFqg6Goiz6fnUvtdykmSqRnugGD/bG1v5hr1LMC9ONs0b4JMAFr0EhvjEo/sYPfqMs0c
	Hdns01rIndDmbz5jIirAxlwcjyPcuydefKP6S+mHWMUbbfVxtg0FJAQ4mTX/DPqoJ/8OApSLN2FRI
	pd0P/4QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t37zV-00000009k9u-2FC5;
	Tue, 22 Oct 2024 06:03:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t37yd-00000009jt4-27KF
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 06:02:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B7BD0227AA8; Tue, 22 Oct 2024 08:02:33 +0200 (CEST)
Date: Tue, 22 Oct 2024 08:02:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, krisman@suse.de, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v4 07/11] io_uring/rw: add support to send meta along
 with read/write
Message-ID: <20241022060233.GA10327@lst.de>
References: <20241016112912.63542-1-anuj20.g@samsung.com> <CGME20241016113747epcas5p4e276eb0da2695ba032ce1d2a3b83fff4@epcas5p4.samsung.com> <20241016112912.63542-8-anuj20.g@samsung.com> <20241017081057.GA27241@lst.de> <20241021053110.GA2720@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021053110.GA2720@green245>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_230243_708132_80086F78 
X-CRM114-Status: GOOD (  29.75  )
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

On Mon, Oct 21, 2024 at 11:01:10AM +0530, Anuj Gupta wrote:
> > What is the meta_type for?  To distintinguish PI from non-PI metadata?
> 
> meta_type field is kept so that meta_types beyond integrity can also
> be supported in future. Pavel suggested this to Kanchan when this was
> discussed in LSF/MM.
> 
> > Why doesn't this support non-PI metadata?
> 
> It supports that. We have tested that (pi_type = 0 case).

What other metadata except for PI and plain non-integrity data
do you plan to support?  This seems like a weird field.  In doubt
just leave reserved space that is checked for 0 instead of adding
an encondig that doesn't make much sense.  If we actually do end
up with a metadata scheme we can't encode into the pi_type we can
still use that reserved space.

> 
> > Also PI or TO_PI might be
> > a better name than the rather generic integrity.  (but I'll defer to
> > Martin if he has any good arguments for naming here).
> 
> Open to a different/better name.

metadata?

> > > +	/* Exclude meta IO as we don't support partial completion for that */
> > >  	return req->flags & REQ_F_ISREG ||
> > > -		S_ISBLK(file_inode(req->file)->i_mode);
> > > +		S_ISBLK(file_inode(req->file)->i_mode) ||
> > > +		!(rw->kiocb.ki_flags & IOCB_HAS_METADATA);
> > >  }
> > 
> > What partial ocmpletions aren't supported?  Note that this would
> > trigger easily as right now metadata is only added for block devices
> > anyway.
> 
> It seems that this scenario is less likely to happen. The plumbing
> seemed a bit non trivial. I have the plan to look at it, once the
> initial version of this series goes in.

I still don't understand what this is trying to do, especially as
it is dead code with the checks above.

> > 
> > > +	if (unlikely(kiocb->ki_flags & IOCB_HAS_METADATA)) {
> > 
> > For a workload using metadata this is everything but unlikely.  Is
> > there a specific reason you're trying to override the existing
> > branch predictor here (although on at least x86_64 gcc these kinds
> > of unlikely calls tend to be no-ops anyway).
> 
> The branch predictions were added to make it a bit friendly for
> non-metadata read/write case. 

Throwing in these hints unless you have numbers justifying them is not
a good idea.


