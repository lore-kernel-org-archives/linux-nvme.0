Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1913D3C54E
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 05:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zrIZBfwiOfd2VeKYISK7qdMVwMDDbJtvjdAuRf4HRCE=; b=NG7rh9UXFmiyN6vrWIIKngVWVE
	sJiHJ7tv6o0eyPDQgSIlDKDw9Q+NH03ldreuswgAjyeUQEQ1TVNTmdYG7yznAsi3VeIfOxa1ejACG
	DvQgf97ipiOv8s4xFz6cW5flKTWhyMUlsrFNy7ZclMt8Wp93QyomiHvOZCrY29P0qiDrtEDNpkLX/
	vcTZvW3OglRen6Sdgw5B2150PUbijlpsi2zUEJEAoX4GJ47oUXjgnIr23rsN/3irGH8Mpr1EVgWIx
	aLasgkY/SF6aA/EKXkvK7Qe9F/JREXwzEw7zVZwYVBOs8OQgBoJZkqsopnayaQ8ZToRqb+9jnzgwy
	aPQIRbKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1fyJ-0000000H2gh-2Jz7;
	Fri, 18 Oct 2024 05:56:23 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1fs4-0000000H185-0OEs
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 05:49:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 397CDA445DE;
	Fri, 18 Oct 2024 05:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD3DC4CEC3;
	Fri, 18 Oct 2024 05:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729230594;
	bh=hKS4vmBWWMoYIGu21fHqLzEas0MmTWeORGm1/vmtlOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y4jlaY+qtS3/Tevld4aw0Mh0MjD4jme5QzUbdHcttzQoHfPrUlzqAdbP1Z2ldv4c1
	 5ZYpUW9ZdL1ZYzgT9XVRIH0DjlbZLGLC0+zljmajyXoE25aCBw5IbstZFos8nWTTQZ
	 WIfRygcw34XTYv6xbddkWC0+k8gAVfGfBH6Ihhxg=
Date: Fri, 18 Oct 2024 07:49:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH v9 0/4] shut down devices asynchronously
Message-ID: <2024101809-granola-coat-9a1d@gregkh>
References: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
 <BN7PR02MB41480DE777B9C224F3C2DF43D4792@BN7PR02MB4148.namprd02.prod.outlook.com>
 <SN6PR02MB41571E2DD410D09CE7494B38D4402@SN6PR02MB4157.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41571E2DD410D09CE7494B38D4402@SN6PR02MB4157.namprd02.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_224956_279559_F1BD3345 
X-CRM114-Status: GOOD (  46.23  )
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

On Fri, Oct 18, 2024 at 03:26:05AM +0000, Michael Kelley wrote:
> From: Michael Kelley <mhklinux@outlook.com> Sent: Thursday, October 10, 2024 9:22 PM
> > 
> > From: Stuart Hayes <stuart.w.hayes@gmail.com> Sent: Wednesday, October 9, 2024 10:58 AM
> > >
> > > This adds the ability for the kernel to shutdown devices asynchronously.
> > >
> > > Only devices with drivers that enable it are shut down asynchronously.
> > >
> > > This can dramatically reduce system shutdown/reboot time on systems that
> > > have multiple devices that take many seconds to shut down (like certain
> > > NVMe drives). On one system tested, the shutdown time went from 11 minutes
> > > without this patch to 55 seconds with the patch.
> > 
> > I've been testing this series against a 6.11.0 kernel in an Azure VM, which
> > is running as a guest on the Microsoft Hyper-V hypervisor. The VM has 16 vCPUs,
> > 128 Gbytes of memory, and two physical NVMe controllers that are mapped
> > into the VM so that it can access them directly.
> > 
> [snip]
> > 
> > But here's the kicker:  The overall process of shutting down the devices
> > took *longer* with the patch set than without.  Here's the same output
> > from a 6.11.0 kernel without the patch set:
> > 
> [snip]
> > 
> > Any thoughts on what might be causing this?  I haven't gone into the
> > details of your algorithms for parallelizing, but is there any extra
> > overhead that could be adding to the time? Or maybe this is
> > something unique to Hyper-V guests. The overall difference is only
> > a few 10's of milliseconds, so not that big of a deal. But maybe it's
> > an indicator that something unexpected is happening that we should
> > understand.
> > 
> > I'll keep thinking about the issue and see if I can get any more insight.
> 
> I've debugged this enough to now know what is happening. I see the
> same behavior in two different environments:
> 
> 1) A Hyper-V VM with 8 vCPUs running on my local laptop. It has
> no NVMe devices, so there's no opportunity for parallelism with this
> patch set.
> 
> 2) A Raspberry Pi 5 with 4 CPUs. Linux is running on the bare metal.
> It has one NVMe device via the Pi 5 M.2 HAT.
> 
> In both cases, the loop in device_shutdown() goes through a lot of
> devices:  492 in my Hyper-V VM, and 577 in the Pi 5. With the code
> in this patch set, all the devices get added to the async_wq in
> kernel/async.c. So async_wq quickly gets heavily populated.
> 
> In the process, the workqueue code spins up additional worker threads
> to handle the load.  On the Hyper-V VM, 210 to 230 new kernel
> threads are created during device_shutdown(), depending on the
> timing. On the Pi 5, 253 are created. The max for this workqueue is
> WQ_DFL_ACTIVE (256).
> 
> Creating all these new worker threads, and scheduling and
> synchronizing them takes 30 to 40 milliseconds of additional time
> compared to the original code. On the Hyper-V VM, device_shutdown()
> completes in about 5 millisecond with the original code, and +/- 40
> milliseconds with the new async code. The Pi 5 results are more
> variable, but also have roughly 30 to 40 milliseconds additional.
> 
> Is all this extra work a problem? I don't know. Clearly, there's big
> benefit in parallelizing the NVMe shutdown, and in those situations
> the extra 30 to 40 milliseconds can be ignored. But I wonder if there
> are other situations whether the extra elapsed time and CPU
> consumption might be a problem.
> 
> I also wonder about scalability. Does everything still work if
> device_shutdown is processing 5000 devices? Is there a possibility
> of deadlock if async_wq can only have 256 active items out of
> 5000 queued ones?

In talking with someone off-list about this yesterday, we guessed that
this was the "thundering herd" problem that might be happening, and you
went and proved it was so!  Thanks so much for doing this work.

I don't think we can put this type of load on all systems just to handle
one specific type of "bad" hardware that takes long periods of time to
shutdown, sorry.

Also think of systems with tens of thousands of devices connected to
them, with tiny 31bit processors (i.e. s390), shutting those down and
spinning up a thread for all of those devices is sure to cause us real
problems.

thanks,

greg k-h

