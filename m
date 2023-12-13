Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE14BC4167D
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 17:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4/fywzGtbHR80oQbRY2IyznN0vfTtuQXOFFYJUM/jwI=; b=xcJuB49agT93TFJfGtBtScs30g
	DECsMdrsz+wAl7qTNNknEhKaqVKM3JSKt4rL92EHGveVPwUNeHtjkPKGkPIkunf8uYEtHa/2fdO1L
	Oy9ylAGWUuU96HX4KRy3R6vmAcQn3QDkG/1epK6168ibG1cQyhQZ4+unKD7zom5l3kPeli+utkich
	PVxYgVv4VK/Hne+vju8/IfIL7VeuRsi4oPkFE6k/goQfc+li6PkfaQDmYi+zGEsUdgHynct+S7yne
	J6njEwwNbnwa+i2Gg8XhAMnYJahVngHx+kB4kRq+yaHufQnuo7qT8WjvBnhHG5z3ewe1ocUxrc2vc
	bOiX3MGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDT7w-00Fc2U-16;
	Wed, 13 Dec 2023 17:34:32 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDT7t-00Fc0h-0p
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 17:34:30 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-28aabe4a728so2027874a91.3
        for <linux-nvme@lists.infradead.org>; Wed, 13 Dec 2023 09:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1702488868; x=1703093668; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/fywzGtbHR80oQbRY2IyznN0vfTtuQXOFFYJUM/jwI=;
        b=Yc9YSPaBA06CLUOkQty1/7FRvpTdd/hjW9PFbGJweLRk3Kmc1kTc837nQsA+JKnSS+
         1pqyBwk21t6kWJzY6/de4qRjwZ7d70U7S+Vfjpf4T1pwo744mYbIJ5ll7+0QqwvLS7w6
         tB9jNkTjE/JPfW3u74xRf8XZql2+AL6UCWQePiAjXKcL3JYFWZhlwkXcwamx7xzlgEy+
         5sfBGfMKhgEn4CQPbCL8EapRXJoWfZTT3mDQzVDHVUqv5cvcEQcKjUjIkPeQip183Wfu
         nwxLuxLkh/mityg3kATEByTIU4biEltDs6lXXOuLYMv2ePq3XVppEZsMa5QtXhWrY2nD
         mhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702488868; x=1703093668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/fywzGtbHR80oQbRY2IyznN0vfTtuQXOFFYJUM/jwI=;
        b=K5ZlP0yVx7RMP172g4A6nWtCQKxhS8VZ5e4zxs/4I4fEtjlpnyOWC0x6YBPtUfZCIe
         J9eqk/AE8XUDNo6Hlb4aaRiF54BPRNC/3WNg8t77jvoZhWRS0vx3awnJTCzG0m78a8+S
         OX7g/mNzuaN1L1uRxG2C11WHMZ805L/0xY03elH83K0a2qQhyXNhAp8WjRqWzs/5ggUK
         qH11pwhYrRTTvk7Sg5w63DE72cQV7BZmUzGpeocw36wtPGkPxz1Ye906XEj11HX9yli7
         3PX8M6/LR6B817nlFNc3whWHF3zzhq1ListACWocNK9EmTUUTd3JWcvTbuMSBnGWb30C
         9jFw==
X-Gm-Message-State: AOJu0YxgurtpDXSej60pe3Fy/fCm4LIYC9F/mkZvp40vMTar/Qe7RMgM
	KCKIwHe0mdvabFwFNcNK9HQN7FPXhn01983recP1qg==
X-Google-Smtp-Source: AGHT+IFvklB86J2s550ZK8lIkhHvc3k5bHQ/VH3DTK4+Krw3ydNZP5r1eGYiZ46uRph4SvdzmohHxm5/SiLwYguJUj0=
X-Received: by 2002:a17:90a:f487:b0:286:6cc0:884c with SMTP id
 bx7-20020a17090af48700b002866cc0884cmr3853821pjb.57.1702488868128; Wed, 13
 Dec 2023 09:34:28 -0800 (PST)
MIME-Version: 1.0
References: <20231212180938.397403-1-jallison@ciq.com> <20231212180938.397403-2-jallison@ciq.com>
 <d05302bc-6228-4798-979d-91904c794c13@grimberg.me>
In-Reply-To: <d05302bc-6228-4798-979d-91904c794c13@grimberg.me>
From: Jeremy Allison <jallison@ciq.com>
Date: Wed, 13 Dec 2023 09:34:16 -0800
Message-ID: <CADfv6KY5fT3FOSPn-M31EYJgYDDp5hrmLm9gVJ5uHbHDng+U6A@mail.gmail.com>
Subject: Re: [PATCH 1/3] driver core: Support asynchronous driver shutdown
To: Sagi Grimberg <sagi@grimberg.me>
Cc: jra@samba.org, tansuresh@google.com, hch@lst.de, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_093429_298632_389DE62E 
X-CRM114-Status: GOOD (  30.75  )
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

