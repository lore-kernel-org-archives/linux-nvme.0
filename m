Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAD0C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 01:25:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E541C606A5
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 01:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E541C606A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oe2+e2ZyBa4Rnil+iy4posUTlRQh41TaKCJ4rWYXRrA=; b=vwxlCnxWQgYAvVdUA4goZCdUG1
	+u6fJqIjs1lTBugsgF9KHGhgxrA9vdpPngehg2C87ZTaYEPmmA7tLGP7qcZvt1u0T/Kq5qiFsAg9T
	0lZa4k1ei/ABtwbkVrctb702HMDwbTU4Z1DDUQKre1eWj/s2LeJTgzY1ZrGtq2sQlEXcDBZ6l3NRP
	r1afoO8l9b1nXHkjBelIxqN9UrC/RNQgegv6VbYHjBL1qNzkpf/P/Vzex1vGB7xHumMpHY85qjX+w
	04Sov378UttuXEi26PkCaKmq4f0fQU1S4eTlvl8BDN+AGbpyy/Rd6WLYZmXdIZuD+qasFH76guxwd
	2qELHW+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mapUo-001BWm-Vj; Thu, 14 Oct 2021 01:25:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mapUk-001BW6-Vm
 for linux-nvme@lists.infradead.org; Thu, 14 Oct 2021 01:25:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634174717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oe2+e2ZyBa4Rnil+iy4posUTlRQh41TaKCJ4rWYXRrA=;
 b=b4PZKO9/XCKydFXNBaYWad2D2Xv13ZPxj5l2zDOyviTxLkFWG59jLC/5N6PcGkEjUvjzc+
 CIRaP1GN5w8F3frKzyWZBLiIkQ9YZrzZ2c1zERw/Ta5+yUsm+91zo5zPv9VKPCxRxsKExE
 8yVqVKT6uRFisunLeU53TBUA/Sz/0ZI=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-f8y4uhVhMBK_3y35sAEHnA-1; Wed, 13 Oct 2021 21:25:15 -0400
X-MC-Unique: f8y4uhVhMBK_3y35sAEHnA-1
Received: by mail-yb1-f200.google.com with SMTP id
 124-20020a251182000000b005a027223ed9so5178106ybr.13
 for <linux-nvme@lists.infradead.org>; Wed, 13 Oct 2021 18:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Oe2+e2ZyBa4Rnil+iy4posUTlRQh41TaKCJ4rWYXRrA=;
 b=ZLTkEm+eni45zy0iwSV5b/yd+iocjqHVrZa53gGdPko5+ugxQdG5VhUJiij4VGtufE
 d4dMrKgbVFadRAd82Y4jxWcQhI4PDLg8tdL7wH97hLb4GeMqQ1Z2RSQovqVpU8VDjpQ/
 3IP15+lFbajYcS41GOl9gSt2CRYee1wL4dLzrJ5AS3dEqCRGdTojmDm4KnpFAJcpKNjt
 xW21L+GMgpVkpLiBK0X2fYwp5FqwOTTUfpAag4i7+NFBVj0TAP+m5V8t6UPH4fph6v/r
 b+6Xgxm7PSODwC1XXuOFK4+V/7CKYuHi/AYi26aupmtO0bmhhljD+4fQVaTxCKbQMRsn
 HoGg==
X-Gm-Message-State: AOAM5319znKQRHR8olZ11FUdsolqe8Ug1QdgzrOkUmCh9M3Q414nRBJb
 34mtk2Xm7Q9+nQPDA4pBwvlHSsfxXhRpeqFEHZEAUgqixV5XCxoGlvfgi0lj2LX7vdEiQPosZcr
 Y682YJ7+UHo4qMMhGIKiKSES+U8OTAVTJeQx2LPAC+E0=
X-Received: by 2002:a25:496:: with SMTP id 144mr3095587ybe.522.1634174715136; 
 Wed, 13 Oct 2021 18:25:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhy4o4ssfv/yWhLhk2a3KWBDRE5rw6FITQZS+vijVKSeE8TNlCQMZF3TrqoFMLlTlGgxLncIMb4rODHJE6t84=
