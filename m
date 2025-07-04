Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83524C83F03
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jul 2025 14:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FlQPn2sHWp1k8A+kShoH+cl9CqxTXVfmDisf36mJ3PM=; b=ABAM9TL0Up1QQbhcwFhzul2V4q
	qIhUSCtGF7zJGR+qGYgsHfRLw99RuhkundjNSZMZ0RoUBMu0BnGFgzi33n0sUGvpYpXZzTF+EA/U+
	krpGdSOfjrKC/SN2OVqu6HMEUUYe9jQxpCMjow5/xZZzuNwA6EYK9rhlLglx0BCX1IwUREymG00KI
	AG1W2fQZEVI9DK/1Ni843ShL87GJ0gcSGWWYq16fm8Sn9hKunuzYzYjPkGF5z53PNW6wGegQHAq1x
	hzo2Nqo/KcZcl0nKcwdMRCIcfBmQutbbX+RSdmyof8/5MWpbVFpQ0QyPkjTzJJYpU9hnmt1ypFGk9
	btqBJr8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXhRC-0000000EfuJ-18mV;
	Fri, 04 Jul 2025 14:30:50 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXhAm-0000000EdOR-3NL0
	for linux-nvme@lists.infradead.org;
	Fri, 04 Jul 2025 14:13:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E0F2BA53C68;
	Fri,  4 Jul 2025 14:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3511C4CEE3;
	Fri,  4 Jul 2025 14:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751638431;
	bh=XCXY0hdMPiwoxIy7NjLRfUW+PFoT6QLeCJ7ONYRjoLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GWJ56djs5EVcj5vZ0V8Lid01iehqE4UQEL5JLbMyTCobCze7PGMhuP0Zc24FK1XF1
	 S86BpFCcsYgd1e8ikKo7WyZ1vb9HIN6PK/rDR0zj5NJECBgjZHmfWYht2FlyLk4LW3
	 KrpM4hGGL/P799y92Xd4Zuq8YUMDj/ag5FdWlZ9k=
Date: Fri, 4 Jul 2025 16:13:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: David Jeffery <djeffery@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Stuart Hayes <stuart.w.hayes@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Jeremy Allison <jallison@ciq.com>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH v10 0/5] shut down devices asynchronously
Message-ID: <2025070438-apache-sprawl-0cbc@gregkh>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
 <20250703114656.GE17686@lst.de>
 <CA+-xHTH2rxWwAao0EuNbhubqA2mrXOTZ7r1p-hcTieieomx75g@mail.gmail.com>
 <2025070408-starlight-pandemic-0266@gregkh>
 <CA+-xHTFKh0VUJ0r4K5L5b0dmrs9d1+cNkqf4HvKa4E-r_+u2CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-xHTFKh0VUJ0r4K5L5b0dmrs9d1+cNkqf4HvKa4E-r_+u2CA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_071352_905574_4D772528 
X-CRM114-Status: GOOD (  23.17  )
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

On Fri, Jul 04, 2025 at 10:09:01AM -0400, David Jeffery wrote:
> On Fri, Jul 4, 2025 at 9:45 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Jul 04, 2025 at 09:38:15AM -0400, David Jeffery wrote:
> > > On Thu, Jul 3, 2025 at 7:47 AM Christoph Hellwig <hch@lst.de> wrote:
> > > >
> > > > On Wed, Jun 25, 2025 at 03:18:48PM -0500, Stuart Hayes wrote:
> > > > > Address resource and timing issues when spawning a unique async thread
> > > > > for every device during shutdown:
> > > > >   * Make the asynchronous threads able to shut down multiple devices,
> > > > >     instead of spawning a unique thread for every device.
> > > > >   * Modify core kernel async code with a custom wake function so it
> > > > >     doesn't wake up threads waiting to synchronize every time the cookie
> > > > >     changes
> > > >
> > > > Given all these thread spawning issues, why can't we just go back
> > > > to the approach that kicks off shutdown asynchronously and then waits
> > > > for it without spawning all these threads?
> > > >
> > >
> > > The async subsystem fix is something that should be fixed regardless
> > > of async shutdown. Async shutdown's use just exposed its thundering
> > > herd behavior which is easily fixed.
> >
> > Great, then please submit that on its own and get the maintainer of that
> > subsystem to agree and accept it as I have no way to judge that code at
> > all.
> 
> Unfortunately, it does not have a maintainer listed and sees limited
> activity. Would CC-ing some of the recent developers of kernel/async.c
> to ask them to review be recommended in this situation?

Like any other piece of the kernel, yes :)


