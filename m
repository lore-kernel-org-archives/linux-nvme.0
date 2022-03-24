Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2920C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 17:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/C6Wi8+apkAa+z6xDNWFQEkIKBR1nPVWir8FvzltVcE=; b=DXj4qQsoA9qwMdZeh7o6pVXMGQ
	kBnLeplX7sDAUVLNgfwHsMYo0rn0Mrugq5NBGRmHxvAcwf3BlV33MXtKPNbKYRbM7Sjo0KGs3iWjz
	nyXLIh7Jna0D2htDvriu5aGkblnMIDfTuGWM7Cir0dTana3aZXlqTPqEnhldw4rz8752qtNYeBhzl
	Pfyn3LvCYKKw39E77TZvaKiFNVkUt74DuXmUlNfMMCNNBnnR6fzqogaQ2w6GBg89PWWYHJwm1uZxz
	pShNAP7K6Iar+Qoyn5KdaXo/t6xki1GVv1oT1auU7Qc30J/LNEvDLk4yzTJrurp/C01qwv5IgJiaP
	QDpGcVQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXRXK-00HQ42-A3; Thu, 24 Mar 2022 17:46:14 +0000
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXRWn-00HPjg-1M
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 17:45:42 +0000
Received: by mail-lf1-x134.google.com with SMTP id bt26so9336916lfb.3
 for <linux-nvme@lists.infradead.org>; Thu, 24 Mar 2022 10:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/C6Wi8+apkAa+z6xDNWFQEkIKBR1nPVWir8FvzltVcE=;
 b=I7bHlwMO0+f0zK0CXx5nTJxPc40eEjCuRLHcKBBftFa39fYh5SyIT6X82M8exBfiQJ
 ZkFEmdDs2nmuxd++MxGwF0+xsZ6f9syPSL3/A9HV/XUeDpbDXt1uvpP3gQnZKKb6Hoev
 I5R78+QLii543xhcz2fndbWH26D0v4PcJgQDt/5KCaFRmPXzY2MdVAmLGmTH+pDb5ux3
 yTZTMY6RYtCbPQNeie4eExtqxpcupb6ilqamE78pQPV6ECflFjDKMBYfpy46uiHFsBqc
 2rVAdR/QaYIh1CUQSp709+f7ZVqx+KNbNxyQX5dIkJjvUp2zJaffqa3xf5x/yRfDIKow
 NS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/C6Wi8+apkAa+z6xDNWFQEkIKBR1nPVWir8FvzltVcE=;
 b=Hq78N95DAJqOUul91/bQCQ+DyecUCUO4JydE34CNK6x6DLd9fSVepmgqbYWWD//x/c
 XfHT2+44NfGPNh1xynfQ21rfJkpXbSMav9aB0OXXTd6hS3ayaMPsFTtriP8WkQFo/a3V
 DljBx7GanoUql3Rs8as097AIyRX0JdStcWSWRW9X0qwXJze+dJgDLc+PU0pWhI9YyZVT
 F8pm+AHn0zn/sNmp1wzx/NYPW7P3wJgK7jQJTFv8D8BDNNXYGWcYvO7lBfWKN0zfFjoM
 e2GeG9uGNgibM3OqKpc0EEPXCjrM+wKuFc9Z2fA7kZ5Tl07JcgiMcXgf9F3TlgII3WNx
 yRFA==
X-Gm-Message-State: AOAM531gZz0M4DWTLXmBelYHezwJleg5MSzM/9RWI3FztACGaUBZth0/
 jWddM+VAHa0saz82Ok5ynCUcvIC2ZFoWktmtWsc=
X-Google-Smtp-Source: ABdhPJw3jE5bSMu2B/HgrDHj58EGXBtoUdyv0j3Jg45FwJ4h7wj3tyj6OLthkCoZbG/3dwSMNRXVSitCwaW7deOA0N4=
X-Received: by 2002:a05:6512:3a95:b0:44a:6189:dad1 with SMTP id
 q21-20020a0565123a9500b0044a6189dad1mr2991299lfu.334.1648143938391; Thu, 24
 Mar 2022 10:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152702epcas5p1eb1880e024ac8b9531c85a82f31a4e78@epcas5p1.samsung.com>
 <20220308152105.309618-6-joshi.k@samsung.com> <20220311070148.GA17881@lst.de>
 <20220314162356.GA13902@test-zns> <20220315085410.GA4132@lst.de>
 <20220316072727.GA2104@test-zns> <20220324062246.GB12519@lst.de>
In-Reply-To: <20220324062246.GB12519@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 24 Mar 2022 23:15:12 +0530
Message-ID: <CA+1E3rJ6=t3DfcqMvpMpTM9jOk=LMq3qnspbcPXkmqbTGVOc_A@mail.gmail.com>
Subject: Re: [PATCH 05/17] nvme: wire-up support for async-passthru on
 char-device.
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
 Keith Busch <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220324_104541_114482_E65D283C 
X-CRM114-Status: GOOD (  18.74  )
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

On Thu, Mar 24, 2022 at 11:52 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Mar 16, 2022 at 12:57:27PM +0530, Kanchan Joshi wrote:
> > So what is the picture that you have in mind for struct io_uring_cmd?
> > Moving meta fields out makes it look like this -
>
>
> > @@ -28,7 +28,10 @@ struct io_uring_cmd {
> >        u32             cmd_op;
> >        u16             cmd_len;
> >        u16             unused;
> > -       u8              pdu[28]; /* available inline for free use */
> > +       void __user     *meta_buffer; /* nvme pt specific */
> > +       u32             meta_len; /* nvme pt specific */
> > +       u8              pdu[16]; /* available inline for free use */
> > +
> > };
> > And corresponding nvme 16 byte pdu - struct nvme_uring_cmd_pdu {
> > -       u32 meta_len;
> >        union {
> >                struct bio *bio;
> >                struct request *req;
> >        };
> >        void *meta; /* kernel-resident buffer */
> > -       void __user *meta_buffer;
> > } __packed;
>
> No, I'd also move the meta field (and call it meta_buffer) to
> struct io_uring_cmd, and replace the pdu array with a simple
>
>         void *private;

That clears up. Can go that route, but the tradeoff is -
while we clean up one casting in nvme, we end up making async-cmd way
too nvme-passthrough specific.
People have talked about using async-cmd for other use cases; Darrick
mentioned using for xfs-scrub, and Luis had some ideas (other than
nvme) too.

The pdu array of 28 bytes is being used to avoid fast path
allocations. It got reduced to 8 bytes, and that is fine for one
nvme-ioctl as we moved other fields out.
But for other use-cases, 8 bytes of generic space may not be enough to
help with fast-path allocations.

