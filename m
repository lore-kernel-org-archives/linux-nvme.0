Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9005AC77B7D
	for <linux-nvme@archiver.kernel.org>; Sat,  6 May 2023 03:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aV3abeVUSRmmDXTG6ImQV+fsst/FNDQnS6/W2j+aJ/g=; b=A6psKd2+0tpohjtkOEztIZAaeK
	cVoJHb2QW5dDZx4X/fQottiaj3bY43IarWujqvLh348cG6dGqw+VDk7MYIp9tFlic0P0kPzXV+W9k
	v5wwiTrS3WO3SrbAF+H0VdBnA+ZAY7gDIAQ8bVcM0BUAiy4ION6W9DyxzZH4k6GAMcXgW/QawxIU6
	qD7eLwSJkBNuqPT2UAwwI4NYsN+k9wqP9MQduUszYArrH7nFz4rcOwLXXRaxlaaEkxTOruyeFHMhj
	cI8glaFT/0yWgAxoSUaLihXKd3g02OS93KZ6QbZ8kD0MepbbWPgDc/CipFKQWv+XiY9jW44zQ/RAp
	6WTVJn3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pv8Lw-00CQIy-2i;
	Sat, 06 May 2023 03:12:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pv8Lr-00CQHw-0n
	for linux-nvme@lists.infradead.org;
	Sat, 06 May 2023 03:12:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683342769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aV3abeVUSRmmDXTG6ImQV+fsst/FNDQnS6/W2j+aJ/g=;
	b=hqByoBEllHL0uoFv+uvL9ImWKOZnLOn4ukoKnkDWEmcnRRIlKbOfdkQIwrtpuLyEbqPmW0
	gGRcuZhRYvE8Ix1mMsB6YmrpA1HAb6J/k4zUglckzYqNhFOLloXq77RBV3GSroEpKOrOfC
	cJqiVNOqEopDTlu0+S7FtqbGAGzD368=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-SYQmnFFTPKewIMTxWWdFbw-1; Fri, 05 May 2023 23:12:48 -0400
X-MC-Unique: SYQmnFFTPKewIMTxWWdFbw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-64378a8b2e7so1322026b3a.0
        for <linux-nvme@lists.infradead.org>; Fri, 05 May 2023 20:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683342766; x=1685934766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aV3abeVUSRmmDXTG6ImQV+fsst/FNDQnS6/W2j+aJ/g=;
        b=Swn8VgXnrWYEzse9dhjV8FgPDA2EHLp54FjBBg2NPLniLIgefpyPTYeacI8VnurKSK
         J0XK4CdiLF/ZxKey1IkJkpfbj7CcnIK3LUVEMKU6gEO9C4NDnhPQGZQIy8oFsosdUIBJ
         WpbKwfdiNh3HxRn1K4weWhfy0c/hT7+RLiVU2CBBjvmpjLCthNTy+K5fL6/CUgFMzEcS
         uwPUfgFqVU7mfFE2ZChigtcvrq9+fVd9bi+Of3Md4Y1kkS5PfmaTxiJdbUH5JY3CRkvH
         LcQZNVw3FnAI/z76HdL2p+Reb3PGyQWo2yrndlN04O8nn2EG0IjtzHZ4jnkKShknzC3R
         50wg==
X-Gm-Message-State: AC+VfDyK3/LOhAXWXnXpNr8YhCOvZFAoHIWPsjS/yVn5T2U7IaUBDBPw
	kMbZowLIt01RvqMFLvql/5DqQnXJIA22fzI43bra49UX4Abqk2yfb0ulTCXhGA1ifgwpIhMXZ2z
	XrmhCp4l5C45BsJwSrHvbxecIFB9/tVqFpM2rOreKa3Arq6JAAfFG4/QF
X-Received: by 2002:a05:6a21:6d98:b0:ec:c8c2:36b7 with SMTP id wl24-20020a056a216d9800b000ecc8c236b7mr4638199pzb.14.1683342765754;
        Fri, 05 May 2023 20:12:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ48tibvOccjtH/np1+Q8Z/MRKPM2iLDPDkVS1kvL/BNqVvBsjSuV/5APfy+A7+DeCubdqNhLsgURnzDv6UAA00=
X-Received: by 2002:a05:6a21:6d98:b0:ec:c8c2:36b7 with SMTP id
 wl24-20020a056a216d9800b000ecc8c236b7mr4638186pzb.14.1683342765450; Fri, 05
 May 2023 20:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230503150925.863308-1-sagi@grimberg.me>
In-Reply-To: <20230503150925.863308-1-sagi@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 6 May 2023 11:12:32 +0800
Message-ID: <CAHj4cs_J0FF2XNWJtWZY92JC2VxXGfLb8F7kWaXThsoJRhqySA@mail.gmail.com>
Subject: Re: [PATCH] nvme: Fix memory leak in nvme_init_ctrl error path
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, 
	Irvin Cote <irvincoteg@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_201251_402621_090F335C 
X-CRM114-Status: GOOD (  28.72  )
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

