Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB6FC43334
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jun 2022 07:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p4rjnES2y9zuUXgrH8SoYJpITOhHCu5+HvhhFNmLvrs=; b=Fr9cFsDVSOZZee34GqpmE+7QMV
	9vHvJAPEb3nSEY4VrkVJZIkG9de2Ok1o40KhsMctre/nfl5SkePrDxoIWFTxCqUNqs90bq8FUOj/w
	dci4aKOl+jpshcMux62N238W5iE6teCv3rCd0oiAGkGRC2Hu9orsCZ1lcvfjbHhEpiUt5DnnrEa01
	hhS2OxaYoEK/wjF9I87qUPViteAhXSsO/oxhtZi73JGuZpVzysn4e2wB1XQNL1D+dtRr6XYlepYwF
	umPJVcU4Gatoy5pgSTEINfJgeUQJQ4ZH7rwRnpX6BVAz2fRRd8tw92ASnbs0DT6YKywXzhGt3JqIJ
	wfOzD4QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzCtO-00HXjb-G2; Thu, 09 Jun 2022 07:47:46 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzCtE-00HXXV-Nq
	for linux-nvme@lists.infradead.org; Thu, 09 Jun 2022 07:47:38 +0000
Received: by mail-ed1-x52e.google.com with SMTP id fd25so30092050edb.3
        for <linux-nvme@lists.infradead.org>; Thu, 09 Jun 2022 00:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p4rjnES2y9zuUXgrH8SoYJpITOhHCu5+HvhhFNmLvrs=;
        b=eJndH48XK/iAnfSAtOq7BYtVgz8PVd8VYYl3gRd8LAZAauKcP/2aRGfqualNWU14CR
         cg8eIFXfkjb5gYYQz08ooAzn5h0IyDZNMv6HAGrtrr5G1By2YZT9+pKEgOHNz7A3rmYw
         +i24s/1owZA6iVH6InYgMf/2eakYB4nn+mkmGITKp44cxaChd2jtanPTaxhx+tcabAqV
         r9daPd8EbnJ0vTzaFBwsRBrqMpUUMce2HSnIS4dcn8R1Nj4f3MWCncdkDE5QLROr2fwI
         Ls/az7zlN+iZvUtvsgY5Q1UdnllSeUZqP2aYOVJqLebOUusBtVj6YdaXxegdxHRp6Fg/
         aAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p4rjnES2y9zuUXgrH8SoYJpITOhHCu5+HvhhFNmLvrs=;
        b=Me4Tgbf/41D9nHZeMdbyORiCGW7ruOAX34Bdc4r+f2p7KU/81ODbu6VdHlSx7ZA+et
         02gw5dgZlFZ8Y3cGHVV6QH+QSM3j3Vmh51DHVxTTn8o5GRzVcFupJMdsH5HGqE1IRhe0
         /+jkzY04PZ35ypmULvfZUtrqXLq+p2vNbNPtRCZH7e4SvN2rP2gaJk64V7WJFwbLwrgA
         2x/wFS3ci7v9GInKcbJfiw4BBttR1/eDqALmUKYiSZv4wspLJz8ipAWsOTvZqRJA/59E
         r3Fj20DeBgQpdBS2k/ExUiuxUZbAwHy2XtLAmf3TmdRDMG+2LUEmZaAxCu8KwKApjOzQ
         HWIA==
X-Gm-Message-State: AOAM531eHRQCFhs+Qz3babbh5mO5eoIyYZzKPGHBQr6BmLa+KZSUtmoO
	e0erDIbMRLFbxD989MV14gBlQMFgztCfUTHnLMEijKmeeOc=
X-Google-Smtp-Source: ABdhPJweOQDm12Rr9v9rrL2Lden8l5bvFzB/F9jaPz4PYfH5azCtumo+59vh0yLwD2HAZ4pAkjiBj52NYzUHORYLcVc=
X-Received: by 2002:a05:6402:3688:b0:42d:d3ba:4725 with SMTP id
 ej8-20020a056402368800b0042dd3ba4725mr44044356edb.212.1654760851964; Thu, 09
 Jun 2022 00:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAMGffEmx1xk1MP30NTzn1tcS27Mc5fVudnkfYeqJrOxs_HYZfQ@mail.gmail.com>
 <9d630d8c-f872-ebf5-2ccd-b7097e726ca9@nvidia.com>
In-Reply-To: <9d630d8c-f872-ebf5-2ccd-b7097e726ca9@nvidia.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 9 Jun 2022 09:47:21 +0200
Message-ID: <CAMGffEk2-sEezeyKpn058DrR=4aSncJmTHysmL5GO1gxd62neA@mail.gmail.com>
Subject: Re: [BUG]LTS 5.10 regression NULL pointer deref in nvme_ioctl
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220609_004736_914529_A6E7CA31 
X-CRM114-Status: GOOD (  12.41  )
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

On Thu, Jun 9, 2022 at 2:32 AM Chaitanya Kulkarni <chaitanyak@nvidia.com> wrote:
>
> On 6/8/22 01:02, Jinpu Wang wrote:
> > Hi folks on nvme list,
> >
> > We hitt the following crash when run "nvme list" on kernel 5.10.115:
> >
> >      /build/ionos-linux-pOGXys/ionos-linux-5.10.42/arch/x86/kernel/dumpstack.c:
> > 359
> >
> >   #4 [ffffa80c7a5c7d10] no_context at ffffffffa7062467
> >
> >      /build/ionos-linux-pOGXys/ionos-linux-5.10.42/arch/x86/mm/fault.c: 754
> >
> >   #5 [ffffa80c7a5c7d78] exc_page_fault at ffffffffa77c919e
> >
> >      /build/ionos-linux-pOGXys/ionos-linux-5.10.42/arch/x86/mm/fault.c: 1327
> >
> >   #6 [ffffa80c7a5c7dd0] asm_exc_page_fault at ffffffffa7800a6e
> >
> >      /build/ionos-linux-pOGXys/ionos-linux-5.10.42/./arch/x86/include/asm/idtentry.h:
> > 571
> >
> >   #7 [ffffa80c7a5c7e58] nvme_ioctl at ffffffffc10c1038 [nvme_core]
> >
> >      /build/ionos-linux-pOGXys/ionos-linux-5.10.42/drivers/nvme/host/nvme.h: 609
> >
> >   #8 [ffffa80c7a5c7ec0] blkdev_ioctl at ffffffffa73f6bc5
> >
> >      /build/ionos-linux-pOGXys/ionos-linux-5.10.42/block/ioctl.c: 237
> >
> >   #9 [ffffa80c7a5c7f08] block_ioctl at ffffffffa72c3329
> >
> >      /build/ionos-linux-pOGXys/ionos-linux-5.10.42/fs/block_dev.c: 1893
> >
> > #10 [ffffa80c7a5c7f10] __x64_sys_ioctl at ffffffffa7292fe4
> >
> >      /build/ionos-linux-pOGXys/ionos-linux-5.10.42/fs/ioctl.c: 49
> >
> >
> >
> > 607 static inline void nvme_get_ctrl(struct nvme_ctrl *ctrl)
> >
> > 608 {
> >
> > 609         get_device(ctrl->device);
> >
> > 610 }
> > The same commands works on kernel 5.4.
> >
> > kernel 5.10 panic while processing nvme2 which is  a bit different.
> >
>
> Did you try if it works on the latest kernel ?
I just tried with 5.15.32, it works there, so it's just a regression
already fixed later.
>
> -ck
>
>

