Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F49CCF9E3
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 22:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jmEsWMPH7op/Tb36OMzWCkWHxDTK+AUjMzjOkLG1p78=; b=lcPDP0dHePK2P/c6D34SBqPFhT
	XJb6mgUhtPgL5Xdij1kNxCV7glplQ6Vz897N0kpMRrlp/Ftn6F5q2ZScIkTRUOY63h1xxrD3yDUYC
	CDkPAZInTu2GB/5XHEZSbfL7k+Q2kj8odMDgn34QF6KT74Vvx/HPb4B5ek+GSWmyDOiLjAkeMPYIi
	PmXnI6GVprhqAAbAjg4BN9acFpM/8RYivEOGhGLCkiljTBGtg2Qh2llDVi5K4BcX2yuddG4mV3oZP
	LXB031JbeHwcmKo97jAkMIwHLHLE4UUp0wt0N4vSkHSMGujwKz0gbl6UjCiwm0SrKgouvpU6KdDvC
	p/1omE/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGPh4-0000000Chd7-2myk;
	Tue, 04 Nov 2025 22:40:02 +0000
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGPh1-0000000ChcL-2NYY
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 22:40:00 +0000
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-87bf3d1e80cso2885246d6.3
        for <linux-nvme@lists.infradead.org>; Tue, 04 Nov 2025 14:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762295998; x=1762900798; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmEsWMPH7op/Tb36OMzWCkWHxDTK+AUjMzjOkLG1p78=;
        b=X1LApQSIiNdAeWdHSMwKiQFH4B7ADG/22k9PXEJt3RVK2B98cWQQmGY+e1BwG1pu6b
         zgiNOrryGow1ScZYShLUqXJMCdfkSldoBm0nNty6q6MAsVOsR7qLzB36fHaH9d3jl/vQ
         WKQEKyZDQZ+KaWAUwCXMogSElVENSiQRX4nBgtdpqANKHtPVMiDll7LnAxcDhcJ0vMAl
         RQ4RUpIcjW+0GQvrofDatqoxnlP1GPruRtZKdIaSZ0Prtz93/kwhDe3sVaEi1EgCOKh0
         qAN90xfd9Mr0BGxY6DPXDesiitf/pdajkN0K3ex4vUYQWUW0l5haFUy76VGXymF88tCe
         8Drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295998; x=1762900798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmEsWMPH7op/Tb36OMzWCkWHxDTK+AUjMzjOkLG1p78=;
        b=PTJ/znurH/LiKzQjOjBjYKx4PJTLYD7+irDMZx8KS7DO4SvrS5Ls2wCcquNxHi/vl3
         a92N76ZxcxWQI77FE8ivXe3f6rG4oFsbKLamfPJf/I4hS1xlk4bk2kHW88vj9LFnjhSg
         j+svFh98Wpd3TVUYMxyPJNqsv2VI+Unp2wMNn+BkM4otJwCikyvgYQ2juMrwI8TWsGAs
         1h8lDOYdKWuKrsFsqOir2DXMIcCZ4q6+9k/vTmg49AUHs6YyuvHMxIBBx7r/QWC/AUt8
         RZKEtds11cDljUmEcEb1FwcGFupo8Vm1LglkbJ56I8L3PmGuXoTisdX2nYHePtbvnNDn
         g8+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXez16sn8keEakEx9JaXnjxXkXlvmFGuy9oTpRg+0jHXT70qyX1XEOK5IOzZdp1PFZ8E/u4O5tv5ynI@lists.infradead.org
X-Gm-Message-State: AOJu0YyYQa7C33K9thBcoyuPhWMADTi8AKqY0Cw4kOJx9nGoQIiB53hq
	1Acgdi/KZ+A7ah/kw8XpKSEE6U/yMIHy1MnDylyRdC53GzfCqTqPUjGl4cvWreWLCxZBzl2tiED
	fQe0Y7JESC+dzv/9eNWiWFOQ3uIW2egwT2sbozdvZKg==
X-Gm-Gg: ASbGnctWp86ayo74HhiP/DmaX7eHdBzjdX3jsxibEMNkChOr9eN9q7F/8zKPl47oI9D
	77mkxmozQB+JTmQcGz/Os54M7W5XgWaHFN62MCplgY3ji7P2pcYeUfxHZRreKwlIMj0Yl1I3X76
	9EiRqf4wLhGwdiNwWTmoGtQB5mHr6VNk7faxyhfFx6zY0sge+1Y3BqoF0cPymOysH2yDDf4STfp
	vL3n4VBbtFWim1Rfj/UKReuPSzD2aFlIdymQlDi9X3thggxXMYyNxZCJ+KtUQ==
