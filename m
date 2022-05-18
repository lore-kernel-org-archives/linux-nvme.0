Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0DAC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 20:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/LqHVbHkRtSXSWgRorqDL1rnNBZq7KUPq1AfC0mPC/E=; b=5FC30iywKOhu/yBsLgnmOOh+9r
	VE/S0cxoKAP/FjZgm2WTOGEmRdKhxofWObXGVkGNa/dq+/g+i/E3gYXjYP2FAryxtSgSadOg5ya7z
	Ibj7YYhLGUzzYGMVyfAH1ApunFVh8i8jxjjM51d1Ys/O+nADtrxMm+vcMFHZQLtjUfd2fKjunTDkN
	cRWeFXRFKSyfXgJVU0u7vsQ1ai5wnM/LRn4juy1BImmhVF2uc3lJoSknekSYv3KyKfaxE5nG/6w0a
	lnI9ht4XIyolJsdxeL17l2YI4tc2yOwdLBEJKHgFnOF75fA/HCYk4M/pu14v8RexY4kRdtIYvVroT
	n6sMi4eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrQXo-003usz-TD; Wed, 18 May 2022 20:45:20 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrQXl-003urm-9j
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 20:45:19 +0000
Received: by mail-il1-x131.google.com with SMTP id l15so2349809ilh.3
 for <linux-nvme@lists.infradead.org>; Wed, 18 May 2022 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/LqHVbHkRtSXSWgRorqDL1rnNBZq7KUPq1AfC0mPC/E=;
 b=NMSkahHunZrqlzsGNcFHRpOqRGdBCbPIwXcry9fcbtEaPi4EgWh/G3ORW/DTiJJCiR
 2caHmsOY1o2oDg/Lq2mDZc44l7S2DvbYBa/xRoSOrGQLzLQ1VeJFugUH4DpTm/NOUEzQ
 80JzEYq2mYF4QyVkFmhDPslstvCcA6ywYjLNGo9fWtOnlyLkkFYt3RSezI1KpaFPv3Tf
 KMc0lUlcgNA6WE2PCSt1FuIByXJXAoQfD43IljOLeBhBIrejNuY3OeOj96r8LgaG6DGv
 lcudB9Q/FZFVK06KTHbUVhpRwE6f/lRMJYv9f81dbzrujs5UvJTyJPX5/xJwZzoO4Bf2
 dacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/LqHVbHkRtSXSWgRorqDL1rnNBZq7KUPq1AfC0mPC/E=;
 b=TH2VDOXnTw10yarGn/zW1u870iRv7OpSko3aGd4L++ORaRH8X/po0zKuZKCG0i307M
 5kpBNqciKNAR/LOCqknUgzL+hbdQgNpCvIQyNTqtpVFbDs8A3uFkVEI2hQjAd47G1Qfc
 aheW240JwUdSTBub1s3vxOeDnhCtlctV3UfsvWCidKOjOJYM9TL76NWIHgv6gqd9UIAr
 vYfKlLReN9WXnT8xU0MIgd53LMFBNkozynIqcYg++0fMwsyB0MBn3qA2ohygIH0j7mYz
 KWHLoOO7MtwtcEVT+x7gL/uzHqIueg3cGyeBY81PUBFcE1V9NMtYsbbW8eS4YtFI9WvQ
 ALJg==
X-Gm-Message-State: AOAM532khV+M85HlYrN52HDyPmPj5+p8bVgoSyEuFghYoEe5OT7kBSNa
 ET/JLJ7l8PVJucMz4mLoRzXQU2RGL2cMQ3rHcL0gjw==
X-Google-Smtp-Source: ABdhPJx1Ez6BpUQnbL8AlNoGX541z5V/MXG31cj11qq+Au56qG8lqli8zs9VnjmgQGsyu7jqJzGrzQ5OuwzUdlo/wrE=
X-Received: by 2002:a92:cc11:0:b0:2d1:129:e1e9 with SMTP id
 s17-20020a92cc11000000b002d10129e1e9mr851387ilp.211.1652906712429; Wed, 18
 May 2022 13:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0ibBw41YSfSWF1CtY7w9oLO+8bKNK2AK0grE0qabJ6QQA@mail.gmail.com>
 <20220518175002.GA1148748@bhelgaas>
 <CAJZ5v0hOp0UuUjRL3AYS_WW+2BxZOaGwURrrSMGQvjpPe+sOmg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hOp0UuUjRL3AYS_WW+2BxZOaGwURrrSMGQvjpPe+sOmg@mail.gmail.com>
