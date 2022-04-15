Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65055C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Apr 2022 14:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VQSHKKZVZ0Nt1UyzeBgM0+KthK67tcnYKJdeT0jg73Y=; b=dyH+LFPvxW5hO+bTVdh8puPxpl
	a+hyqTRearqv4zXWdeuzQGZoSoRKjBKar5kIsUX8fj8mfBhjvl7TIMMGug3Le8lh6MIBgL6jC9j18
	s2F3MuGccQ4hQJZvrm9BXV13+fJvX8zkqTH0+tD2UkQ9KSKzPEY4zPWvxsg8AjdRH3Ak4p39+pK4A
	SRT/Fh2sHAialIqC7SsmkgHwmbOEvXfrLCTUXPEh4S+r2pyq64LHOpg2rjG7Jf5kNkyD8qiXAUmyp
	4Qr3+IH3CPZE5+5ANSCazXgwbZrVs+pq1V+qTjQ/MFa9QcEe0KJgTNtGb6jUA2D3A6CO5HUY9IWW9
	PZ72ffxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfN9S-00APBc-KR; Fri, 15 Apr 2022 14:42:22 +0000
Received: from mail-yb1-f180.google.com ([209.85.219.180])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfN9P-00APAv-H4
 for linux-nvme@lists.infradead.org; Fri, 15 Apr 2022 14:42:21 +0000
Received: by mail-yb1-f180.google.com with SMTP id e71so14795902ybf.8
 for <linux-nvme@lists.infradead.org>; Fri, 15 Apr 2022 07:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VQSHKKZVZ0Nt1UyzeBgM0+KthK67tcnYKJdeT0jg73Y=;
 b=RGe0opNTWqE4dWzmk5M9BUWsJhgqQn3k7S/VKPIbznSnjIqlitPdsgImC+eU8ebZn4
 cok6NseXb8YrhioY/yy60gGBhktUI1GqaWxBv6PnwwFBnDdvkxnPtEX43toFDxqvODc1
 3dTsdeHvxTDpcaLEvbPbaGJ/w6Gpnb3TQr7RM4I6pFs63Kj9VcswF6pPLF4Z+/umxdoj
 bwrb+IqQTmsdI6JOGBxq+5clhHh/3q+QSpIqh0gUu18TuPtTdWn8aj6c7D43gRsKOw2W
 6M87ZtLNsjknoy2q6qQ/YxsWnuhEt71OAsvXPkig3TdfYly/1PZHwvjZ1Js+LsrPzhU1
 f74g==
X-Gm-Message-State: AOAM530Yf5LRCdP2AOADhOOO633YUwIo8bAEVYZhi0XRq0xNgkJOJlZw
 lWBcsbtgGYIveJO803JIGCMIf3kUfxLX8f/jLII=
X-Google-Smtp-Source: ABdhPJzHImZ6AlstLn7pVijrPVyShFWryTuDK7hJhgtHmoiyUY6jExoXezPsWwLknhi0wsShbmhDkbJ9zA8uv2Zpyuw=
X-Received: by 2002:a25:230d:0:b0:641:375c:b5ad with SMTP id
 j13-20020a25230d000000b00641375cb5admr5695905ybj.137.1650033737467; Fri, 15
 Apr 2022 07:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220412224348.1038613-1-tansuresh@google.com>
 <20220412224348.1038613-2-tansuresh@google.com>
In-Reply-To: <20220412224348.1038613-2-tansuresh@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 15 Apr 2022 16:42:06 +0200
Message-ID: <CAJZ5v0ivNq3aYCEcxPYMosLJCAyWiAnucwOCmRBzkM=sbyPWgQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] driver core: Support asynchronous driver shutdown
To: Tanjore Suresh <tansuresh@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, 
 Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220415_074219_602738_2AF27197 
X-CRM114-Status: GOOD (  32.70  )
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

On Wed, Apr 13, 2022 at 12:44 AM Tanjore Suresh <tansuresh@google.com> wrote:
>
> This changes the bus driver interface with additional entry points
> to enable devices to implement asynchronous shutdown. The existing
> synchronous interface to shutdown is unmodified and retained for
> backward compatibility.
>
> This changes the common device shutdown code to enable devices to
> participate in asynchronous shutdown implementation.
>
> Signed-off-by: Tanjore Suresh <tansuresh@google.com>