X-Google-Smtp-Source: AGHT+IEyeHjjFj8+TsVUUEgbqqLfkWtfVgrvKYzGLN4yJzAm6F/wkmEMp7Ibqd0wOiB4hBO3OW6u8353lny/xj50vEg=
X-Received: by 2002:a05:6214:2027:b0:880:5cc1:693e with SMTP id
 6a1803df08f44-880712318cbmr12872266d6.7.1762295997796; Tue, 04 Nov 2025
 14:39:57 -0800 (PST)
MIME-Version: 1.0
References: <20251029210853.20768-1-cachen@purestorage.com>
 <20251029210853.20768-2-cachen@purestorage.com> <aQKzxpJp98Po_pch@kbusch-mbp>
 <9669f8a9-11ad-4911-9e03-00758e1d9957@nvidia.com> <CALCePG3Q9u-Mcj6qWqudip+JPVHMq=XBX2=QxJJrV1hELJrYDw@mail.gmail.com>
 <8015bde9-39eb-49e3-9102-7576b7b01239@nvidia.com>
In-Reply-To: <8015bde9-39eb-49e3-9102-7576b7b01239@nvidia.com>
From: Casey Chen <cachen@purestorage.com>
Date: Tue, 4 Nov 2025 14:39:47 -0800
X-Gm-Features: AWmQ_bmWbTcDiAXhZk6QVYMFqbQYIPaXR33cpXP-v32VMmaMiZ-W8SWLAHSC9bM
Message-ID: <CALCePG1oAs_gBW-YkBGKD_xG+ZEUpM66e9CS4MRrV-bOvY0ZkQ@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20251104_143959_688939_BC4E1016 
X-CRM114-Status: GOOD (  34.48  )
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

On Fri, Oct 31, 2025 at 12:31=E2=80=AFPM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 10/31/25 12:19, Casey Chen wrote:
> > On Thu, Oct 30, 2025 at 1:12=E2=80=AFAM Chaitanya Kulkarni
> > <chaitanyak@nvidia.com> wrote:
> >> On 10/29/25 17:39, Keith Busch wrote:
> >>> On Wed, Oct 29, 2025 at 03:08:53PM -0600, Casey Chen wrote:
> >>>> Fix this by taking an additional reference on the admin queue during
> >>>> namespace allocation and releasing it during namespace cleanup.
> >>> Since the namespaces already hold references on the controller, would=
 it
> >>> be simpler to move the controller's final blk_put_queue to the final
> >>> ctrl free? This should have the same lifetime as your patch, but with
> >>> simpler ref counting:
> >>>
> >>> ---
> >>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >>> index fa4181d7de736..0b83d82f67e75 100644
> >>> --- a/drivers/nvme/host/core.c
> >>> +++ b/drivers/nvme/host/core.c
> >>> @@ -4901,7 +4901,6 @@ void nvme_remove_admin_tag_set(struct nvme_ctrl=
 *ctrl)
