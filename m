Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE728C4829A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Feb 2024 03:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wZFoMi1WTu3P3CrXAYHQEQbX4qpbiSTbfXRbwXZD6+E=; b=zG6vvRZeUX0SpbMJ7omjiCO+JC
	NnLASNSbiyY/tnxN1mW3nBRtZrmw1v7w7wDbEAc1rP5Ig+PX1ersn658R//HYCfZmVUjbqUmxdBlF
	YudzLm+F+xUSn2WkLM0t0YNcyJa253NnnuNtL5uLk0XHBI6pMr/+IVic/5rqhhS36f1rPoZ6jG3DP
	UAMWm5pchDyuDaipXQxN8epIzoODQKFKFfF/v3t32sb4AIuCTsEzONfCBpx+/2gdpNKXWeEWhP8Kl
	cy9QEyrZ87C8EdrCikvOl5eK/IJerrILTVRlHu8q/Vr6AbOwxFj6KhsBT52KH+QZMSSJZtZ2XSmGQ
	wgRa+goA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ra65H-0000000BfpH-1B5i;
	Wed, 14 Feb 2024 03:37:19 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ra65F-0000000BfoT-1GR9
	for linux-nvme@lists.infradead.org;
	Wed, 14 Feb 2024 03:37:18 +0000
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-42c70247923so369611cf.1
        for <linux-nvme@lists.infradead.org>; Tue, 13 Feb 2024 19:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707881835; x=1708486635; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZFoMi1WTu3P3CrXAYHQEQbX4qpbiSTbfXRbwXZD6+E=;
        b=sNSe/LjFqCWG22x/9wZnw3qPnfuAJfkQPODkOH+3UiZE5EqK5bgVhQiUrZWfZ1BMD4
         CHEMUrb0fmvSOeNhlHCs0QFNBsgAwuBctIPZVu/Ildu2bCFqOUVLA1TgvpcxKu/ncGsx
         dfBucw4UBsq+L2FucYsBnSdd6zO34ucDdGszhArGzqwXNwWt0q1P0BfHtHBkJ2hNzf8l
         cgCR8idzuUASQjxp8eTFb9T2l/eHa10nBkCU44MwhwI3+hqNPswx1V8iDSd/Rpj8+vkM
         N6Zr1G2BFNrte4Ii8MpxqezEM+RKV92nOWc2lh3VXf7C8Ees6Yj6VnBBEDnady5jmfRx
         +87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707881835; x=1708486635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZFoMi1WTu3P3CrXAYHQEQbX4qpbiSTbfXRbwXZD6+E=;
        b=dDwuRN+zkJAohyCb9kw/mfACr89E+KPTv9s+FNMTpCzw8+vtLIhyy7w2UpPFquMyW5
         zFOyKlMiKzGYg4QSHnHUcr3UgDSD/EVfsGuX8QhTjOgu+bhdS+GXTW+QMhhyV2OywU4K
         V77RKCh5asNhhmGsgHhpLtU0oBqFRqspnPnH1u14D1VFCBCJO9vp3K+wn4IoOb9+MNaL
         yS3zTtozzEEp+TrXWpeF+5DwBtmZ73kMOVI0F1aBMn6mvTy5IVTxhgEk4wgRRTOHjb0o
         wUscQ+KIOL05SSsRBkI25sS1Nhz3tmq89v6I7TXyAU7bK/W9vsexxSy7HwYsL+uIH7RR
         Ps3w==
X-Forwarded-Encrypted: i=1; AJvYcCXmmedfPdIkOQNjPuddKAmrzANvMtgPqetu0ORnmowptQbjQCyO3C827kduyegN9yhh+0cvjuZ81K5gm7GmczV/BEbd0C8dVOhJfv7ybB8=
X-Gm-Message-State: AOJu0Yy7g2NDspHHpr5WdtRxbr2WlJcDFUKb8UlO7T7wOfkRKEeWaB5w
	JxOYhxgWvIIfrZ4vjp0StB0ZHTZgwCcsrAAUmtxQhyKo4sZ2WuwMCIxnkXOyE9AJ1JyGOWGsKaG
	rk6ZGX32L/x3NPBx7YdwFoBcRZNXSmvONrVLI
X-Google-Smtp-Source: AGHT+IE7i6aw6BPCbeaBk7LqgxajUqJcV1R7irsMIpNztjWzC2xCZu5ox0MGfC/2spqWW4YFdobmpRNtc95bm7cvXGo=
X-Received: by 2002:ac8:5301:0:b0:42c:73ec:383a with SMTP id
 t1-20020ac85301000000b0042c73ec383amr181308qtn.10.1707881834543; Tue, 13 Feb
 2024 19:37:14 -0800 (PST)
