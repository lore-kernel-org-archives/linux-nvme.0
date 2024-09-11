Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF67EE49BC
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 15:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kcu+tl8PE5eqpQbrQao39l9Yvml/LfOvSfgKJAFRNzM=; b=hZvecvzmv7ZOsjbS08JLI5+KRR
	oLLGx68oD/92OLhjR0sRklKsVER9u+57t2IESgUBTkjesb1e3xi9gYD8pbVblChFuI7fVZ2RaAtly
	80C2zFe+zAp9cIsk2r9famT3EoJeNEMjFYMWRyDuyFL9g07NvjEf4PyKHBdHUgFd6a4Jsxg5alfah
	ZxQLpcjBbgM2ACKAM59rTw2LgG/AqEviw7Nbi1Ul4WqG9fay0iEeNJbdQIqHCmmQ3NLUfJbbGtDx5
	iu/k+Tsa+fVODILGXHUOsAqKSZwUBGEHs46Q/y/TzTx8yu3eGaqJ1SN2rZKkV7sj8zNuGw2YKuGhJ
	LCyYkFQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soPgT-0000000AFgQ-0NL7;
	Wed, 11 Sep 2024 15:55:09 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soPGt-0000000A9bR-0IXI
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 15:28:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CB97E5C06D1;
	Wed, 11 Sep 2024 15:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEC8C4CEC5;
	Wed, 11 Sep 2024 15:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726068521;
	bh=DqtkfdaA8P1FYjzF3GC+zMYqZk72DjfX7QjCW8jFSys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YoMCgDtw3d7qW2tYi+Xz30aYj3X9q9rO9DhMB4wmZEMPb/L7NKZJw6iw0S2e6pHb2
	 zpSoY79IUr5blezaNWacaw+TZIBT7fhfjmUGxHIF/icasi5AivB8DgG5+nZAIYy5aJ
	 R/NNf8CogCGbea5VopmELrKCQqCqIxPBAqGp5wdDchkWSWk8jfFB199XbnMn69VnCP
	 e9/b50RArisnekOIElkpmkJlCq9bpB3LFyDiPIJoXhCsn8tUmT9ota+sEvLW+qW2xD
	 k0swsa4wYpsHmD3siQWHHumTotVRfxUgz8npKzq4yn8HZqqM9/bSEONRHP2uFt5jrF
	 T/xhlemsa+2SA==
Date: Wed, 11 Sep 2024 09:28:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	sagi@grimberg.me
Subject: Re: [PATCHv3 06/10] blk-integrity: simplify counting segments
Message-ID: <ZuG3JoOq-XaLbBo4@kbusch-mbp.dhcp.thefacebook.com>
References: <20240904152605.4055570-1-kbusch@meta.com>
 <20240904152605.4055570-7-kbusch@meta.com>
 <20240910154105.GF23805@lst.de>
 <ZuBua91J2X5Yt-72@kbusch-mbp>
 <20240911081720.GA7372@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911081720.GA7372@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_082843_228561_A607330E 
X-CRM114-Status: GOOD (  16.00  )
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

On Wed, Sep 11, 2024 at 10:17:20AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 10, 2024 at 10:06:03AM -0600, Keith Busch wrote:
> > Exactly. bio_integrity_add_page will use the queue's limits to decide if
> > it can combine pages into one vector, so appending pages through that
> > interface will always result in the most compact bip vector.
> > 
> > This patch doesn't combine merged bio's but that's unlikely to have
> > mergable segments.
> 
> Oh, bio_integrity_add_page uses bvec_try_merge_hw_page.  That means it
> doesn't really work well for our stacking model, as any stacking driver
> can and will change these.  Maybe we need to take a step back and fully
> apply the immutable biovec and split at final submission model to
> metadata?

Would you be okay if I resubmit this patchset with just the minimum to
fix the existing merging? I agree stacking and splitting integrity is
currently broken, but I think the merging fixes from this series need to
happen regardless of the how the block stack might change when integrity
data is set in bios.

