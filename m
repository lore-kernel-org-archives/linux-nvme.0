Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A92AD64063
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 16:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tX2OW8gm2eZqcGpVxXoWc0pIWwhTKYsQysmSCULf/iw=; b=Atw+MYTZDtxdafjW8ycnJMFqp4
	uALQf6feplns7pxIPHQay4E2hHPsjwJqF8BY+rsGSFunUXleLvZruZNwwcxUxhg2YwyKIl/5QxlUH
	rQVrZJy+ubFaxYdcY7KY5Vqf5jkOuBIAirFIeNA7tEvPIq3PbzSOdzmKGYogG2aBKzlijCBWDxZMT
	ilGB1wJhBOiBP17BMF02zz+ia1H0UusLgqwtaFwxRQ8VH5TdvT4k81IrkBqOxkbbVeMwjbD/93PHU
	b64tHXemv/1SgueijxQiLnCFl4WmsXCxn3Zbe9mNaIKGKWjbhi2OzjjvoD926SJLJkMtlSrSN5eX8
	orft4CMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9RvM-0000000BEUU-2zMk;
	Fri, 08 Nov 2024 16:33:28 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9RGq-0000000B6dJ-1oN8
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 15:51:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1DE615C4CF0;
	Fri,  8 Nov 2024 15:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3747C4CECD;
	Fri,  8 Nov 2024 15:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731081093;
	bh=mOMvtGK40YQ3w77ykrXsI3BGNXP4DVCCfcRaNvLRXC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WbzJMLFhJ8MFKHcEYj94OUODGQgdpKtvpquZXfUUW/usquKC6kMnB0VWo6b5HPyyH
	 bld0Af7AjvcwnKBQbk5rdCymUKo2uErcYMDs8jJoW1SkR2ajpIDZoLdmnbCoJgcX8o
	 Jx6qtKbNNtuo1oBAJ5e0ylhkMweLyh7QHjTjPAZdvNA+G6ylvpUbHhx3ZqetevQute
	 h0vxxkeeb0XlGAjcYGeh7HldbzjimC+He1taEWYRbqIlhMxKcZdM72Qsk9xKpJX0m4
	 mJHKMhlFFB7/BKLrF6kPr/Cb6PoOZ9aW34B3rP20bKbWSChtXksfYE+zUts+/8/mXC
	 PSth57QGQ/Vdw==
Date: Fri, 8 Nov 2024 08:51:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com, bvanassche@acm.org
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Message-ID: <Zy4zgwYKB1f6McTH@kbusch-mbp>
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241105155014.GA7310@lst.de>
 <Zy0k06wK0ymPm4BV@kbusch-mbp>
 <20241108141852.GA6578@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108141852.GA6578@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_075136_535769_5977F005 
X-CRM114-Status: GOOD (  18.21  )
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

On Fri, Nov 08, 2024 at 03:18:52PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 07, 2024 at 01:36:35PM -0700, Keith Busch wrote:
> > The zone block support all looks pretty neat, but I think you're making
> > this harder than necessary to support streams. You don't need to treat
> > these like a sequential write device. The controller side does its own
> > garbage collection, so no need to duplicate the effort on the host. And
> > it looks like the host side gc potentially merges multiple streams into
> > a single gc stream, so that's probably not desirable.
> 
> We're not really duplicating much.  Writing sequential is pretty easy,
> and tracking reclaim units separately means you need another tracking
> data structure, and either that or the LBA one is always going to be
> badly fragmented if they aren't the same.

You're getting fragmentation anyway, which is why you had to implement
gc. You're just shifting who gets to deal with it from the controller to
the host. The host is further from the media, so you're starting from a
disadvantage. The host gc implementation would have to be quite a bit
better to justify the link and memory usage necessary for the copies
(...queue a copy-offload discussion? oom?).

This xfs implementation also has logic to recover from a power fail. The
device already does that if you use the LBA abstraction instead of
tracking sequential write pointers and free blocks.

I think you are underestimating the duplication of efforts going on
here.

