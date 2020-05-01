Return-Path: <SRS0=VrRv=6P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0CEC47253
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 15:12:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D66216FD
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 15:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U5aC9AKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D66216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yzG5nwXv0l+b0QfaMwfy++s5bYiWxY898P1vLijKqLs=; b=U5aC9AKxNpLvWK
	/TPY99Hr8/yjDC9Rtj1344T8g9mzp1UIwsfcXwnPUpyOU5nqe/2IhdIX2SdlV86zwp2AhqK7TNwhr
	K9jIkC/xW8vFc5lagI0ZcQ/RSC0AklqMlXvfzGP4wr9I+mAmk8T0WYDsgJ4XbkLRkOzwSNkTTzm18
	ObOC/0itbkKFO0jw52XN7HockUww110Mz7FELzNn3miv0DOaLayWbsAfJ4jdD0HNMAFBAnbCpKYPD
	T6OOz165o+zOM/R2cD/3wHlyFshLhVeNldblhBfqSzlk//RiVXRAl9JGy5rNNvQkUdVtJYsj9ZdCD
	DGpufCJLkx5pmsrxDbZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUXLP-0002fA-SE; Fri, 01 May 2020 15:12:51 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUXLN-0002af-2n
 for linux-nvme@lists.infradead.org; Fri, 01 May 2020 15:12:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5072F68BFE; Fri,  1 May 2020 17:12:46 +0200 (CEST)
Date: Fri, 1 May 2020 17:12:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/3] nvme-pci: reshuffle nvme_queue members
Message-ID: <20200501151246.GA17006@lst.de>
References: <20200427235243.2268765-1-kbusch@kernel.org>
 <20200427235243.2268765-3-kbusch@kernel.org> <20200501125704.GC5197@lst.de>
 <20200501150815.GA22665@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200501150815.GA22665@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200501_081249_289876_A5510B96 
X-CRM114-Status: GOOD (  13.09  )
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
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, May 02, 2020 at 12:08:15AM +0900, Keith Busch wrote:
> > > +	/* only used for poll queues: */
> > > +	spinlock_t cq_poll_lock;
> > > +	dma_addr_t sq_dma_addr;
> > > +	dma_addr_t cq_dma_addr;
> > >  	struct completion delete_done;
> > 
> > We probably want a comment before the last three that this is only
> > used during queue deletion.  Also cq_poll_lock very much is in the
> > hot path for polled I/O, so I'd rather keep it with other CQ bits.
> 
> Yeah, I moved the cq lock so 'flags' could fit since we're still using
> that in the submission path. We should be able to get rid of that hack
> at some point, so I'll redo this as you're suggesting.

We could easily kill the qid field by using the same trick as
the fabrics drivers.  But that is only 16-bits, does that give you
enough space?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
