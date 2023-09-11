Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6282EEE57DF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Sep 2023 05:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mddRx9TAqSRMsMPN4p3Vnm+hCIKQPnvIVc3OSLx1r8E=; b=3Yxdd3GgGJ5CJP/9Ym+012Q/w6
	nkZgV7BnNemRK+1vKAnr+88WNvrU45On12JeF4qa0yIez6mGiISVHMGnnoG48kAgVNZ8mTU7YQyZS
	Xzxu9SnvnFeMS3o216hakFF9AASuEg9msfBRQ9PmnUwPlcBjyCLIaFXBtqWHU7iVOGwwsnR0/PzpT
	BnsqlLhFw6yq9H8EIIINJsWRXjAtvkehZs+o6v5ZYhFOI5yeLrx1q1gPA08QjheIcT4MfExAWVJTy
	BA/AnT5jV/uoi1yTFHFmJcNZmbfxbv918mhHM/WYSJ5YGGLMLVcp8nEUbtOr4soR7yT7btjbqjfqf
	CAVPMWvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfZso-00HHly-2b;
	Mon, 11 Sep 2023 05:54:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfZsm-00HHl6-0P
	for linux-nvme@lists.infradead.org;
	Mon, 11 Sep 2023 05:54:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694411685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mddRx9TAqSRMsMPN4p3Vnm+hCIKQPnvIVc3OSLx1r8E=;
	b=HFUwjchEXZvAZL9u31rdP6ZXv9O0hcxn+wfifaRoRIc8Z6IIlg8lDAXP+ZcpcdhhYgvnT/
	lovTVG/oPOX7uo8uRJjQnFk1n1Ua02EBQ6MUvpLqM1tOhQGYAP2f3IFZ/4nVYFrQiHpNGv
	W+z1I16fRMCrY2NvFCtDGeGxVw3C+wo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-pek7hHUONEWF6UgmBjCIRg-1; Mon, 11 Sep 2023 01:54:43 -0400
X-MC-Unique: pek7hHUONEWF6UgmBjCIRg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-273f8487f53so2184320a91.1
        for <linux-nvme@lists.infradead.org>; Sun, 10 Sep 2023 22:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694411682; x=1695016482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mddRx9TAqSRMsMPN4p3Vnm+hCIKQPnvIVc3OSLx1r8E=;
        b=tiYW7/LwNajw/Q5sMsC8FMnkwbBOMVItcIPd93afObM7Nq99At8NSGFlSvSV1cKVfL
         NHA6C556+Kz0Zdm/lob1ovDFkJZjBV1BWO/ggXD1eTL+I5n3j2E2em7asS6P5gYRWRNJ
         3TX2pZEU0YODttrzavQ7AfrhckcFLHnrROdgpvLuLji6TzGfdy4tHoUP4b8WreUXVbbV
         5h4iIKq2LoB05mspKRwleKAkaR8Bfbd6HoXnQx9pn90l9UfKa0jPErtXTU1LcnjHvcI/
         OGkSRF/4M6E2GwLiNTYHYECbNlm/9BtI0QOKd/8bniX5K8bjWgH4Dv1BymIXMA0Kw8QG
         USqw==
X-Gm-Message-State: AOJu0Yy4hQ4t/DNCzc8icbaIrUArzzD/WYxKuawhW1S1i55E9lFQEJyJ
	zYOA2f/uSXIpjHcDp7lfhE7/PyN5ISAr8wOlRoAqdg8z33tLWFwORnaMh7NZFvB8+TzkW0iFxki
	8Lj1W+Pio3J9+RLo+I9MqB3C7g58J8RBG36qLRCj1RRI=
X-Received: by 2002:a17:90b:38c1:b0:262:f449:4497 with SMTP id nn1-20020a17090b38c100b00262f4494497mr8172712pjb.2.1694411682713;
        Sun, 10 Sep 2023 22:54:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOVhvWBZ/E4QHwrJrErqhIG48dfTYHKkmlSCxE/hxSMmUATo+/U5fqOt1szNDCMfTjC/TgtkCnFUpqYpkXLS0=
