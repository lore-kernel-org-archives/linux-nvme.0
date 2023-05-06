Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31ABC77B7C
	for <linux-nvme@archiver.kernel.org>; Sat,  6 May 2023 03:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wnkb+1N63ixO0hqz31ZUNkVZ743oQ/QrWctaAGFypis=; b=0j7M3IXg4hP77WrGpfcEwx5xMB
	xldJ41fzxoXtpTYDXG1DsfPvZyDLe9Q0/S67T+ngRdX6Ui5RgRfTOY0OzCPZrnc1tox8l5d+2d72F
	2xoHGRZG/tzhIuPbgex3xz3anvL6siTMFPFQMvg5qjHVY+XpZuMkDHdy9mGFdksh4IeWLDGJ5Qx1z
	7pecuxr52BQ3X27j/BF9EAOcVfXe5HRzY8aJorlonFVLKGkUfeHkUoeXe7Pen23XNUcj4ftji06lZ
	kYH+Voo2rxrOIg9Uoq6STno0GZB9SxrkshHyVulTwVlCN9k4SlQExOzcX/kNg/QPfpZXp/El+93G0
	dytDf2Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pv8O9-00CQZY-1R;
	Sat, 06 May 2023 03:15:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pv8O6-00CQYv-1d
	for linux-nvme@lists.infradead.org;
	Sat, 06 May 2023 03:15:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683342909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wnkb+1N63ixO0hqz31ZUNkVZ743oQ/QrWctaAGFypis=;
	b=hiF+fyMalJdn6gs/twUcRy9T18Rle4kMEH4mH5T7WRp0h0O9xGUnD7lT9jrudY0P8w7WMX
	ILCEmtpt+04O1LOdQSavzqM7ce8pA7z4jXT1WW2bXwqKnzszX4hXb/sSCaoxdGhiieZx0b
	gSzrN0FrQ7s4iRB2y+xKcw0j6AMG+eU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-Vcm_etn8NFuh3XVLNYtWwg-1; Fri, 05 May 2023 23:15:08 -0400
X-MC-Unique: Vcm_etn8NFuh3XVLNYtWwg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-24e1e0263daso2220206a91.2
        for <linux-nvme@lists.infradead.org>; Fri, 05 May 2023 20:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683342906; x=1685934906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wnkb+1N63ixO0hqz31ZUNkVZ743oQ/QrWctaAGFypis=;
        b=Jty0Gus+Dil4OrqElDNV9ksEx0L8VDzeoLf1Geeje6eeraHGfCgRTjvULUDA3+qP1R
         054dMk0UJ72FNUf3OCqlNVcPUj/B4IC+JacytIvJh+1NMxPBo8RrVdFJzOHAbc2RJJPR
         /YtnNp05/6eWdniMuPLn7BOKiG+tT/nDrG3kObU/lg6dSW0YZfcUzoJOP2JBBuhacB6S
         VHBks2LUFqLItMOmkS7uzP+v4ssrcuQknlZM5Ym9RkUwQv50aAluFE03wtnYYio7wjUZ
         6siNVT3o8sLutZNM1eC223U0QXn7HrJAyMOnSpKoEJHBbMB4rqLBJYrow7a+i4SF148d
         bMBA==
X-Gm-Message-State: AC+VfDySaU9/yf+AZB04nht1X3V10ei4XIK+BKyuZEyA1ZPLzbB7qgIy
	yTV6+2J5HuK4ecgxVxhU0Z7967Lx119xvZwNReo20zNH44/au3r3AJ+IWn5WJ7TIkqfaNvmFmuq
	paPulyhumUPseh7mQ07dcJOvGIMP9QlgYusZWMN7vhHB7UnnOzGvkoYTG
X-Received: by 2002:a17:90b:390d:b0:250:1114:e591 with SMTP id ob13-20020a17090b390d00b002501114e591mr3669058pjb.3.1683342906140;
        Fri, 05 May 2023 20:15:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6H0DRgbooS1k5sEWtbRXoFhypJ2ZVK6D822Nq+AVY5uJ+8KyM+rnco6A1nxmMn5ldeI9W0sKovU3N1vdA3uFw=
X-Received: by 2002:a17:90b:390d:b0:250:1114:e591 with SMTP id
 ob13-20020a17090b390d00b002501114e591mr3669043pjb.3.1683342905862; Fri, 05
 May 2023 20:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230428073115.22987-1-kch@nvidia.com> <20230428073115.22987-5-kch@nvidia.com>
In-Reply-To: <20230428073115.22987-5-kch@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 6 May 2023 11:14:53 +0800
Message-ID: <CAHj4cs81oO71p_stdOG_7fzUmY4ZncNAfA8e-Wuu+1WsqGxQxg@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] nvme-core: fix dev_pm_qos memleak
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, kbusch@kernel.org, 
	hch@lst.de, sagi@grimberg.me
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_201510_614953_B2806DF0 
X-CRM114-Status: GOOD (  13.31  )
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


On Fri, Apr 28, 2023 at 3:42=E2=80=AFPM Chaitanya Kulkarni <kch@nvidia.com>=
 wrote:
>
> Call dev_pm_qos_hide_latency_tolerance() in the error unwind patch to
> avoid following kmemleak:-
>
> blktests (master) # kmemleak-clear; ./check nvme/044;
> blktests (master) # kmemleak-scan ; kmemleak-show
> nvme/044 (Test bi-directional authentication)                [passed]
>     runtime  2.111s  ...  2.124s
> unreferenced object 0xffff888110c46240 (size 96):
>   comm "nvme", pid 33461, jiffies 4345365353 (age 75.586s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<0000000069ac2cec>] kmalloc_trace+0x25/0x90
>     [<000000006acc66d5>] dev_pm_qos_update_user_latency_tolerance+0x6f/0x=
100
>     [<00000000cc376ea7>] nvme_init_ctrl+0x38e/0x410 [nvme_core]
>     [<000000007df61b4b>] 0xffffffffc05e88b3
>     [<00000000d152b985>] 0xffffffffc05744cb
>     [<00000000f04a4041>] vfs_write+0xc5/0x3c0
>     [<00000000f9491baf>] ksys_write+0x5f/0xe0
>     [<000000001c46513d>] do_syscall_64+0x3b/0x90
>     [<00000000ecf348fe>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
>
> Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/nvme/host/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 15607281baaa..90dc4b832200 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5202,6 +5202,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct d=
evice *dev,
>         return 0;
>  out_free_cdev:
>         nvme_fault_inject_fini(&ctrl->fault_inject);
> +       dev_pm_qos_hide_latency_tolerance(ctrl->device);
>         cdev_device_del(&ctrl->cdev, ctrl->device);
>  out_free_name:
>         nvme_put_ctrl(ctrl);
> --
> 2.40.0
>
>


--
Best Regards,
  Yi Zhang


