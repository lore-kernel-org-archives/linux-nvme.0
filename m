Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA323C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 11:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zrwlit81NOfQDl1MFOpzqvUONSVA1zEjJ5vK5GKa7Pw=; b=djx39zex4UkstCG674izHIyQxW
	Psz/DlB9047FeJIM6DkW13Kf8UgcTCMPivMn6MzYgG8P7WKHahxEmNekhgPajLXLq6LKcE6eI4DUv
	lOHImwIsJj93ctFe0yH8ycl0csVue6D/Ngivu49uZwZPmJAo71lpbjiu2fVbSIGvzSGebCVbMeuwk
	cLQrhjBnxFK0W4WxSCHiA7CW5Qoc+RhIJIu8oYLjlOVb8C7TlCfWxff1nE1ePcej7zSpJpey9ym+Z
	yq9uM6p/0d4kuBMiuJCwZ8uBMYjKS8re/Zjq5EtUajIny+6Jrym/N7q/8dk+ACn7ArMBlH8s9hJ3r
	CcJbwdaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrI1w-001cvb-RI; Wed, 18 May 2022 11:39:52 +0000
Received: from mail-yb1-f182.google.com ([209.85.219.182])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrI1E-001cWt-Gw
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 11:39:10 +0000
Received: by mail-yb1-f182.google.com with SMTP id q135so3125651ybg.10
 for <linux-nvme@lists.infradead.org>; Wed, 18 May 2022 04:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zrwlit81NOfQDl1MFOpzqvUONSVA1zEjJ5vK5GKa7Pw=;
 b=wWPfigHsEuU+B4UmryG4lbwN5t2qTM+kvcZR8lUvuKP0jyfMaYhZyPNURPbghMJX1f
 XKDN268mDJ+CB+I2JzNdryowQHCt6pCfOBo5whVx/GHBF3DC/zZgZlJwGngsZsJzyJH5
 6E0BBinpHm+aScTjve/9h3nv+iqx5Kf57IFs+ox3rYc9OHubcHJ3+KNBK+8hqiDLQOdj
 UlEZ5BOQdZ3tbkY/BtRP4x5ry9NMb8cDXR9JmCeuPHOkb16xnCaTy9gzqtkvq+Agrv3n
 eepwlnu9d5gJTgkK72S/o/ay4SGG1VU2AuwHm7gyZXDCuBwiz8HsWqfobapacTINxJgQ
 W1Pg==
X-Gm-Message-State: AOAM530of29ohxCJBMlI5UMhCKpDmovbEwZTifWCKGAqp9FHDlffRurM
 CyOkxh/GkWyZgmMHT0l0Oi8lTq9IK3aLJqM3bHG0GHQ4
X-Google-Smtp-Source: ABdhPJz1ujxrXfeaULJzzClaVci8qVX8qcy5AEI2vEsdX5a/9cHfhru7x3l9WTnfZuXXpfw8ZlAJM4f1hmEGjaIPrJY=
X-Received: by 2002:a25:7717:0:b0:64d:854f:2da4 with SMTP id
 s23-20020a257717000000b0064d854f2da4mr15356551ybc.633.1652873941589; Wed, 18
 May 2022 04:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220517220816.1635044-1-tansuresh@google.com>
 <20220517220816.1635044-2-tansuresh@google.com>
In-Reply-To: <20220517220816.1635044-2-tansuresh@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 May 2022 13:38:49 +0200
Message-ID: <CAJZ5v0ibBw41YSfSWF1CtY7w9oLO+8bKNK2AK0grE0qabJ6QQA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] driver core: Support asynchronous driver shutdown
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
X-CRM114-CacheID: sfid-20220518_043908_630903_DBBCBB4E 
X-CRM114-Status: GOOD (  33.38  )
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

On Wed, May 18, 2022 at 12:08 AM Tanjore Suresh <tansuresh@google.com> wrote:
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

I'm going to repeat my point here, but only once.

I see no reason to do async shutdown this way, instead of adding a
flag for drivers to opt in for calling their existing shutdown
callbacks asynchronously, in analogy with the async suspend and resume
implementation.

Is there any reason why this is not viable?

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
> 2.36.0.550.gb090851708-goog
>

