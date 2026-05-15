Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F862CD4851
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 13:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WnCSWO+kf/oEUAxF/KEAn0D20lCH29XUHyFRrwpQzb8=; b=ZFqy4q/ZnIYaNaiKccwrROsLBP
	Ggd75s3sTR7VY81scjtJTry3gL3HLSfJmuDlpF4aEQIZ5zc5i5LhqIXn14MLB2VRCBeq0LgzqYMni
	ZyYqnRA7804kKcjr5nAXaH99Oem70eW0CCpWujaMs+Dp5MTq6bq4BKFXZYBzZTz6mPnWqWXguY74S
	g8g0/H35XCwnNjTPxtRcgvmRVJK/EBVXzkNcjPeykQI98I/9UaPzxluCWXNQyg/90KyN3cdUcdFIt
	RnZFK8DAQBOhJ+gFVOTMkaR8tCkNP9fiJvxLd0BkAWkUHmNXA+urvY+kCJ/nK6VvmzD7PbBEaxbjb
	XXxzBOOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNsbg-00000008Re5-3xFY;
	Fri, 15 May 2026 13:29:36 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNsbe-00000008Rdd-25EZ
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 13:29:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CF79343B93;
	Fri, 15 May 2026 13:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3EAC2BCB7;
	Fri, 15 May 2026 13:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778851773;
	bh=FvWFFcehvNR2DhIUD3Frsh9U8c0shuA8aG6cI28/jY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MGyyyg2PN453a0Pm48sqmKGFF+XelHsXoQlbHIQzbykwASJY3kJGSkuKp7kfD/g44
	 RV3qwmVd5n1i+MzgndEjAEhL4gMNFcH+WPXLnbAl1hBUyrRQslIKhV05myyJLvnj+7
	 7x3THrHA4nBYCcizqrrzkCCjQeGi9UZJsiiQLzSuDlrziqOI0OMmTSNHJsdrJmy4C9
	 ctR7W/Mypej6a76jHXBDeW4lyAfbvI4qoRI+/Fb4YOBkETJuR98dkDiZzd8jkFV6wx
	 lFSx/nwSNkMHB2r44HZq4FMG/PqdHQD5guM9DyVT0+WNZOmxkG1wHBrh9bOVzn2qzC
	 hyNMLWUqfNtoQ==
Date: Fri, 15 May 2026 07:29:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] nvme-pci: serialize polling interrupt queue with shutdown
Message-ID: <agcfu6hzCWpM68Fa@kbusch-mbp>
References: <20260514144544.1752178-1-kbusch@meta.com>
 <20260515042941.GB3433@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515042941.GB3433@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_062934_555730_8A0C7176 
X-CRM114-Status: GOOD (  17.25  )
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

On Fri, May 15, 2026 at 06:29:41AM +0200, Christoph Hellwig wrote:
> On Thu, May 14, 2026 at 07:45:44AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Polling an interrupt driven completion queue temporarilly disables the
> > irq. If this occurs concurrently with another thread disabling the
> > device, the irq vector may have been freed, which makes it available for
> > reuse. Reenabling the irq after polling the queue may be referencing a
> > stale irq at that point.
> > 
> > Fix this race by ensuring nvme_poll_irqdisable() can not run
> > concurrently with nvme_dev_disable(), and skip polling the completion
> > queue if the queue has already been disabled.
> 
> Do we need the same change in nvme_suspend_queue?  I.e., should the check
> and locking be moved into nvme_poll_irqdisable?

nvme_suspend_queue is called from only one place that already holds the
same lock, so not necessary. And we can't do the locking within
nvme_poll_irqdisable since nvme_dev_disable calls it with the lock
already held too. I can add lockdep asserts to make the expectations
clear, though. 

