Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95C6C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Apr 2022 18:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+UEKgXrrD0bBkveYKV1BzyuG02j+m4QM4Vug4t1K1Lc=; b=ftXoXGvdJ0oNP/rO0kRXKvBsqU
	L9mD+QrXLw4LGJQ5MtwDkdE8FL3ZgM4ZtiOFo+gK0g4Wpxp0FNQbHmf6fKdCVqZIFHOfLPSwYl5sn
	xqc4dJuecXwrOb5jfwEjr5cU39TdhekRIAbq3/cq5x6HO+3lQQYG0QWlfdSQzlIpczFUi+hyK+/Bm
	c0rGo4hr8Y0AJmKHMMxXO0OPvWPlV7HcX7sY5rVZeIZ7993uXWYbbnz2ZU8LdWGViYb689QRrkNaC
	uy48qUplaQmKPkHYcZgpw8i02lhniRxcJSKn3dvXWMKQ+37Fd9Var3qJKJV9fO2LgW3M+AtjM26fb
	g2q7degA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nkUxj-00C9rt-D2; Fri, 29 Apr 2022 18:03:27 +0000
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nkUxg-00C9qJ-OB
 for linux-nvme@lists.infradead.org; Fri, 29 Apr 2022 18:03:26 +0000
Received: by mail-io1-xd34.google.com with SMTP id i20so8896375ion.0
 for <linux-nvme@lists.infradead.org>; Fri, 29 Apr 2022 11:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+UEKgXrrD0bBkveYKV1BzyuG02j+m4QM4Vug4t1K1Lc=;
 b=QTAhsROB7PeybDtVIea7NpCcw6Y2SGXrxVNMO7ueaeqMjkvhygrvrO0CB92dH9jYHv
 /1nCwI6Csg2CaPABJV27UPGb+RZGethrwyW6l9S/0RC4pDBGuwKfa+1q7I/+z5H21Z+w
 +7l5ZduiDLL6NLD8GFd41Tsa7yF5dg6x6s+q3kbxi4YNf3F7vWX1I2KU7vW2wJ2z/HrJ
 TdeOd6pFhgxZGYn+oda5ArqSaiiM9auNh6u6kBlG8er/5Dn7LqYesgqm6k8RG1rG2swV
 jLFb9vwGPv4PNejd+S6r4d5/N9/J7CVn5pzUglxFfDhAg7y/B0z64DikIAot0VeJMD+r
 oaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+UEKgXrrD0bBkveYKV1BzyuG02j+m4QM4Vug4t1K1Lc=;
 b=kHG9jwDohMjFGvM/hc8rtwy3SnAYqrIkSceIhaWpRGIW8GTuCNZ910Eq5EAzX6uIdX
 0J+/4kdJuzs9NIYLgMCB04f1jy3E5LDgOJ97va8DDdl8OujoEfJzbZfG9F6ugFA8ePWK
 39OJjfAI7jBUoZZlFYyuJbD9Durrc808DKt+Nr/bbNB9mhF/oQJ+/eFxnX88H+V0dMwx
 Nqwm0Txen3hj3yNm/Ywu8DCZCpUiPI7KyrWRK1dH+a2c5uuGMS4P4fCwbW211gqoRxmn
 zUd9ZwOp2Ydi86Cv+y3Nvl5Fp42OCBh1SFPLq/VfqMdYumzkjPH7cqnqO0E8gnlVeFcs
 6I8A==
X-Gm-Message-State: AOAM532axFe6txnZfH6L/KakUC0WwFw9Y1TOj4GGE5afoaAJiwLoZrh6
 OH0OhzZ6/jck9Lr4FALt26XFDfPpkdh+fS2NY71qkg==
X-Google-Smtp-Source: ABdhPJxlXzGicn38bpRJBvIzpXXTfNsqk06DDdDi/Q9CDMeryZztyna/X6hAAJIMQXteAb0adbuW7DcpXj+kgmwV6hg=
X-Received: by 2002:a02:7a06:0:b0:32b:1b83:649a with SMTP id
 a6-20020a027a06000000b0032b1b83649amr229323jac.29.1651255398079; Fri, 29 Apr
 2022 11:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220412224348.1038613-1-tansuresh@google.com>
 <20220412224348.1038613-2-tansuresh@google.com>
 <CAJZ5v0ivNq3aYCEcxPYMosLJCAyWiAnucwOCmRBzkM=sbyPWgQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0ivNq3aYCEcxPYMosLJCAyWiAnucwOCmRBzkM=sbyPWgQ@mail.gmail.com>
From: Tanjore Suresh <tansuresh@google.com>
Date: Fri, 29 Apr 2022 11:03:07 -0700
Message-ID: <CALVARr6v5hcY0Vcf1izPUX-tXNJyyNXBMANbKX4CW9wfRf-pYQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] driver core: Support asynchronous driver shutdown
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, 
 Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220429_110324_816027_BDB0B323 
X-CRM114-Status: GOOD (  39.12  )
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

Rafael,

That is a good observation, however, many of the use cases in data
centers (deployment of devices in data centers) do not exploit device
power management. Therefore, I'm not sure that is the right way to
design this.

Also if you look into device_shutdown (drivers/base/core.c) generic
kernel routine does not exploit the shutdown method suggested by you
instead use the generic shutdown methods defined in bus, class,
drivers structures. Therefore, adopting to expand on those generic
shutdown interfaces is the incremental choice to not confuse driver
developers.

