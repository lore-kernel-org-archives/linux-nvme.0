Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B697DD711CC
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Dec 2025 02:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KoHkMhtK9i7H2CKYfHaqozTf4i0vAnfnaZCckBGJ5yM=; b=cDV0VxZt53hK70aoP044TdF+NN
	zwiJIK1yTNKoO/XYyfgMJj+vQAs+S68bwnG0U0SCvPg9O5JNzeUyJLg4zvoWckce7lxh2wBuBU5Io
	EOeaMflnkB/+GJFD3dPeVompxBk08Y6JuGz1Lvpm815zlKM5Mq7Kn/KbLqe6URa7XM+FbeDo20B+K
	5IMBAorHOoIFK6kDimb1gqDTGEaC094+Zz2A9QckDPnf6kYyh8rAQXVgP1q/zPxf1gksUi4CDu59U
	tKc+dEvLTLgeLJj2vsOx+r/IQ1LxVLoK+ahEu4MXzzxq6O9vh3Czm5GRrYuaMqz/MYg0XqKJBqfJD
	PKT0QOGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWQ2X-00000009U3d-1AUB;
	Fri, 19 Dec 2025 02:16:21 +0000
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWQ2U-00000009U38-2S0d
	for linux-nvme@lists.infradead.org;
	Fri, 19 Dec 2025 02:16:19 +0000
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-93f4f04d9f6so1404617241.0
        for <linux-nvme@lists.infradead.org>; Thu, 18 Dec 2025 18:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766110577; x=1766715377; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoHkMhtK9i7H2CKYfHaqozTf4i0vAnfnaZCckBGJ5yM=;
        b=F2fHOk14NN+/hoAB/H6/QwJyVDeV1kX10GP3wG6QUXU6C+3l8w/+Psb5SMx68KtuAm
         uUKfEGDkBD2Ce60P8n7rz34MC9wlB+7GPQbCfilxhIDg4b72WM26U8ogY/6QVdXgwgL2
         6jlFN6pAqgSCrqNYZwORqeEgiZrQy2lYbOi1IGGg1Su7/9DqWSGr/52yDfsIprNCPI0s
         7P6b3+DVvq8i6iZ47rxqnPEmVu5xs39zQKDdQDISx9wWTgCy9kzLvzCXcSxr+t7BQ3gw
         LNdyBpdxJ8v1jsPOSMGEerXfbnCCMvMmgq4yzIrgQvqPztxf/7EtJqAoXl7/jyaOUu2V
         F2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766110577; x=1766715377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KoHkMhtK9i7H2CKYfHaqozTf4i0vAnfnaZCckBGJ5yM=;
        b=ZS9Ik5bBbJwaadVEC/LlkxgDCOJUwTBEMR2FggzgSERWKR6wNGqoFuTI+g+tNLKDT0
         6B1Kck36i3dsvVK3a8uvB4PVpErW2L4hzHkPEfmLPLixWmh4OWpg8eWljuaBybOzATaL
         7dGjhv11KlV1scXiu/XYGjotJ/uf6I0KPU8XgaD5bSNNIO9448nR+ZZSquCKsONzHaDA
         nAwFN/4TLt2TatKKOb23kDSySwrNT+kl/bn30Ve+jsxBwwC464R0RnSw1tyrFO0EzAt0
         QjHD0qxTaJk+21eCBRi702kwsjVLQ51/FDcnx3N9EFQjcWYHnymcsCjecU/NJxgiUqKn
         BQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCUsZenEr0oyDpWaamtiyU09c0WpFJGr5Bx5LbtLSqHQtm/n4zODjXE0qLAGhsgvYjqSvyGuD60sPjV4@lists.infradead.org
X-Gm-Message-State: AOJu0YyqXSc/GXfzj2h8k8fwYsv3/BPl2540v/8lp3Bq6dGcRNFsIZEV
	KQNYaS4S1GUWPljWe3UOfbgbd3TG+QMwqhc5vL6F78zBrU/1qQNBT0yMTnQWMNP5s3ni0X9PLdA
	7b++PurrshGf2c8kKWiGz3kW2vhiada0nTqK0VA/8nA==
