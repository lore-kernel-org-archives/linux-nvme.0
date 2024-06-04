Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E47FC25B75
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 00:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EmpIluP+/It0K7RGvmuRlSFGUpJmAGRKm1b7eesbC2c=; b=NZi2hUQU24/ru/WeqQr6+wT1zU
	t7XtwcO/gCf5aZm941hypLpBhgkjBKfjB2YULlN8unm5tquVQIx6xcFiZvc/fksc8mffjqWCRFfQ/
	hynE9C/2tdCIYKwzGAQ5wy1WdHWe4tMwc9l64l/g71vloIa0QuG5NEL+5SBVxCdrcjb3NEEWBoO3k
	tuiikj7JZ2DXNEBFGpwgS2o5Ox7ZOS0Rudet9GSEx4Sl/kJl5y8w9PvnEvidn9gUMQzhpy5Hx8em0
	6SeQiYu3AinGGHKfiZdWMlpbyvUPKTYwExU7Ws95UVxQ2bzxeKrMeP9euX39sKpUrQRryzbWi2J9c
	kL2TT/nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEI9E-00000000kJQ-18o3;
	Tue, 04 Jun 2024 00:35:32 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEI9B-00000000kIt-0qoj
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 00:35:30 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2c24109aca8so1079877a91.1
        for <linux-nvme@lists.infradead.org>; Mon, 03 Jun 2024 17:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1717461325; x=1718066125; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmpIluP+/It0K7RGvmuRlSFGUpJmAGRKm1b7eesbC2c=;
        b=W+ASiSrvWC1L3Lh0eRUu5w/EgiZ+PT9MN+eeR51+I1sKx94ViAPk7+uXoEJLSnbX0G
         Z6Gr/9J2CM9NizDgi4i1Nf22GeuxCr+mksU5QYMIvkEboeLIsk4nctAOIXW4L0E+mr6R
         AhhJ+7UfyZHPCkWWO9TCD8UQ1siYG/IDz92ZnhAMB5PakTaO/jsTxt9AfmhOAtseQz67
         pkUEtdIP12Pb2NeozFstSBJZaODYCPjEi3u7VVFNlCcv7OgxQ4hGLLFqTJfYhsaEzoZO
         kcUW7wTxsWWCbsbsU/LTCRfCyA36/9Igtbs1YXz8gruTHADXpd7gs/iyL5HC5LZb7MtL
         EEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717461325; x=1718066125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmpIluP+/It0K7RGvmuRlSFGUpJmAGRKm1b7eesbC2c=;
        b=jJyHPNM20HTGDHdVLLiODMLa9Z21J3jsjqoxAb5DqYLEudnsxGfahm46wgOzmBJnd2
         BKxdpoAwit2F/38k+trZ2RGKkLdNupO+qilPqVE11pAdpbu2rv/Qfh1usCcc4NHJ6uvx
         K8yqy/8A/EQppt6tsbX7n8HJXfpzio868Rri1HmNVhcMcb+7Sr32RROPkXgCyB5xqBLa
         p5DyrIM/fwXWSy0QTLL9z7VnDIaycSQxKD9uaeWWpo+XtQIIfxwQbT84vtq0QeDQodK3
         UXm7wTxyE4SdgJ70bqlqp7YF2ZiFzPRqIb+bKPdP4+I0Ta+JTjczNHqHm7ryTjdVkCaF
         HVgw==
X-Gm-Message-State: AOJu0YzA6iHQlr4a+w2abQmHGi8qIBCCzj6XIEkajOwi1DQKTLrIJztp
	jiLZmXc058q7DLU9sB4N0BYNeoO4kbGMI4QThSaJ2gKVhdXC1blLRKyMjWZdKZiDWCvWebGGumL
	EiJpqeMCRdOl/cueAVo9avGYujRdMe5p+WhRPKg==
X-Google-Smtp-Source: AGHT+IEXQSkXTMZNyGWGcxWMAOzhEn74th64Ntr9UjVRd1L2mjqCRm6nFZmfK8AZL6I3tc4rsijfKTEPboquA5WsNTA=
X-Received: by 2002:a17:90a:b390:b0:2a5:e087:768a with SMTP id
 98e67ed59e1d1-2c1dc58fd6dmr9882480a91.29.1717461324339; Mon, 03 Jun 2024
 17:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240603230524.3854115-1-kbusch@meta.com> <20240603230524.3854115-3-kbusch@meta.com>
In-Reply-To: <20240603230524.3854115-3-kbusch@meta.com>
From: Caleb Sander <csander@purestorage.com>
Date: Mon, 3 Jun 2024 17:35:13 -0700
Message-ID: <CADUfDZpbsNmYsVX6AvUtmkjD92zJvWWjyS7KBCDzhHSksL+tqQ@mail.gmail.com>
Subject: Re: [PATCH-RFC 2/5] nvme: tcp: split controller bringup handling
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, 
	mlombard@redhat.com, hare@suse.de, shinichiro.kawasaki@wdc.com, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_173529_315080_15BE00BD 
X-CRM114-Status: GOOD (  19.28  )
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

On Mon, Jun 3, 2024 at 4:08=E2=80=AFPM Keith Busch <kbusch@meta.com> wrote:
>
> From: Keith Busch <kbusch@kernel.org>
>
> Drivers must call nvme_uninit_ctrl after a successful nvme_init_ctrl.
> Split the allocation side out to make the error handling boundary easier
> to navigate. The nvme tcp driver's error handling had different returns
> in the error goto labels, which harm readability.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/tcp.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 8b5e4327fe83b..7f75d01dcbed0 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2686,7 +2686,7 @@ nvme_tcp_existing_controller(struct nvmf_ctrl_optio=
ns *opts)
>         return found;
>  }
>
> -static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
> +static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
>                 struct nvmf_ctrl_options *opts)
>  {
>         struct nvme_tcp_ctrl *ctrl;
> @@ -2761,6 +2761,24 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(stru=
ct device *dev,
>         if (ret)
>                 goto out_kfree_queues;
>
> +       return ctrl;
> +out_kfree_queues:
> +       kfree(ctrl->queues);
> +out_free_ctrl:
> +       kfree(ctrl);
> +       return ERR_PTR(ret);
> +}
> +
> +static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
> +               struct nvmf_ctrl_options *opts)
> +{
> +       struct nvme_tcp_ctrl *ctrl;
> +       int ret;
> +
> +       ctrl =3D nvme_tcp_alloc_ctrl(dev, opts);
> +       if (IS_ERR(ctrl))
> +               return (struct nvme_ctrl *)ctrl;

This cast doesn't look right, as struct nvme_tcp_ctrl doesn't start
with a struct nvme_ctrl field. Looks like this should be &ctrl->ctrl
to match the current implementation of nvme_tcp_create_ctrl()?

> +
>         if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
>                 WARN_ON_ONCE(1);
>                 ret =3D -EINTR;
> @@ -2786,11 +2804,6 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(stru=
ct device *dev,
>         if (ret > 0)
>                 ret =3D -EIO;
>         return ERR_PTR(ret);
> -out_kfree_queues:
> -       kfree(ctrl->queues);
> -out_free_ctrl:
> -       kfree(ctrl);
> -       return ERR_PTR(ret);
>  }
>
>  static struct nvmf_transport_ops nvme_tcp_transport =3D {
> --
> 2.43.0
>
>

