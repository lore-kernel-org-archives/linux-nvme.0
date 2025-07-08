Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AC8C83030
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jul 2025 00:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mw0H4znRNvFOsCeoBJhqxSDJMZoZ+H5yrQMWI0sghlk=; b=soIRFIABq6/n7qFVvUBIYkAZKv
	QG39aIX9iQp/pz6QzaebTTyFa/8pAIcJUsgjEM5j9RC/zPMkhavbIclWh5OVC7KXZk7ueNKsbe/Is
	p1BUvqZJo9878N0fpWATc29r/hUbJZVxNT0KaCPDG9VbH1Tp96l3usNRa0gTr74Coc0wRJt2gFhtP
	7tkC1suoEYy5hgeccG6OGR8pf3GxLlIgzqUwT2pMUto3JYLGFzZgf80NlF0ONGdC5Nnz02rcIawGP
	moS6GRelEsVs7Tet9ik/BoVaSNL0Cz3/6/Dq2zZ6Usl8DdrfQUTpaWQMe8g1Lga2L4G5Pxn/pu4Sk
	T6Ik8u0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYvnn-00000003pRY-3wjw;
	Tue, 08 Jul 2025 00:03:15 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYvlI-00000003p76-1Hrn
	for linux-nvme@lists.infradead.org;
	Tue, 08 Jul 2025 00:00:41 +0000
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-73c17c770a7so4655035b3a.2
        for <linux-nvme@lists.infradead.org>; Mon, 07 Jul 2025 17:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1751932839; x=1752537639; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mw0H4znRNvFOsCeoBJhqxSDJMZoZ+H5yrQMWI0sghlk=;
        b=ZHah7rmeLzBGyuL3gBy9JMoN1S75mZmjLjwQqJSsagy9AGkjcm7fRjU79y0xQ69Fbw
         7GZ09K4W5t1q1h9DFI17e5MyGD8iI2neOMlINfQE+s6Eq91MAzePHhJ13Dh80MuxHJQP
         +Drw19y/tMl2cHGsXGUKJ8gCKD0UDF+4+x0hZWCL62U253ihlZivil9QfKin7OQUKCnc
         o2A/gd+4+GgOl7Cq0m4prizJucodxsBW261bRE1d+WIWIii9JpCjYl++hC9csd/gPfMP
         uMcpeQdOC2wiAePeLX22Y+ao49O63ke2iYGCvGZO5ZaTrWMx2czD2VQvEZuXXvVRATNL
         ycxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751932839; x=1752537639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mw0H4znRNvFOsCeoBJhqxSDJMZoZ+H5yrQMWI0sghlk=;
        b=F5nXzs1ASfg52DifO4I4TRK7cboTmGUJDOGIHdn93oYxDc+PQkZXsPRisqcVdj576Q
         gBYnzebOlzapoTEu7e/Gq21PwnXBOZ8gadSiI3Rlz74QA1hcHDBafNXFnm38TaoBZ2Hg
         OTeY11c3KhHalyHxcMHWJK10kC9lI8I5EchIG7PJHd1wmWfFNMYl0+gUT2u4yIDKgK6z
         CtSTlQZAvWvngcOlJA3NSKawmhZGUAQ5BdV5BHROiiO1G37oqa7+CBI62e7lAW0kON9I
         VNE4NwP3a0nw6s23Nsga6l2yh94sUozwp2ojy53qqk9Exzv9mpcnnpaOJdOTzWMiDoJE
         7vJg==
X-Forwarded-Encrypted: i=1; AJvYcCWHS56UPejNs36ymcu8ILMscB0+TzdqMP7g2+B2e7+P7hK7gQsDbnzuwnC11DPzrGeyrYVVmCffYlVv@lists.infradead.org
X-Gm-Message-State: AOJu0YxA1dfKuC2sLi2xYlE/MfFmFyYBLvFOxxk0sIm14NSPmCQK8rlC
	inarrlJToimc4t1tO8MF3kkvC38Aq9UdNmRKHShgRZc8clzHdHvH5rJZmGvho55uJlb0om+KoVr
	qkmov2TSUjCWxZSz7
