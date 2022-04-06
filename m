Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDD7C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Apr 2022 05:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l9+/yCBOkTtbp5l+BKTxdkzgNWz3+13PB5ObVpgIN9E=; b=eoH20xO21C/ArxbFyBsArEKv/B
	FeFGtlSktXMcDfZO/xGeEZjPz3SJ8UA15C3B2S5zDNE2DJ539uyOF9ySBfoSq2Y+pwbPH3Etq6Trj
	N5mJPlVgJ2APTnpuDZu64XyXMXaNuf0hKekSfQVO97/qUqsFcVKybTxw9R8e2Z72kg76paSJYPOjK
	Z1LsjCLlRgklJ3VFFexyll1ZIbA/lskjmJYmFocZHc8c0I3iAyY1PO+Rb+Ac2WqPEcoSUUSLHbjKK
	GaGkhjr+8hbDh/SAA4c2Jje72nFH7mzilj1xRlWNJRgM41YhkWE2CXqw25Lqr+SEwv3xPwVOcndgX
	FCSZWYeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nby5z-003oHD-Pp; Wed, 06 Apr 2022 05:20:43 +0000
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nby5x-003oGW-1K
 for linux-nvme@lists.infradead.org; Wed, 06 Apr 2022 05:20:42 +0000
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-df22f50e0cso1812808fac.3
 for <linux-nvme@lists.infradead.org>; Tue, 05 Apr 2022 22:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l9+/yCBOkTtbp5l+BKTxdkzgNWz3+13PB5ObVpgIN9E=;
 b=I7Izv+wp6ICDb7mI38AwuHhe5dwXif0rfGr2Hjv999l3tq946mdQCUX5KDMy4GBm1d
 R2R4NrMcXrZSImZBvZj0Kq0ufHsMuiMGSkvm41mS8GL7aPJUE7ffi+VlRJte3B7gEzol
 VM6NNi9Tnu3MelDu6ixUrnDKREHSy7jj1V167N7majhuSd+ogSb5O6Pj+clwWf5qYV2T
 RGKWSXX+oF8XfN5riAnfTWiYnzX2mP8afPBKfmdQK+5ZjjMxvC/9OkCrOjCl/HJc7PM1
 M63y3OI6/eh8DtaXftYnx9d9/QaI2AzYAfkLwh2nWLIyb4nLRDuXbVGDXGJfOPGi2xl3
 vIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l9+/yCBOkTtbp5l+BKTxdkzgNWz3+13PB5ObVpgIN9E=;
 b=oOy283ZbNcWsJD5datwY83t86VDKq1koYSLTKHAGmLTF3nDbQ3DsvIEmifWSUcHFUC
 TqzPQLUP+I2qHqpR7UOThWfBjkh5tmORj6jPW9wo56nhLNMBS3x6yXF32mJBjU3nzmDA
 lvuJmOBo+ntZjR6XmWjExaQWJQ9NZ/pycGevxa/UI+JethTEo20bjyadQvqmdfB3i76C
 +WijF7/l6B59fvwtqUUwEphpwHO0V/W6zH8SKuXd30scsEJ3XgEgPf+uLuWnS8LKVXO5
 UTAgbF3NA4XdyCSMkrbzDi83MJMdLf6uFYUx1GKfWmJDkDos5EPssFEQQUzry8GBejWZ
 GQnQ==
X-Gm-Message-State: AOAM531ueaYRMcbdCVx1QDgo1UZbHOEMsk1jDdDReseuMzmeHHlk9mRb
 4QwhR1vJ2BQvwpxuS+wJ6Nadm5Dm/yPg/k8OcXE=
X-Google-Smtp-Source: ABdhPJw0/I69tdKuJDxigBoP3AuSaTFMWHsdn/qNZukJRBdrFbQrK5Om31iXu3Aez6v38D8oDQ1TQV860NcC4Y6Gz0U=
X-Received: by 2002:a05:6870:d18b:b0:d9:f452:be90 with SMTP id
 a11-20020a056870d18b00b000d9f452be90mr3118492oac.15.1649222439368; Tue, 05
 Apr 2022 22:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220401110310.611869-1-joshi.k@samsung.com>
 <CGME20220401110838epcas5p2c1a2e776923dfe5bf65a3e7946820150@epcas5p2.samsung.com>
 <20220401110310.611869-6-joshi.k@samsung.com> <20220404072016.GD444@lst.de>
 <CA+1E3rJ+iWAhUVzVrRDiFTUmp5sNF7wqw_7oVqru2qLCTBQrqQ@mail.gmail.com>
 <20220405060224.GE23698@lst.de>
 <CA+1E3rJXrUnmc08Zy3yO=0mGJv1q0CaJez4eUDnTpaJcSh_1FQ@mail.gmail.com>
In-Reply-To: <CA+1E3rJXrUnmc08Zy3yO=0mGJv1q0CaJez4eUDnTpaJcSh_1FQ@mail.gmail.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 6 Apr 2022 10:50:14 +0530
Message-ID: <CA+1E3rK3EzyNVwPEuR3tJfRGvScwwrDhxAc9zs=a5XMc9trpmg@mail.gmail.com>
Subject: Re: [RFC 5/5] nvme: wire-up support for async-passthru on char-device.
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Pavel Begunkov <asml.silence@gmail.com>, 
 Ming Lei <ming.lei@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Pankaj Raghav <pankydev8@gmail.com>,
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_222041_113592_F7D5CFA1 
X-CRM114-Status: GOOD (  19.99  )
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

> > Also I think we'll want admin command passthrough on /dev/nvmeX as
> > well, but I'm fine solving the other items first.

Sure, will add that in the second round. Should be fairly simple as we
can reuse io-command work anyway.

> > > > +static int nvme_ioctl_finish_metadata(struct bio *bio, int ret,
> > > > +               void __user *meta_ubuf)
> > > > +{
> > > > +       struct bio_integrity_payload *bip = bio_integrity(bio);
> > > > +
> > > > +       if (bip) {
> > > > +               void *meta = bvec_virt(bip->bip_vec);
> > > > +
> > > > +               if (!ret && bio_op(bio) == REQ_OP_DRV_IN &&
> > > > +                   copy_to_user(meta_ubuf, meta, bip->bip_vec->bv_len))
> > > > +                       ret = -EFAULT;
> > >
> > > Maybe it is better to move the check "bio_op(bio) != REQ_OP_DRV_IN" outside.
> > > Because this can be common, and for that we can avoid entering into
> > > the function call itself (i.e. nvme_ioctl_finish_metadata).
> >
> > Function calls are pretty cheap, but I'll see what we can do.  I'll try
> > to come up with a prep series to refactor the passthrough support for
> > easier adding of the io_uring in the next days.
>
> In that case we will base the newer version on its top.
But if it saves some cycles for you, and also the travel from nvme to
linux-block tree - I can carry that refactoring as a prep patch in
this series. Your call.