Hope this clarifies why this extension is proposed when compared to
overloading a generic shutdown entry point with device power
management requirements.

Thanks
sureshtk



On Fri, Apr 15, 2022 at 7:42 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Apr 13, 2022 at 12:44 AM Tanjore Suresh <tansuresh@google.com> wrote:
> >
> > This changes the bus driver interface with additional entry points
> > to enable devices to implement asynchronous shutdown. The existing
> > synchronous interface to shutdown is unmodified and retained for
> > backward compatibility.
> >
> > This changes the common device shutdown code to enable devices to
> > participate in asynchronous shutdown implementation.
> >
> > Signed-off-by: Tanjore Suresh <tansuresh@google.com>
>
> Is there any specific reason why you didn't follow the design of, say,
> dpm_suspend(), where the "async" devices only need to have a flag set
> and the driver is not required to implement any new callbacks?
>
> IMO having different driver interfaces for asynchronous suspend and
> shutdown would be quite confusing for driver developers, wouldn't it?
>
> > ---
> >  drivers/base/core.c        | 38 +++++++++++++++++++++++++++++++++++++-
> >  include/linux/device/bus.h | 12 ++++++++++++
> >  2 files changed, 49 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 3d6430eb0c6a..ba267ae70a22 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -4479,6 +4479,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
> >  void device_shutdown(void)
> >  {
> >         struct device *dev, *parent;
> > +       LIST_HEAD(async_shutdown_list);
> >
> >         wait_for_device_probe();
> >         device_block_probing();
> > @@ -4523,7 +4524,13 @@ void device_shutdown(void)
> >                                 dev_info(dev, "shutdown_pre\n");
> >                         dev->class->shutdown_pre(dev);
> >                 }
> > -               if (dev->bus && dev->bus->shutdown) {
> > +               if (dev->bus && dev->bus->async_shutdown_start) {
> > +                       if (initcall_debug)
> > +                               dev_info(dev, "async_shutdown_start\n");
> > +                       dev->bus->async_shutdown_start(dev);
> > +                       list_add_tail(&dev->kobj.entry,
> > +                               &async_shutdown_list);
> > +               } else if (dev->bus && dev->bus->shutdown) {
> >                         if (initcall_debug)
> >                                 dev_info(dev, "shutdown\n");
> >                         dev->bus->shutdown(dev);
> > @@ -4543,6 +4550,35 @@ void device_shutdown(void)
> >                 spin_lock(&devices_kset->list_lock);
> >         }
> >         spin_unlock(&devices_kset->list_lock);
> > +
> > +       /*
> > +        * Second pass spin for only devices, that have configured
> > +        * Asynchronous shutdown.
> > +        */
> > +       while (!list_empty(&async_shutdown_list)) {
> > +               dev = list_entry(async_shutdown_list.next, struct device,
> > +                               kobj.entry);
> > +               parent = get_device(dev->parent);
> > +               get_device(dev);
> > +               /*
> > +                * Make sure the device is off the  list
> > +                */
> > +               list_del_init(&dev->kobj.entry);
> > +               if (parent)
> > +                       device_lock(parent);
> > +               device_lock(dev);
> > +               if (dev->bus && dev->bus->async_shutdown_end) {
> > +                       if (initcall_debug)
> > +                               dev_info(dev,
> > +                               "async_shutdown_end called\n");
> > +                       dev->bus->async_shutdown_end(dev);
> > +               }
> > +               device_unlock(dev);
> > +               if (parent)
> > +                       device_unlock(parent);
> > +               put_device(dev);
> > +               put_device(parent);
> > +       }
> >  }
> >
> >  /*
> > diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> > index a039ab809753..f582c9d21515 100644
> > --- a/include/linux/device/bus.h
> > +++ b/include/linux/device/bus.h
> > @@ -49,6 +49,16 @@ struct fwnode_handle;
> >   *             will never get called until they do.
> >   * @remove:    Called when a device removed from this bus.
> >   * @shutdown:  Called at shut-down time to quiesce the device.
> > + * @async_shutdown_start:      Called at the shutdown-time to start
> > + *                             the shutdown process on the device.
> > + *                             This entry point will be called only
> > + *                             when the bus driver has indicated it would
> > + *                             like to participate in asynchronous shutdown
> > + *                             completion.
> > + * @async_shutdown_end:        Called at shutdown-time  to complete the shutdown
> > + *                     process of the device. This entry point will be called
> > + *                     only when the bus drive has indicated it would like to
> > + *                     participate in the asynchronous shutdown completion.
> >   *
> >   * @online:    Called to put the device back online (after offlining it).
> >   * @offline:   Called to put the device offline for hot-removal. May fail.
> > @@ -93,6 +103,8 @@ struct bus_type {
> >         void (*sync_state)(struct device *dev);
> >         void (*remove)(struct device *dev);
> >         void (*shutdown)(struct device *dev);
> > +       void (*async_shutdown_start)(struct device *dev);
> > +       void (*async_shutdown_end)(struct device *dev);
> >
> >         int (*online)(struct device *dev);
> >         int (*offline)(struct device *dev);
> > --
> > 2.36.0.rc0.470.gd361397f0d-goog
> >