> >>>            */
> >>>           nvme_stop_keep_alive(ctrl);
> >>>           blk_mq_destroy_queue(ctrl->admin_q);
> >>> -       blk_put_queue(ctrl->admin_q);
> >>>           if (ctrl->ops->flags & NVME_F_FABRICS) {
> >>>                   blk_mq_destroy_queue(ctrl->fabrics_q);
> >>>                   blk_put_queue(ctrl->fabrics_q);
> >>> @@ -5045,6 +5044,7 @@ static void nvme_free_ctrl(struct device *dev)
> >>>                   container_of(dev, struct nvme_ctrl, ctrl_device);
> >>>           struct nvme_subsystem *subsys =3D ctrl->subsys;
> >>>
> >>> +       blk_put_queue(ctrl->admin_q);
> >>>           if (!subsys || ctrl->instance !=3D subsys->instance)
> >>>                   ida_free(&nvme_instance_ida, ctrl->instance);
> >>>           nvme_free_cels(ctrl);
> >>> --
> >>>
> >> above is much better approach that doesn't rely on taking extra
> >> ref count but using existing count to protect the UAF.
> >> I've added required comments that are very much needed here,
> >> totally untested :-
> >>
> >> nvme: fix UAF when accessing admin queue after removal
> >>
> >> Fix a use-after-free where userspace IOCTLs can access ctrl->admin_q
> >> after it has been freed during controller removal.
> >>
> >> The Race Condition:
> >>
> >>     Thread 1 (userspace IOCTL)          Thread 2 (sysfs remove)
> >>     --------------------------          -------------------
> >>     open(/dev/nvme0n1) -> fd=3D3
> >>     ioctl(3, NVME_IOCTL_ADMIN_CMD)
> >>       nvme_ioctl()
> >>       nvme_user_cmd()
> >>                                          echo 1 > .../remove
> >>                                          pci_device_remove()
> >>                                          nvme_remove()
> >>    nvme_remove_admin_tag_set()
> >>                                            blk_put_queue(admin_q)
> >>                                            [RCU grace period]
> >>                                            blk_free_queue(admin_q)
> >>                                              kmem_cache_free() <- FREE=
D
> >>       nvme_submit_user_cmd(ns->ctrl->admin_q) <- STALE POINTER
> >>         blk_mq_alloc_request(admin_q)
> >>           blk_queue_enter(admin_q)
> >>             *** USE-AFTER-FREE ***
> >>
> >>
> >> The admin queue is freed in nvme_remove_admin_tag_set() while userspac=
e
> >> may still hold open file descriptors to namespace devices. These open
> >> file descriptors can issue IOCTLs that dereference ctrl->admin_q after
> >> it has been freed.
> >>
> >> Defer blk_put_queue(ctrl->admin_q) from nvme_remove_admin_tag_set() to
> >> nvme_free_ctrl(). Since each namespace holds a controller reference vi=
a
> >> nvme_get_ctrl()/nvme_put_ctrl(), the controller will only be freed aft=
er
> >> all namespaces (and their open file descriptors) are released. This
> >> guarantees admin_q remains allocated while it may still be accessed.
> >>
> >> After blk_mq_destroy_queue() in nvme_remove_admin_tag_set(), the queue
> >> is marked dying (QUEUE_FLAG_DYING), so new IOCTL attempts fail safely
> >> at blk_queue_enter() with -ENODEV. The queue structure remains valid f=
or
> >> pointer dereference until nvme_free_ctrl() is called.
> >>
> >> ---
> >>    drivers/nvme/host/core.c | 22 +++++++++++++++++++++-
> >>    1 file changed, 21 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >> index 734ad725e6f4..dbbcf99dbef8 100644
> >> --- a/drivers/nvme/host/core.c
> >> +++ b/drivers/nvme/host/core.c
> >> @@ -4897,7 +4897,19 @@ void nvme_remove_admin_tag_set(struct nvme_ctrl
> >> *ctrl)
> >>         */
> >>        nvme_stop_keep_alive(ctrl);
> >>        blk_mq_destroy_queue(ctrl->admin_q);
> >> -    blk_put_queue(ctrl->admin_q);
> >> +    /**
> >> +     * Defer blk_put_queue() to nvme_free_ctrl() to prevent use-after=
-free.
> >> +     *
> >> +     * Userspace may hold open file descriptors to namespace devices =
and
> >> +     * issue IOCTLs that dereference ctrl->admin_q after controller r=
emoval
> >> +     * starts. Since each namespace holds a controller reference, def=
erring
> >> +     * the final queue release ensures admin_q remains allocated unti=
l all
> >> +     * namespace references are released.
> >> +     *
> >> +     * blk_mq_destroy_queue() above marks the queue dying
> >> (QUEUE_FLAG_DYING),
> >> +     * causing new requests to fail at blk_queue_enter() with -ENODEV=
 while
> >> +     * keeping the structure valid for pointer access.
> >> +     */
> >>        if (ctrl->ops->flags & NVME_F_FABRICS) {
> >>            blk_mq_destroy_queue(ctrl->fabrics_q);
> >>            blk_put_queue(ctrl->fabrics_q);
> >> @@ -5041,6 +5053,14 @@ static void nvme_free_ctrl(struct device *dev)
> >>            container_of(dev, struct nvme_ctrl, ctrl_device);
> >>        struct nvme_subsystem *subsys =3D ctrl->subsys;
> >>
> >> +    /**
> >> +     * Release admin_q's final reference. All namespace references ha=
ve
> >> +     * been released at this point. NULL check is needed for to handl=
e
> >> +     * allocation failure in nvme_alloc_admin_tag_set().
> >> +     */
> >> +    if (ctrl->admin_q)
> >> +        blk_put_queue(ctrl->admin_q);
> >> +
> >>        if (!subsys || ctrl->instance !=3D subsys->instance)
> >>            ida_free(&nvme_instance_ida, ctrl->instance);
> >>        nvme_free_cels(ctrl);
> >>
> >> -ck
> >>
> >>
> >>
> > Thanks Chaitanya. I tested your fix and all tests look good. We're
> > looking forward to your final version.
>
>
> This is Keith's patch I just tested his patch and added commit log-commen=
ts.
>
>

Hi Keith,

Could you make a patch based on this ? So we can backport upstream
patch instead of keeping our own patch. Thanks

> -ck
>
>

