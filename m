Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA507C61CE8
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Jun 2025 03:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XYei06hzEiyL3lNCPH3NyvqZz+PcjkzCJQ7Fhz6eAI0=; b=0jB/FOEiDyUU61KuafLfgALqZr
	CflgezUWGxxpia320txBFBO66x9He0zllnO8zrVLP6Eu15Cw2ZXQH+sxcoE7ezpDeH+HuxGibFeMx
	ujUt3bL4TgKNFdSeTq/Oo5SUXBDoC6bI7g2aOXs2W7uZ2BcXf1Qy/ESIsg865NGkaBsyqeMpIQwnB
	U5N8/7ngL2rUvRYVkBU5qRz0iLCg++HrXCL41GdrjGfy9n/R2rubT9Zlscbn03n5d2G2Dm2mBaYT9
	fzpCnc2sWjZNPDOGj+oCXWvS764jj2L8EFSKMgRGkFOg7wssqoC7piKozpcjeFu9vIHrO50EcD5af
	6+MsB0Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPuio-0000000FCHK-2hIV;
	Fri, 13 Jun 2025 03:04:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPuil-0000000FCGm-22zi
	for linux-nvme@lists.infradead.org;
	Fri, 13 Jun 2025 03:04:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749783885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XYei06hzEiyL3lNCPH3NyvqZz+PcjkzCJQ7Fhz6eAI0=;
	b=UxrmpcwXrNfyc7d8UvonF+VQDuVgAP4a5uiMchEuUEt74QXq4iP1GKd2zeawvhRMY7gP29
	eJHxZdUNOKmgvCegdXe5BCWpXDS3QYaKBaLI+WgLMCFVe+VNFbpq6k8OJwZMELgt+aUk2x
	tAWKXRAzxXV/LLDQaiOebBp/ORmuy4k=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-5HmkXnZXMjCGkhdbfj-Zlw-1; Thu, 12 Jun 2025 23:04:43 -0400
X-MC-Unique: 5HmkXnZXMjCGkhdbfj-Zlw-1
X-Mimecast-MFC-AGG-ID: 5HmkXnZXMjCGkhdbfj-Zlw_1749783882
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32b40be4525so638211fa.2
        for <linux-nvme@lists.infradead.org>; Thu, 12 Jun 2025 20:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749783882; x=1750388682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYei06hzEiyL3lNCPH3NyvqZz+PcjkzCJQ7Fhz6eAI0=;
        b=TBhIaQQg9rxLLouZJ+D+57nibpXYaHQ5LBYNzYcqmmRnHIYBqKZMYCVcmr9ueZ+CZ7
         VILU6ithhtKTBTYoHqHI++2PqpCWKEfK/dV8fygeM5/dXc1qNPArt4VZUgIqt3PSYDxN
         30pwNxNaexH6WCDlHbFiu8oF8o/osR2kbnXV0ZqqNw1x389bxHdlNuKc+U8t8yP9msIX
         6u6o27lC/nRjpRCB+4LEhJ5QLONZdU/FQCTkzUQGK903rOlk8NN2owMFEG+y5dTxdl9T
         +6Yv1tcwjTrLHG85UX+AzdmBQRUlwccT6A6+YYXMAzKKGbqMiyiRnZORdeKf/bpo3i4W
         QzPw==
X-Forwarded-Encrypted: i=1; AJvYcCWAFcw42rLYHj1AGTYQMl0kzCfMA/xkvRu0YpyeLq6wS17RdZ1DU1pIzy9Jo0kxmQEskzcDmOWerQkO@lists.infradead.org
X-Gm-Message-State: AOJu0YxgWXHoOfnra6jRPMocGOKOUhyVpxTe9+Rof+u9HamRHmewZek2
	cs+TRJVueW6sicLh3HkZe21j9o43uPdcN4IZA5+z+JzBxk2pPktokSEn/farWZv7eD89zFKosHv
	C9CGNfdFKW3s26yt4elw/8kVy3kdu2LAOo5ly4iTKSPsgCrL4aB3U0HqTHbyjXabw8JSHMJ61eN
	U5t0AwFbuUdWOP5eqjdFf/CfGJ0nfNpPBEB6AduEQ9mE8=
X-Gm-Gg: ASbGncv8pdL3wBctdcOuKuy6KFEx+o7JiOTbi7+2/iAvoX1CEkNjDw328BAgWhJswWO
	qQ8ipEhnap1awigpzPHZKMP/jiSuEYMTJhrmgBDDlRDwE591vWZ2oJdl6IeW+GpuiaRT+kug9DE
	g0SMwm
X-Received: by 2002:a2e:a7c1:0:b0:32a:63eb:f0b9 with SMTP id 38308e7fff4ca-32b3ebba2f8mr3082861fa.38.1749783882097;
        Thu, 12 Jun 2025 20:04:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgoGXEuViYJyFgoT0uyYfJ3Ky5oeVCVGsbN1HIsErnVhkXjdUfJCtDZWQcprIDaVRLNXeaSoHRIvF3krXIYsE=
X-Received: by 2002:a2e:a7c1:0:b0:32a:63eb:f0b9 with SMTP id
 38308e7fff4ca-32b3ebba2f8mr3082661fa.38.1749783880828; Thu, 12 Jun 2025
 20:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250611055432.2401372-1-hch@lst.de> <20250611055432.2401372-3-hch@lst.de>