X-Gm-Gg: ASbGncu27p56ZgPlENFBasxghi6WkIy7KMxfwRUrIQgobYr7sFs26WxDpsn/Lt0US7f
	vQzIO2dbCSFy1FINaPg9biNigC98Q9C8A5hlGV/IxYVaqfHI86gjs5DZczwmPhOJMPbR6nkfrCt
	1B36GKTynHKb1Si37Pc+Qd1zYVRI9RFpwAmCJFQwY/owviafo0mjfkd1gc3QNOXnkIE6Am6q7Pa
	wMqndnDs3EwSPcdVCLu8o1OU6FWDG9QFjRIt5xOZFXYYYxU/zvbPX80Rma+3Rz52xGBLTyJ4tjb
	fnGm+g8tfOE0k73A3xjgbBa0bIaZHEdC3zmtyGwWbaUFEeUFVO+euu6z6toIf0li
X-Google-Smtp-Source: AGHT+IGwh8MkxUmtG3ny5yTUcyZnjRvVq1ckz8zzVP3GrObaG6Q3EN4p91gwmyWqH3fRaVfkvH14hg==
X-Received: by 2002:a05:6a00:3991:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-74ce8833fbamr23918640b3a.3.1751932838774;
        Mon, 07 Jul 2025 17:00:38 -0700 (PDT)