X-Received: by 2002:a17:90b:38c1:b0:262:f449:4497 with SMTP id
 nn1-20020a17090b38c100b00262f4494497mr8172706pjb.2.1694411682474; Sun, 10 Sep
 2023 22:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230726142939.10062-1-guoqing.jiang@linux.dev>
 <CAHj4cs9LppxseFzZe-fj7tDaeKd0x8t8Wr-aYcjXAU-8FyfoiQ@mail.gmail.com>
 <a403c942-5b1c-c7f7-243b-81545f7f83ad@linux.dev> <065d800d-8c6c-4257-ade2-9ffa92c36735@suse.de>
 <CAHj4cs_8iC5rn+xA7_bvRifE+1Uu9jjj0wHf=5EmuW7zvaxeYw@mail.gmail.com>
 <CAHj4cs_bn=mCiVu1ZhZYUhf950TsHzdLe4++9N2ebHsLq2YGwg@mail.gmail.com>
 <77c0f80d-cf77-4828-93ce-5cb06405ceac@suse.de> <CAHj4cs-3Mc0hjE1etM=EPHqcicdOHYw7MzwXb=nCnwQ+KhA9sQ@mail.gmail.com>
In-Reply-To: <CAHj4cs-3Mc0hjE1etM=EPHqcicdOHYw7MzwXb=nCnwQ+KhA9sQ@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 11 Sep 2023 13:54:31 +0800
Message-ID: <CAHj4cs_X-4c0KiKUYPqMc2rTCsnFwvRXrcM2WxJPHRHBeCYoSg@mail.gmail.com>
Subject: Re: [PATCH RFC] nvmet-tcp: add new workqueue to surpress lockdep warning
To: Hannes Reinecke <hare@suse.de>
Cc: Guoqing Jiang <guoqing.jiang@linux.dev>, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230910_225448_257092_95DBAE9A 
X-CRM114-Status: GOOD (  21.31  )
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

On Fri, Sep 8, 2023 at 5:00=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrote=
:
>
> On Fri, Sep 8, 2023 at 4:58=E2=80=AFPM Hannes Reinecke <hare@suse.de> wro=
te:
> >
> > On 9/8/23 10:44, Yi Zhang wrote:
> > > On Fri, Sep 8, 2023 at 4:09=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com>=
 wrote:
> > >>
> > >> On Fri, Sep 8, 2023 at 3:15=E2=80=AFPM Hannes Reinecke <hare@suse.de=
> wrote:
> > >>>
> > >>> On 9/7/23 10:12, Guoqing Jiang wrote:
> > >>>> Hi Yi,
> > >>>>
> > >>>> On 9/7/23 14:41, Yi Zhang wrote:
> > >>>>> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> > >>>>>
> > >>>>> Confirmed below issue was fixed by this patch:
> > >>>>
> > >>>> Thanks a lot for the test!
> > >>>>
> > >>>> And I had got another similar lockdep warning about nvmet-rdma.
> > >>>>
> > >>> Please note that this issue is fixed by my patch 'nvmet-tcp: avoid
> > >>> circular locking dependency on install_queue()' send earlier to thi=
s list.
> > >>>
> > >>> Can you please test with that one to see if it fixes the issue for =
you?

Hi Hannes

Confirmed the issue was fixed with your patch.

> > >
> > > Hi Hannes
> > > There are changes in nvmet_tcp_install_queue and the patch cannot be
> > > cleanly applied,
> > > Could you check it, Thanks.
> > >
> > On which tree?
>
> Sorry, I forgot to revert Guoqing's patch before, I can apply the patch n=
ow.
>
> >
> > Cheers,
> >
> > Hannes
> >
>
>
> --
> Best Regards,
>   Yi Zhang



--=20
Best Regards,
  Yi Zhang


