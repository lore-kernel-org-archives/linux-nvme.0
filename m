Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628BBCCFA02
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 19:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9ObbBtY4bAACLHGXaCLYX4TLQoujOeHfNhffdejq4q8=; b=E4DPdMHxKlWFNPXH9iXXYFYaTL
	8z6SeVWWJ28MTbIhbYAtp1bE/CIiBNhfMN9reQ9iH58uAZBa5O6qGYrjI6Mvl8GFAtkeAp52q3RQO
	6Hv6naYtoF6LCpwe853+818X9gubmA4SoQKYBnNno95PXEvXX8lFoaL9v6zWaP72PDrDj2ANTr3Mg
	MVwknM0FvSlZ9t8B3drDy9h90lIc/uPgxttJ2fF2rBjZd3JCVk978rNzKEeUI1vlwq04f4nlxKnYR
	Vv5HTaEQES8qpM9rTf2esazsLR5XBS1dIduJQRcvCtIZQ0AIhCNvaIign/ZxXTWq4vGMBcMWI1adx
	ztbVhe8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEueg-00000006gt3-2pgX;
	Fri, 31 Oct 2025 19:19:22 +0000
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEuee-00000006gsi-0Syt
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 19:19:21 +0000
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-89ed32f388dso47911285a.2
        for <linux-nvme@lists.infradead.org>; Fri, 31 Oct 2025 12:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761938358; x=1762543158; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ObbBtY4bAACLHGXaCLYX4TLQoujOeHfNhffdejq4q8=;
        b=cyG6LDx8aShz0v+ZGaLl1d0PuvZ8VZYpjSUQXajSV3dmKWODVozaLV6k8lacLJJmvi
         HFv5io8CgyWwHApvUBzE2/YgWvJbG0CBxWj+sIFRTFS5HwO7ON+Xj/kT4CS/OTDl/xX0
         FTQ1Ts5kBaGqej/K9CPbpCGfnoLgtS3qJaZ9DDIgMl3XfCWyP3SenNZ2quJb8O4/rpFp
         ENsTR8f+eqUNbN62/D31RGdAinWolmBEkrIZuyIknKngHcWLW0UWprlg3Ax0dIjNyFrS
         oJC9bG/OsQafpZ4ijfn4624kYQOviACyxND0RbXup06KHZZv2BTug7hEfWNR+h87nOuY
         eAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761938358; x=1762543158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ObbBtY4bAACLHGXaCLYX4TLQoujOeHfNhffdejq4q8=;
        b=YSrtylSc0ZWZiNnXZO/Jhh83ny4Y/CBA3m+VqMXSwBNydny6ZPNdX6vYE/Vy3VDkBW
         Y3yyX8NIe4zqWPybo7oCNlCqaFttMwV+WI0dC/XtA/HsBlmRKU+GFlyIOV3nN84lRgxw
         iJwyBYASus9oFt/4oc2pRkgq5vOE4xDgyPoacp9MrxZZcEn0vUBUGQOwKZAUqAnNQ/XE
         JlQb/8M4rshC0+iy60POmDNBMJomBGfOHPbuK73q/0zLrHODNEKhwqdfNoCV5112S/3j
         NpE3WXfs4GusTikcf3z8MlKHJk0DYd5xMrAtE33BAV335B2zO79/GN/XVHjdAAQXx2Kp
         FKFg==
X-Forwarded-Encrypted: i=1; AJvYcCW3udTvgXdlbaWJ8N6m8uAgFe4OWLVPIvZoQa5667lY+2Hk/FAW5xtV8W0U9U6JjLaGwSDLAHcPCAHt@lists.infradead.org
X-Gm-Message-State: AOJu0YylSj2H0ob42huClCsTgmiEOK9sSlA7hRWhb+W5lGtslYK5TRFu
	4IOPUP3qkV+jgA/dSIAgta9EAKyk8Qt2nrRCdsWmxvX36HsksH9AjLFhrsZmI/C83Ox3ovS2vyO
	7m9b/Cf91NHnDyX7T4hSjWtIrYF6A8e2S7jqmJtLHyA==
