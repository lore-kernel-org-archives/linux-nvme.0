Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE62C76188
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 18:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4y0FNliCSXQAD+wEVvEoo8BtBLgr9anvaABjQOhHg4Y=; b=198aMFKrpeVm56wwTSYCV5bAql
	fZA9LdzemDaqPclEf3l/Mxt+k8nQpkFYHbSz6Ciw2zi7CQ144YWBdYA0lu0iEHRs5zrOcHOW4+wFP
	oCedNWdF3v3T6/R3Igi9HtYSahcyA7YMNcCGa8Nm9XPvwEOPQ2PBmb3k1SrAIO2YIH0i5nJTe71i1
	5niXibjAZq+vwt2EqnQYRuOafLFNx+4rP1DmUfvl9TIlw4XS7TuYPz6RoaOBEUvMW53Ffx8FNDh42
	5KMDvadNvlfmtR/zDIdIyHFHUbhBm1Dbm03SKcYfu8TZiiU2ANu25Bk5F8H5pv9aLbSdFaq8bfzA2
	wRRRV2qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjOuV-00GCWU-1c;
	Mon, 03 Apr 2023 18:28:07 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjOuQ-00GCUm-1N
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 18:28:06 +0000
Received: by mail-pj1-x1035.google.com with SMTP id x15so28089084pjk.2
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 11:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680546481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4y0FNliCSXQAD+wEVvEoo8BtBLgr9anvaABjQOhHg4Y=;
        b=nV6oSpc970IUDs8mZHt+Be0urpucTxPuaAxYRCYqkxN6a+CevLQ+QntBlJMiBKPiXs
         3LocRy48lZJdLjSOXj/PLCkORgLvzRnArbmHWp6satAHWijhVwRWO6yiZ3tHk9f5aQ+z
         QAcZfTuOxmC3s0PKbBNV9DgNpM2I/VhYaoAe96YKuPJJsp+FXX+sK1D7t61SNEVKjIiJ
         +214bKzWtc49JQKZfeZq43xPBw8vZAEwYjTQDxVyquBQoXR07LVlN/yfbm+8PpAHvvzc
         RhnOJ2o+aIIIym9lb/biNQXMeyWkwQnsOK6glEmPPYcA6fyvshAyvv3Qmvlv8WFN1RlC
         7xPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680546481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4y0FNliCSXQAD+wEVvEoo8BtBLgr9anvaABjQOhHg4Y=;
        b=j2QPcxV4nfaxUQk80DCee+QfUYU8xqCHP8/KbyHCc9EbM0SbjcTawhwmmq7cqwBxly
         D/YwfeMSHmVk4KRs4G5qaTK/4pEoumI0R5nXrzUHMo9ZPEElTlarxYm9aYODMMwEh2Uu
         Oa518sV4Qu2QOykVAiSa9knqeV6knQ5ZnBXnCENjIEghj45ADyqDret2VCRttHovf5Xo
         FpnEnBbgfzjTqqZZspktUHsvJkudjqkHf0W/HsmiXws7ODE4kEAKE8MLfJ3kA8ReAKlw
         QDqKJMNUGVKdtg177tz07anudLbyaLfjPm2Z/daa+vnsVVHQvg61VkdpPFz213BuC/cZ
         EmPg==
X-Gm-Message-State: AAQBX9fSefzNW4nuSPoVSDXLsa4ovnhV6u6Ut0JdK9JExX0N+NEbAdqR
	PlDnCE4sQhFEaLeNqXAcktxW2nIrOLnibm0AJXs=
X-Google-Smtp-Source: AKy350arXmp+v7Y9Sfkejq60gAU51YeM+aB9r/BqDKFqzM91bwfJcYvp/C5vKFA2nbatAUiJ5smJChTzkoBgaCkqQM4=
X-Received: by 2002:a17:90a:2a8a:b0:240:ad3a:6476 with SMTP id
 j10-20020a17090a2a8a00b00240ad3a6476mr2189pjd.0.1680546481358; Mon, 03 Apr
 2023 11:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <ZCoguA3gBUw1CIdd@archlinux> <38fbc59a-94cf-9764-e4c4-0fd3c8f3830b@grimberg.me>
In-Reply-To: <38fbc59a-94cf-9764-e4c4-0fd3c8f3830b@grimberg.me>
From: irvin cote <irvincoteg@gmail.com>
Date: Mon, 3 Apr 2023 15:27:50 -0300
Message-ID: <CALL+9ei1m2oj=MceRyyjM+FMuSrv9eD=nLKFrkX+RD-0Zp7v0Q@mail.gmail.com>
Subject: Re: [PATCH] nvme-core: Fixing ctrl de-referencing in nvme_init_ctrl
To: Sagi Grimberg <sagi@grimberg.me>
Cc: hch@lst.de, kbusch@kernel.org, axboe@fb.com, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_112802_463478_97A094A0 
X-CRM114-Status: GOOD (  21.14  )
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

The thing is that after device_initialize is called the reference
count for the device is equal to 1. Now the function also calls
nvme_get_ctrl which increases the ref-count to 2.
However the teardown path only accounts for 1 decrement. This means
that if an error were to occur during nvme_init_ctrl, we would return
from nvme_probe without having freed the resources of the controller.

On Mon, 3 Apr 2023 at 07:22, Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
>
> On 4/3/23 03:41, Irvin Cote wrote:
> > Correcting the de-reference count for
> > the controller in the core layer to avoid
> > a memory leak.
>
> Is this a regression?
>
> > Also cleaning a bit the teardown logic of nvme_init_ctrl.
>
> This is a good cleanup.
>
> >
> > Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
> > ---
> >   drivers/nvme/host/core.c | 14 ++++++--------
> >   1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 8698410aeb84..3d7aca7d0f2a 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -5137,14 +5137,12 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
> >       BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
> >                       PAGE_SIZE);
> >       ctrl->discard_page = alloc_page(GFP_KERNEL);
> > -     if (!ctrl->discard_page) {
> > -             ret = -ENOMEM;
> > -             goto out;
> > -     }
> > +     if (!ctrl->discard_page)
> > +             return -ENOMEM;
> >
> >       ret = ida_alloc(&nvme_instance_ida, GFP_KERNEL);
> >       if (ret < 0)
> > -             goto out;
> > +             goto out_free_page;
> >       ctrl->instance = ret;
> >
> >       device_initialize(&ctrl->ctrl_device);
> > @@ -5191,10 +5189,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
> >       nvme_put_ctrl(ctrl);
> >       kfree_const(ctrl->device->kobj.name);
> >   out_release_instance:
> > +     nvme_put_ctrl(ctrl);
> >       ida_free(&nvme_instance_ida, ctrl->instance);
> > -out:
> > -     if (ctrl->discard_page)
> > -             __free_page(ctrl->discard_page);
> > +out_free_page:
> > +     __free_page(ctrl->discard_page);
> >       return ret;
> >   }
> >   EXPORT_SYMBOL_GPL(nvme_init_ctrl);

