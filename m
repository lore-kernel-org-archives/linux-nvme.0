Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2484C4345F
	for <linux-nvme@archiver.kernel.org>; Thu,  2 May 2024 08:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5dYYBVqEhw8WQInWDK199EhWFJRWWZznG2ekd940vGE=; b=f5fUX0QgSBrDCSNVtbJas4wD1b
	qKaxcsb6UmUkvEGYM1e7lqvv/rYSBWZoFGOJ76gZ3RC20f8TopeC0mqW9a5bfShOtL5qLFYX3vd50
	eUREYbdgs2yVChbXig36DGsKrJ2doKGHHJugxCeqWmrNmWaak0S4L/Pb26TXgaOUHBqi3hDMD9kC0
	UEni2lDsd2wCXdS0Jh8gxYxsXRP2NWUKJK6p4oYc8fjamTQwF6FEh5z/w1qoYlUIeBsFhCz+06ZXh
	iaS6QOF6fxc3/7/l9x1Yr1WGh/AnarFbQCoV6/XO8CYzcwF6hYrVwA5GivXIf3fw/QVyL9VJtTYYw
	77QHcabA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2S2c-0000000C0dl-0oNK;
	Thu, 02 May 2024 08:43:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2S2Z-0000000C0dE-0e0x
	for linux-nvme@lists.infradead.org;
	Thu, 02 May 2024 08:43:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4FCE060B32;
	Thu,  2 May 2024 08:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F97CC116B1;
	Thu,  2 May 2024 08:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714639420;
	bh=auh5dHeyLQ0WHUwxn16UYoQAmo0A7838S8nH5FcQ5NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DUgEbZv1TQwB3yEhSYSi8JCopvnEETOvsYF/4+3aEC/MjHm8GKYOGQZY3nq7QCdrN
	 LlNJrCjd6ghoara3bivJegogstbJODGUxVuqRs7tYvkcDM1G4sTX3alLqZe2yzGlrN
	 jV+ay9nuyzGOhTGaaOJ3wDRxZviDHzbOAFL1Yfea12NJtpiqCmY5gVzxv3oSsbMinW
	 SKwTl86ldsTC/5SIHDxkr/lf1RtV2aiijVVEx+A42F9L+biRnKiw3oY0bcZJ3Co/Z/
	 IOM/8Ym9PNPQc/iTgHNedclrnElu4pOIG/jk73dnP2ijR4wWtKUIfxQ9e1GVX+qJ1y
	 or40+THoaxvdA==
Date: Thu, 2 May 2024 09:43:36 +0100
From: Keith Busch <kbusch@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: `nvme_disable_ctrl()` takes 411 ms on a Dell XPS 13 with SK
 hynix PC300 NVMEe
Message-ID: <ZjNSOEfDMgqJW01F@kbusch-mbp.dhcp.thefacebook.com>
References: <19a6071a-7fb8-4e0f-8050-6f3ba5ee4774@molgen.mpg.de>
 <20240501045145.GA32110@lst.de>
 <ZjH2Coc8Wz9QrdRM@kbusch-mbp.dhcp.thefacebook.com>
 <93c29602-b162-47b3-9a03-a18158b9f6ef@molgen.mpg.de>
 <ZjK8IjHfwpAMQajT@kbusch-mbp>
 <1c826b9a-4b21-43c8-9064-c3ab095307c5@molgen.mpg.de>
 <522a8fd6-5865-4e8a-b8e8-b0288dfe384a@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <522a8fd6-5865-4e8a-b8e8-b0288dfe384a@molgen.mpg.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240502_014343_265575_ADF0009D 
X-CRM114-Status: GOOD (  18.00  )
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

On Thu, May 02, 2024 at 08:12:39AM +0200, Paul Menzel wrote:
> > > That doesn't seem too hard to believe to me. A safe shutdown can often
> > > take a while time for an SSD. I've seen other implementations orders of
> > > magnitude worse than what you're showing.
> > 
> > But why? Due to physics or due to "slow" firmware?

Maybe both? The run time metadata doesn't necessarily match the on-disk
format, and constructing that can take a moment. These device's CPUs are
usually the cheapest the vendor could get that satisifies a run-time
performance target, so may be under powered for computational tasks.

And it may also have to flush pending user data from its internal
memory, which could be a few GB.

Lower end devices don't even have memory, so may have to make many round
trips to host memory to retreive its metadata then manipulate that to
its on-disk format.

Maybe this could be better optimized, but vendors may not consider
shutdown time to be a high priority.

This gets worse as you add more nvme devices to your system because
shutdown is serialized. Some of us have proposed patches parallelizing
this process. I wish I could spend more time on helping see that to
completion, but other priorities get in the way. :(

> > So this confirms the ftrace findings. Excuse my ignorance, so the
> > time-out is in seconds? And how does this relate to the rtd3e value (410
> > ms /= 60 ms /= 5 s(?)?

The driver provides a user tunable parameter to specify the minimum
timeout value, and it defaults to 5 seconds.

  nvme_core.shutdown_timeout=<time_in_seconds>

The driver selects this or the advertised rtd3e, whichever is greater.
We can't trust device's to report this correctly (and NVMe 1.0 didn't
even provide a way for a device to report an expected shutdown time), so
this exists to prevent unsafe shutdowns. Devices are supposed to survive
an unsafe shutdown, but it's best to avoid that path.

The parameter is in granularity of seconds because the NVMe 1.0 spec
said to "wait at least one second" for a shutdown to complete. Not the
most clear wording for a spec, but that's where we started.

