Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18990C636CC
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Jan 2023 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AqxauuQvtM0gOXSBYsffmsVlfC8atHtla/XITRxlMTE=; b=lL/4zRFNd6Ck6UgTFA+7er9967
	JNGwcBK+o8yeXQhs+WtHNyxYbqpx1EnudMVBBdEUMllqJP0B3ZiwRMTwDe+hrLCZd781gAW7rQCOj
	bcJy78kuwETumE7ly4YgdpJAOrAShTaoKm/rPSyhnEbPqVG5X5Bems4IJmlyOOqA94M4JInytkzPh
	KKT2a4MeKUQyWztnqjjZ7ZojjiVUHcVCo+jMNAPQzlQ7GiBRhoFzpcSNIlYEcW8gbsVaMrCvyEee+
	LkSmuzLWOtkRwVDQC7A/1hxQKHifdsI1UUTpswRLiBXvxn9aHEiU18V1MKFNjpxk50/GkFOo6jIS+
	mGMEHZyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMsSi-008Vhv-MN; Tue, 31 Jan 2023 15:22:20 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMsSe-008VgH-LM
	for linux-nvme@lists.infradead.org; Tue, 31 Jan 2023 15:22:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D9A9D61591;
	Tue, 31 Jan 2023 15:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B153DC433B3;
	Tue, 31 Jan 2023 15:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675178535;
	bh=2Ch5OcqZ+dIFAFxbEX6Wl0MfvjTSl7UfH/KwkUlcod4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SiqoS5DaHywGXPbLTUwuNlm8kHhr/2PEI6BVyCRLlWpUQZQiiT2IRj9m+aF37MaBT
	 yB6M+jvzI9GZUqUo4ZswuVrCqH4+puLwQVQQRe7Tr9ORR0tjUb60A5VZnIoz8hcR7F
	 l26oi5DbxKcA/NoK+zGLvisgQHnQOz2ZkqCzUaJxvg9YTN5uWFrCKK+uhI+O3EL+je
	 ZyvFKFdFkDB3Jk8i+EtjIKrSbtoNT6hwFvqOuc2aFS93SKYvpm3MIY4EhXdm/znrpV
	 nv7w8+VJBWPqNjMKBvVSXXuf7WA4ruYyF5NYKqD8DNevn9MfldGYMe1WoLmqKY+2wR
	 4P+lXFsG4FWPA==
Date: Tue, 31 Jan 2023 08:22:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
	Maciej Grochowski <Maciej.Grochowski@sony.com>
Subject: Re: [PATCH] nvme-pci: fix resume after AER recovery
Message-ID: <Y9kyIzTi6/7hsDsm@kbusch-mbp.dhcp.thefacebook.com>
References: <20230130101449.1772800-1-hch@lst.de>
 <Y9gN+FsDZQBcKJvk@kbusch-mbp.dhcp.thefacebook.com>
 <Y9gP0MvNpC/dgxQn@kbusch-mbp.dhcp.thefacebook.com>
 <20230131085828.GB3139@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131085828.GB3139@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_072216_777246_CC256504 
X-CRM114-Status: GOOD (  16.95  )
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

On Tue, Jan 31, 2023 at 09:58:28AM +0100, Christoph Hellwig wrote:
> On Mon, Jan 30, 2023 at 11:43:28AM -0700, Keith Busch wrote:
> > > Why isn't slot_reset being called after error_detected? Driver should be
> > > returning "RESULT_NEEDS_RESET", which should have the pcie error handling
> > > always invoke the slot_reset callback.
> > 
> > Are you using an older kernel that doesn't have
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=387c72cdd7fb6bef650fb078d0f6ae9682abf631
> 
> Oh, that does looks like the real fix.  That being said, what is
> the point of flushing the reset_wor in nvme_error_resume?

It's so we don't try to handle a new error or remove before finishing recovery
from the first one.

