Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437E9C001B0
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 17:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KoOgtExPknyCjaZt6yFcpJm1OTXC8gB2XRIzfWFG1zw=; b=xvVsUU9x2kT6GZe0+Vpd/aZmyJ
	JssEwFEMdLDhwuL5LdjdbzvkaUpYsLcs6WOj1i3JDKhpktZumAYuj6soLmnDupzBpsBOsUb0Uj4YM
	OiDBRK9fqM59GszjvtW1nfan+EwL/OpKC/qsKVBh5fGiRBPD5UD3qHWlqTcxiEtYO6RnktuUmfDFj
	yVZcJg4uf/tw0TLiSRyYMeAElHY4v1UP59CU5/AdIcWzC6iBY8f1pTJsSeZT6T9CEaKN5Yre+dEpR
	5UmALX8qm29cQXRnelIjPaZ61uyZYrXXMTfsuzEg50oZxrKJbXuXFf3z7Jv3IHpTGBww5E5I9bDXg
	gTGWunIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVaxP-0000Lg-1d;
	Mon, 14 Aug 2023 17:02:19 +0000
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVaxN-0000Kd-1O
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 17:02:18 +0000
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d66f105634eso2057702276.1
        for <linux-nvme@lists.infradead.org>; Mon, 14 Aug 2023 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692032524; x=1692637324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoOgtExPknyCjaZt6yFcpJm1OTXC8gB2XRIzfWFG1zw=;
        b=XLYg47TzlIjv0bDM3AhmFaX0S1yOUGR0Ki1gyiGdT/2yEwVkM8/9mdaMTU37WM1DT6
         ExF1EsTqfg0PvHcTo77VcOpQ4jYwSM3nKmtdF0/FJ8Oxxy92UaKByZygEwud8PnWgjJZ
         E99louhXal4GvwauXD4HIZ+pIanBpSWe3BhzNKazqDdGMDiS5paRiXveT0ouptcFvmPa
         V+57PNGVpPVN42nGM58YFn43daZnIPF9eM2j1KwSKq0YOesYSdKHe9RXf7Fk0KuDXTy9
         c76wWof7WARoY8G2dxdDjgExCVaqoDIWuUNTx2SoQZO+kdGqvNBmzIuEeLU8kSgR5G8+
         mMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692032524; x=1692637324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoOgtExPknyCjaZt6yFcpJm1OTXC8gB2XRIzfWFG1zw=;
        b=j/hVplx9EskyRSfILqEcDpIe3MTS1sQjT/L8G93qrpZT+umbJqq6lNTUMKi64d0EbX
         6faQNG2vxPD8xMEkieYapxurijVK5AP+y5kd3CaVdYrV7ujbaKpAguqkZON3mkg1uoVZ
         bDCxgXy8EfqO0hPPH3JImGrPf3cZdf+e98MSJLpUcHmyRNuWQU+O4Ra1KwQeBnwBSJw4
         meNTx4rzDKIjPYx2Cn7xKOn+uaNxcjBVC0pcQY6VWJCsPmOCYQ9i/bvooD7aRCH2QRfs
         jmc0aKEUpNmSdw9k5LYXBi8yMrOKUf6cNL+n+zFxIqtgaq8V8+67g/rR2ffoOSAEbHym
         pjQA==
X-Gm-Message-State: AOJu0YzziNTGBZF0ypUYmFd5Sybq5mG0WiaNhGkQlw28y2RbAOcS2CRI
	wcfcdom0z2QYhiqUsD/OyZJSUThA5rYFgKYOjfI=
X-Google-Smtp-Source: AGHT+IG4bEDG0zFs6h8QgX1qJybvmoa2ss9LjkCZgljhQecK4wSD5P/FZmnDf7b05hg7BMMrprZPOZB2OS6moqWhAGI=
X-Received: by 2002:a25:2386:0:b0:d15:f337:938b with SMTP id
 j128-20020a252386000000b00d15f337938bmr8112041ybj.8.1692032524122; Mon, 14
 Aug 2023 10:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230811105300.15889-1-nj.shetty@samsung.com> <CGME20230811105659epcas5p1982eeaeb580c4cb9b23a29270945be08@epcas5p1.samsung.com>
 <20230811105300.15889-4-nj.shetty@samsung.com> <0899ddc3-d9c1-3d9a-3649-2b1add9b2a7f@acm.org>
In-Reply-To: <0899ddc3-d9c1-3d9a-3649-2b1add9b2a7f@acm.org>
From: Nitesh Shetty <nitheshshetty@gmail.com>
Date: Mon, 14 Aug 2023 22:31:53 +0530
Message-ID: <CAOSviJ2+tUZ=jiOnPSi8=mOzjANwvuNXAkAG6f3ADGi=M=F5PQ@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH v14 03/11] block: add copy offload support
To: Bart Van Assche <bvanassche@acm.org>
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, martin.petersen@oracle.com, 
	linux-doc@vger.kernel.org, gost.dev@samsung.com, 
	Anuj Gupta <anuj20.g@samsung.com>, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	mcgrof@kernel.org, dlemoal@kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_100217_467778_7689F5A2 
X-CRM114-Status: GOOD (  15.87  )
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

On Sat, Aug 12, 2023 at 3:10=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 8/11/23 03:52, Nitesh Shetty wrote:
> > + * Description:
> > + *   Copy source offset to destination offset within block device, usi=
ng
> > + *   device's native copy offload feature.
>
> Offloading the copy operation is not guaranteed so I think that needs to
> be reflected in the above comment.
>
Acked.
> > + *   We perform copy operation by sending 2 bio's.
> > + *   1. We take a plug and send a REQ_OP_COPY_SRC bio along with sourc=
e
> > + *   sector and length. Once this bio reaches request layer, we form a
> > + *   request and wait for dst bio to arrive.
>
> What will happen if the queue depth of the request queue at the bottom
> is one?
>
For any reason if a request reaches the driver with only one of the src/dst=
 bio,
copy will fail. This design requires only one request to do a copy,
so it should work fine.

> > +             blk_start_plug(&plug);
> > +             dst_bio =3D blk_next_bio(src_bio, bdev, 0, REQ_OP_COPY_DS=
T, gfp);
>
> blk_next_bio() can return NULL so its return value should be checked.
>
Acked.

Thank you,
Nitesh Shetty

