Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AB8C27C50
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 14:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q0xFrfAHM+B8khTimiE+Wta4nJKEpmNlTo0p/B1ZdJA=; b=EwgeMS+gyiVvrEozgDDN4Lb7nj
	CHm5+wE20LaO6mTQpbEOZosU7syL7LBuMqyfe951VXjmLfJH9NWohABioj/KTF0jdAkApKZS7aRB8
	qPD7w1xu/kDylzr4GEZolBUGVWIBwiI0/VNf7gQ9xhDHPJ7DX7yQd1f1gG0hZoh6q5fTdYvlmwPRM
	4/WnZLdrvoHTYrdmklJUDK1ZRnNBJCzX2Z7D5WzLqMvg5QdapmSROuPfI07e8MrxhN18sDTd813Jg
	ujwA1mUPtk7JX7tyBG7rGDrWikn2REQokxigAnSaMiX/jRm7xSzFEJxZ7uHSrIqOuYuFjP1FhPvbW
	TNMvk4gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEVMw-00000002mJN-3dhd;
	Tue, 04 Jun 2024 14:42:34 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEVMu-00000002mIG-3TFI
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 14:42:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A7328CE11AD;
	Tue,  4 Jun 2024 14:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9731AC32786;
	Tue,  4 Jun 2024 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717512146;
	bh=fmlRiz5M5NjXBFuEtUQcEwmSqlNPoKCDWdQmvJU2bn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n4L/sFM8i0oFnDH7F8EaDAMFQuuQh8PoG7QQq1M8IxZeajDv8ixPlzS8RP5O5WSbo
	 fx1EtGxLjwFmVcfA7L6XJ9nj159hlyDZMc5x3Rop05fJhMF0pnorbMylNaXque9krv
	 nRofPSsBjJTBD+bxZ5P7AhVAicmfaTkOKshWmMLUxvyDRcPKU89n/WuKiFwbnGnmhg
	 7nCXXoiTqNiZjM8rwLtJ/ZsklEk4PWnKZZJZr8AwL96O1R3jn01o0gIHPfx3nzAUpc
	 gjuPAWdnyLbyguqM/uXLIwcHdQYnVguuAoMNTsqVxMHwDWIVHTh0ulOUvJoNsydamC
	 Bk9alCkb/mfng==
Date: Tue, 4 Jun 2024 07:42:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ofir Gal <ofir.gal@volumez.com>, davem@davemloft.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com,
 edumazet@google.com, pabeni@redhat.com, kbusch@kernel.org, axboe@kernel.dk,
 sagi@grimberg.me, philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
 christoph.boehmwalder@linbit.com, idryomov@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v2 0/4] bugfix: Introduce sendpages_ok() to check
 sendpage_ok() on contiguous pages
Message-ID: <20240604074224.44668dab@kernel.org>
In-Reply-To: <20240604043041.GA28886@lst.de>
References: <20240530142417.146696-1-ofir.gal@volumez.com>
	<20240531073214.GA19108@lst.de>
	<20240601153610.30a92740@kernel.org>
	<20240604043041.GA28886@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_074233_077685_4E02DCA8 
X-CRM114-Status: GOOD (  18.89  )
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

On Tue, 4 Jun 2024 06:30:41 +0200 Christoph Hellwig wrote:
> On Sat, Jun 01, 2024 at 03:36:10PM -0700, Jakub Kicinski wrote:
> > On Fri, 31 May 2024 09:32:14 +0200 Christoph Hellwig wrote:  
> > > I still find it hightly annoying that we can't have a helper that
> > > simply does the right thing for callers, but I guess this is the
> > > best thing we can get without a change of mind from the networking
> > > maintainers..  
> > 
> > Change mind about what? Did I miss a discussion?  
> 
> Having a net helper to just send some memory in the most efficient
> way and leave it up to the networking code to decide if it wants
> to use sendpage or sendmsg internally as needed instead of burdening
> the caller.

I'd guess the thinking was that if we push back the callers would
switch the relevant allocations to be page-backed. But we can add
a comment above the helper that says "you'd be better off using
page frags and calling sendmsg(MSG_SPLICE_PAGES) directly".

