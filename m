Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31394C77B60
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Apr 2023 15:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hHNzkumt+Rlx9qttIOpzSeKG9f9iWnfVuge1BRN5GRc=; b=MVKDn/KO83u6+v7vsYu/2Hjb00
	wMF/k/8KEMmEX44w5P0OeSwh+fPmMDFasyPDYowZr3qSDhlEMkw6yROx6CzArISV/x0aOroI3AURg
	BRNuxvhGQwmuTdcmWFDa/e1AYy3Xr5GkyNHhRwONDOsstqNyJeK2UlN5UEn5F4FkCS3NdaH0wdkHE
	WBQN0ibCDm8yEEYoLb96vl7vZGPVM0qbkltAqtrWs2WYXLVnAlR3xwR1JBeJLAiZrzNA1c+njkgqW
	ewDcPDPMdIitPROThIgaDwDG25oeFaMicQJbOl5rA/U+ZZ1R7NrmbIHPsiE78wbCzQ+dwuM1Z3Iad
	3RLzwVcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psQG3-00B928-0X;
	Fri, 28 Apr 2023 15:43:39 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psQFy-00B91c-2J
	for linux-nvme@lists.infradead.org;
	Fri, 28 Apr 2023 15:43:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C4A5A60C4B;
	Fri, 28 Apr 2023 15:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EE9C433D2;
	Fri, 28 Apr 2023 15:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682696613;
	bh=I0cC7l00Yeha121oOxxfd3MYMTmwVMK3kxBdX3h9QYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C4GIGxYKuHlbrpIs+w1yFKLYBs5MGs2hCBqyWm1Ozsq1VQCupGMUQgoswEut+Yhw6
	 4Sz9BHTjqOTG6DXlYDn3pmG3EZiOVCK0KaKGNWA+EDYiiybh/4sXPiSTKW8XaOY7uT
	 KDWgGvjHIxi1qpmKSQ6FyZePpo0rHjgPLD95vB78XnUmr4Igu9awfbllzeHIcBuerP
	 +jfSK5+rTILsaT/twmVP6a0A9ITIc6mil/DCjwes81AMIZ4AIp1BYh7mDTGO+lobnM
	 7yy/3Jcelk07bpRegEIinNInViNGUxX3ohAbWwsuz0HYJedd3D0Tsz3tMI7hp8JWQW
	 zfAiIicaP60zw==
Date: Fri, 28 Apr 2023 09:43:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Wang Yicheng <wangyicheng1209@gmail.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Seeking for help with NVMe arbitration questions
Message-ID: <ZEvpoiDVFuOs8wyw@kbusch-mbp.dhcp.thefacebook.com>
References: <CAPiksxOuMyosYh0Ky==jfRcgWpGs5-4SxwfxpaLND5kHsOpq+w@mail.gmail.com>
 <528f9679-1b07-f3af-c936-06ec1e316720@nvidia.com>
 <CAPiksxOQsF0-p_pwFQQhG7r5WERrRKv9R_w3Bgxp=qCBcPNc+w@mail.gmail.com>
 <ZEre23NoKOB56eDj@kbusch-mbp.dhcp.thefacebook.com>
 <CAPiksxOEFDjHh4OrkcuBCMe59vf8_CE=AHeCN_+yFCe3_ry-2w@mail.gmail.com>
 <ZErr8OV5JRpUityQ@kbusch-mbp.dhcp.thefacebook.com>
 <CAPiksxOu2W62bP9fFuHvxjACz+cvxH58fEkoFvALKFdHax3Tcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPiksxOu2W62bP9fFuHvxjACz+cvxH58fEkoFvALKFdHax3Tcw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230428_084334_832840_B3DCA537 
X-CRM114-Status: GOOD (  28.36  )
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

On Thu, Apr 27, 2023 at 05:36:12PM -0700, Wang Yicheng wrote:
> Thanks a lot Keith! This is very helpful!
> 
> 1. Then do you see a way to prioritize a specific set of IOs (favor
> small writes over large writes) from the IO queue's perspective?
> Initially I was thinking of WRR, which later turned out to be not
> supported. If I want to leverage the IO queues to achieve the same
> goal, from what I understand I can simply send small writes to poll
> queues, and allocate more of those queues. Say on average small writes
> take up 20% of the total IOs. And if I distribute 40% of total queues
> as poll queues, in some sense I give more weight to small writes and
> thus prioritize them.

You might expect that a new command placed on a shallow queue will
be handled ahead of a command place on a deep queue at the same
time. Indeed, some implementation may even show desirable results
with that scheme, but the spec doesn't really guarantee that, though.

For a pure software side solution, you could use an ioscheduler and
set your ioprio accordingly.
 
> > > 3. Say I have only 1 default queue and I submit an I/O from some CPU,
> > > then there can be a chance that the I/O would need to cross CPUs, if
> > > the default queue happens not to be on the same core right?
> >
> > If you only have one queue of a particular type, then the sysfs mq
> > directory for that queue should show cpu_list having all CPU's set,
> > so no CPU crossing necessary for dispatch. In fact, for any queue
> > count and CPU topo, dispatch should never need to reschedule to
> > another core (that was the point of the design). Completions on the
> > other hand are typically affinitized to a single specific CPU, so
> > the complete may happen on a different core than your submit in
> > this scenario.
> 
> 2. You mentioned that completions are affinitized to a single specific
> CPU. And this is exactly what I observed in my test. This also seems
> to cause worse performance. Is there a way to query that affinity or
> is it invisible from outside?

To query a queue's affinity, check /proc/irq/<#>/effective_affinity.
You can check /proc/interrupts to determine which irq# goes with
which queue.

