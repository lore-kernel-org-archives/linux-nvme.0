Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85C5C25B4F
	for <linux-nvme@archiver.kernel.org>; Sun, 12 May 2024 22:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d8SF7imfPRExwKfvWE8Kcsqi/4l0YM8MLX6OFr14XyM=; b=iYxwnbtckP0op684lSI12501Z+
	AfrPCK9z63eSk/o21xmvMg+qwEtUdRtJ4s9bs2XxBkO0kYoK7RUgD73JeRBxhoB5mdAiDv/oWBKTs
	WxRxlPIr/3O1QuYhlmIbt4BqfpUpYfYspLdjUZJny/2N0F4AkuCNQWPpMzxcLNMFZeR4Kit8pC/mm
	VJx3BALRMJRyP/+6E9JuoT5q0FmMQYD5wRx0dAMI+0GdCKDs6pgkaevkx6VcmDfIotKxNwMk+JAHb
	35oMwT+cfWhePlz9lg5/HV3TDcrQEJwDiOFM1z0H34uBHffHHjgQ3P47QJWvxfpS0R3gZ7k9k2/q6
	F7WJ2BbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6HJw-0000000Aum1-2tSd;
	Sun, 12 May 2024 22:05:28 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6HJs-0000000AulA-2YMN
	for linux-nvme@lists.infradead.org;
	Sun, 12 May 2024 22:05:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 984FE60B89;
	Sun, 12 May 2024 22:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B59C116B1;
	Sun, 12 May 2024 22:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715551521;
	bh=m/u0C8tgIfK1RYveBkGN4xXuJiEU++a20yHhjFgSTQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+lIJNR7KaWhLYtPwO7pJxiRA+zQ7zFVzM9xhgKsM3+Ybi45lousp5Ym6/qROJkeA
	 dgogKpTq2Nk18qhmNVTrXEL3ROW0FyOKC554T7WIWltnucepZKR9a9FaWJs6PUalNF
	 T9kYcKv94drxI0dmgSNxHNqMQVsiBrNx6k1ecie2r4KatEVIyghVxNPf621wlNxgCz
	 bMIBkJQbnbDuC+HNv3wY+wg0bd8zYIOJEmhtkhtul40HLbW/mtSPc21VNrgLB7cK3j
	 H3Q2kxQpcJNmXTLjTOqs7Dq+o1H4RiVjrV7nGZvxCvQI//W6zo4ReGEVxF9CaCTJx0
	 vbhZ3O9a2pK5Q==
Date: Sun, 12 May 2024 16:05:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: [PATCHv2] nvme-pci: allow unmanaged interrupts
Message-ID: <ZkE9H3dpE6E5xHzf@kbusch-mbp.dhcp.thefacebook.com>
References: <20240510174645.3987951-1-kbusch@meta.com>
 <Zj6yDtRzl68zspQY@fedora>
 <Zj6745UDnwX1BteO@kbusch-mbp.dhcp.thefacebook.com>
 <Zj6/gqxxDD74IYR6@fedora>
 <d6e8c980-7be7-4902-b466-79dc4b9beb17@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6e8c980-7be7-4902-b466-79dc4b9beb17@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240512_150524_727998_7EE3E170 
X-CRM114-Status: GOOD (  22.15  )
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

On Sun, May 12, 2024 at 05:16:13PM +0300, Sagi Grimberg wrote:
> 
> > > Everyone expects nvme performance will suffer. IO latency and CPU
> > > efficieny are not everyone's top priority, so allowing people to
> > > optimize for something else seems like a reasonable request.
> > I guess more people may be interested in 'something else', care to share
> > them in the commit log, cause nvme is going to support it.
> 
> I don't have a special interest in this, but I can share what I heard
> several
> times. The use-case is that people want to dedicate a few cores to handle
> interrupts so they know it does not take cpu time from their application
> threads
> that are running (usually pinned to different cores).
> 
> The app threads isolation is more important to them than affinity to the
> device...

Yes, that is consistently the same reasoning I've heard. While managed
irq is overwhelmingly the best choice for most use cases, it's clearly
been communicated that some users do not want it for exactly this
reason.

As far as I can tell, there's no techincal reason to prevent letting
people make that choice. This "kernel knows better than you" argument is
less sustainable than letting users do whatever they want with their
CPUs.

> > > > Is there any benefit to use unmanaged irq in this way?
> > > The immediate desire is more predictable scheduling on a subset of CPUs
> > > by steering hardware interrupts somewhere else. It's the same reason
> > > RDMA undid managed interrupts.
> > > 
> > >    231243c82793428 ("Revert "mlx5: move affinity hints assignments to generic code")
> > The above commit only mentions it becomes not flexible since user can't
> > adjust irq affinity any more.
> > 
> > It is understandable for network, there is long history people need to adjust
> > irq affinity from user space.
> 
> I suspect that the reasoning is similar to nvme as well.

+1, exactly.