Received: from sultan-box ([142.147.89.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce359ead0sm10280841b3a.8.2025.07.07.17.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 17:00:38 -0700 (PDT)
Date: Mon, 7 Jul 2025 17:00:34 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: stuart hayes <stuart.w.hayes@gmail.com>,
	David Jeffery <djeffery@redhat.com>
Cc: Jeremy Allison <jra@samba.org>, Christoph Hellwig <hch@lst.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Jeremy Allison <jallison@ciq.com>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH v10 0/5] shut down devices asynchronously
Message-ID: <aGxfoqccqot9t9SB@sultan-box>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
 <20250703114656.GE17686@lst.de>
 <aGaklKejxefXTQB4@jeremy-HP-Z840-Workstation>
 <CA+-xHTFC6KTs6D8EdvmVe=buqw9oN5P7GJ-WWvam6M3SzeZF4g@mail.gmail.com>
 <aGgAuje4tpIOveFc@sultan-box>
 <CA+-xHTFNRwbxH=zNMM4kasB=kUAne0b6cxPM+sq5FyM32k8peg@mail.gmail.com>
 <fd941519-6f71-4286-9517-2dc861ee99a5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd941519-6f71-4286-9517-2dc861ee99a5@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250707_170040_522908_006BCA41 
X-CRM114-Status: GOOD (  51.28  )
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

On Mon, Jul 07, 2025 at 03:49:44PM -0500, stuart hayes wrote:
> On 7/7/2025 10:34 AM, David Jeffery wrote:
> > On Fri, Jul 4, 2025 at 12:26 PM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> > > 
> > > On Fri, Jul 04, 2025 at 09:45:44AM -0400, David Jeffery wrote:
> > > > On Thu, Jul 3, 2025 at 12:13 PM Jeremy Allison <jra@samba.org> wrote:
> > > > > 
> > > > > On Thu, Jul 03, 2025 at 01:46:56PM +0200, Christoph Hellwig wrote:
> > > > > > On Wed, Jun 25, 2025 at 03:18:48PM -0500, Stuart Hayes wrote:
> > > > > > > Address resource and timing issues when spawning a unique async thread
> > > > > > > for every device during shutdown:
> > > > > > >    * Make the asynchronous threads able to shut down multiple devices,
> > > > > > >      instead of spawning a unique thread for every device.
> > > > > > >    * Modify core kernel async code with a custom wake function so it
> > > > > > >      doesn't wake up threads waiting to synchronize every time the cookie
> > > > > > >      changes
> > > > > > 
> > > > > > Given all these thread spawning issues, why can't we just go back
> > > > > > to the approach that kicks off shutdown asynchronously and then waits
> > > > > > for it without spawning all these threads?
> > > > > 
> > > > > It isn't just an nvme issue. Red Hat found the same issue
> > > > > with SCSI devices.
> > > > > 
> > > > > My colleague Sultan Alsawaf posted a simpler fix for the
> > > > > earlier patch here:
> > > > > 
> > > > > https://lists.infradead.org/pipermail/linux-nvme/2025-January/053666.html
> > > > > 
> > > > > Maybe this could be explored.
> > > > > 
> > > > 
> > > > Unfortunately, this approach looks flawed. If I am reading it right,
> > > > it assumes async shutdown devices do not have dependencies on sync
> > > > shutdown devices.
> > > 
> > > It does not make any such assumption. Dependency on a sync device is handled
> > > through a combination of queue_device_async_shutdown() setting an async device's
> > > shutdown_after and the synchronous shutdown loop dispatching an "async" shutdown
> > > for a sync device when it encounters a sync device that has a downstream async
> > > dependency.
> > > 
> > 
> > Yes, but not what I think fails. This handles a sync parent having an
> > async child. It does not handle the reverse, a sync child having an
> > async parent.
> > 
> > For example, take a system with 1 pci nvme device. The nvme device
> > which is flagged for async shutdown can have sync shutdown children as
> > well as a sync shutdown parent. The patch linked pulls the async
> > device off the shutdown list into a separate async list, then starts
> > this lone async device with queue_device_async_shutdown from being on
> > the async list. The device then is passed to the async subsystem
> > running shutdown_one_device_async where it will immediately do
> > shutdown due to a zero value shutdown_after. The patch sets
> > shutdown_after for its parent, but there is nothing connecting and
> > ordering the async device to its sync children which will be shutdown
> > later from the original device_shutdown task.
> > 
> > > > Maintaining all the dependencies is the core problem and source of the
> > > > complexity of the async shutdown patches.
> > > 
> > > I am acutely aware. Please take a closer look at my patch.
> > > 
> > 
> > I have, and it still looks incomplete to me.
> > 
> > David Jeffery
> > 
> 
> Also, the way it is implemented, it could hang if there isn't enough memory
> to queue up all of the async device shutdowns before starting the
> synchronous shutdowns.
> 
> When you call async_schedule_domain() and there's not enough memory to
> allocate an async_entry, the async function will be run immediately. If that
> happens when queuing up the async shutdowns, it could easily hang if there
> if there are any dependencies requiring an async device shutdown to have to
> wait for a synchronous device to shutdown, since none of the synchronous
> shutdown devices have been scheduled yet.

Understood. Thank you both for the clarifications.

Regarding an async device with a sync child: this case strikes me as odd. What
exactly makes the child device require "synchronous" shutdown? Synchronous
relative to what, specifically?

This also makes me question what, exactly, the criteria are for determining that
a device is safe to shut down "async". I think that all children of an async
shutdown device should be enrolled into async shutdown to isolate the entire
async dependency chain. That way, the async shutdown devices don't need to wait
for synchronous shutdown of unrelated devices. I'm happy to do this in a v3.

Regarding async_schedule_domain() running synchronously when async_entry
allocation fails: this is a bothersome constraint of the async helpers. Although
there is a lot of overlap between the async helpers and the requirements for
async device shutdown, there are other annoying constraints that make the async
helpers unfit as-is for async device shutdown (like the arbitrary MAX_WORK
limit).

The async helpers also don't do exclusive wakes, which leads to the behavior you
observed in "[PATCH v10 1/5] kernel/async: streamline cookie synchronization".
We could use exclusive wakes by isolating async shutdown device dependency
chains and creating a different async_domain for each chain, which is faster
than calling TTWU on all async waiters and filtering out the wakeups ad hoc.

These points make me think that either the async helpers should be made far more
generic or the driver core code should have its own async infrastructure.

> Before your patch, all device shutdowns are scheduled in order such that if
> the call to async_schedule_domain() runs the function immediately, it will
> still be able to complete, it just won't get the benefit of multiple threads
> shutting down devices concurrently. The V10 patch maintains that--it just
> lets one thread shut down multiple synchronous devices instead of creating
> one thread for each synchronous device shutdown.

This still dedicates threads to shutting down synchronous devices that don't
share a dependency chain with an async shutdown device. This shouldn't be
necessary.

(PS: fixed CC of Jan Kiszka <jan.kiszka@siemens.com>, who appears to have been
CC'd with a typo'd email address for at least the entire v9 patchset and this
v10 patchset. The CC list had siemens.com misspelled as seimens.com)

Sultan

