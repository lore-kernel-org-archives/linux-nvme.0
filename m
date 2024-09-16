Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E80C3ABA2
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2024 06:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lmthOZ9LLLumFpcwuDBpSL332WlcZi+U6LXauexX6J8=; b=06H6Yk40Lh1TiQTnI6rnXWzE+O
	RSxJ6zRSauoZfqwkCIwo4OaYYlXaJhn05zlEJQaNxWE1d+8Oxf3URIISMBzKcVwTlvllFDljDeENH
	ap8Xjk8LCvL7kBx1flwvjd+Usw7Nb4RD7oJc+RmGUXZvDhTQBbAeioltGJUjpnCEFIg4nMWgwRUvX
	xkLXX27TH0/GoH0/ur4wFVObzDL0ulnvjipLF6UpkVLjuG548I8zHN1sgebqvXXLVQEXACDXXIYso
	hiCVk9LyD3B5cxuZGIGaaJ4OuKZHBfKMIF4DsGYIQvM5gZl/Pc9OhR4wv8WNaZPgPtuC79BGFV2OC
	hXqPNYeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sq5Tn-00000003D7r-2lti;
	Mon, 16 Sep 2024 06:44:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sq5TF-00000003D0V-19yh
	for linux-nvme@lists.infradead.org;
	Mon, 16 Sep 2024 06:44:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 37EC6227AAA; Mon, 16 Sep 2024 08:44:13 +0200 (CEST)
Date: Mon, 16 Sep 2024 08:44:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	axboe@kernel.dk, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, sagi@grimberg.me
Subject: Re: [PATCHv5 4/9] blk-integrity: consider entire bio list for
 merging
Message-ID: <20240916064412.GA15929@lst.de>
References: <20240913182854.2445457-1-kbusch@meta.com> <20240913182854.2445457-5-kbusch@meta.com> <20240914073011.GA30261@lst.de> <ZuW-_hu1-98SEjll@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuW-_hu1-98SEjll@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240915_234425_484644_3F446102 
X-CRM114-Status: GOOD (  22.84  )
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

On Sat, Sep 14, 2024 at 10:51:10AM -0600, Keith Busch wrote:
> On Sat, Sep 14, 2024 at 09:30:12AM +0200, Christoph Hellwig wrote:
> > On Fri, Sep 13, 2024 at 11:28:49AM -0700, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > If a bio is merged to a request, the entire bio list is merged, so don't
> > > temporarily detach it from its list when counting segments. In most
> > > cases, bi_next will already be NULL, so detaching is usually a no-op.
> > > But if the bio does have a list, the current code is miscounting the
> > > segments for the resulting merge.
> > 
> > As I explained in detail last round this is still wrong.  There is
> > no bio list here ever.
> 
> Could you explain "wrong"? If we assume there is never bio list here,
> then the current code is performing a useless no-op, and this patch
> removes it. That's a good thing, no?

The wrong thing primarily is the above commit log.  The code change
itself is correct, but we'd be better off killing the iteration over
the bio chain as well to make the code less confusing.

