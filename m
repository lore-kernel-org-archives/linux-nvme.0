Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAE8C19F28
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Aug 2022 15:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ouan4Svxron6vwUQD0UpAc3rvidEPjwBels5eMrK9DQ=; b=tWMscuhqVPY9PIhtFs1qvAyQKz
	E8HL2M9bWXHQ7nHoRCu7VJENSEkhaK303xAiATI36RBHAbDtKmmqCwNMlKjnUKx6R+I+Y6kKsSEVQ
	3BkKJSVGp/c25c5QcF9M47MinoyPEulFcd9M3wl/l6dh0k7Ndwj2nzAgwpsoKQXN36GYcpiT20vwH
	5nZ6wo14Q5CPFyzNXaTO9tOIX+hNf1ZU3SQm7qDjNuCPLHUZaw2PPeQ+mKvlPtC9lKGrFakocvym0
	RIg1MFwh4FVOBJMUHfH9UeKZdrXyA1Xx7VifuijAkez64djlVqHA8T+QD8LwghPdcvPUIMvDXA2a2
	2AjnRdDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJFve-006ylr-Kh; Wed, 03 Aug 2022 15:04:58 +0000
Received: from mail-yw1-f171.google.com ([209.85.128.171])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJFvb-006yjJ-2F
	for linux-nvme@lists.infradead.org; Wed, 03 Aug 2022 15:04:57 +0000
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-31f661b3f89so174183507b3.11
        for <linux-nvme@lists.infradead.org>; Wed, 03 Aug 2022 08:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ouan4Svxron6vwUQD0UpAc3rvidEPjwBels5eMrK9DQ=;
        b=eGztgeniBMzXE7fd9gWskfsD8C0M2kxomv2uAwaRnPDZM1F2kvp9cUnARYlDcV5EIJ
         CuqCFqFH6wJnqSVJvvdTEfgtQS2dlGd6IZhzELlh/viVb1niHgWm7WTTTdNCunWId3G1
         5H/f71w1V5w1Og0JyeKiaru2NzgZN4Xbz2BY8hjaNpGQqCljk5niZLQ0cEjgCIba0FFk
         MF39s7ApFe5Z4xiRdu1jEa8xYk+mxskK8eFK5B+7OCr+IVYjqn2pm1tFzMN0HYYci+jD
         jpMLazY65K2HlF3TMpom/92YJXLyS+HEgBBKg2fTdtMgHJS79yGSltcn6MpahCYex0Nj
         nv0g==
X-Gm-Message-State: ACgBeo0aIomQQJ82xAIpjPK3go7bEiPnu38UonZ1lBveGIqmEv+jGJkj
	wMymwvhxudAfy/2adhF9Z7V4Tr5xIQEigxmobOk=
X-Google-Smtp-Source: AA6agR42p5rkbE8sCWpMYfdup41Al1EYl3FCyQRWucakWGKFoLkxTabC0VIDOG3BRuaGnSFEoT8sO0fgCIdyYebzfIk=
X-Received: by 2002:a0d:d694:0:b0:325:1881:6a52 with SMTP id
 y142-20020a0dd694000000b0032518816a52mr12643988ywd.149.1659539092812; Wed, 03
 Aug 2022 08:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220518175002.GA1148748@bhelgaas> <20220802213511.GA738995@bhelgaas>
In-Reply-To: <20220802213511.GA738995@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Aug 2022 17:04:40 +0200
Message-ID: <CAJZ5v0hrrHvBwXThEjiWAxUcM3=NgsfYw+nTyXjdiTmNug_PbQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] driver core: Support asynchronous driver shutdown
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tanjore Suresh <tansuresh@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvme <linux-nvme@lists.infradead.org>, 
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220803_080455_128512_3F3518CA 
X-CRM114-Status: GOOD (  34.89  )
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

On Tue, Aug 2, 2022 at 11:35 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [Beginning of thread: https://lore.kernel.org/r/20220517220816.1635044-2-tansuresh@google.com]
> On Wed, May 18, 2022 at 12:50:02PM -0500, Bjorn Helgaas wrote:
>
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
>
> Correct me if I'm wrong: in the suspend scenario, there are several
> phases, and async_synchronize_full() ensures that one phase finishes
> before the next phase starts.  For example:
>
>   dpm_suspend_end
>     dpm_suspend_late                             # phase 1
>       while (!list_empty(&dpm_suspended_list))
>         device_suspend_late
>       async_synchronize_full                     # finish phase 1
>     dpm_suspend_noirq                            # phase 2
>       dpm_noirq_suspend_devices
>         while (!list_empty(&dpm_late_early_list))
>           device_suspend_noirq
>       async_synchronize_full
>
> The device .suspend_late() and .suspend_noirq() methods may all be
> started asynchronously.  So far there's nothing to order them within
> the phase, but async_synchronize_full() ensures that all the
> .suspend_late() methods finish before the .suspend_noirq() methods
> start.
>
> Obviously we do want a child's method to complete before we run the
> parent's method.  If I understand correctly, that parent/child
> synchronization is done by a different method: __device_suspend_late()
> and __device_suspend_noirq() call dpm_wait_for_subordinate(), which
> waits for &dev->power.completion for all children:
>
>   __device_suspend_late
>     dpm_wait_for_subordinate
>       dpm_wait_for_children   # wait for children .suspend_late()
>         device_for_each_child(dev, &async, dpm_wait_fn)
>           dpm_wait_fn
>             dpm_wait
>               wait_for_completion(&dev->power.completion)
>     dpm_run_callback          # run parent method, e.g., ops->suspend_late
>     complete_all(&dev->power.completion)  # note completion of parent
>
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
> In the shutdown case, I think we still probably need the
> async_synchronize_full() to ensure that all the .shutdown() methods
> complete before we turn the power off, reboot, or kexec.
>
> But I think we also need a mechanism like dev->power.completion to
> make sure all the child .shutdown() methods complete before we run a
> parent's .shutdown().
>
> There's not much overlap between the suspend path and the shutdown
> path (probably none at all), so it's tempting to use the existing
> dev->power.completion for shutdown as well.
>
> But I don't think that's feasible because dev->power.completion is
> tied up with dev->power.async_suspend, which is set by
> device_enable_async_suspend().  That's a different concept than async
> shutdown, and drivers will want one without the other.
>
> Does this make sense?

Well, why don't we change the code so that dev->power.completion is
not tied to dev->power.async_suspend, but can be also used
(analogously) if something like dev->async_shutdown is set?

My point is that we know how to suspend devices asynchronously (the
fact that there are multiple phases is not that important IMV), so why
don't we design the async shutdown analogously?

