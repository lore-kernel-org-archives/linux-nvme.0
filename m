Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F89C30653
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 14:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lQHiKheUZkHn50AxjZouoKLxa6g4cpujt17k/BC4nOw=; b=CFXOOnfZ9l8AcnfAFbpjrmHrqE
	O49w5pMDVdvpzZcQj0nztv0RXb2INGpFiwCPLPWKgByFi3Ziib1ZHNS3o2165FLJ296FNayJDgk/1
	mTNOGSNCVpkPXxks1hdfmFkGr9SIF/u1ocQo1VIFWhRuiMHHIAnrK+Iv27INucEVVPPVfvibZnKwD
	3a5GM7c1DFtTz1BKhp+tBIzi9YafOIgO1GVu0zkkwp0l502n1LgfxmM56k4vi4kpINRy/oKvkTPq2
	VK8tvBHc8OfIrCfZ1NeaHrHWmESs4s9Ho5GvugVq9LZA5sFFAWvHPLe3efwQlgf0KMfhL4tV8TcNJ
	cubKMKPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOHjD-00000003el2-2tZE;
	Mon, 01 Jul 2024 14:09:59 +0000
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOHjA-00000003ekH-33Fd
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jul 2024 14:09:58 +0000
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5c219c54800so1458645eaf.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jul 2024 07:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719842995; x=1720447795; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQHiKheUZkHn50AxjZouoKLxa6g4cpujt17k/BC4nOw=;
        b=YzGiNNiuJlMARAAvc3v6R3+iMkMCcKSwKtLa5P/NFbkNrJhmiLKexHrkfIPOkXM/iD
         XhAKtUtXeA+YU6FEsxBhESdE2ZUNwqjjkJW+QlXtvkMgIpMTtSrYIeEZVZ60MNwovY8R
         wJUHBagEX67E6GMRxPHdc/feaaZuRuR35mQy+5Xtw9x1sByIUZMDJID30VHVhBIg2XJA
         iWavvaGdbJMYYYgb1kEcfOWqFUyc58nry/c4S9h535GCIwGikyjpGClx7ubYZT0Ik0No
         0b6aWbNoE9CrpfmAxfI9QKdLYzoPeaB9+spFmH3JgFdZqfrdWXKPPslJzH0pp0cacbWl
         GnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719842995; x=1720447795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQHiKheUZkHn50AxjZouoKLxa6g4cpujt17k/BC4nOw=;
        b=EKwP3/1bCulLAsF9VeMqwaA3lyE+HUGeMbTK6d8KAuMq5UQ+ARpS1kh9A38s5fHHdN
         znPoy+wSseo/Irhq7fEg4UQuEDrfKPImDPfstBqCFafbO7FDB6MGiPlo+k1Zq7fkBHDq
         9x95p32Rj97rQPgskS4wRnE8UWRQJeMUjDIdqLEWa4lIKv/MVxdLMamdG5gYXv7MNvys
         yM/dfFbZWhSU0WoxzZO3p/HNi7w+gEJcI8XvlD8MoAzS4aciBObnshH1AzPelGJFKe1z
         w1sKExPW7nVhEbnQlKCUeIaz5I1YNs8jFCmll/vqCGsvUCae+aENmmUXnBd4b4emEMde
         hcyA==
X-Forwarded-Encrypted: i=1; AJvYcCWNpfvydo8uMfMWd92DW0Zh5loZs5HF5zs1WNt22+OtJmIn3vcCamJPAD2t0TDT/E1BZbOhmiywsdzrGPprfQOBG4wWL1Qvg2SXRdozXfw=
X-Gm-Message-State: AOJu0YwWUwTsij4hn8p7YiKfMwaoc+o6SqH+0NzbwW4CRSDf91KLI3yM
	tmXBRIO8NU1GCHDU/ymZ3JXq3TP03EbZWJhaUzi6gpvZKPxDRCLYYgwhmArzbyDjsbwR3GuzZab
	5R0/22+aiBAsArsBGsgDCiNgAEA==
X-Google-Smtp-Source: AGHT+IE8TG4svOSi6+jhYYnyW+u67ovSQnNVXF3NuZm79i2x0GD967K06PjxyjiYGXymjIv5LSLiODSMfh0keRpyC1E=
X-Received: by 2002:a05:6358:2910:b0:1a6:a960:4787 with SMTP id
 e5c5f4694b2df-1a6acf43eb3mr630619755d.20.1719842994996; Mon, 01 Jul 2024
 07:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240626100700.3629-1-anuj20.g@samsung.com> <CGME20240626101525epcas5p4dbcef84714e4e9214b951fe2ff649521@epcas5p4.samsung.com>
 <20240626100700.3629-9-anuj20.g@samsung.com> <87y16rmxnb.fsf@mailhost.krisman.be>
In-Reply-To: <87y16rmxnb.fsf@mailhost.krisman.be>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 1 Jul 2024 19:39:17 +0530
Message-ID: <CACzX3AtdWHCp7hCCMKyb-qkxFLZKFPn3qiib5W-=0-qtKSgbxw@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] io_uring/rw: add support to send meta along with read/write
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Anuj Gupta <anuj20.g@samsung.com>, asml.silence@gmail.com, mpatocka@redhat.com, 
	axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, martin.petersen@oracle.com, 
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_070956_790344_5C22FC51 
X-CRM114-Status: GOOD (  16.50  )
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

On Wed, Jun 26, 2024 at 10:47=E2=80=AFPM Gabriel Krisman Bertazi
<krisman@suse.de> wrote:
>
> Anuj Gupta <anuj20.g@samsung.com> writes:
>
> >  static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe =
*sqe,
> >                     int ddir, bool do_import)
> >  {
> > @@ -269,11 +307,16 @@ static int io_prep_rw(struct io_kiocb *req, const=
 struct io_uring_sqe *sqe,
> >               rw->kiocb.ki_ioprio =3D get_current_ioprio();
> >       }
> >       rw->kiocb.dio_complete =3D NULL;
> > +     rw->kiocb.ki_flags =3D 0;
> >
> >       rw->addr =3D READ_ONCE(sqe->addr);
> >       rw->len =3D READ_ONCE(sqe->len);
> >       rw->flags =3D READ_ONCE(sqe->rw_flags);
> > -     return io_prep_rw_setup(req, ddir, do_import);
> > +     ret =3D io_prep_rw_setup(req, ddir, do_import);
> > +
> > +     if (unlikely(req->ctx->flags & IORING_SETUP_SQE128 && !ret))
> > +             ret =3D io_prep_rw_meta(req, sqe, rw, ddir);
> > +     return ret;
>
> Would it be useful to have a flag to differentiate a malformed SQE from
> a SQE with io_uring_meta, instead of assuming sqe->cmd has it? We don't
> check for addr3 at the moment and differently from uring_cmd, userspace
> will be mixing writes commands with and without metadata to different
> files, so it would be useful to catch that.
>
Yes, but I couldn't find a good place to keep that flag. sqe->rw_flags are =
RWF
flags and are meant for generic read/write. sqe->flags are generic io_uring
flags and are not opcode specific. Do you see a place where this flag
could fit in?

> --
> Gabriel Krisman Bertazi
>
--
Anuj Gupta