Is there any specific reason why you didn't follow the design of, say,
dpm_suspend(), where the "async" devices only need to have a flag set
and the driver is not required to implement any new callbacks?

IMO having different driver interfaces for asynchronous suspend and
shutdown would be quite confusing for driver developers, wouldn't it?

> ---
>  drivers/base/core.c        | 38 +++++++++++++++++++++++++++++++++++++-
>  include/linux/device/bus.h | 12 ++++++++++++
>  2 files changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 3d6430eb0c6a..ba267ae70a22 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4479,6 +4479,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
>  void device_shutdown(void)
>  {
>         struct device *dev, *parent;
> +       LIST_HEAD(async_shutdown_list);
>
>         wait_for_device_probe();
>         device_block_probing();
> @@ -4523,7 +4524,13 @@ void device_shutdown(void)
>                                 dev_info(dev, "shutdown_pre\n");
>                         dev->class->shutdown_pre(dev);
>                 }
> -               if (dev->bus && dev->bus->shutdown) {
> +               if (dev->bus && dev->bus->async_shutdown_start) {
> +                       if (initcall_debug)
> +                               dev_info(dev, "async_shutdown_start\n");
> +                       dev->bus->async_shutdown_start(dev);
> +                       list_add_tail(&dev->kobj.entry,
> +                               &async_shutdown_list);
> +               } else if (dev->bus && dev->bus->shutdown) {
>                         if (initcall_debug)
>                                 dev_info(dev, "shutdown\n");
>                         dev->bus->shutdown(dev);
> @@ -4543,6 +4550,35 @@ void device_shutdown(void)
>                 spin_lock(&devices_kset->list_lock);
>         }
>         spin_unlock(&devices_kset->list_lock);
> +
> +       /*
> +        * Second pass spin for only devices, that have configured
> +        * Asynchronous shutdown.
> +        */
> +       while (!list_empty(&async_shutdown_list)) {
> +               dev = list_entry(async_shutdown_list.next, struct device,
> +                               kobj.entry);
> +               parent = get_device(dev->parent);
> +               get_device(dev);
> +               /*
> +                * Make sure the device is off the  list
> +                */
> +               list_del_init(&dev->kobj.entry);
> +               if (parent)
> +                       device_lock(parent);
> +               device_lock(dev);
> +               if (dev->bus && dev->bus->async_shutdown_end) {
> +                       if (initcall_debug)
> +                               dev_info(dev,
> +                               "async_shutdown_end called\n");
> +                       dev->bus->async_shutdown_end(dev);
> +               }
> +               device_unlock(dev);
> +               if (parent)
> +                       device_unlock(parent);
> +               put_device(dev);
> +               put_device(parent);
> +       }
>  }
>
>  /*
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index a039ab809753..f582c9d21515 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -49,6 +49,16 @@ struct fwnode_handle;
>   *             will never get called until they do.
>   * @remove:    Called when a device removed from this bus.
>   * @shutdown:  Called at shut-down time to quiesce the device.
> + * @async_shutdown_start:      Called at the shutdown-time to start
> + *                             the shutdown process on the device.
> + *                             This entry point will be called only
> + *                             when the bus driver has indicated it would
> + *                             like to participate in asynchronous shutdown
> + *                             completion.
> + * @async_shutdown_end:        Called at shutdown-time  to complete the shutdown
> + *                     process of the device. This entry point will be called
> + *                     only when the bus drive has indicated it would like to
> + *                     participate in the asynchronous shutdown completion.
>   *
>   * @online:    Called to put the device back online (after offlining it).
>   * @offline:   Called to put the device offline for hot-removal. May fail.
> @@ -93,6 +103,8 @@ struct bus_type {
>         void (*sync_state)(struct device *dev);
>         void (*remove)(struct device *dev);
>         void (*shutdown)(struct device *dev);
> +       void (*async_shutdown_start)(struct device *dev);
> +       void (*async_shutdown_end)(struct device *dev);
>
>         int (*online)(struct device *dev);
>         int (*offline)(struct device *dev);
> --
> 2.36.0.rc0.470.gd361397f0d-goog
>