Good catch. Thanks. I'll fix that and re-submit.

On Wed, Dec 13, 2023 at 5:59=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
> > From: Tanjore Suresh <tansuresh@google.com>
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
> > ---
> >   drivers/base/core.c        | 39 +++++++++++++++++++++++++++++++++++++=
-
> >   include/linux/device/bus.h | 10 ++++++++++
> >   2 files changed, 48 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 67ba592afc77..d9745822fb50 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -4725,6 +4725,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
> >   void device_shutdown(void)
> >   {
> >       struct device *dev, *parent;
> > +     LIST_HEAD(async_shutdown_list);
> >
> >       wait_for_device_probe();
> >       device_block_probing();
> > @@ -4769,7 +4770,14 @@ void device_shutdown(void)
> >                               dev_info(dev, "shutdown_pre\n");
> >                       dev->class->shutdown_pre(dev);
> >               }
> > -             if (dev->bus && dev->bus->shutdown) {
> > +
> > +             if (dev->bus && dev->bus->shutdown_pre) {
>
> I'm assuming that there is no shutdown_pre without a shutdown_post
> paired with it, so I think the code should verify that.
>
> > +                     if (initcall_debug)
> > +                             dev_info(dev, "shutdown_pre\n");
> > +                     dev->bus->shutdown_pre(dev);
> > +                     list_add(&dev->kobj.entry,
> > +                             &async_shutdown_list);
> > +             } else if (dev->bus && dev->bus->shutdown) {
> >                       if (initcall_debug)
> >                               dev_info(dev, "shutdown\n");
> >                       dev->bus->shutdown(dev);
> > @@ -4789,6 +4797,35 @@ void device_shutdown(void)
> >               spin_lock(&devices_kset->list_lock);
> >       }
> >       spin_unlock(&devices_kset->list_lock);
> > +
> > +     /*
> > +      * Second pass spin for only devices, that have configured
> > +      * Asynchronous shutdown.
> > +      */
> > +     while (!list_empty(&async_shutdown_list)) {
> > +             dev =3D list_entry(async_shutdown_list.next, struct devic=
e,
> > +                             kobj.entry);
> > +             parent =3D get_device(dev->parent);
> > +             get_device(dev);
> > +             /*
> > +              * Make sure the device is off the  list
> > +              */
> > +             list_del_init(&dev->kobj.entry);
> > +             if (parent)
> > +                     device_lock(parent);
> > +             device_lock(dev);
> > +             if (dev->bus && dev->bus->shutdown_post) {
> > +                     if (initcall_debug)
> > +                             dev_info(dev,
> > +                             "shutdown_post called\n");
> > +                     dev->bus->shutdown_post(dev);
> > +             }
> > +             device_unlock(dev);
> > +             if (parent)
> > +                     device_unlock(parent);
> > +             put_device(dev);
> > +             put_device(parent);
> > +     }
> >   }
> >
> >   /*
> > diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> > index ae10c4322754..cbcb001f6336 100644
> > --- a/include/linux/device/bus.h
> > +++ b/include/linux/device/bus.h
> > @@ -48,6 +48,14 @@ struct fwnode_handle;
> >    *          will never get called until they do.
> >    * @remove: Called when a device removed from this bus.
> >    * @shutdown:       Called at shut-down time to quiesce the device.
> > + * @shutdown_pre:    Called at the shutdown-time to start the shutdown
> > + *                   process on the device. This entry point will be c=
alled
> > + *                   only when the bus driver has indicated it would l=
ike
> > + *                   to participate in asynchronous shutdown completio=
n.
> > + * @shutdown_post:   Called at shutdown-time  to complete the shutdown
> > + *                   process of the device. This entry point will be c=
alled
> > + *                   only when the bus drive has indicated it would li=
ke to
> > + *                   participate in the asynchronous shutdown completi=
on.
> >    *
> >    * @online: Called to put the device back online (after offlining it)=
.
> >    * @offline:        Called to put the device offline for hot-removal.=
 May fail.
> > @@ -90,6 +98,8 @@ struct bus_type {
> >       void (*sync_state)(struct device *dev);
> >       void (*remove)(struct device *dev);
> >       void (*shutdown)(struct device *dev);
> > +     void (*shutdown_pre)(struct device *dev);
> > +     void (*shutdown_post)(struct device *dev);
> >
> >       int (*online)(struct device *dev);
> >       int (*offline)(struct device *dev);