X-Received: by 2002:a25:496:: with SMTP id 144mr3095570ybe.522.1634174714947; 
 Wed, 13 Oct 2021 18:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20211013150421uscas1p297a8bd51cf3f3b68dcef3a1c87da2959@uscas1p2.samsung.com>
 <20211013150413.320133-1-a.manzanares@samsung.com>
In-Reply-To: <20211013150413.320133-1-a.manzanares@samsung.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 14 Oct 2021 09:25:03 +0800
Message-ID: <CAHj4cs_2Dip8PzoiHoXaHNyicBxWp5uxnfQj_yXLGwwwBMtq=Q@mail.gmail.com>
Subject: Re: [PATCH] nvme: Cleanup per-namespace chardev deletion
To: Adam Manzanares <a.manzanares@samsung.com>
Cc: "sagi@grimberg.me" <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>, 
 Minwoo Im <minwoo.im.dev@gmail.com>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_182519_162334_44251179 
X-CRM114-Status: GOOD (  20.05  )
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

Verified this patch on top of 5.15.0-rc5.

Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Wed, Oct 13, 2021 at 11:04 PM Adam Manzanares
<a.manzanares@samsung.com> wrote:
>
> Decrease reference count of chardevice during char device deletion in order to
> fix a kmemleak. Add relese function for the device associated chardev and moved
> ida_simple_remove into the release function.
>
> Fixes: 2637bae (nvme: introduce generic per-namespace chardev)
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Suggested-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Adam Manzanares <a.manzanares@samsung.com>
> ---
>  drivers/nvme/host/core.c      | 21 ++++++++++++---------
>  drivers/nvme/host/multipath.c |  2 --
>  2 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f9a25c61fb8b..3bc4bb620ab7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3583,10 +3583,15 @@ static int __nvme_check_ids(struct nvme_subsystem *subsys,
>         return 0;
>  }
>
> +static void nvme_cdev_rel(struct device *dev)
> +{
> +       ida_simple_remove(&nvme_ns_chr_minor_ida, MINOR(dev->devt));
> +}
> +
>  void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device)
>  {
>         cdev_device_del(cdev, cdev_device);
> -       ida_simple_remove(&nvme_ns_chr_minor_ida, MINOR(cdev_device->devt));
> +       put_device(cdev_device);
>  }
>
>  int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
> @@ -3599,14 +3604,14 @@ int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
>                 return minor;
>         cdev_device->devt = MKDEV(MAJOR(nvme_ns_chr_devt), minor);
>         cdev_device->class = nvme_ns_chr_class;
> +       cdev_device->release = nvme_cdev_rel;
>         device_initialize(cdev_device);
>         cdev_init(cdev, fops);
>         cdev->owner = owner;
>         ret = cdev_device_add(cdev, cdev_device);
> -       if (ret) {
> +       if (ret)
>                 put_device(cdev_device);
> -               ida_simple_remove(&nvme_ns_chr_minor_ida, minor);
> -       }
> +
>         return ret;
>  }
>
> @@ -3638,11 +3643,9 @@ static int nvme_add_ns_cdev(struct nvme_ns *ns)
>                            ns->ctrl->instance, ns->head->instance);
>         if (ret)
>                 return ret;
> -       ret = nvme_cdev_add(&ns->cdev, &ns->cdev_device, &nvme_ns_chr_fops,
> -                           ns->ctrl->ops->module);
> -       if (ret)
> -               kfree_const(ns->cdev_device.kobj.name);
> -       return ret;
> +
> +       return nvme_cdev_add(&ns->cdev, &ns->cdev_device, &nvme_ns_chr_fops,
> +                            ns->ctrl->ops->module);
>  }
>
>  static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index fb96e900dd3a..bd490a7c4808 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -434,8 +434,6 @@ static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
>                 return ret;
>         ret = nvme_cdev_add(&head->cdev, &head->cdev_device,
>                             &nvme_ns_head_chr_fops, THIS_MODULE);
> -       if (ret)
> -               kfree_const(head->cdev_device.kobj.name);
>         return ret;
>  }
>
> --
> 2.25.1
>


-- 
Best Regards,
  Yi Zhang