X-Gm-Gg: ASbGncsMWe7JZP0zll03ayVQGLaFHyJwYaSUn5SDeanWXa4r6tz5o+c2C+0qhspFGAG
	gDSJCjKyvgZrOxBvfhYyNpILs3SgUnjts/kaK5PqaD3VZN8yse3aocr/l0P2VglaYIp7Hb4UL9I
	1ot04Poq1vr+ml2IEEqVN4oeVCsKqnLTDt7l8Fvm7XC2squnm020CUquG1MxGI3ETDy1Hqj3i5i
	ndOiHWl26Q+U/Cd4gamQzDIfmZ3nTbfrMNLi7+Xe8FL7obgo0dnm9g+btQ4
X-Google-Smtp-Source: AGHT+IHXoeGmi8LnCdXA77pFlBZKMCAMSpt8AYomLHc17PLdvJiM/1UMje1jR4m5+81nyZw+tLwE34AQdhYwBck5Yz0=
X-Received: by 2002:a05:620a:1a85:b0:863:88f9:3edf with SMTP id
 af79cd13be357-8ab9b694e4fmr379255185a.13.1761938358244; Fri, 31 Oct 2025
 12:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20251029210853.20768-1-cachen@purestorage.com>
 <20251029210853.20768-2-cachen@purestorage.com> <aQKzxpJp98Po_pch@kbusch-mbp> <9669f8a9-11ad-4911-9e03-00758e1d9957@nvidia.com>
In-Reply-To: <9669f8a9-11ad-4911-9e03-00758e1d9957@nvidia.com>
From: Casey Chen <cachen@purestorage.com>
Date: Fri, 31 Oct 2025 12:19:06 -0700
X-Gm-Features: AWmQ_blv_5UoJMF1pDaZQg5T4Bip-zzv__0KvKfNk-uc74laM-93_6kfXXbTk20
Message-ID: <CALCePG3Q9u-Mcj6qWqudip+JPVHMq=XBX2=QxJJrV1hELJrYDw@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvme: fix use-after-free of admin queue via stale pointer
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"yzhong@purestorage.com" <yzhong@purestorage.com>, 
	"sconnor@purestorage.com" <sconnor@purestorage.com>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	"mkhalfella@purestorage.com" <mkhalfella@purestorage.com>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_121920_362756_5AA028DB 
X-CRM114-Status: GOOD (  32.69  )
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

