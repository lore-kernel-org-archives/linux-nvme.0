Return-Path: <SRS0=VrRv=6P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9E6C47258
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 15:08:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F1E2173E
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 15:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iGwUX6EZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHYbuc0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F1E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gsf1ckMe5lxMRX/IDHYYXln/Ahk9QUfsTmQcQywlyT0=; b=iGwUX6EZenvMQv
	128JDQryo5wNaKjM6hBO6ugBPg4rBsecH5dVHk+xheaxMHosoFs5fGLauuprQVRBiUJYeHZz5JI+f
	TCAWKypn/lUFIBZD7vwZKW7abBGKz7TK2bOU+/+6IW2v3oPx3xwUl6+PnwKi235J+afKtS9M+oJTl
	Pp9iZZ0lM+jSCC/7nyn0KI9WJDgtMktdJ4LYZBlyQFV2WEGqKBKpYguPj5jmXehQ/dSoprc6bT80t
	sf/rusr6spfRP6KlRP880xnv2Kto+NhKWympMVjZSc8vPzM0GdWS2DNhRPC5KPsM15zxQ+ze45rs3
	NSf6Jjlz7TH3fLFl1Ohw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUXH5-0007hy-Gv; Fri, 01 May 2020 15:08:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUXH2-0007gh-Ht
 for linux-nvme@lists.infradead.org; Fri, 01 May 2020 15:08:21 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 450B42137B;
 Fri,  1 May 2020 15:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588345699;
 bh=43GMTCOgrYMZCQ2fbatWSsfjk2jy0DK6ry3mDCrd+aI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PHYbuc0Oj3jcQD+0cBUOWvRXWf9PbqXxh5cc72xLFhFn+V3wuOFVDfhHxQKKdpIJT
 c65qvxxcHdANIYSerAdecPO9b6WIYlxajwL+CTHOiC/6AWnuGTYFkSH/xJpGj5914g
 Rk4IveB0Lf8/8NUfmI0uU7kJl95zziQ3OoQ/t+cc=
Date: Sat, 2 May 2020 00:08:15 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] nvme-pci: reshuffle nvme_queue members
Message-ID: <20200501150815.GA22665@redsun51.ssa.fujisawa.hgst.com>
References: <20200427235243.2268765-1-kbusch@kernel.org>
 <20200427235243.2268765-3-kbusch@kernel.org>
 <20200501125704.GC5197@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200501125704.GC5197@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200501_080820_612099_3FCA3532 
X-CRM114-Status: GOOD (  16.72  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 01, 2020 at 02:57:04PM +0200, Christoph Hellwig wrote:
> On Mon, Apr 27, 2020 at 04:52:43PM -0700, Keith Busch wrote:
> > All the io path hot members can fit within the first 64-bytes, which is
> > a common cacheline. Order the members of this struct so those members
> > fit in and align to that window.
> 
> Do we even want to share a cacheline for the submission vs completion
> path?  I know other places try to keep the deliberately separate.

We usually complete on the same CPU that submitted, so it appears
beneficial to fit both sides in the same line. I'll try it out both
ways, though I don't think I'll be able to measure a difference.
 
> > +	/* only used for poll queues: */
> > +	spinlock_t cq_poll_lock;
> > +	dma_addr_t sq_dma_addr;
> > +	dma_addr_t cq_dma_addr;
> >  	struct completion delete_done;
> 
> We probably want a comment before the last three that this is only
> used during queue deletion.  Also cq_poll_lock very much is in the
> hot path for polled I/O, so I'd rather keep it with other CQ bits.

Yeah, I moved the cq lock so 'flags' could fit since we're still using
that in the submission path. We should be able to get rid of that hack
at some point, so I'll redo this as you're suggesting.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
