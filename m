Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ABEC07E99
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 15:14:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6EC361966
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 15:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6EC361966
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HvVhhmB7d8iEA4bU2gqnBdfYecLboCU/QgtDhHIw6Dw=; b=NXdZxATNDSvg5k
	MXjRQZ7BcuWdGuuFbgc7i9yj1sC7RA2JE+NIQsqG9uwZ1c4/T9W/ks9R7t69q7HeSFxKGQ1YibMHW
	2lBAVXuTB92eg9z0N/Zj5JXoRLo8lrL2WTGXpb533o5EfumvemFs7tFqIo1Fg1JVjmlmZvsg8ii4Z
	UzhwkJNXV2TLI1p3WsBjxSuPhYyhMMkBfSjCLDTUIdswcy1PWhc4FitBg1s+cFcUgmdfALHO3C3XS
	n5huEcnllUzVkcK1VWyHmyv1niq/L7wQ160XGafKYaDdW4qwpum/X29DP2TGQ7fgHsvqh+kx2ODMi
	DfHjKRagyZ1WIWhSFffw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0QIH-009IyY-Pw; Mon, 05 Jul 2021 15:13:57 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0QIA-009IwJ-Oc
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 15:13:56 +0000
Received: by mail-pj1-x102c.google.com with SMTP id
 cx9-20020a17090afd89b0290170a3e085edso163630pjb.0
 for <linux-nvme@lists.infradead.org>; Mon, 05 Jul 2021 08:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tbxDZ9fdqnufcCUG35g70ViZ0ewXUlgGUaE0TT68B00=;
 b=p0Sk3+G6KXxx5N2AaII50FrmvloUNjGPJwjDJs492cyjHRnMwrF5Ga+BUbQFRw2I0R
 //57lAvXxM14RVXRWIny88NrzKrgRNUbGsf8VJvbu8j8OyIleS3ii6Paywk32F9ggA0H
 yEriS8tWIuO42U/N/+WG2pq0Q3mGmyPVTFYCgCi30CzKCFYjuK9Ydp9oL2CD4R0y+yRg
 9Yz0SEJv23SmFHyQyM5Wj/YHvX0+bWrTVMt0wLfyuJ/yk6+TwrKSrxSmAYP1BiQ+d4yr
 +YKdwFnPNEtG9FisXendXX6lr71k6wUVoel/cRlFPZlYoewhrr5zKbi4yS56ELx17rXi
 n/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tbxDZ9fdqnufcCUG35g70ViZ0ewXUlgGUaE0TT68B00=;
 b=t9qMZ+qaEfpZ/uCq1Gn4DpFoEVGBHqBTQVluFyKNyMPvZDbDlEfMJYDsWslXmBnueY
 x2Gid174VxsJ/88jsPovcoVgVjWN2+wSv/6nSey4NCYjlx1ARWAdIiMmHrEFxi66DxFL
 LAb3gCSeCjHYC8AdGiLsxR02Fve5+5h4y7X6u5iM7gq+PvmvzQVd+VwquVvC5diPH6GW
 7Lmt4DmhDLbGZplQkSc3bA3I7JbNfPPikJZojCdAUCCQ6DqKQzLcvOgprEUt5e/cURfm
 eJqj6pn1Tw/djzQWptxGuJw0l2jhEj2q0JZEyl8StoachCJJW1zs52pOy9cdb+CVJzMp
 hXZw==
X-Gm-Message-State: AOAM5318Tfov8cEKPZY6FB00HzX//XBJ3ECJ5Q7paaQ9ayWa0DLecqk5
 8+kKLCUua8LTWvAfHd5VrHPHk/Zqb8VAI+zXe24=
X-Google-Smtp-Source: ABdhPJwZSO/6gWcDJSdht2/EOq0Y5ENc+L4SOtC0b+rR8ZpvE5TEOgR+cpU0sRmVaPYgdBa7a9rw7IihJqndvYBCay8=
X-Received: by 2002:a17:90b:94c:: with SMTP id
 dw12mr15823167pjb.17.1625498030084; 
 Mon, 05 Jul 2021 08:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210629124743.6898-1-pkushwaha@marvell.com>
 <20210629124743.6898-11-pkushwaha@marvell.com>
 <20210701134850.GA20739@lst.de>
In-Reply-To: <20210701134850.GA20739@lst.de>
From: Shai Malin <malin1024@gmail.com>
Date: Mon, 5 Jul 2021 18:13:39 +0300
Message-ID: <CAKKgK4wVWb1wuf3wOwyUqAK=1k9XNrswK7URy9RH4T=QB=Nh5A@mail.gmail.com>
Subject: Re: [PATCH v4 10/20] qedn: Add qedn probe
To: Christoph Hellwig <hch@lst.de>
Cc: Prabhakar Kushwaha <pkushwaha@marvell.com>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, axboe@fb.com, Keith Busch <kbusch@kernel.org>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Shai Malin <smalin@marvell.com>, 
 Ariel Elior <aelior@marvell.com>, Michal Kalderon <mkalderon@marvell.com>,
 okulkarni@marvell.com, 
 prabhakar.pkin@gmail.com, Dean Balandin <dbalandin@marvell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_081350_883158_3B005CE9 
X-CRM114-Status: GOOD (  24.45  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 1 Jul 2021 at 16:48, Christoph Hellwig <hch@lst.de> wrote:
> On Tue, Jun 29, 2021 at 03:47:33PM +0300, Prabhakar Kushwaha wrote:
> > From: Shai Malin <smalin@marvell.com>
> >
> > This patch introduces the functionality of loading and unloading
> > physical function.
> > qedn_probe() loads the offload device PF(physical function), and
> > initialize the HW and the FW with the PF parameters using the
> > HW ops->qed_nvmetcp_ops, which are similar to other "qed_*_ops" which
> > are used by the qede, qedr, qedf and qedi device drivers.
> > qedn_remove() unloads the offload device PF, re-initialize the HW and
> > the FW with the PF parameters.
> >
> > The struct qedn_ctx is per PF container for PF-specific attributes and
> > resources.
> >
> > Acked-by: Igor Russkikh <irusskikh@marvell.com>
> > Signed-off-by: Dean Balandin <dbalandin@marvell.com>
> > Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> > Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
> > Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> > Signed-off-by: Ariel Elior <aelior@marvell.com>
> > Signed-off-by: Shai Malin <smalin@marvell.com>
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > ---
> >  drivers/nvme/hw/Kconfig          |   1 +
> >  drivers/nvme/hw/qedn/qedn.h      |  26 ++++++
> >  drivers/nvme/hw/qedn/qedn_main.c | 155 ++++++++++++++++++++++++++++++-
> >  3 files changed, 177 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/nvme/hw/Kconfig b/drivers/nvme/hw/Kconfig
> > index 374f1f9dbd3d..91b1bd6f07d8 100644
> > --- a/drivers/nvme/hw/Kconfig
> > +++ b/drivers/nvme/hw/Kconfig
> > @@ -2,6 +2,7 @@
> >  config NVME_QEDN
> >       tristate "Marvell NVM Express over Fabrics TCP offload"
> >       depends on NVME_TCP_OFFLOAD
> > +     select QED_NVMETCP
>
> This makes kconfig unhappy:
>
> WARNING: unmet direct dependencies detected for QED_NVMETCP
>   Depends on [n]: NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_QLOGIC [=n]
>   Selected by [y]:
>   - NVME_QEDN [=y] && NVME_TCP_OFFLOAD [=y]
>
> While we're at unhappy:  without pinpointing it to the pointlessly
> split patches, this series generates tons of sparse warnings:
>

Sorry about that. Will be fixed.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
