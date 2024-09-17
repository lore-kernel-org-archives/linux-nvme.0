Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A960CAC5A0
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2024 20:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=07wX4E7SE7GQY29DyPDdJcWQ8QFb2MOXcuehYSfT0fo=; b=BXM8yK19UAJmIaQ9BK4tyV2LWi
	ng1JnmCYEWbSk5V6BSEKmot03NQUGi1Ggr8w+KKvCLY+s0449v60yALfZp70whStCjDdskJYExjqY
	tDE+DcdjXc12moTt7Ngy0aXuEL9KxjjUQwbnrUstn2xo0/fBHlX0SWZggWIG+mGH5+i6mhy4EzGH0
	1bWN+79TPYKqf7QhiSkNngjHhFMUld2YGVjGA+Vrtavncyh+A4/FkzPjPLe7l6uybM/tDPcW3oDtq
	hX1slwhi5/dOoKSuvqySPPrlKj17kJlkRay5ivI6K79S60OoaB6y18i43oMXWUbkIQwZpf1JAXZSI
	chL3Mocw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqf2K-00000006sWR-30Cb;
	Tue, 17 Sep 2024 20:43:00 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqf2I-00000006sVo-30yE
	for linux-nvme@lists.infradead.org;
	Tue, 17 Sep 2024 20:42:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AE528A40BA8;
	Tue, 17 Sep 2024 20:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD51C4CEC6;
	Tue, 17 Sep 2024 20:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726605777;
	bh=TMRd4Ct+X1vXdb7D+t1i3Sil5lbPkF4ByWGk3IsX2Hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kx5owZAXMiusFrPRfxPXx6T5eQZ8RKib2xeicQ6b7FPQkdkGTNHvJWWGB3izaU3lN
	 ws5F8nzw/B+vxG+I7TB3qTkN7b2fCd7BNFYiD7ff7+1ZtTAYfg3jCbRv4V15io2jyo
	 rIPNb2BrVhSCGtG+IkvNtVng9yY34jn9YVizzxv8=
Date: Tue, 17 Sep 2024 22:42:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>
Subject: Re: [PATCH] driver core: fix async device shutdown hang
Message-ID: <2024091753-estate-legroom-5d62@gregkh>
References: <20240917201517.1145331-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917201517.1145331-1-stuart.w.hayes@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240917_134258_867774_9AA1BB1B 
X-CRM114-Status: GOOD (  13.22  )
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

On Tue, Sep 17, 2024 at 03:15:17PM -0500, Stuart Hayes wrote:
> Modify device_shutdown() so that supplier devices do not wait for
> consumer devices to be shut down first when the devlink is sync state
> only, since the consumer is not dependent on the supplier in this case.
> 
> Without this change, a circular dependency could hang the system.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

What commit id does this fix?  Should it go to stable?

And what driver is causing this problem, is this a regression or for
something new that just got added to the tree?

thanks,

greg k-h

