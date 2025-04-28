Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F87C3ABA4
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 15:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Qcf4ajR8DTaAVVm8dHJYvwvf+GeXYW1cu5TecDVwJY=; b=IuHHsavqbh51Z6Lj7LgBcEWRnv
	5z05sElEdMf50cy/qQB7IBf4J2w4VzasPRULmPj+46E3YzeDJ8aIwRy/JRymA+pFyWya56m5lW0sb
	D5sDkcO6eTfl9cNL7fjOACuQNjjISdizoduunGuYLAoDEmUqcVlruH2qNlswZK7i/L5s8GzUxFYrv
	6ubP7XHWiHWvoayiOMBCeJaJ4o5c2Rue4StAM1pDsI8gEKggBMyIZFf1pekf/hxGFR+JILDXwV3kA
	m1VdtYgFX5m65j2W4eh3lEDTRlTZj4BsD52/CPkCiw9rU/FZlFdsBwe5tE2od7nCasJV1TLxQjCH8
	ZNYkK6XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9QJz-00000006kN7-37vg;
	Mon, 28 Apr 2025 15:23:03 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9QJx-00000006kLy-0Bbz
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 15:23:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 01E0844207;
	Mon, 28 Apr 2025 15:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBC9C4CEE4;
	Mon, 28 Apr 2025 15:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745853777;
	bh=7Q1gEOvYnSoJSnGZOkVo3FeqEG8LjxQ/oq/0yGiaF/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kXIvcZoAOT8tqW3YNfmsS+Wq6tgNawY8qT4szU6k1tK1kt+d4uwZCVux3PbRC1rEj
	 7ngXPdWz0FlZ0IBMSJRjmHbEZ55wlNWrgMgXMio+qw4oep+E92/JGzJF915HJecr1J
	 WMUP4U/H/vIKTu2tNuGJMNF9F6WXlI7wknfxEcNn7xb5i8jOsNQwXitUtc4bxVTU3r
	 8or89NAbYa3qI0ZAjyIYOiMlsGYmBeZSaE9omXBX4YnEFJiuqyxG3qOSHpipo/Wj7H
	 nERu3orSQEpBrNbl4PJuF26RqgpQ0zH/lwkZBSBLF9FPuQfXlQLMbfpVusSk9qiZL1
	 qhOG0Dh8wSCZA==
Date: Mon, 28 Apr 2025 09:22:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	Dhankaran Singh Ajravat <dhankaran@meta.com>
Subject: Re: [PATCH] nvme-pci: fix queue unquiesce check on slot_reset
Message-ID: <aA-dT-iVfnSVx_6u@kbusch-mbp.dhcp.thefacebook.com>
References: <20250424171801.2300390-1-kbusch@meta.com>
 <20250425131935.GA5460@lst.de>
 <aAudOMQi05je8ADN@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAudOMQi05je8ADN@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_082301_102996_FACB7CE3 
X-CRM114-Status: GOOD (  18.15  )
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

On Fri, Apr 25, 2025 at 08:33:28AM -0600, Keith Busch wrote:
> On Fri, Apr 25, 2025 at 03:19:35PM +0200, Christoph Hellwig wrote:
> > On Thu, Apr 24, 2025 at 10:18:01AM -0700, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > A zero return means the reset was successfully scheduled. We don't want
> > > to unquiesce the queues while the reset_work is pending, as that will
> > > just flush out requeued requests to a failed completion.
> > > 
> > > Fixes: 71a5bb153be104 ("nvme: ensure disabling pairs with unquiesce")
> > 
> > Sounds like this code path isn't get teste all the much if this stuck
> > around for so long..
> 
> The conditions that trigger pcie errors were the primary concern. Of
> course you'll get IO errors, right? The pcie connection is flakey! But
> we are supposed retry IO's after recovery, which we weren't doing, and
> that was a secondary concern I embaressingly overlooked for many
> reports.

We can still take this right? It is a good fix, even if we misunderstood
why IO was failing for over a year there.

