Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC70C27C54
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 12:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EMi3K2Q+Wm1UmK2MmUf1tbocOK62abdXo6Je0hwpr9c=; b=AraBA5KRGOj6GAgQIVTY7bE0wJ
	xfjbwtEwQGR83BUSgkWx2ImmP5XiLM/06yBkuUv/PUb4DORVPauwhCOzlBWdsBseVqG5jviHlhG2C
	H5dCmZmB773pmucsqwfcFZQN/qDYqslgnCYO1YIBSDEfGCMmUktdVyCPWGOgYAm1ppoVK5zFCUuAP
	v9bVqVzyYDfSHD+FDCo/0sUfBrAYSyMDU7gnkRU6t74iv6ikD3BIE2rUFXYk61/G3G77UP5JJnvxd
	ZTSm/Xl64l9A7lIQiMM0Rf6FiPcZjETg/UvdNeiL/BfXs0IABcV0IN/2XVJ7+2O2u1DPiHMwO7btL
	mBeKjY6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFC05-00000009eCt-33pT;
	Thu, 06 Jun 2024 12:13:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFC03-00000009eBe-1e0O
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jun 2024 12:13:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717676023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMi3K2Q+Wm1UmK2MmUf1tbocOK62abdXo6Je0hwpr9c=;
	b=h8P0N4snFqF5yYqwY6C1EAQ0mu/pN4y0n+b1U4aoQsgvr0RKf0kSMDUbFUo5eP78Rx5m39
	EgpbB6OG/+c2IpcMU9BjHRn07O8pUMnQpd+jAlhb+QsrXCY4wUIA0OdYTEVRUnUiBTRM43
	WejIdZjSLWsD3cRXZ+ZXj+kWEPJpk6U=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-j5Dqe-yDMmiul2Edb99YSg-1; Thu, 06 Jun 2024 08:13:41 -0400
X-MC-Unique: j5Dqe-yDMmiul2Edb99YSg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c1e6fc4122so831328a91.0
        for <linux-nvme@lists.infradead.org>; Thu, 06 Jun 2024 05:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717676020; x=1718280820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMi3K2Q+Wm1UmK2MmUf1tbocOK62abdXo6Je0hwpr9c=;
        b=uPCRpyp4wNhSrPXN/glVj9PX/LJs0DP1j1SAnuLatIBExfCnGPX5jBDQnHuVE4DQZD
         VG/cd44b6rif/FoF+Z8TkgzOkB2/moP9nwyWPzHHIsjjs5hTwxx3haW2EyXG28ZZaKEG
         CMOLXak5zaQeBKTCI89llpt4xv9V6EPVa1BOLbPFuInGV9Xd8GZDCz7fMKVu9LiKvbBW
         K6qes/F4k05CO/bUyhfNQQEIHlWjKLLt0OKJmMihpaUXXd1ue7JP8PMP9Ug+NqA+W/HX
         pi6L6sSlFOjsC7nRiBndFCIICz+8Lfa0W7qlB6X8rKcSOcNAXtCG61J13adzT0erjffQ
         uYlQ==
X-Gm-Message-State: AOJu0Ywerxo6b873zKIXErmoy/+yVcV9zdxado4P3SIlTpwg/BWLDbgN
	pdpc2b4bvKjgbgIvoHxxgT71m6ftfAz5mo/EduLBsOqc14pwKXW48UOUBo7In278AFj5NDjH+ta
	wakBzZsk4S1130B7iu4AJr9FoEMUOrBPhxKHwwV+4yI6Yi1FMy8Id8HgAUiuiwio8AJiT7tijG0
	868Nuu6jbQLDt4sJOLPNOOY89UJi5HKX0nJNs0IKM=
X-Received: by 2002:a17:90b:46c7:b0:2c2:264a:3704 with SMTP id 98e67ed59e1d1-2c27db0ac9emr5433729a91.18.1717676020228;
        Thu, 06 Jun 2024 05:13:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5MNgq8BpZkpbiGM26NQUGkVuV28yXqnQSD2zNrdE6N3l/Fuhp0U0FCCpFRlyHKm+Tk5GVfyxBEEBkCOsRnGg=
