Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B30C4829D
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Feb 2024 03:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RVdsZB/ToMM1hFsUZU0UC5LfdCPk9RGSv+kQCIcz0sE=; b=wyoYHVnGlPcGv1Na+NJ64IiZP1
	epK8bqANcaYEuOqs1AhzImDAx1mWdNuFHGGOXraSnFsECBDsNBQgTrTVOzZLrI7Wbh6O3NlxpY81I
	kXHsUTcbu3cesaZPhdJm69dpHiLcrm/zmfAc8YCK6WoPDHeUlmJoZTZEr5h4lryz8O0pyNr/5zHz4
	l6MEfHysfJmWlL2I9e7Qtm6LgiWi3OVW9oEnxNiXPDWhlYBCTQnIhfJkrRtO2baUBjQ23sMtY8m/G
	BKk18aXUGWy+jcQCZyJyzMNY7/3J6SPQeLUkMFQlXzV8FbKZyRrDGIBqHu7xyxtHGRJORhYKAejo3
	oaYP9Q/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ra6BI-0000000Bgrq-1hKp;
	Wed, 14 Feb 2024 03:43:32 +0000
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ra6BE-0000000Bgqv-3fek
	for linux-nvme@lists.infradead.org;
	Wed, 14 Feb 2024 03:43:30 +0000
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-42a99dc9085so262761cf.0
        for <linux-nvme@lists.infradead.org>; Tue, 13 Feb 2024 19:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707882207; x=1708487007; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVdsZB/ToMM1hFsUZU0UC5LfdCPk9RGSv+kQCIcz0sE=;
        b=k/8tHmbI2Ff+tpO3gmqU2bPEQpVMcEL51mk6mAvtUmSPdDfEUWBxnKZiacoy4iHrLY
         /cEizea2UD7WztgGCYrVy29ihFmuDSd+Yxg/kyxlt1OE1OPmiTy4E1g9ztGE64Ruajgj
         7AMuIvY8jDMTYR41gUgVMOixeKMgmBSFZBr41P4SG20k6KY8aBGmWkcnn9le1etQgGUK
         T0kd3R9cxDDkLUCzHUinPQ81ih0qwL6kj837zyrCqSLPf9jQA3/tUdWydPD1ahOjWEWa
         lrMPr6kh7O0EEa6hZLuQ9XOFxet3/ORv/vTv7VlCt9+aeRn0wTFtQuoxrartJW6KszaG
         YL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707882207; x=1708487007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVdsZB/ToMM1hFsUZU0UC5LfdCPk9RGSv+kQCIcz0sE=;
        b=YeyIfz0OWJaDKVWB5XQ8dcFstz//LsyNIJE4ILXNl9QDohUbo2HY1LS98/XYfgV7e8
         c+2QquRYmBTPsgH1fR7O5wx9SkvqHXh+kOcwX3n+MOrQNKrWCRkoGtx2EYz9//TIWs8f
         TtsbVxQKis/d+VKuNU945aC5m5J/T87P5kERavorfGK/oxS5DEgZNzeSKxHCB4ifXXc5
         MUDRio/Kcd5gZCMIcmYYaSKaLtx4c1xXJwAG7aHc36eQxUEvrvMjZWznUHYN8ph7LXA8
         NR1etFwoi+5R6cKd5mI0C0lt+KB9gqMFMcHM3wNV1FdRTZbyRYpfv2ItbhDJSwrYKhKt
         cOFw==
X-Forwarded-Encrypted: i=1; AJvYcCX7LwX+Qgg5kBpbd2nU8W4KYBrONFHT40c06fJ/VzPoYcYkLm+6LgpzgN52rNj3KbluCsd2iMv2D/HwRQTHRMRMDkFwkF/DIobcze7S78Y=
X-Gm-Message-State: AOJu0YwEj8XxV8lR6zhbrMcO+spIykO98Iv6dzmSTy+0SDem63h5v5N4
	/i/CzDfvqvb8bF9hZSnx6uJE3HyXCLGp1sX99ErfQgNwBIgkfDCbOLSc+iuZzZ4KufFn+JjBihj
	SXMdIfrfvweLLtw9GDMfAv8ltUVN2gSQDGni5
X-Google-Smtp-Source: AGHT+IERNeITuXB2DOctF8Q3TmFhxDZD8cOk9Z6lv9oJLw9g32v/uohB8ZGy6kvhRku0RZXUjsHH+ryWlD5ENik9eMI=
X-Received: by 2002:ac8:5dce:0:b0:42d:b492:868f with SMTP id
 e14-20020ac85dce000000b0042db492868fmr199017qtx.24.1707882206589; Tue, 13 Feb
 2024 19:43:26 -0800 (PST)