X-Gm-Gg: AY/fxX71uLDfJVWEF/5Lq3o8JXZZz9XmTjVeY4XQv9GqwW/G4wpJaPej6iytbJUltG2
	nAjtFNwsWlFlmLKiNX+xteB+sMEbFpFBMWyZsnz7+nAn+NwdCz0q9sMJEtjPIKkFrNPQ56O2dSg
	CQcpdLPoh3GdjxeFdVX7YHKaqPl/GhAH/nAeVEX6jDWQzltK9H41pslOf+HFqgbPsDLr6mmHfYG
	IWD5enWvKRogtTK6esoYYV4D1vX6+/rOg1aZ6ohxsO++qHu4q31GrNVc/CZkstJ+Y+6LAKe
X-Google-Smtp-Source: AGHT+IHtDfgBccrKRGYpy0rMLdBNJIR/IFftzS3cHyisvuW/R2ToOdIttrzSZp+XoNJFxxW3Zr0MdY89MF2pxJB6u3c=
X-Received: by 2002:a05:6102:3710:b0:5db:3c3b:7767 with SMTP id
 ada2fe7eead31-5eb187045a8mr586326137.16.1766110577195; Thu, 18 Dec 2025
 18:16:17 -0800 (PST)
MIME-Version: 1.0
References: <20251126021250.2583630-1-mkhalfella@purestorage.com> <20251126021250.2583630-12-mkhalfella@purestorage.com>
In-Reply-To: <20251126021250.2583630-12-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 18 Dec 2025 18:16:04 -0800
X-Gm-Features: AQt7F2p6Q3f0yAbEb6gwvkOKayjbjXgKIMoFgNneb1IjPIFX-JGP4SyNmpHaVqk
Message-ID: <CAPpK+O2=j6sGu01YCh=CnfkuN1kkE=xuxDEOW75t4mXXShavkA@mail.gmail.com>
Subject: Re: [RFC PATCH 11/14] nvme-rdma: Use CCR to recover controller that
 hits an error
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, John Meneghini <jmeneghi@redhat.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_181618_633955_C4F787B5 
X-CRM114-Status: GOOD (  18.29  )
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

On Tue, Nov 25, 2025 at 6:13=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> An alive nvme controller that hits an error will now move to RECOVERING
> state instead of RESETTING state. In RECOVERING state, ctrl->err_work
> will attempt to use cross-controller recovery to terminate inflight IOs
> on the controller. If CCR succeeds, then switch to RESETTING state and
> continue error recovery as usuall by tearing down the controller, and
> attempting reconnect to target. If CCR fails, the behavior of recovery
"usuall" -> "usual"
"attempt reconnecting" -> "attempting to reconnect"

it would read better with "the" added:
"reconnect to the target"

> depends on whether CQT is supported or not. If CQT is supported, switch
> to time-based recovery by holding inflight IOs until it is safe for them
> to be retried. If CQT is not supported proceed to retry requests
> immediately, as the code currently does.


> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 190a4cfa8a5e..4a8bb2614468 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c

> +static int nvme_rdma_recover_ctrl(struct nvme_ctrl *ctrl)

> +       queue_delayed_work(nvme_reset_wq, &to_rdma_ctrl(ctrl)->err_work, =
rem);
nvme_rdma_recover_ctrl is exactly the same as
nvme_tcp_recover_ctrl. Seems like a core.c function
nvme_recover_ctrl could take a delayed work queue,
unifying the code.

>  static void nvme_rdma_error_recovery_work(struct work_struct *work)
>  {
> -       struct nvme_rdma_ctrl *ctrl =3D container_of(work,
> +       struct nvme_rdma_ctrl *ctrl =3D container_of(to_delayed_work(work=
),
>                         struct nvme_rdma_ctrl, err_work);
>
> +       if (nvme_ctrl_state(&ctrl->ctrl) =3D=3D NVME_CTRL_RECOVERING) {
> +               if (nvme_rdma_recover_ctrl(&ctrl->ctrl))
> +                       return;
> +       }
> +
>         nvme_stop_keep_alive(&ctrl->ctrl);
The state of the controller should not be LIVE while waiting for
recovery, so I do not think we will succeed in sending keep alives,
but I think this should move to before (or inside of)
nvme_tcp_recover_ctrl().

Sincerely,
Randy Jennings

