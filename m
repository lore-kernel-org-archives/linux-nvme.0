Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04355E92FF7
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Oct 2023 07:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BF6XGl5McgQ11STX4m6TVbbd2FkzhdSDGa4dPnDuBJw=; b=IttV5dcL0s5tWqUSKEMT9Vm+I0
	atj9qIgCTvJgObD5QrFCz4AcooVmi4DlX2Oaxde8Wj94c+veFJwJL9Tp25licbV4DV7HScDrl9S2a
	2SayohDqYQLqCH+vYBT7s64EHwqFK/+ZuQ2MC5J3wKgKTks6GYi6GKGCH/OJzqRzoT30KSNB4ZEw7
	mCIJHKBDYWySueMZGHQppaXyMZG8NpCWUjv7Ts8vxg7mjpFK3vPgUaVDk72lX1Jz3mw8rA3ff2hZ6
	iV7iwR5skCU9MGrMjTkqBXXpqsBhm6L9OrQH/i5Zr3EZayESIQPnJwY7tRYYxD0vagiWOl6/HXF14
	XsqgYpXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qofXy-005CjS-2n;
	Fri, 06 Oct 2023 07:46:54 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qofXw-005Cj6-2i;
	Fri, 06 Oct 2023 07:46:52 +0000
Date: Fri, 6 Oct 2023 00:46:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mark Syms <mark.syms@cloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org,
	Ross Lagerwall <ross.lagerwall@cloud.com>,
	Andrew Cooper <andrew.cooper@cloud.com>
Subject: Re: NVMe fabric multipathing
Message-ID: <ZR+7bCOan1wPM8jZ@infradead.org>
References: <CAPYKksW8SyqG1+P1J7JRbrwnjkj=S5gWA93+yOugB=N+zhD3OQ@mail.gmail.com>
 <ZR5y+2P/NQ25/Rkv@infradead.org>
 <CAPYKksVJgr+XJUe5kFQq7T59Hn1ELvK9nLsz9re8UwvwPRY5Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPYKksVJgr+XJUe5kFQq7T59Hn1ELvK9nLsz9re8UwvwPRY5Pw@mail.gmail.com>
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

On Thu, Oct 05, 2023 at 11:16:41AM +0100, Mark Syms wrote:
> > > We have a requirement to report information about the status of NVMe
> > > multipath controllers on an NVMe over fabrics deployment. In
> > > particular the total number of "known" paths and the number of
> > > "currently active" paths. As far as we can see right now, when a path
> > > to an NVMe target device, when using Fibre Channel, is blocked, all
> > > local information about the affected controller is flushed leaving
> > > just the currently active controller(s) present.
> >
> > What do you mean with "blocked"?
> >
> Made unavailable for any reason. So failed switch port, failed HBA,
> failed SAN controller, etc. We've been "emulating" this for testing
> purposes by unbinding the PCI device for the HBA on the NVMe target
> device but I expect the same happens for any of those reasons.

If you undbind the device there is no way NVMe can keep any knowledge
about the connections it has.  If you have a real path failure on
the underlying fabric as long as it hasn't given up on reconnects.  You
can set the max_reconnects value to -1 to never stop reconnecting.