Verified the kmemleak issue I reported:
https://lore.kernel.org/linux-nvme/CAHj4cs-nDaKzMx2txO4dbE+Mz9ePwLtU0e3egz+=
StmzOUgWUrA@mail.gmail.com/

Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Wed, May 3, 2023 at 11:13=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
> nvme_init_ctrl may fail before creating the misc device or after creating
> the misc device.
>
> If we fail before creating the misc device, we just need to deallocate wh=
at
> was allocated before and return (as usually done).
>
> If we fail after we create the misc device, we must put
> the final reference on the device in order to make sure that internal
> device resources are cleaned up.
>
> The device release also triggers nvme_free_ctrl method so we need to make
> sure to identify that we failed during the initialization itself and skip
> cleaning because nvme_init_ctrl error path cleaned up on its own (we do
> that by marking the ctrl->instance to UNINITIALIZED).
>
> We also drop the explicit dev_name deallocation because it is freed in
> the device release sequence.
>
> This addresses a memory leak triggered by blktests nvme/044 which happens
> to fail exactly after misc device initialization:
> --
> unreferenced object 0xffff95678a54cd00 (size 256):
>   comm "nvme", pid 1941, jiffies 4294761594 (age 10.010s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 08 cd 54 8a 67 95 ff ff  ..........T.g...
>     08 cd 54 8a 67 95 ff ff e0 b5 7b 8b ff ff ff ff  ..T.g.....{.....
>   backtrace:
>     [<ffffffff8b349205>] kmalloc_trace+0x25/0x90
>     [<ffffffff8b7c0463>] device_add+0x303/0x690
>     [<ffffffff8b4103c4>] cdev_device_add+0x44/0x90
>     [<ffffffffc0de1c42>] 0xffffffffc0de1c42
>     [<ffffffffc0d788b3>] 0xffffffffc0d788b3
>     [<ffffffffc0d8c66d>] 0xffffffffc0d8c66d
>     [<ffffffffc0d8c831>] 0xffffffffc0d8c831
>     [<ffffffff8b40a8b2>] vfs_write+0xc2/0x3c0
>     [<ffffffff8b40aeff>] ksys_write+0x5f/0xe0
>     [<ffffffff8bc0eb58>] do_syscall_64+0x38/0x90
>     [<ffffffff8be000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> --
>
> Reported-by: Irvin Cote <irvincoteg@gmail.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/core.c | 28 ++++++++++++++++------------
>  drivers/nvme/host/nvme.h |  1 +
>  2 files changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ea508e9a1de7..b374e6007553 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5083,6 +5083,9 @@ static void nvme_free_ctrl(struct device *dev)
>                 container_of(dev, struct nvme_ctrl, ctrl_device);
>         struct nvme_subsystem *subsys =3D ctrl->subsys;
>
> +       if (ctrl->instance =3D=3D NVME_CTRL_INSTANCE_UNINITIALIZED)
> +               return;
> +
>         if (!subsys || ctrl->instance !=3D subsys->instance)
>                 ida_free(&nvme_instance_ida, ctrl->instance);
>
> @@ -5137,18 +5140,19 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct=
 device *dev,
>         INIT_DELAYED_WORK(&ctrl->failfast_work, nvme_failfast_work);
>         memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
>         ctrl->ka_cmd.common.opcode =3D nvme_admin_keep_alive;
> +       ctrl->instance =3D NVME_CTRL_INSTANCE_UNINITIALIZED;
>
>         BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) =
>
>                         PAGE_SIZE);
>         ctrl->discard_page =3D alloc_page(GFP_KERNEL);
> -       if (!ctrl->discard_page) {
> -               ret =3D -ENOMEM;
> -               goto out;
> -       }
> +       if (!ctrl->discard_page)
> +               return -ENOMEM;
>
>         ret =3D ida_alloc(&nvme_instance_ida, GFP_KERNEL);
> -       if (ret < 0)
> -               goto out;
> +       if (ret < 0) {
> +               __free_page(ctrl->discard_page);
> +               return ret;
> +       }
>         ctrl->instance =3D ret;
>
>         device_initialize(&ctrl->ctrl_device);
> @@ -5172,7 +5176,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct d=
evice *dev,
>         ctrl->cdev.owner =3D ops->module;
>         ret =3D cdev_device_add(&ctrl->cdev, ctrl->device);
>         if (ret)
> -               goto out_free_name;
> +               goto out_put_ctrl;
>
>         /*
>          * Initialize latency tolerance controls.  The sysfs files won't
> @@ -5193,14 +5197,14 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct=
 device *dev,
>         nvme_fault_inject_fini(&ctrl->fault_inject);
>         dev_pm_qos_hide_latency_tolerance(ctrl->device);
>         cdev_device_del(&ctrl->cdev, ctrl->device);
> -out_free_name:
> +out_put_ctrl:
> +       /* pairs with nvme_get_ctrl */
>         nvme_put_ctrl(ctrl);
> -       kfree_const(ctrl->device->kobj.name);
>  out_release_instance:
>         ida_free(&nvme_instance_ida, ctrl->instance);
> -out:
> -       if (ctrl->discard_page)
> -               __free_page(ctrl->discard_page);
> +       ctrl->instance =3D NVME_CTRL_INSTANCE_UNINITIALIZED;
> +       /* pairs with device_initialize .release method will cleanup */
> +       nvme_put_ctrl(ctrl);
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(nvme_init_ctrl);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index bf46f122e9e1..920403589670 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -255,6 +255,7 @@ struct nvme_ctrl {
>         struct request_queue *connect_q;
>         struct request_queue *fabrics_q;
>         struct device *dev;
> +#define NVME_CTRL_INSTANCE_UNINITIALIZED (-1)
>         int instance;
>         int numa_node;
>         struct blk_mq_tag_set *tagset;
> --
> 2.34.1
>
>


--=20
Best Regards,
  Yi Zhang


