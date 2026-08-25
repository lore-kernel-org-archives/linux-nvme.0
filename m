Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB30AC5DF81
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2026 02:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GvQLhOLHeYJKJN1cjIsTMtPcdFE2OhruwkpoQivV+VQ=; b=X5OtmHaxHUBBj6S/0iOSsTrFMW
	02QxFaWzF9PJ9t2gMb2nwbYScBOc8khKZhYpyMI77ZNiPW2tIGM4Lwd5LJvkEXrz7pWL1jLqcIPla
	ZF/+yZLzArBXto8Ldy3eFgkA46aFnldD06eXuFuIjGeMYpy9oVxbLbU8uwzqxUVK+mrvi+JlH6/VQ
	gS5M9p2gD2M4WembAxXlpyjN1WnvMGxAz7Pagg7IIPAkIQT7RVHP2yLyJzA0kDuB6IXceAqju5TRD
	LVDeo0ZbpnH0X3Jo3FBhsDOVAuitKc+LjmoIvyMJfFQKmoKQR2YKAJKEMjNZk6LPFSHL+Rxp1sios
	SugqwTqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyhMO-000000004bn-00E7;
	Tue, 25 Aug 2026 02:58:00 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyhMJ-000000004be-0TUp
	for linux-nvme@lists.infradead.org;
	Tue, 25 Aug 2026 02:57:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3A94E6011F;
	Tue, 25 Aug 2026 02:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A42F1F000E9;
	Tue, 25 Aug 2026 02:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787626671;
	bh=GvQLhOLHeYJKJN1cjIsTMtPcdFE2OhruwkpoQivV+VQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gEx1uHm8a1VuwiuOrZW/RdciGlXOwBqbGAAdtEfSlWkRDOJsjPg2No/v/7pfQxdY7
	 eG7MGO68buLG8qKlRVgr6ohDeGP1tcM+SuR/n1f4Du/0vhOAcGj3+Nm+rKLiu9598s
	 8LGf3I9srSR3Jlb2FJVkyS4dJhwgu8MYCf3oYsjq4HgYLmvuTlFI59cjwMItgvRf9T
	 58PMOQBkETzq/fOHnp0LHcIDPxDLTMxVy8tYy612FqQcHRe+UpDH+mZHbpHs3x8gRM
	 k3y6KeInWb2zYL2+KBFWNgLBzGIDNCxfVSWHv2MAXnHvY9MxCbmlSB4cewm9wPcHAB
	 hC/zYqBlpedIQ==
Date: Mon, 24 Aug 2026 20:57:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-kernel@vger.kernel.org, hare@kernel.org,
	shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH] nvme-tcp: defer TLS inline send to io_work
Message-ID: <ao0ErlDKMbvwAoGx@kbusch-mbp>
References: <ajtk1CaN1pBreS4O@shinmob>
 <cover.1782436781.git.liuxixin@kylinos.cn>
 <8803a2bf-3f8e-4ee9-b6d7-5467bfc1b1ce@suse.de>
 <reply-hannes.062lockdep.20260629.liuxixin@kylinos.cn>
 <reply-hannes.062lockdep.20260701.liuxixin@kylinos.cn>
 <aoPuIUSQvZxujmv7@shinhome>
 <ee0225fa-6a0b-4933-9a4d-5c77792eb94b@suse.de>
 <c6e2a91f0b62.1787100300.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6e2a91f0b62.1787100300.git.liuxixin@kylinos.cn>
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

On Wed, Aug 19, 2026 at 08:50:00AM +0800, Xixin Liu wrote:
> blk_mq holds set->srcu while queuing and running requests.  The kTLS
> software send path takes ctx->tx_lock.  lockdep knows that tx_lock
> nests under elevator_lock which then waits on srcu, so an inline
> send from that path under TLS triggers circular locking.
> 
> Skip the inline send optimization for TLS queues so the send runs
> from the workqueue instead.  The same workqueue already retries TLS
> sends on write-space notifications.  Plain TCP keeps the inline path.

Thanks, applied to nvme-7.3.

For future, could you please send new patches as new threads separate
from the discussion that spawned them? You can use "Link:" tags for
prior discussion if you want to keep it, but this interleaving and
changing subjects in the same thread is a bit unpleasant for tracking
purposes.

