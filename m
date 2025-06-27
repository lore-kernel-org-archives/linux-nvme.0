Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6F7C7EE30
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jun 2025 00:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jQ+qdd6fUgWCvQmCOIyWaJBSFh4FbLcCZv9Xuyjzhk4=; b=ou54B0iBc7ZK1LiXwJtro7pmWq
	hePN+n5/Lxf4PAAHuQvqD2eLt3z5ldkuKJWyK6FJ/PZTFSyaW4/kZ7nVjj3/WhXiFdSLpQX+9P3Ow
	m0GQtUDnfdIjtBhq/eQDEORoYJaM99sf6QQpRREsWMiuL4GP7N0p0IMUTOxNWVvHZKxmZi3dFBEDT
	FdJcYnbhdF1oI6MoKibj6hypskOAo1ylWsN8mpCTzlKIVoxsdbq8woFLaMBj9d+9XscF42NjIryNP
	bqenAzggtIKOxwkgVM+lnE+z0MsRzi/ifDmfnR0Gbyv9vuBPdcjoj97unpOj0g0nsYBsWrhBPhCr2
	y6J6UOaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUxH0-0000000DF2N-3mFY;
	Fri, 27 Jun 2025 00:48:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUwo3-0000000DBhk-2te2
	for linux-nvme@lists.infradead.org;
	Fri, 27 Jun 2025 00:19:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750983542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQ+qdd6fUgWCvQmCOIyWaJBSFh4FbLcCZv9Xuyjzhk4=;
	b=LZpngpCUnVi1EmlDfd4IutLHH5zmX5A2iqUe8U+pz9rFHIrvNhgR+I70KObdXekwsWknjK
	WTffznh88gkezhMQX1/eiTB4ZhML+2EMYbXUfj7kFPnE16Gf0/qn3vUTiiFHsvqRliORbs
	fJ3RVF0NehH594EyXQiZciVRRo8/MnY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-oHkqFvlGMQ6eheBKVCDCzg-1; Thu, 26 Jun 2025 20:19:01 -0400
X-MC-Unique: oHkqFvlGMQ6eheBKVCDCzg-1
X-Mimecast-MFC-AGG-ID: oHkqFvlGMQ6eheBKVCDCzg_1750983540
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-32b93fa2e51so6317831fa.3
        for <linux-nvme@lists.infradead.org>; Thu, 26 Jun 2025 17:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750983540; x=1751588340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQ+qdd6fUgWCvQmCOIyWaJBSFh4FbLcCZv9Xuyjzhk4=;
        b=jlyuMx1yWItjfIGuwPbRWeL+tS5vAtHlCkGZlW2Vhw3yKwCnyhv933xv54+RfqTUeJ
         9plvFlaqvoxM75IQDuR4XKRy+Uw6UaxnRnMXVAnWHtHheFXABiO/VJ3R0Y7olQrvjEDW
         gQ7duIdZOE4EqnPhUSGOR7/KXXycr+P7H9UypHvmQ/Uq0Bi4xtB0fLMugqztVkv1xrSY
         X3QSBVRd0BwKTld7WNNQ6q7k1np8I/L7dqJjjMlpeKKRAdRduqd+Wqcebqrv9uFqTFGS
         489m+i2W87N9mXzL3in+LIkDNVlG7XAYerS+7wO/1R5p1/FE7zhVjLTr6tbFsIVJn5oD
         Du4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/ibDkkEbkrlOcfCwIFmtRS7dOEnnwyudPRrjemVUeaHKewTI4lAjNpYfAO5i+7F5FJgwPJD2iZyVq@lists.infradead.org
X-Gm-Message-State: AOJu0YxBBNMLCUODFs9aNi4Rbyrd6yDGgUM3AWazov+SFXTB4iNuIFXi
	iTVnyISOZa7YLJCG6SW1ekK4dY3gxTA9dWFH/0SZRa9Lqf9lwI1hRcPvTP28Izd0swiS9QU+mAn
	enUOFW3mrWRLkX24zsNoIJ9Lx1i2c5MR0Na9XnYaxBXLEUGXap5jQg/JFokw7+dmE8z1YRqE3CE
	69iBH7V6xxlR83FOBv6L3TIQMPhBbO6Gkmpg9VmrDsck0=