On Thu, Oct 30, 2025 at 1:12=E2=80=AFAM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 10/29/25 17:39, Keith Busch wrote:
> > On Wed, Oct 29, 2025 at 03:08:53PM -0600, Casey Chen wrote:
> >> Fix this by taking an additional reference on the admin queue during
> >> namespace allocation and releasing it during namespace cleanup.
> > Since the namespaces already hold references on the controller, would i=
t
> > be simpler to move the controller's final blk_put_queue to the final
> > ctrl free? This should have the same lifetime as your patch, but with
> > simpler ref counting:
> >
> > ---
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index fa4181d7de736..0b83d82f67e75 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -4901,7 +4901,6 @@ void nvme_remove_admin_tag_set(struct nvme_ctrl *=
ctrl)
> >           */
> >          nvme_stop_keep_alive(ctrl);
> >          blk_mq_destroy_queue(ctrl->admin_q);
> > -       blk_put_queue(ctrl->admin_q);
> >          if (ctrl->ops->flags & NVME_F_FABRICS) {
> >                  blk_mq_destroy_queue(ctrl->fabrics_q);
> >                  blk_put_queue(ctrl->fabrics_q);
> > @@ -5045,6 +5044,7 @@ static void nvme_free_ctrl(struct device *dev)
> >                  container_of(dev, struct nvme_ctrl, ctrl_device);
> >          struct nvme_subsystem *subsys =3D ctrl->subsys;
> >
> > +       blk_put_queue(ctrl->admin_q);
> >          if (!subsys || ctrl->instance !=3D subsys->instance)
> >                  ida_free(&nvme_instance_ida, ctrl->instance);
> >          nvme_free_cels(ctrl);
> > --
> >
>
> above is much better approach that doesn't rely on taking extra
> ref count but using existing count to protect the UAF.
> I've added required comments that are very much needed here,
> totally untested :-
>
> nvme: fix UAF when accessing admin queue after removal
>
> Fix a use-after-free where userspace IOCTLs can access ctrl->admin_q
> after it has been freed during controller removal.
>
> The Race Condition:
>
>    Thread 1 (userspace IOCTL)          Thread 2 (sysfs remove)
>    --------------------------          -------------------
>    open(/dev/nvme0n1) -> fd=3D3
>    ioctl(3, NVME_IOCTL_ADMIN_CMD)
>      nvme_ioctl()
>      nvme_user_cmd()
>                                         echo 1 > .../remove
>                                         pci_device_remove()
>                                         nvme_remove()
>   nvme_remove_admin_tag_set()
>                                           blk_put_queue(admin_q)
>                                           [RCU grace period]
>                                           blk_free_queue(admin_q)
>                                             kmem_cache_free() <- FREED
>      nvme_submit_user_cmd(ns->ctrl->admin_q) <- STALE POINTER
>        blk_mq_alloc_request(admin_q)
>          blk_queue_enter(admin_q)
>            *** USE-AFTER-FREE ***
>
>
> The admin queue is freed in nvme_remove_admin_tag_set() while userspace
> may still hold open file descriptors to namespace devices. These open
> file descriptors can issue IOCTLs that dereference ctrl->admin_q after
> it has been freed.
>
> Defer blk_put_queue(ctrl->admin_q) from nvme_remove_admin_tag_set() to
> nvme_free_ctrl(). Since each namespace holds a controller reference via
> nvme_get_ctrl()/nvme_put_ctrl(), the controller will only be freed after
> all namespaces (and their open file descriptors) are released. This
> guarantees admin_q remains allocated while it may still be accessed.
>
> After blk_mq_destroy_queue() in nvme_remove_admin_tag_set(), the queue
> is marked dying (QUEUE_FLAG_DYING), so new IOCTL attempts fail safely
> at blk_queue_enter() with -ENODEV. The queue structure remains valid for
> pointer dereference until nvme_free_ctrl() is called.
>
> ---
>   drivers/nvme/host/core.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 734ad725e6f4..dbbcf99dbef8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4897,7 +4897,19 @@ void nvme_remove_admin_tag_set(struct nvme_ctrl
> *ctrl)
>        */
>       nvme_stop_keep_alive(ctrl);
>       blk_mq_destroy_queue(ctrl->admin_q);
> -    blk_put_queue(ctrl->admin_q);
> +    /**
> +     * Defer blk_put_queue() to nvme_free_ctrl() to prevent use-after-fr=
ee.
> +     *
> +     * Userspace may hold open file descriptors to namespace devices and
> +     * issue IOCTLs that dereference ctrl->admin_q after controller remo=
val
> +     * starts. Since each namespace holds a controller reference, deferr=
ing
> +     * the final queue release ensures admin_q remains allocated until a=
ll
> +     * namespace references are released.
> +     *
> +     * blk_mq_destroy_queue() above marks the queue dying
> (QUEUE_FLAG_DYING),
> +     * causing new requests to fail at blk_queue_enter() with -ENODEV wh=
ile
> +     * keeping the structure valid for pointer access.
> +     */
>       if (ctrl->ops->flags & NVME_F_FABRICS) {
>           blk_mq_destroy_queue(ctrl->fabrics_q);
>           blk_put_queue(ctrl->fabrics_q);
> @@ -5041,6 +5053,14 @@ static void nvme_free_ctrl(struct device *dev)
>           container_of(dev, struct nvme_ctrl, ctrl_device);
>       struct nvme_subsystem *subsys =3D ctrl->subsys;
>
> +    /**
> +     * Release admin_q's final reference. All namespace references have
> +     * been released at this point. NULL check is needed for to handle
> +     * allocation failure in nvme_alloc_admin_tag_set().
> +     */
> +    if (ctrl->admin_q)
> +        blk_put_queue(ctrl->admin_q);
> +
>       if (!subsys || ctrl->instance !=3D subsys->instance)
>           ida_free(&nvme_instance_ida, ctrl->instance);
>       nvme_free_cels(ctrl);
>
> -ck
>
>
>

Thanks Chaitanya. I tested your fix and all tests look good. We're
looking forward to your final version.

