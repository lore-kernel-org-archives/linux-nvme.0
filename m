Return-Path: <SRS0=GOb3=P4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886D1C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 08:13:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C109611BD
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 08:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C109611BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Zj4SWs2GkJABrKboImmoF1dGGCqYZb6uoJmOA12uSQ=; b=njktvkxhD7R/m3njILuBtHc3Ik
	eYUJ3kEPR4qfFGQ/8xEpA24EwLsS5YrEd2jCJWrfRdKvMLenOnOxd4naPJKJEFVdHDQllPMFg8zji
	x3z2ZWrblJD6HY5OqG7Llm7O7SvfY7e9iaEQUwKgUze3g2/TL3ZPN1mu+NZ2TplZUeRNsGzDFY7ik
	ZHt8qTv/50tR6w3tjijXaNKtutwU7CIDor1xNkr8lVXvQECwnHRKZp/YCZ78Qp1U6ecIfM1KYlBAt
	eKk6pL8Irkh6I+VaLrCjAtWh1gfBVvdZh4f+uW7vrSDm3XuTxM8yahE14ihUb4u0hJATQP0ynQl8o
	IGMaWeuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkMFi-000wl7-4Z; Tue, 09 Nov 2021 08:13:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkMFe-000wk4-2S
 for linux-nvme@lists.infradead.org; Tue, 09 Nov 2021 08:13:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 63D7467373; Tue,  9 Nov 2021 09:13:03 +0100 (CET)
Date: Tue, 9 Nov 2021 09:13:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, axboe@fb.com, hch@lst.de
Subject: Re: [PATCH] nvme-tcp: fix memory leak when freeing a queue
Message-ID: <20211109081303.GC28785@lst.de>
References: <20211103081817.94820-1-mlombard@redhat.com>
 <a609e935-f529-d87e-a950-33367694aef5@grimberg.me>
 <20211103104516.GD4840@raketa> <20211103110310.GE4840@raketa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103110310.GE4840@raketa>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211109_001306_284179_1D15594B 
X-CRM114-Status: GOOD (  18.56  )
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

On Wed, Nov 03, 2021 at 12:03:10PM +0100, Maurizio Lombardi wrote:
> > > 
> > > Thanks Maurizio,
> > > 
> > > Why do we need to the pf_cache.va protection? nvme_tcp_free_queue
> > > is already protected against re-entry with the NVME_TCP_Q_ALLOCATED
> > > bit.
> > > 
> > 
> > It's not the re-entry what worried me, I thought that nvme_tcp_free_queue()
> > might be called before page_frag_alloc() had the chance to initialize the pf_cache, triggering
> > a NULL pointer dereference. I am doing some tests right now and it seems not to be
> > possible so maybe we can drop the "if".
> 
> Oh wait, if nvme_tcp_setup_ctrl() fails it could call nvme_tcp_destroy_io_queues() and
> iI guess that in that case the pf_cache is not initialized, so the if(pf_cache.va) protection
> is necessary.

Sagi, does this look good to you now?