X-Received: by 2002:a17:90b:46c7:b0:2c2:264a:3704 with SMTP id
 98e67ed59e1d1-2c27db0ac9emr5433694a91.18.1717676019696; Thu, 06 Jun 2024
 05:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240604185908.3703052-1-kbusch@meta.com> <20240604185908.3703052-6-kbusch@meta.com>
In-Reply-To: <20240604185908.3703052-6-kbusch@meta.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 6 Jun 2024 20:13:27 +0800
Message-ID: <CAHj4cs9Pyowh+DUqK4QstNBoPd6LwUO8jgXicGcs+op1J__JkA@mail.gmail.com>
Subject: Re: [PATCHv2 5/5] nvme: split device add from initialization
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, 
	mlombard@redhat.com, hare@suse.de, shinichiro.kawasaki@wdc.com, 
	james.smart@broadcom.com, Keith Busch <kbusch@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240606_051347_607984_646D9123 
X-CRM114-Status: GOOD (  28.84  )
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

Verified the kmemleak reported was fixed by this patch, thanks.

Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Wed, Jun 5, 2024 at 3:01=E2=80=AFAM Keith Busch <kbusch@meta.com> wrote:
>
> From: Keith Busch <kbusch@kernel.org>
>
> Combining both creates an ambiguous cleanup scenario for the caller if
> an error is returned: does the device reference need to be dropped or
> did the error occur before the device was initialized? If an error
> occurs after the device is added, then the existing cleanup routines
> will leak memory.
>
> Furthermore, the nvme core is taking it upon itself to free the device's
> kobj.name under certain conditions rather than go the the core device
> API. We shouldn't be peaking into these implementation details.
>
> Split the device initialization from the addition to make it easier to
> know the error handling actions, fix the existing memory leaks, and stop
> the device layering violations.
>
> Link: https://lore.kernel.org/linux-nvme/c4050a37-ecc9-462c-9772-65e25166=
f439@grimberg.me/
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/apple.c  |  5 ++++
>  drivers/nvme/host/core.c   | 58 +++++++++++++++++++++++---------------
>  drivers/nvme/host/fc.c     |  5 ++++
>  drivers/nvme/host/nvme.h   |  1 +
>  drivers/nvme/host/pci.c    |  5 ++++
>  drivers/nvme/host/rdma.c   |  5 ++++
>  drivers/nvme/host/tcp.c    |  5 ++++
>  drivers/nvme/target/loop.c |  5 ++++
>  8 files changed, 66 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index d3384aecc0d39..9760c97bc8f19 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -1531,6 +1531,10 @@ static int apple_nvme_probe(struct platform_device=
 *pdev)
