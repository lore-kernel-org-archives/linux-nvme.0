Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C38C77B7C
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 12:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2tDfXQ17FO7BOQj7+ESY06ETyUTlemE288YQq2nrYcU=; b=MBQUQL9+KNGlue2mTXeVv5+B98
	1nwcP7yz2fhR2r7R4T6sjpe4pThG3xv/Qao4OZPBvrRTS+MAIVbMIJzWpVddM4bVBKNmHW5AgUIy+
	hy4W8R2Wv5QzqnZG8AwhxbOTWllareVvqILbl+IOj6LmJugY+1Ie1Y4FBGoByqOw6W5+7SrvnCY1Q
	IW5T1D8csiP0/oMBURA1xtiR9XQG/dAcffxXNMIoonxOykgy0LA4WvuPLBPCaqn6WiMzTnB/ArCeQ
	/Gw9XiiIG1AEk61y9iVsp1Stn7tO1AqHQOAOTVimXvztP027XR2YALEIWIJYPbd60q6q/xqllFsXQ
	FUwHvfqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1px54A-008i3M-0d;
	Thu, 11 May 2023 12:06:38 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1px547-008i2N-1n
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 12:06:37 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9660af2499dso1268061766b.0
        for <linux-nvme@lists.infradead.org>; Thu, 11 May 2023 05:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683806791; x=1686398791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tDfXQ17FO7BOQj7+ESY06ETyUTlemE288YQq2nrYcU=;
        b=jbI88sNpPdUELvvFxsUTjkocAebLsvf95+U/8NHHX/pJvUND+kMggu0ip00C9fLHW3
         Sr00b7xjjhTkvvT16eK9VLhjAc2/n5gSxn1ZBsc2D9snJt/WMj3vv7/e0h7/7LGTarfq
         rzKcRql09iF6sqmFS6xDgNR8RclAqTpY7WQdZDQcqBooYjV4ijtzGTvpDcsWbe4/7yeI
         Ygcbswr7MJAm2agnKxHM3GxOf1IG0++tStjs7U/EHFTQN6nLOIru+hGV/143e4J5a1Kt
         MUQ+ILA696hZm94i+PaymfHWPSvY0e3Oi1cn9Q4WMlgyTOfbp9D7m5cJjY+7DuquofJW
         OAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683806791; x=1686398791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tDfXQ17FO7BOQj7+ESY06ETyUTlemE288YQq2nrYcU=;
        b=e3LF7LmdXifCf0guNAS2Z+uFQ8+rvdlszT8p557x+uNCBvlgJsTzJUwVQrUh0LuDxy
         RPrZYkilqTnqmXalofMOl/j814dtK5Vncp8oFwmeDt98Q3lqMcI0cIisgKfpjoy+zHbw
         yIYBL7um9bCDFEo7PJ7pdiES6mSGkiku7n34mmmHM9d+7M1NrsyryA5e3PPa6UdC+IY3
         ve0YhzMumejJbogPIvkShQxFgVYOIE8XJCaHwb5pGp9xsYbrtnSb0wcpaU8NFPblHFHi
         IyHAJ5cXEgI0/C8sRMBT5VA/iD1b4hRM42ZjhlpP8roCU9GN8Andg7cD/ereI5rNUBdQ
         JPVw==
X-Gm-Message-State: AC+VfDxjEGLSp19oMnqRVlb8/dfbkdJsSYoYP1NmswhYxLggokG/fmMG
	98X6wBReXkKt4xK12oL4s5mpI+4KYG9Y5lbHCio=
X-Google-Smtp-Source: ACHHUZ60+xojJ+RF7byu2Sar29A3i4lAnC4JlYOPqe+rUOFHFfM22cKd8y41fY8EeH1nbgJXNHR16+LwNdR9w90VWHw=
X-Received: by 2002:a17:907:2d09:b0:966:4d75:4a44 with SMTP id
 gs9-20020a1709072d0900b009664d754a44mr14333819ejc.24.1683806790925; Thu, 11
 May 2023 05:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230421080800.18837-1-adrianhuang0701@gmail.com>
 <20230503161759.GA1614@lst.de> <ZFvgz5VgVGEmyAuj@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZFvgz5VgVGEmyAuj@kbusch-mbp.dhcp.thefacebook.com>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Thu, 11 May 2023 20:06:19 +0800
Message-ID: <CAHKZfL3Pbv76fqF6Dn8NHbMn7oQ=G02azU-=meLwAKMFPi+jbg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] nvme-pci: clamp max_hw_sectors based on DMA
 optimized limitation
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>, 
	Sagi Grimberg <sagi@grimberg.me>, iommu@lists.linux.dev, Jiwei Sun <sunjw10@lenovo.com>, 
	Adrian Huang <ahuang12@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_050635_617328_54DE6050 
X-CRM114-Status: GOOD (  16.53  )
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

On Thu, May 11, 2023 at 2:22=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Wed, May 03, 2023 at 06:17:59PM +0200, Christoph Hellwig wrote:
> > dma_opt_mapping_size falls back to and is bound by dma_max_mapping_size=
.
> > So I think we could just do this:
>
> Thanks for discoverying this even futher simplifaction. This looks good
> to me.
>
> Adrian, are you okay with the suggestion?

Yes. This looks good to me. I like this simplicity.

Thanks for Christoph's changes.

> > @@ -2956,7 +2956,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct=
 pci_dev *pdev,
> >        * over a single page.
> >        */
> >       dev->ctrl.max_hw_sectors =3D min_t(u32,
> > -             NVME_MAX_KB_SZ << 1, dma_max_mapping_size(&pdev->dev) >> =
9);
> > +             NVME_MAX_KB_SZ << 1, dma_opt_mapping_size(&pdev->dev) >> =
9);
> >       dev->ctrl.max_segments =3D NVME_MAX_SEGS;
> >
> >       /*

