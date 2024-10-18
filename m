Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185FCD2FFE0
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 09:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tztq9Ibnt9AecApjTy82GLjkPbi9MxacR6bxD92MGPE=; b=hTCPGMJmXlGyoaD9llUAwGsxji
	S6d2xR7SbAkeN5SLKqI7K7aZzz1da8LNZzebPt2wRmLkNcWtULgG6HfF+Cxx5TWwJct2aNfwD762P
	EgEMI6EBjDSslMRgRfCu3hJkWs3kwEVnSuq6sycjRlrw7k/3m+jvHujd2yYTvw+qmLtK4VK5FqHMQ
	xYPbRwYIiPpW7Zdz+59/FxzTqFGYHbz0uqjuJXig/lR4sgxCOI2ODhRn+IcHgAZTeL8YjFpMxlSYt
	9AYPOABNBSvvrFuFMChQANlV/Wb+hoUuSo6uOh7IcENBuj0g4lAKHUOQfy4Lf/zz6/25lP5K2LGul
	cQxKwXRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1jRU-00000000DFJ-2zrS;
	Fri, 18 Oct 2024 09:38:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1jQK-00000000D6W-1aDN
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 09:37:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4E22B5C5DE2;
	Fri, 18 Oct 2024 09:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A87C4CEC3;
	Fri, 18 Oct 2024 09:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729244251;
	bh=3tfw6kwha5dEhRJgoh+7ac3boOs7M6p7ZM1zuo9oEZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YAJLw9IcO5pq9FnAUFToJ0U9LydlHRNXgqwAr4ArIBV5VhwzOpgsE//ZA3YlXYE4y
	 DERLl+d6plZH5aL3z/0An9svl2x9B6DL81/emeu/NSoU3RtU6ag0W2f1eUdHFpvtbD
	 9eInJ1TCCHWoV6cYB8VJ8Jr8pg8b6TB+9IJCyRp8=
Date: Fri, 18 Oct 2024 11:37:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Michael Kelley <mhklinux@outlook.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH v9 0/4] shut down devices asynchronously
Message-ID: <2024101808-subscribe-unwrapped-ee3d@gregkh>
References: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
 <BN7PR02MB41480DE777B9C224F3C2DF43D4792@BN7PR02MB4148.namprd02.prod.outlook.com>
 <SN6PR02MB41571E2DD410D09CE7494B38D4402@SN6PR02MB4157.namprd02.prod.outlook.com>
 <2024101809-granola-coat-9a1d@gregkh>
 <ZxInC1U7WiB7FNkJ@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxInC1U7WiB7FNkJ@wunner.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241018_023732_484775_F07C4FF8 
X-CRM114-Status: GOOD (  17.07  )
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

On Fri, Oct 18, 2024 at 11:14:51AM +0200, Lukas Wunner wrote:
> On Fri, Oct 18, 2024 at 07:49:51AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Oct 18, 2024 at 03:26:05AM +0000, Michael Kelley wrote:
> > > In the process, the workqueue code spins up additional worker threads
> > > to handle the load.  On the Hyper-V VM, 210 to 230 new kernel
> > > threads are created during device_shutdown(), depending on the
> > > timing. On the Pi 5, 253 are created. The max for this workqueue is
> > > WQ_DFL_ACTIVE (256).
> [...]
> > I don't think we can put this type of load on all systems just to handle
> > one specific type of "bad" hardware that takes long periods of time to
> > shutdown, sorry.
> 
> Parallelizing shutdown means shorter reboot times, less downtime,
> less cost for CSPs.

For some systems, yes, but as have been seen here, it comes at the
offset of a huge CPU load at shutdown, with sometimes longer reboot
times.

> Modern servers (e.g. Sierra Forest with 288 cores) should handle
> this load easily and may see significant benefits from parallelization.

"may see", can you test this?

> Perhaps a solution is to cap async shutdown based on the number of cores,
> but always use async for certain device classes (e.g. nvme_subsys_class)?

Maybe, but as-is, we can't take the changes this way, sorry.  That is a
regression from the situation of working hardware that many people have.

thanks,

greg k-h