X-Gm-Gg: ASbGnctY96bYPUfYPgj9QHIy0AgOGSWoBKnbPsktnzcNe/f3KRv7rwzbproOx4RPZ/U
	t0GCCoVcukkKShFXvO+FSpKsOhzY79ANtomTttQCX12GmADx9bQr6sbRD8Kn9tyePRLeb6D76rq
	ZXvgrL
X-Received: by 2002:a05:651c:40cf:b0:32a:8297:54e3 with SMTP id 38308e7fff4ca-32cdc447f62mr2062841fa.6.1750983539587;
        Thu, 26 Jun 2025 17:18:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKLwwanrP8zMbRqDRTojcdk+tmTCpP0S8vGdFxk4F+d3yIUJgnDKwPKQXwdjDwZdm6rJ8eM3qQLNwZAyeggC0=
X-Received: by 2002:a05:651c:40cf:b0:32a:8297:54e3 with SMTP id
 38308e7fff4ca-32cdc447f62mr2062751fa.6.1750983539093; Thu, 26 Jun 2025
 17:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250625064003.436582-1-hch@lst.de> <20250625064003.436582-3-hch@lst.de>
 <aF3gNWvBaPpATiI+@dev-ushankar.dev.purestorage.com>
In-Reply-To: <aF3gNWvBaPpATiI+@dev-ushankar.dev.purestorage.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 27 Jun 2025 08:18:46 +0800
X-Gm-Features: Ac12FXz89CDTbON32XeYH2F1L8Jvo9bo5tldFpbfaEV1PSFTAwPFS4TlOf3YpgY
Message-ID: <CAHj4cs8w40MbdnHUh9R0fx6fMWR2K48vmz+VbpUFFToXm0+tgg@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: fix atomic write size validation
To: Uday Shankar <ushankar@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, Alan Adamson <alan.adamson@oracle.com>, 
	John Garry <john.g.garry@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w76oG7iCKEB9h4ihx9BD0K5Z3Zxz8-ytVkIvr9SjA8k_1750983540
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_171903_817433_090B9DBA 
X-CRM114-Status: GOOD (  38.05  )
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