From: Tanjore Suresh <tansuresh@google.com>
Date: Wed, 18 May 2022 13:45:01 -0700
Message-ID: <CALVARr6ORrcsgEx7A71wFFx67kya8Kf4O6mkN5p-dmFiS=HVSA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] driver core: Support asynchronous driver shutdown
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, 
 Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_134517_367204_4D421D09 
X-CRM114-Status: GOOD (  43.57  )
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

Rafeal,

On Wed, May 18, 2022 at 11:01 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, May 18, 2022 at 7:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Wed, May 18, 2022 at 01:38:49PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, May 18, 2022 at 12:08 AM Tanjore Suresh <tansuresh@google.com> wrote:
> > > >
> > > > This changes the bus driver interface with additional entry points
> > > > to enable devices to implement asynchronous shutdown. The existing
> > > > synchronous interface to shutdown is unmodified and retained for
> > > > backward compatibility.
> > > >
> > > > This changes the common device shutdown code to enable devices to
> > > > participate in asynchronous shutdown implementation.
> > > >
> > > > Signed-off-by: Tanjore Suresh <tansuresh@google.com>
> > > > ---
> > > >  drivers/base/core.c        | 38 +++++++++++++++++++++++++++++++++++++-
> > > >  include/linux/device/bus.h | 12 ++++++++++++
> > > >  2 files changed, 49 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index 3d6430eb0c6a..ba267ae70a22 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -4479,6 +4479,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
> > > >  void device_shutdown(void)
> > > >  {
> > > >         struct device *dev, *parent;
> > > > +       LIST_HEAD(async_shutdown_list);
> > > >
> > > >         wait_for_device_probe();
> > > >         device_block_probing();
> > > > @@ -4523,7 +4524,13 @@ void device_shutdown(void)
> > > >                                 dev_info(dev, "shutdown_pre\n");
> > > >                         dev->class->shutdown_pre(dev);
> > > >                 }
> > > > -               if (dev->bus && dev->bus->shutdown) {
> > > > +               if (dev->bus && dev->bus->async_shutdown_start) {
> > > > +                       if (initcall_debug)
> > > > +                               dev_info(dev, "async_shutdown_start\n");
> > > > +                       dev->bus->async_shutdown_start(dev);
> > > > +                       list_add_tail(&dev->kobj.entry,
> > > > +                               &async_shutdown_list);
> > > > +               } else if (dev->bus && dev->bus->shutdown) {
> > > >                         if (initcall_debug)
> > > >                                 dev_info(dev, "shutdown\n");
> > > >                         dev->bus->shutdown(dev);
> > > > @@ -4543,6 +4550,35 @@ void device_shutdown(void)
> > > >                 spin_lock(&devices_kset->list_lock);
> > > >         }
> > > >         spin_unlock(&devices_kset->list_lock);
> > > > +
> > > > +       /*
> > > > +        * Second pass spin for only devices, that have configured
> > > > +        * Asynchronous shutdown.
> > > > +        */
> > > > +       while (!list_empty(&async_shutdown_list)) {
> > > > +               dev = list_entry(async_shutdown_list.next, struct device,
> > > > +                               kobj.entry);
> > > > +               parent = get_device(dev->parent);
> > > > +               get_device(dev);
> > > > +               /*
> > > > +                * Make sure the device is off the  list
> > > > +                */
> > > > +               list_del_init(&dev->kobj.entry);
> > > > +               if (parent)
> > > > +                       device_lock(parent);
> > > > +               device_lock(dev);
> > > > +               if (dev->bus && dev->bus->async_shutdown_end) {
> > > > +                       if (initcall_debug)
> > > > +                               dev_info(dev,
> > > > +                               "async_shutdown_end called\n");
> > > > +                       dev->bus->async_shutdown_end(dev);
> > > > +               }
> > > > +               device_unlock(dev);
> > > > +               if (parent)
> > > > +                       device_unlock(parent);
> > > > +               put_device(dev);
> > > > +               put_device(parent);
> > > > +       }
> > > >  }
> > > >
> > > >  /*
> > > > diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> > > > index a039ab809753..f582c9d21515 100644
> > > > --- a/include/linux/device/bus.h
> > > > +++ b/include/linux/device/bus.h
> > > > @@ -49,6 +49,16 @@ struct fwnode_handle;
> > > >   *             will never get called until they do.
> > > >   * @remove:    Called when a device removed from this bus.
> > > >   * @shutdown:  Called at shut-down time to quiesce the device.
> > > > + * @async_shutdown_start:      Called at the shutdown-time to start
> > > > + *                             the shutdown process on the device.
> > > > + *                             This entry point will be called only
> > > > + *                             when the bus driver has indicated it would
> > > > + *                             like to participate in asynchronous shutdown
> > > > + *                             completion.
> > > > + * @async_shutdown_end:        Called at shutdown-time  to complete the shutdown
> > > > + *                     process of the device. This entry point will be called
> > > > + *                     only when the bus drive has indicated it would like to
> > > > + *                     participate in the asynchronous shutdown completion.
> > >
> > > I'm going to repeat my point here, but only once.
> > >
> > > I see no reason to do async shutdown this way, instead of adding a
> > > flag for drivers to opt in for calling their existing shutdown
> > > callbacks asynchronously, in analogy with the async suspend and resume
> > > implementation.
> >
> > There's a lot of code here that mere mortals like myself don't
> > understand very well, so here's my meager understanding of how
> > async suspend works and what you're suggesting to make this a
> > little more concrete.
> >
> > Devices have this async_suspend bit:
> >
> >   struct device {
> >     struct dev_pm_info {
> >       unsigned int async_suspend:1;
> >
> > Drivers call device_enable_async_suspend() to set async_suspend if
> > they want it.  The system suspend path is something like this:
> >
> >   suspend_enter
> >     dpm_suspend_noirq(PMSG_SUSPEND)
> >       dpm_noirq_suspend_devices(PMSG_SUSPEND)
> >         pm_transition = PMSG_SUSPEND
> >         while (!list_empty(&dpm_late_early_list))
> >           device_suspend_noirq(dev)
> >             dpm_async_fn(dev, async_suspend_noirq)
> >               if (is_async(dev))
> >                 async_schedule_dev(async_suspend_noirq)       # async path
> >
> >                   async_suspend_noirq               # called asynchronously
> >                   __device_suspend_noirq(dev, PMSG_SUSPEND, true)
> >                     callback = pm_noirq_op(PMSG_SUSPEND) # .suspend_noirq()
> >                     dpm_run_callback(callback)      # async call
> >
> >             __device_suspend_noirq(dev, pm_transition, false) # sync path
> >               callback = pm_noirq_op(PMSG_SUSPEND)  # .suspend_noirq()
> >               dpm_run_callback(callback)            # sync call
> >
> >         async_synchronize_full                                # wait
> >
> > If a driver has called device_enable_async_suspend(), we'll use the
> > async_schedule_dev() path to schedule the appropriate .suspend_noirq()
> > method.  After scheduling it via the async path or directly calling it
> > via the sync path, the async_synchronize_full() waits for completion
> > of all the async methods.
> >
> > I assume your suggestion is to do something like this:
> >
> >   struct device {
> >     struct dev_pm_info {
> >       unsigned int async_suspend:1;
> >  +    unsigned int async_shutdown:1;
> >
> >  + void device_enable_async_shutdown(struct device *dev)
> >  +   dev->power.async_shutdown = true;
> >
> >     device_shutdown
> >       while (!list_empty(&devices_kset->list))
> >  -      dev->...->shutdown()
> >  +      if (is_async_shutdown(dev))
> >  +        async_schedule_dev(async_shutdown)   # async path
> >  +
> >  +         async_shutdown               # called asynchronously
> >  +           dev->...->shutdown()
> >  +
> >  +      else
> >  +        dev->...->shutdown()                 # sync path
> >  +
> >  +    async_synchronize_full                   # wait
>
> Yes, that's the idea IIUC.

Thanks for the clarification, I misunderstood your earlier comment,
thanks for explaining and clarification. Let me evaluate and get back
to you as soon as possible.

Thanks
sureshtk

