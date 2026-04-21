Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB191F327CC
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2026 09:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W6rJ+0VXi49xCQrxNs2KSyNZeKpDvLDF1B14DRPmB84=; b=z+y2vjd9i526VlrjXRIklJ1ZO+
	S2skNTM54RnRn5BQIb+gGNwzr/RFIHolt/wqHQKsyqUVCdypBKBs7cxj+qaGcCNE+/k/CIeEhM1HV
	P7Va5wbwD/PmS6I7Etr3GoLIWzBAnPgf8bDb7J/su54hWuM4raSLcDSGg4bISv2+V+uYx9qTUZU5m
	3tb094QxrVjjDmaoQ4+R2I0fB/IfHgkPX36zJzNMPWYzkeKmwWzPqYGhQ3tZetpVbI33011kFan3q
	kIUQUeM7rbByj1ZqQVQNgG2bKOnLYtU0xX5HXTrkuxu2cHBHxpoAr59M/msHwukg9eYAxVtSz8V0v
	9/eL/zCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF7I2-00000008JwZ-3IS8;
	Tue, 21 Apr 2026 09:21:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF7Hz-00000008JwB-2gEK
	for linux-nvme@lists.infradead.org;
	Tue, 21 Apr 2026 09:21:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776763261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W6rJ+0VXi49xCQrxNs2KSyNZeKpDvLDF1B14DRPmB84=;
	b=g00tZoFsjpn0FcSWht30D0DgfVx4aUpVRemERPXOoAgH8vU2OtYKGwgNkuRl3Np+KHOzaH
	yfeiwhZ4vyYIEbQx1lCm3rsWmTvC1ZdEVX1il6iMv3TrXebQb8/7T4T2HwXVz2cJdfYofc
	Z0a7c2i/XmHPm4bPUvhaJFQEwdzR4XU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-LD50eSUKPamo6QrIaDQbig-1; Tue, 21 Apr 2026 05:19:02 -0400
X-MC-Unique: LD50eSUKPamo6QrIaDQbig-1
X-Mimecast-MFC-AGG-ID: LD50eSUKPamo6QrIaDQbig_1776763141
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3870692ea5cso29422891fa.0
        for <linux-nvme@lists.infradead.org>; Tue, 21 Apr 2026 02:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776763141; x=1777367941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W6rJ+0VXi49xCQrxNs2KSyNZeKpDvLDF1B14DRPmB84=;
        b=R2WZkP/TMr8d9a0vO79rPIMMoCWWKPAM+m2ROmf16JuF4tg0TlvbJ8zg9b4Y4HPGKu
         89L/dmh9wX/BCI8Dva0+/pAb/H9WX3Bs7cDvk02/8eSURw4AZ2ORcuk1Ub40TPNSpgMS
         /pbfGEiC9ehH80IQvmnx3Cf7V5vsR6JuzZ68NV5qlzc9fHmcJihUMsMmQqYcJeVaN62C
         IaxvTXwTjGoFAxF0n4p6/FLO/37uMVaspWCFU/t3wElofmr2CbMdu9wQ/K+nlTPe+dLc
         pipiEgKc28E33Pp+Iu/fJUOsFdxotaQ5XrWPcdXMOcT+Rl1q42q2QuwDBVitwhgnFG8o
         K+XA==
X-Forwarded-Encrypted: i=1; AFNElJ9Eo1q0olSFn8DpnR2YLR01DGwJjqYb5J5224IywrrMylHbntW+3OnRlfPTD2ClJ3/CE7lBFfc+Qnzc@lists.infradead.org
X-Gm-Message-State: AOJu0Yxk0xTOQB2oOPVJYw07rD3CL77hvnV35Eie5FdXuNe7FNDxDC1C
	jzhlEF0z8v9vIj2n1a7UVQ8FDps9TENHEz4vlb+JyFwaHjom4r6W3hIwFOIudvFNHSMUXbjDHJT
	CQiEHkrLiBmtOHwOFpod2rlCMLXmWlB8wggNvlhwzepsBtfVH2J+rhi8fh5pf8lNpkYO+SzIYQR
	g2U9GErWbCgq7/3SQsN0CnRGGsheRUJTqtqoX54vHGmdg=
X-Gm-Gg: AeBDietiz43hyQ2Abcdh729SnLlzKzVRMO/TqrNaSr+a84otT9iudDZzOnOm8Ok0+AJ
	0I933bEkmDqkg6iDq7lPKNoYvFp6nDIpIAwczHbb0nuYciU9cnSDeftrqgvf2Hhr6TZjflGQEgL
	Yxbvb/dD24STNDl3XNkMw8sD/qwGxxR+qr20euDakllTavIwOlzY8VN4sC7+v1ac151keeenYUz
	FeDz628XP34Iyc51A1QYFS/GX3Z27HvzY6oPn6+4aKYDY86k9wkKYID6CZUWcvaBppklrNbe2eA
	RrxRCjbu6FTW9OGn