MIME-Version: 1.0
References: <20240207184100.18066-1-djeffery@redhat.com> <20240207184100.18066-2-djeffery@redhat.com>
In-Reply-To: <20240207184100.18066-2-djeffery@redhat.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 13 Feb 2024 19:42:50 -0800
Message-ID: <CAGETcx91KahXY6ULXDpek3Xf6k4s646Y6+jn_LtfZPDDOpg7hA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] minimal async shutdown infrastructure
To: David Jeffery <djeffery@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Laurence Oberman <loberman@redhat.com>, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240213_194328_950213_553F5509 
X-CRM114-Status: GOOD (  40.10  )
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

On Wed, Feb 7, 2024 at 10:40=E2=80=AFAM David Jeffery <djeffery@redhat.com>=
 wrote:
>
> Adds the async_shutdown_start and async_shutdown_end calls to perform asy=
nc
> shutdown. Implements a very minimalist method of async shutdown support
> within device_shutdown(). The device at the head of the shutdown list is
> checked against a list of devices under async shutdown. If the head is a
> parent of a device on the async list, all active async shutdown operation=
s
> are completed before the parent's shutdown call is performed.
>
> The number of async operations also has a max limit to prevent the list b=
eing
> checked for a child from getting overly large.
>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Tested-by:     Laurence Oberman <loberman@redhat.com>
>
> ---
>  drivers/base/core.c           | 116 +++++++++++++++++++++++++++++++++-
>  include/linux/device/bus.h    |   8 ++-
>  include/linux/device/driver.h |   7 ++
>  3 files changed, 127 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 14d46af40f9a..5bc2282c00cd 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4719,12 +4719,92 @@ int device_change_owner(struct device *dev, kuid_=
t kuid, kgid_t kgid)
>  }
>  EXPORT_SYMBOL_GPL(device_change_owner);
>
> +
> +#define MAX_ASYNC_SHUTDOWNS 32
> +static int async_shutdown_count;
> +static LIST_HEAD(async_shutdown_list);
> +
> +/**
> + * If a device has a child busy with an async shutdown or there are too =
many
> + * async shutdowns active, the device may not be shut down at this time.
> + */
> +static bool may_shutdown_device(struct device *dev)
> +{
> +       struct device *tmp;
> +
> +       if (async_shutdown_count >=3D MAX_ASYNC_SHUTDOWNS)
> +               return false;
> +
> +       list_for_each_entry(tmp, &async_shutdown_list, kobj.entry) {
> +               if (tmp->parent =3D=3D dev)
> +                       return false;
> +       }
> +       return true;
> +}
> +
> +/**
> + * Call and track each async shutdown call
> + */
> +static void async_shutdown_start(struct device *dev, void (*callback) (s=
truct device *))
> +{
> +       if (initcall_debug)
> +               dev_info(dev, "async_shutdown_start\n");
> +
> +       (*callback)(dev);
> +       list_add_tail(&dev->kobj.entry, &async_shutdown_list);
> +       async_shutdown_count++;
> +}
> +
> +/**
> + * Wait for all async shutdown operations currently active to complete
> + */
> +static void wait_for_active_async_shutdown(void)
> +{
> +       struct device *dev, *parent;
> +
> +        while (!list_empty(&async_shutdown_list)) {
> +                dev =3D list_entry(async_shutdown_list.next, struct devi=
ce,
> +                                kobj.entry);
> +
> +                parent =3D dev->parent;

I didn't check the code thoroughly, but so there might be other big
issues. But you definitely need to take device links into account.
Shutdown all your consumers first similar to how you shutdown the
children devices first. Look at the async suspend/resume code for some
guidance.

> +
> +                /*
> +                 * Make sure the device is off the list
> +                 */
> +                list_del_init(&dev->kobj.entry);
> +                if (parent)
> +                        device_lock(parent);
> +                device_lock(dev);
> +                if (dev->bus && dev->bus->async_shutdown_end) {
> +                        if (initcall_debug)
> +                                dev_info(dev,
> +                                "async_shutdown_end called\n");
> +                        dev->bus->async_shutdown_end(dev);
> +                } else if (dev->driver && dev->driver->async_shutdown_en=
d) {
> +                       if (initcall_debug)
> +                               dev_info(dev,
> +                               "async_shutdown_end called\n");
> +                       dev->driver->async_shutdown_end(dev);
> +               }
> +                device_unlock(dev);
> +                if (parent)
> +                        device_unlock(parent);
> +
> +                put_device(dev);
> +                put_device(parent);
> +        }
> +       if (initcall_debug)
> +               printk(KERN_INFO "device shutdown: waited for %d async sh=
utdown callbacks\n", async_shutdown_count);
> +       async_shutdown_count =3D 0;
> +}
> +
>  /**
>   * device_shutdown - call ->shutdown() on each device to shutdown.
>   */
>  void device_shutdown(void)
>  {
>         struct device *dev, *parent;
> +       bool async_busy;
>
>         wait_for_device_probe();
>         device_block_probing();
> @@ -4741,6 +4821,8 @@ void device_shutdown(void)
>                 dev =3D list_entry(devices_kset->list.prev, struct device=
,
>                                 kobj.entry);
>
> +               async_busy =3D false;
> +
>                 /*
>                  * hold reference count of device's parent to
>                  * prevent it from being freed because parent's
> @@ -4748,6 +4830,17 @@ void device_shutdown(void)
>                  */
>                 parent =3D get_device(dev->parent);
>                 get_device(dev);
> +
> +                if (!may_shutdown_device(dev)) {
> +                       put_device(dev);
> +                       put_device(parent);
> +
> +                       spin_unlock(&devices_kset->list_lock);
> +                       wait_for_active_async_shutdown();
> +                       spin_lock(&devices_kset->list_lock);
> +                       continue;
> +               }
> +
>                 /*
>                  * Make sure the device is off the kset list, in the
>                  * event that dev->*->shutdown() doesn't remove it.
> @@ -4769,26 +4862,43 @@ void device_shutdown(void)
>                                 dev_info(dev, "shutdown_pre\n");
>                         dev->class->shutdown_pre(dev);
>                 }
> -               if (dev->bus && dev->bus->shutdown) {
> +               if (dev->bus && dev->bus->async_shutdown_start) {
> +                       async_shutdown_start(dev, dev->bus->async_shutdow=
n_start);
> +                       async_busy =3D true;
> +               } else if (dev->bus && dev->bus->shutdown) {
>                         if (initcall_debug)
>                                 dev_info(dev, "shutdown\n");
>                         dev->bus->shutdown(dev);
> +               } else if (dev->driver && dev->driver->async_shutdown_sta=
rt) {
> +                       async_shutdown_start(dev, dev->driver->async_shut=
down_start);
> +                       async_busy =3D true;
>                 } else if (dev->driver && dev->driver->shutdown) {
>                         if (initcall_debug)
>                                 dev_info(dev, "shutdown\n");
>                         dev->driver->shutdown(dev);
> +               } else {
> +                       if (initcall_debug)
> +                               dev_info(dev, "no shutdown callback\n");
>                 }
>
>                 device_unlock(dev);
>                 if (parent)
>                         device_unlock(parent);
>
> -               put_device(dev);
> -               put_device(parent);
> +               /* if device has an async shutdown, drop the ref when don=
e */
> +               if (!async_busy) {
> +                       put_device(dev);
> +                       put_device(parent);
> +               }
>
>                 spin_lock(&devices_kset->list_lock);
>         }
>         spin_unlock(&devices_kset->list_lock);
> +       /*
> +        * Wait for any async shutdown still running.
> +        */
> +       if (!list_empty(&async_shutdown_list))
> +               wait_for_active_async_shutdown();
>  }
>
>  /*
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index 5ef4ec1c36c3..7a4a2ff0bc23 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -48,7 +48,11 @@ struct fwnode_handle;
>   *             will never get called until they do.
>   * @remove:    Called when a device removed from this bus.
>   * @shutdown:  Called at shut-down time to quiesce the device.
> - *
> + * @async_shutdown_start:      Optional call to support and begin the sh=
utdown
> + *                             process on the device in an asynchronous =
manner.
> + * @async_shutdown_end:                Optional call to complete an asyn=
chronous
> + *                             shutdown of the device. Must be provided =
if a
> + *                             sync_shutdown_start call is provided.
>   * @online:    Called to put the device back online (after offlining it)=
.
>   * @offline:   Called to put the device offline for hot-removal. May fai=
l.
>   *
> @@ -87,6 +91,8 @@ struct bus_type {
>         void (*sync_state)(struct device *dev);
>         void (*remove)(struct device *dev);
>         void (*shutdown)(struct device *dev);
> +       void (*async_shutdown_start)(struct device *dev);
> +       void (*async_shutdown_end)(struct device *dev);
>
>         int (*online)(struct device *dev);
>         int (*offline)(struct device *dev);
> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.=
h
> index 7738f458995f..af0ad2d3687a 100644
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -71,6 +71,11 @@ enum probe_type {
>   * @remove:    Called when the device is removed from the system to
>   *             unbind a device from this driver.
>   * @shutdown:  Called at shut-down time to quiesce the device.
> + * @async_shutdown_start:      Optional call to support and begin the sh=
utdown
> + *                             process on the device in an asynchronous =
manner.
> + * @async_shutdown_end:                Optional call to complete an asyn=
chronous
> + *                             shutdown of the device. Must be provided =
if a
> + *                             sync_shutdown_start call is provided.
>   * @suspend:   Called to put the device to sleep mode. Usually to a
>   *             low power state.
>   * @resume:    Called to bring a device from sleep mode.
> @@ -110,6 +115,8 @@ struct device_driver {
>         void (*sync_state)(struct device *dev);
>         int (*remove) (struct device *dev);
>         void (*shutdown) (struct device *dev);
> +       void (*async_shutdown_start) (struct device *dev);
> +       void (*async_shutdown_end) (struct device *dev);

Why not use the existing shutdown and call it from an async thread and
wait for it to finish? Similar to how async probes are handled. Also,
adding separate ops for this feels clunky and a very narrow fix. Just
use a flag to indicate the driver can support async shutdown using the
existing shutdown() op.

-Saravana

