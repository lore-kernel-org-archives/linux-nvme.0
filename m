Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AEDD711D1
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2024 17:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WA9z4wj5HnQQ90Qg0zsZ+x7lAFaOXcjSgVjyerwaRkE=; b=HNTFIVqKevUB+EOmjeBZyhE3Zd
	S8VezIooEZOJEf+R431eTA0SRnl/YHb1xta603kksGDNQ+/uwnGTwFzrcCliaSQes7pcSnr245/7x
	+2rf+qnWmRwzR8L8V6LzJ6QTVWZf0VXrq7UZ81I45sktyHqtYTiq0TwXr4lPbWLJKpzArPEvG9ebF
	+V35wfz9YXgB87gQJE7n4lZddzZ0gum4/sbLRLcYilNxFpYjoYPsKvgOtMQGJtoELDJwWDcCj+9kx
	Xx58PYl7ocatt0o05qadduHQ95KF4eFutz4UJGXpKb+Mq4i8aZbZoPPfe5nCRzhf7kJk+4LSc0VqV
	FgRhatdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDobq-0000000FwYC-0UKi;
	Wed, 20 Nov 2024 17:35:22 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDobn-0000000FwXY-2pyp
	for linux-nvme@lists.infradead.org;
	Wed, 20 Nov 2024 17:35:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8658AA432DF;
	Wed, 20 Nov 2024 17:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9551EC4CECD;
	Wed, 20 Nov 2024 17:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732124118;
	bh=zhUb1iqG0sWlDdOWsUtyWjkBDoFZXFk2BYB6s8NvcW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LLUzD5nAaUwl9vXY+3MQc8Sg4ssq4q4ByVc9JI2Y4n+Yt1kif7fKNsX1iw9qBALKd
	 jrOIX3vDsp2ybevJ8zF9wEi7L09s4rgIFxHzejp/m2+yh18lWnuoB2Svmu6jQL7+t3
	 QaBtG50OgjyjfvpbeVJZEVrcnLl8m7cob922A4sdXGTs0c9gELvbboSE2ZPMBQFesP
	 vOAuV4FlMssmc2SFpWEdfqFsTjNPns8SGxD9Mz+ig/gbJCVrIRii6cssEsFwAuBu8J
	 DKV3AkQ36KcBvFxleA+LPG4qjhOdljCjhPqKIrXpezWXIJDntBVMJMsZ/6yd6cO5t+
	 kb0lafconi9CQ==
Date: Wed, 20 Nov 2024 09:35:17 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Christoph Hellwig <hch@lst.de>,
	Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk,
	kbusch@kernel.org, martin.petersen@oracle.com,
	anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
Message-ID: <20241120173517.GQ9425@frogsfrogsfrogs>
References: <20241114104517.51726-1-anuj20.g@samsung.com>
 <CGME20241114105405epcas5p24ca2fb9017276ff8a50ef447638fd739@epcas5p2.samsung.com>
 <20241114104517.51726-7-anuj20.g@samsung.com>
 <20241114121632.GA3382@lst.de>
 <3fa101c9-1b38-426d-9d7c-8ed488035d4a@gmail.com>
 <ZzeNEcpSKFemO30g@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzeNEcpSKFemO30g@casper.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241120_093519_776817_89516228 
X-CRM114-Status: GOOD (  21.44  )
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

On Fri, Nov 15, 2024 at 06:04:01PM +0000, Matthew Wilcox wrote:
> On Thu, Nov 14, 2024 at 01:09:44PM +0000, Pavel Begunkov wrote:
> > With SQE128 it's also a problem that now all SQEs are 128 bytes regardless
> > of whether a particular request needs it or not, and the user will need
> > to zero them for each request.
> 
> The way we handled this in NVMe was to use a bit in the command that
> was called (iirc) FUSED, which let you use two consecutive entries for
> a single command.
> 
> Some variant on that could surely be used for io_uring.  Perhaps a
> special opcode that says "the real opcode is here, and this is a two-slot
> command".  Processing gets a little spicy when one slot is the last in
> the buffer and the next is the the first in the buffer, but that's a SMOP.

I like willy's suggestion -- what's the difficulty in having a SQE flag
that says "...and keep going into the next SQE"?  I guess that
introduces the problem that you can no longer react to the observation
of 4 new SQEs by creating 4 new contexts to process those SQEs and throw
all 4 of them at background threads, since you don't know how many IOs
are there.

That said, depending on the size of the PI metadata, it might be more
convenient for the app programmer to supply one pointer to a single
array of PI information for the entire IO request, packed in whatever
format the underlying device wants.

Thinking with my xfs(progs) hat on, if we ever wanted to run xfs_buf(fer
cache) IOs through io_uring with PI metadata, we'd probably want a
vectored io submission interface (xfs_buffers can map to discontiguous
LBA ranges on disk), but we'd probably have a single memory object to
hold all the PI information.

But really, AFAICT it's 6 of one or half a dozen of the other, so I
don't care all that much so long as you all pick something and merge it.
:)

--D