X-Received: by 2002:a05:6512:3ba6:b0:5a3:ff60:b72e with SMTP id 2adb3069b0e04-5a4172eac66mr5550783e87.39.1776763140945;
        Tue, 21 Apr 2026 02:19:00 -0700 (PDT)
X-Received: by 2002:a05:6512:3ba6:b0:5a3:ff60:b72e with SMTP id
 2adb3069b0e04-5a4172eac66mr5550766e87.39.1776763140398; Tue, 21 Apr 2026
 02:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260416212633.72650-1-kch@nvidia.com> <20260416212633.72650-3-kch@nvidia.com>
In-Reply-To: <20260416212633.72650-3-kch@nvidia.com>
From: Xiao Ni <xni@redhat.com>
Date: Tue, 21 Apr 2026 17:18:48 +0800
X-Gm-Features: AQROBzDf2tjvBa_f8b5LjqU6QJRyMegO5Ky2-PWAQkE5Cy7OI3M6rtbRfAnWzKI
Message-ID: <CALTww2_bSwhqUnc-9Z7qL_-J3JtvhtGr3CmjUg-r-=zoaGt68g@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] md: propagate BLK_FEAT_PCI_P2PDMA from member
 devices to RAID device
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: song@kernel.org, yukuai@fnnas.com, linan122@huawei.com, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, kmodukuri@nvidia.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wzzFPe12qviEW_iVCQjWOUpl0vkcEtE_gLwg7wrudEA_1776763141
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_022103_810754_EF82E218 
X-CRM114-Status: GOOD (  18.40  )
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

On Fri, Apr 17, 2026 at 5:27=E2=80=AFAM Chaitanya Kulkarni <kch@nvidia.com>=
 wrote:
>
> From: Kiran Kumar Modukuri <kmodukuri@nvidia.com>
>
> MD RAID does not propagate BLK_FEAT_PCI_P2PDMA from member devices to
> the RAID device, preventing peer-to-peer DMA through the RAID layer even
> when all underlying devices support it.
>
> Enable BLK_FEAT_PCI_P2PDMA unconditionally in raid0, raid1 and raid10
> personalities during queue limits setup.  blk_stack_limits() clears it
> automatically if any member device lacks support, consistent with how
> BLK_FEAT_NOWAIT and BLK_FEAT_POLL are handled in the block core.
>
> Parity RAID personalities (raid4/5/6) are excluded because they require
> CPU access to data pages for parity computation, which is incompatible
> with P2P mappings.
>
> Tested with RAID0/1/10 arrays containing multiple NVMe devices with
> P2PDMA support, confirming that peer-to-peer transfers work correctly
> through the RAID layer.
>
> Signed-off-by: Kiran Kumar Modukuri <kmodukuri@nvidia.com>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/md/raid0.c  | 1 +
>  drivers/md/raid1.c  | 1 +
>  drivers/md/raid10.c | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index 5e38a51e349a..2cdaf7495d92 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -392,6 +392,7 @@ static int raid0_set_limits(struct mddev *mddev)
>         lim.io_opt =3D lim.io_min * mddev->raid_disks;
>         lim.chunk_sectors =3D mddev->chunk_sectors;
>         lim.features |=3D BLK_FEAT_ATOMIC_WRITES;
> +       lim.features |=3D BLK_FEAT_PCI_P2PDMA;
>         err =3D mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRIT=
Y);
>         if (err)
>                 return err;
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index ba91f7e61920..422ad4786569 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -3215,6 +3215,7 @@ static int raid1_set_limits(struct mddev *mddev)
>         lim.max_hw_wzeroes_unmap_sectors =3D 0;
>         lim.logical_block_size =3D mddev->logical_block_size;
>         lim.features |=3D BLK_FEAT_ATOMIC_WRITES;
> +       lim.features |=3D BLK_FEAT_PCI_P2PDMA;
>         err =3D mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRIT=
Y);
>         if (err)
>                 return err;
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 4901ebe45c87..07a5b734c8f3 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -3939,6 +3939,7 @@ static int raid10_set_queue_limits(struct mddev *md=
dev)
>         lim.chunk_sectors =3D mddev->chunk_sectors;
>         lim.io_opt =3D lim.io_min * raid10_nr_stripes(conf);
>         lim.features |=3D BLK_FEAT_ATOMIC_WRITES;
> +       lim.features |=3D BLK_FEAT_PCI_P2PDMA;
>         err =3D mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRIT=
Y);
>         if (err)
>                 return err;
> --
> 2.39.5
>
>

Thanks for enabling this feature. Looks good to me.
Reviewed-by: Xiao Ni <xni@redhat.com>