In-Reply-To: <20250611055432.2401372-3-hch@lst.de>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 13 Jun 2025 11:04:28 +0800
X-Gm-Features: AX0GCFskjXXMbvXPxMJBdxGtTWiYbUGFaNBbsou6LPVsoxAW_c1di1NnswsBWcY
Message-ID: <CAHj4cs_okcZ+zqoT6t1Hp==_Ukrn9atOeDaaoBM_jkzCnm1aaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: fix atomic write boundary validation
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	Alan Adamson <alan.adamson@oracle.com>, John Garry <john.g.garry@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g0qd6UsRf7OUv8GJ76hIF2B4j3eEIlpSKvrEmKRhn_U_1749783882
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250612_200447_983413_1051A733 
X-CRM114-Status: GOOD (  24.67  )
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

On Wed, Jun 11, 2025 at 1:56=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Don't mix the namespace and controller values, and validate the
> per-controller limit when probing the controller.  This avoid spurious
> failures for controllers with namespaces that have different namespaces
> with different logical block sizes, or report the per-namespace values
> only for some namespaces.
>
> It also fixes a missing queue_limits_cancel_update in an error path by
> removing that error path.
>
> Fixes: 8695f060a029 ("nvme: all namespaces in a subsystem must adhere to =
a common atomic write size")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>

Thanks for the fix:
Tested-by: Yi Zhang <yi.zhang@redhat.com>


> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 34 ++++++++++++----------------------
>  drivers/nvme/host/nvme.h |  3 +--
>  2 files changed, 13 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 520fb5f1e214..3da5ac71a9b0 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2041,17 +2041,7 @@ static u32 nvme_configure_atomic_write(struct nvme=
_ns *ns,
>                  * no clear language in the specification prohibiting dif=
ferent
>                  * values for different controllers in the subsystem.
>                  */
> -               atomic_bs =3D (1 + ns->ctrl->awupf) * bs;
> -       }
> -
> -       if (!ns->ctrl->subsys->atomic_bs) {
> -               ns->ctrl->subsys->atomic_bs =3D atomic_bs;
> -       } else if (ns->ctrl->subsys->atomic_bs !=3D atomic_bs) {
> -               dev_err_ratelimited(ns->ctrl->device,
> -                       "%s: Inconsistent Atomic Write Size, Namespace wi=
ll not be added: Subsystem=3D%d bytes, Controller/Namespace=3D%d bytes\n",
> -                       ns->disk ? ns->disk->disk_name : "?",
> -                       ns->ctrl->subsys->atomic_bs,
> -                       atomic_bs);
> +               atomic_bs =3D (1 + ns->ctrl->subsys->awupf) * bs;
>         }
>
>         lim->atomic_write_hw_max =3D atomic_bs;
> @@ -2386,16 +2376,6 @@ static int nvme_update_ns_info_block(struct nvme_n=
s *ns,
>         if (!nvme_update_disk_info(ns, id, &lim))
>                 capacity =3D 0;
>
> -       /*
> -        * Validate the max atomic write size fits within the subsystem's
> -        * atomic write capabilities.
> -        */
> -       if (lim.atomic_write_hw_max > ns->ctrl->subsys->atomic_bs) {
> -               blk_mq_unfreeze_queue(ns->disk->queue, memflags);
> -               ret =3D -ENXIO;
> -               goto out;
> -       }
> -
>         nvme_config_discard(ns, &lim);
>         if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
>             ns->head->ids.csi =3D=3D NVME_CSI_ZNS)
> @@ -3555,7 +3535,18 @@ static int nvme_init_identify(struct nvme_ctrl *ct=
rl)
>                 ret =3D nvme_init_effects(ctrl, id);
>                 if (ret)
>                         goto out_free;
> +
> +               ctrl->subsys->awupf =3D le16_to_cpu(id->awupf);
>         }
> +
> +       if (le16_to_cpu(id->awupf) !=3D ctrl->subsys->awupf) {
> +               dev_err_ratelimited(ctrl->device,
> +                       "inconsistent AWUPF, controller not added (%u/%u)=
.\n",
> +                       le16_to_cpu(id->awupf), ctrl->subsys->awupf);
> +               ret =3D -EINVAL;
> +               goto out_free;
> +       }
> +
>         memcpy(ctrl->subsys->firmware_rev, id->fr,
>                sizeof(ctrl->subsys->firmware_rev));
>
> @@ -3651,7 +3642,6 @@ static int nvme_init_identify(struct nvme_ctrl *ctr=
l)
>                 dev_pm_qos_expose_latency_tolerance(ctrl->device);
>         else if (!ctrl->apst_enabled && prev_apst_enabled)
>                 dev_pm_qos_hide_latency_tolerance(ctrl->device);
> -       ctrl->awupf =3D le16_to_cpu(id->awupf);
>  out_free:
>         kfree(id);
>         return ret;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a468cdc5b5cb..7df2ea21851f 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -410,7 +410,6 @@ struct nvme_ctrl {
>
>         enum nvme_ctrl_type cntrltype;
>         enum nvme_dctype dctype;
> -       u16 awupf; /* 0's based value. */
>  };
>
>  static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctr=
l)
> @@ -443,11 +442,11 @@ struct nvme_subsystem {
>         u8                      cmic;
>         enum nvme_subsys_type   subtype;
>         u16                     vendor_id;
> +       u16                     awupf; /* 0's based value. */
>         struct ida              ns_ida;
>  #ifdef CONFIG_NVME_MULTIPATH
>         enum nvme_iopolicy      iopolicy;
>  #endif
> -       u32                     atomic_bs;
>  };
>
>  /*
> --
> 2.47.2
>
>


--
Best Regards,
  Yi Zhang