>         if (IS_ERR(anv))
>                 return PTR_ERR(anv);
>
> +       result =3D nvme_add_ctrl(&anv->ctrl);
> +       if (result)
> +               goto out_put_ctrl;
> +
>         anv->ctrl.admin_q =3D blk_mq_alloc_queue(&anv->admin_tagset, NULL=
, NULL);
>         if (IS_ERR(anv->ctrl.admin_q)) {
>                 ret =3D -ENOMEM;
> @@ -1545,6 +1549,7 @@ static int apple_nvme_probe(struct platform_device =
*pdev)
>
>  out_uninit_ctrl:
>         nvme_uninit_ctrl(&dev->ctrl);
> +out_put_ctrl:
>         nvme_put_ctrl(&dev->ctrl);
>         return ret;
>  }
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f5d150c62955d..070cc4d76b6a4 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4611,6 +4611,9 @@ static void nvme_free_ctrl(struct device *dev)
>   * Initialize a NVMe controller structures.  This needs to be called dur=
ing
>   * earliest initialization so that we have the initialized structured ar=
ound
>   * during probing.
> + *
> + * On success, the caller must use the nvme_put_ctrl() to release this w=
hen
> + * needed, which also invokes the ops->free_ctrl() callback.
>   */
>  int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>                 const struct nvme_ctrl_ops *ops, unsigned long quirks)
> @@ -4659,6 +4662,12 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct =
device *dev,
>                 goto out;
>         ctrl->instance =3D ret;
>
> +       ret =3D nvme_auth_init_ctrl(ctrl);
> +       if (ret)
> +               goto out_release_instance;
> +
> +       nvme_mpath_init_ctrl(ctrl);
> +
>         device_initialize(&ctrl->ctrl_device);
>         ctrl->device =3D &ctrl->ctrl_device;
>         ctrl->device->devt =3D MKDEV(MAJOR(nvme_ctrl_base_chr_devt),
> @@ -4671,16 +4680,36 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct=
 device *dev,
>                 ctrl->device->groups =3D nvme_dev_attr_groups;
>         ctrl->device->release =3D nvme_free_ctrl;
>         dev_set_drvdata(ctrl->device, ctrl);
> +
> +       return ret;
> +
> +out_release_instance:
> +       ida_free(&nvme_instance_ida, ctrl->instance);
> +out:
> +       if (ctrl->discard_page)
> +               __free_page(ctrl->discard_page);
> +       cleanup_srcu_struct(&ctrl->srcu);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(nvme_init_ctrl);
> +
> +/*
> + * On success, returns with an elevated controller reference and caller =
must
> + * use nvme_uninit_ctrl() to properly free resources associated with the=
 ctrl.
> + */
> +int nvme_add_ctrl(struct nvme_ctrl *ctrl)
> +{
> +       int ret;
> +
>         ret =3D dev_set_name(ctrl->device, "nvme%d", ctrl->instance);
>         if (ret)
> -               goto out_release_instance;
> +               return ret;
>
> -       nvme_get_ctrl(ctrl);
>         cdev_init(&ctrl->cdev, &nvme_dev_fops);
> -       ctrl->cdev.owner =3D ops->module;
> +       ctrl->cdev.owner =3D ctrl->ops->module;
>         ret =3D cdev_device_add(&ctrl->cdev, ctrl->device);
>         if (ret)
> -               goto out_free_name;
> +               return ret;
>
>         /*
>          * Initialize latency tolerance controls.  The sysfs files won't
> @@ -4691,28 +4720,11 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct=
 device *dev,
>                 min(default_ps_max_latency_us, (unsigned long)S32_MAX));
>
>         nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device=
));
> -       nvme_mpath_init_ctrl(ctrl);
> -       ret =3D nvme_auth_init_ctrl(ctrl);
> -       if (ret)
> -               goto out_free_cdev;
> +       nvme_get_ctrl(ctrl);
>
>         return 0;
> -out_free_cdev:
> -       nvme_fault_inject_fini(&ctrl->fault_inject);
> -       dev_pm_qos_hide_latency_tolerance(ctrl->device);
> -       cdev_device_del(&ctrl->cdev, ctrl->device);
> -out_free_name:
> -       nvme_put_ctrl(ctrl);
> -       kfree_const(ctrl->device->kobj.name);
> -out_release_instance:
> -       ida_free(&nvme_instance_ida, ctrl->instance);
> -out:
> -       if (ctrl->discard_page)
> -               __free_page(ctrl->discard_page);
> -       cleanup_srcu_struct(&ctrl->srcu);
> -       return ret;
>  }
> -EXPORT_SYMBOL_GPL(nvme_init_ctrl);
> +EXPORT_SYMBOL_GPL(nvme_add_ctrl);
>
>  /* let I/O to all namespaces fail in preparation for surprise removal */
>  void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl)
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index c52446013388f..d5a383766b34d 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3563,6 +3563,10 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_=
ctrl_options *opts,
>         if (IS_ERR(ctrl))
>                 return ERR_CAST(ctrl);
>
> +       ret =3D nvme_add_ctrl(&ctrl->ctrl);
> +       if (ret)
> +               goto out_put_ctrl;
> +
>         ret =3D nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_se=
t,
>                         &nvme_fc_admin_mq_ops,
>                         struct_size_t(struct nvme_fcp_op_w_sgl, priv,
> @@ -3607,6 +3611,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_c=
trl_options *opts,
>         /* initiate nvme ctrl ref counting teardown */
>         nvme_uninit_ctrl(&ctrl->ctrl);
>
> +out_put_ctrl:
>         /* Remove core ctrl ref. */
>         nvme_put_ctrl(&ctrl->ctrl);
>
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index f3a41133ac3f9..9693490680866 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -792,6 +792,7 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool sh=
utdown);
>  int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
>  int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>                 const struct nvme_ctrl_ops *ops, unsigned long quirks);
> +int nvme_add_ctrl(struct nvme_ctrl *ctrl);
>  void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
>  void nvme_start_ctrl(struct nvme_ctrl *ctrl);
>  void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 102a9fb0c65ff..c92125b0238d4 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3015,6 +3015,10 @@ static int nvme_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)
>         if (IS_ERR(dev))
>                 return PTR_ERR(dev);
>
> +       result =3D nvme_add_ctrl(&dev->ctrl);
> +       if (result)
> +               goto out_put_ctrl;
> +
>         result =3D nvme_dev_map(dev);
>         if (result)
>                 goto out_uninit_ctrl;
> @@ -3101,6 +3105,7 @@ static int nvme_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
>         nvme_dev_unmap(dev);
>  out_uninit_ctrl:
>         nvme_uninit_ctrl(&dev->ctrl);
> +out_put_ctrl:
>         nvme_put_ctrl(&dev->ctrl);
>         return result;
>  }
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 94d4f3dbac6b6..5c44c7c5c688c 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2323,6 +2323,10 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(str=
uct device *dev,
>         if (IS_ERR(ctrl))
>                 return ERR_CAST(ctrl);
>
> +       ret =3D nvme_add_ctrl(&ctrl->ctrl);
> +       if (ret)
> +               goto out_put_ctrl;
> +
>         changed =3D nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECT=
ING);
>         WARN_ON_ONCE(!changed);
>
> @@ -2341,6 +2345,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(stru=
ct device *dev,
>
>  out_uninit_ctrl:
>         nvme_uninit_ctrl(&ctrl->ctrl);
> +out_put_ctrl:
>         nvme_put_ctrl(&ctrl->ctrl);
>         if (ret > 0)
>                 ret =3D -EIO;
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 5ee3bbc67f411..3be67c98c906e 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2779,6 +2779,10 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(stru=
ct device *dev,
>         if (IS_ERR(ctrl))
>                 return ERR_CAST(ctrl);
>
> +       ret =3D nvme_add_ctrl(&ctrl->ctrl);
> +       if (ret)
> +               goto out_put_ctrl;
> +
>         if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
>                 WARN_ON_ONCE(1);
>                 ret =3D -EINTR;
> @@ -2800,6 +2804,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struc=
t device *dev,
>
>  out_uninit_ctrl:
>         nvme_uninit_ctrl(&ctrl->ctrl);
> +out_put_ctrl:
>         nvme_put_ctrl(&ctrl->ctrl);
>         if (ret > 0)
>                 ret =3D -EIO;
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index e589915ddef85..e32790d8fc260 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -555,6 +555,10 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struc=
t device *dev,
>                 goto out;
>         }
>
> +       ret =3D nvme_add_ctrl(&ctrl->ctrl);
> +       if (ret)
> +               goto out_put_ctrl;
> +
>         if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
>                 WARN_ON_ONCE(1);
>
> @@ -611,6 +615,7 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct=
 device *dev,
>         kfree(ctrl->queues);
>  out_uninit_ctrl:
>         nvme_uninit_ctrl(&ctrl->ctrl);
> +out_put_ctrl:
>         nvme_put_ctrl(&ctrl->ctrl);
>  out:
>         if (ret > 0)
> --
> 2.43.0
>
>


--
Best Regards,
  Yi Zhang