On Fri, Jun 27, 2025 at 8:05=E2=80=AFAM Uday Shankar <ushankar@purestorage.=
com> wrote:
>
> On Wed, Jun 25, 2025 at 08:39:56AM +0200, Christoph Hellwig wrote:
> > Don't mix the namespace and controller values, and validate the
> > per-controller limit when probing the controller.  This avoid spurious
> > failures for controllers with namespaces that have different namespaces
>
> nit: having namespaces with different logical block sizes
>
> > with different logical block sizes, or report the per-namespace values
> > only for some namespaces.
> >
> > It also fixes a missing queue_limits_cancel_update in an error path by
> > removing that error path.
> >
> > Fixes: 8695f060a029 ("nvme: all namespaces in a subsystem must adhere t=
o a common atomic write size")
> > Reported-by: Yi Zhang <yi.zhang@redhat.com>
>
> I couldn't find the report on linux-nvme; if it is public, can you
> include a "Closes:" link here?

Yes, it was reported here:
https://lore.kernel.org/linux-nvme/CAHj4cs93WutyoPLFMr0JidHhRAxHC1ZDcj-Rvdn=
X=3DR7OaV5ejg@mail.gmail.com/

>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > Tested-by: Yi Zhang <yi.zhang@redhat.com>
>
> I also saw a problem in a system running on 6.16-rc3 with several NVMe
> subsystems, each containing one controller with AWUPF=3D0, each containin=
g
> two namespaces with NSABP=3D0. One namespace has a 512-byte LBA size whil=
e
> the other has a 4096-byte LBA size, and some namespaces failed to add:
>
> # dmesg | grep Inconsistent
> [    5.537494] nvme nvme4: nvme4n2: Inconsistent Atomic Write Size, Names=
pace will not be added: Subsystem=3D512 bytes, Controller/Namespace=3D4096 =
bytes
> [    5.539038] nvme nvme6: nvme6n2: Inconsistent Atomic Write Size, Names=
pace will not be added: Subsystem=3D4096 bytes, Controller/Namespace=3D512 =
bytes
> [    5.560079] nvme nvme7: nvme7n2: Inconsistent Atomic Write Size, Names=
pace will not be added: Subsystem=3D4096 bytes, Controller/Namespace=3D512 =
bytes
> [    5.595093] nvme nvme3: nvme3n2: Inconsistent Atomic Write Size, Names=
pace will not be added: Subsystem=3D4096 bytes, Controller/Namespace=3D512 =
bytes
> [    5.597627] nvme nvme8: nvme8n2: Inconsistent Atomic Write Size, Names=
pace will not be added: Subsystem=3D512 bytes, Controller/Namespace=3D4096 =
bytes
> [    5.600007] nvme nvme0: nvme0n2: Inconsistent Atomic Write Size, Names=
pace will not be added: Subsystem=3D512 bytes, Controller/Namespace=3D4096 =
bytes
> [    5.605748] nvme nvme5: nvme5n2: Inconsistent Atomic Write Size, Names=
pace will not be added: Subsystem=3D512 bytes, Controller/Namespace=3D4096 =
bytes
> [    5.608961] nvme nvme11: nvme11n2: Inconsistent Atomic Write Size, Nam=
espace will not be added: Subsystem=3D4096 bytes, Controller/Namespace=3D51=
2 bytes
> [    5.618011] nvme nvme12: nvme12n1: Inconsistent Atomic Write Size, Nam=
espace will not be added: Subsystem=3D4096 bytes, Controller/Namespace=3D51=
2 bytes
> [    5.618251] nvme nvme10: nvme10n2: Inconsistent Atomic Write Size, Nam=
espace will not be added: Subsystem=3D4096 bytes, Controller/Namespace=3D51=
2 bytes
>
> Note that despite the messages saying otherwise, only those log lines
> containing "Subsystem=3D512 bytes, Controller/Namespace=3D4096 bytes"
> actually failed to add a namespace - the others had both namespaces
> added just fine. I guess it isn't deterministic as to which namespace
> was added first.
>
> Anyways, the problem was fixed by this patch set.
>
> Tested-by: Uday Shankar <ushankar@purestorage.com>
>
> > ---
> >  drivers/nvme/host/core.c | 33 +++++++++++----------------------
> >  drivers/nvme/host/nvme.h |  3 +--
> >  2 files changed, 12 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 520fb5f1e214..e533d791955d 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2041,17 +2041,7 @@ static u32 nvme_configure_atomic_write(struct nv=
me_ns *ns,
> >                * no clear language in the specification prohibiting dif=
ferent
> >                * values for different controllers in the subsystem.
> >                */
> > -             atomic_bs =3D (1 + ns->ctrl->awupf) * bs;
> > -     }
> > -
> > -     if (!ns->ctrl->subsys->atomic_bs) {
> > -             ns->ctrl->subsys->atomic_bs =3D atomic_bs;
> > -     } else if (ns->ctrl->subsys->atomic_bs !=3D atomic_bs) {
> > -             dev_err_ratelimited(ns->ctrl->device,
> > -                     "%s: Inconsistent Atomic Write Size, Namespace wi=
ll not be added: Subsystem=3D%d bytes, Controller/Namespace=3D%d bytes\n",
> > -                     ns->disk ? ns->disk->disk_name : "?",
> > -                     ns->ctrl->subsys->atomic_bs,
> > -                     atomic_bs);
> > +             atomic_bs =3D (1 + ns->ctrl->subsys->awupf) * bs;
> >       }
> >
> >       lim->atomic_write_hw_max =3D atomic_bs;
> > @@ -2386,16 +2376,6 @@ static int nvme_update_ns_info_block(struct nvme=
_ns *ns,
> >       if (!nvme_update_disk_info(ns, id, &lim))
> >               capacity =3D 0;
> >
> > -     /*
> > -      * Validate the max atomic write size fits within the subsystem's
> > -      * atomic write capabilities.
> > -      */
> > -     if (lim.atomic_write_hw_max > ns->ctrl->subsys->atomic_bs) {
> > -             blk_mq_unfreeze_queue(ns->disk->queue, memflags);
> > -             ret =3D -ENXIO;
> > -             goto out;
> > -     }
> > -
> >       nvme_config_discard(ns, &lim);
> >       if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> >           ns->head->ids.csi =3D=3D NVME_CSI_ZNS)
> > @@ -3219,6 +3199,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *=
ctrl, struct nvme_id_ctrl *id)
> >       memcpy(subsys->model, id->mn, sizeof(subsys->model));
> >       subsys->vendor_id =3D le16_to_cpu(id->vid);
> >       subsys->cmic =3D id->cmic;
> > +     subsys->awupf =3D le16_to_cpu(id->awupf);
> >
> >       /* Versions prior to 1.4 don't necessarily report a valid type */
> >       if (id->cntrltype =3D=3D NVME_CTRL_DISC ||
> > @@ -3556,6 +3537,15 @@ static int nvme_init_identify(struct nvme_ctrl *=
ctrl)
> >               if (ret)
> >                       goto out_free;
> >       }
> > +
> > +     if (le16_to_cpu(id->awupf) !=3D ctrl->subsys->awupf) {
> > +             dev_err_ratelimited(ctrl->device,
> > +                     "inconsistent AWUPF, controller not added (%u/%u)=
.\n",
> > +                     le16_to_cpu(id->awupf), ctrl->subsys->awupf);
> > +             ret =3D -EINVAL;
> > +             goto out_free;
> > +     }
> > +
>
> Could you explain (and perhaps add a comment here) why all controllers
> in a subsystem must report the same awupf? Is it because namespaces may
> inherit awupf from the controller, and may be reachable through multiple
> controllers for multipath?
>
> >       memcpy(ctrl->subsys->firmware_rev, id->fr,
> >              sizeof(ctrl->subsys->firmware_rev));
> >
> > @@ -3651,7 +3641,6 @@ static int nvme_init_identify(struct nvme_ctrl *c=
trl)
> >               dev_pm_qos_expose_latency_tolerance(ctrl->device);
> >       else if (!ctrl->apst_enabled && prev_apst_enabled)
> >               dev_pm_qos_hide_latency_tolerance(ctrl->device);
> > -     ctrl->awupf =3D le16_to_cpu(id->awupf);
> >  out_free:
> >       kfree(id);
> >       return ret;
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index a468cdc5b5cb..7df2ea21851f 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -410,7 +410,6 @@ struct nvme_ctrl {
> >
> >       enum nvme_ctrl_type cntrltype;
> >       enum nvme_dctype dctype;
> > -     u16 awupf; /* 0's based value. */
> >  };
> >
> >  static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *c=
trl)
> > @@ -443,11 +442,11 @@ struct nvme_subsystem {
> >       u8                      cmic;
> >       enum nvme_subsys_type   subtype;
> >       u16                     vendor_id;
> > +     u16                     awupf; /* 0's based value. */
> >       struct ida              ns_ida;
> >  #ifdef CONFIG_NVME_MULTIPATH
> >       enum nvme_iopolicy      iopolicy;
> >  #endif
> > -     u32                     atomic_bs;
> >  };
> >
> >  /*
> > --
> > 2.47.2
> >
> >
>


--=20
Best Regards,
  Yi Zhang


