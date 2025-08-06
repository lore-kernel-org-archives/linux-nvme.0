Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23567C87FD3
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Aug 2025 15:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lpeDX7wvpLWtHi+pBJ/XLo6+IPiozT01pfnUdKNoPQU=; b=Vm63PPWmkFZJdam8ouzM5PIG2e
	kbXxyHJJeWtaUzOoVjjWZbzIMPStyvlytR2kyI1v4u9Ojl16Q+3137UMkruab17Ruoj9rSuGSroVk
	ruLzqCp3E7I076PprnG+VBE3pt9I4Yfosz1RQ1RSWOrFXR2L7R15cwOoI/d/IXjPu57W1pGB0A3C+
	oQ5kvzbhMMxGzAMajoHrbGoZOETNHbIGgIreB4Q1dA8nbvEoh1wO4OnPDzCzTGOEQfDnkxzVm5Xmv
	43GzCRTh1eYUopSPu6Tzxod1LeTAuaDKFixyXlOgO7BSlwOzYaW9+LCmBWs/C5123NF7pIJoyG0Q2
	PKMolGig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujgX2-0000000Fgg9-0bG9;
	Wed, 06 Aug 2025 15:58:24 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujgJv-0000000FePS-0U3f
	for linux-nvme@lists.infradead.org;
	Wed, 06 Aug 2025 15:44:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 030135C5EAB;
	Wed,  6 Aug 2025 15:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4825DC4CEE7;
	Wed,  6 Aug 2025 15:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754495089;
	bh=uKdAPwLRahqr9w+gCnjr/ezk+JdtxLnUTz4ylfHc++c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NtDaW1/+e3aK9+fmIYGksRBd7sOU1DrSftOfN1AxcM/Obn/EFPFvAuoQpAV8bD5Mk
	 a660SJdCCCriKC6sCuYlNED6zd4jiRI7sI5TxuxQXFi5j3JOIEoVgmW0sXVH3hZt2P
	 xDrcMAGDQQm0PkPiLFNUvtwVNs34oT7AkRxukkZqJLZHw0q6aKwRDCBBRKVY+FL2kl
	 CCb48MzixOeTmz0Xzz9acCDpbdOp2FIcbSuvTCcfqBsbCKVkvi3wBrRxXWE8NcVDS6
	 aEWx65DS5fWRDvu3gom1zC29EluoLIqUnwR08R+t4bTZl85lQ/u4Iv11j7l6A2Bs2r
	 QVHKYzHGyGQmQ==
Date: Wed, 6 Aug 2025 09:44:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk
Subject: Re: [PATCH 1/2] block: accumulate segment page gaps per bio
Message-ID: <aJN4b6GS30eJdQLd@kbusch-mbp>
References: <20250805195608.2379107-1-kbusch@meta.com>
 <20250806145621.GC20102@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806145621.GC20102@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_084451_189488_8A1F1F73 
X-CRM114-Status: GOOD (  15.20  )
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

On Wed, Aug 06, 2025 at 04:56:21PM +0200, Christoph Hellwig wrote:
> > index 0a29b20939d17..d0ed28d40fe02 100644
> > --- a/include/linux/blk_types.h
> > +++ b/include/linux/blk_types.h
> > @@ -264,6 +264,8 @@ struct bio {
> >  
> >  	unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */
> >  
> > +	unsigned int		page_gaps;	/* a mask of all the vector gaps */
> 
> Bloating the bio for the gaps, especially as the bio is otherwise not
> built to hardware limits at all seems like an odd tradeoff.

Maybe, but I don't have anywhere else to put this. We split the bio to
its hardware limits at some point, which is where this field gets
initially set.

It doesn't need to be a mask (though that conceptually is the most
intuitive). It really just needs to indicate the lowest set bit of any
page gap between segments. There is a one byte hole in the bio that can
fit it without changing the bio size.