MIME-Version: 1.0
References: <20240129181953.1183084-1-jallison@ciq.com> <20240129181953.1183084-2-jallison@ciq.com>
In-Reply-To: <20240129181953.1183084-2-jallison@ciq.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 13 Feb 2024 19:36:35 -0800
Message-ID: <CAGETcx_eUELgBcTdmgA=iN9Mx7U4jHmjEZm_ZjEphF-VB4Thyw@mail.gmail.com>
Subject: Re: [PATCH 1/5] driver core: Support two-pass driver shutdown.
To: Jeremy Allison <jallison@ciq.com>
Cc: jra@samba.org, tansuresh@google.com, hch@lst.de, 
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240213_193717_369672_EDCF000C 
X-CRM114-Status: GOOD (  31.46  )
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

On Mon, Jan 29, 2024 at 10:19=E2=80=AFAM Jeremy Allison <jallison@ciq.com> =
wrote:
>
> From: Tanjore Suresh <tansuresh@google.com>
>
> This changes the bus driver interface with an additional entry point
> to enable devices to implement two-pass shutdown. The existing
> synchronous interface to shutdown is called, and if a shutdown_wait
> method is defined the device is moved to an alternate list.

This sounds more like you need a parallelized async shutdown than a
two-pass shutdown. Similar to how async probes are done today. Why not
do that so it'll actually be useful in a more general fashion? You can
even add a flag like we have for probes so that drivers don't need to
do anything special to allow this parallelism.

-Saravana

>
> Once the shutdown method is called for all devices, the
> shutdown_wait method is then called synchronously for
> all devices on the alternate list.
>
> Signed-off-by: Tanjore Suresh <tansuresh@google.com>
> Signed-off-by: Jeremy Allison <jallison@ciq.com>
> ---
>  drivers/base/core.c        | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/device/bus.h |  6 +++++-
>  2 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 14d46af40f9a..c8b0d4c9abed 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4725,6 +4725,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
>  void device_shutdown(void)
>  {
>         struct device *dev, *parent;
> +       LIST_HEAD(shutdown_wait_list);
>
>         wait_for_device_probe();
>         device_block_probing();
> @@ -4769,10 +4770,17 @@ void device_shutdown(void)
>                                 dev_info(dev, "shutdown_pre\n");
>                         dev->class->shutdown_pre(dev);
>                 }
> +
>                 if (dev->bus && dev->bus->shutdown) {
>                         if (initcall_debug)
>                                 dev_info(dev, "shutdown\n");
>                         dev->bus->shutdown(dev);
> +                       /*
> +                        * Only put the device on the shutdown_wait_list
> +                        * if a shutdown_wait() method is also defined.
> +                        */
> +                       if (dev->bus->shutdown_wait)
> +                               list_add(&dev->kobj.entry, &shutdown_wait=
_list);
>                 } else if (dev->driver && dev->driver->shutdown) {
>                         if (initcall_debug)
>                                 dev_info(dev, "shutdown\n");
> @@ -4789,6 +4797,33 @@ void device_shutdown(void)
>                 spin_lock(&devices_kset->list_lock);
>         }
>         spin_unlock(&devices_kset->list_lock);
> +
> +       /*
> +        * Second pass only for devices that have configured
> +        * a shutdown_wait() method.
> +        */
> +       while (!list_empty(&shutdown_wait_list)) {
> +               dev =3D list_entry(shutdown_wait_list.next, struct device=
,
> +                               kobj.entry);
> +               parent =3D get_device(dev->parent);
> +               get_device(dev);
> +               /*
> +                * Make sure the device is off the  list
> +                */
> +               list_del_init(&dev->kobj.entry);
> +               if (parent)
> +                       device_lock(parent);
> +               device_lock(dev);
> +               if (initcall_debug)
> +                       dev_info(dev,
> +                       "shutdown_wait called\n");
> +               dev->bus->shutdown_wait(dev);
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
> index 5ef4ec1c36c3..a4132c44dac3 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -48,7 +48,10 @@ struct fwnode_handle;
>   *             will never get called until they do.
>   * @remove:    Called when a device removed from this bus.
>   * @shutdown:  Called at shut-down time to quiesce the device.
> - *
> + * @shutdown_wait:     If this method exists, devices are stored on a se=
parate
> + *                     list after shutdown() has been called and
> + *                     shutdown_wait() is called synchronously on each d=
evice
> + *                     in this list in turn.
>   * @online:    Called to put the device back online (after offlining it)=
.
>   * @offline:   Called to put the device offline for hot-removal. May fai=
l.
>   *
> @@ -87,6 +90,7 @@ struct bus_type {
>         void (*sync_state)(struct device *dev);
>         void (*remove)(struct device *dev);
>         void (*shutdown)(struct device *dev);
> +       void (*shutdown_wait)(struct device *dev);
>
>         int (*online)(struct device *dev);
>         int (*offline)(struct device *dev);
> --
> 2.39.3
>
>
>

