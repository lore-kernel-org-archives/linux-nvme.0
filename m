Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C2EC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 15:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yUttHdvINpe5sVhWObI5vLGtPLNGhZcWSqGwgeAO4mE=; b=XmzbkTTGPEARLGU1e130z17PSl
	zCZCylLrBwxvj/rL8GqBYjYOHILtokoSCVuY1tIvq1iLto4lczKGppwduA7uI9LxWOPv3cXrMyd1m
	69YAm8ij6WxO2SLjmetzf1NomaMEwvDQBXf63OyOaMvLv+zQjDhT25D+fVr2IA0weBlWQdadmmlHG
	jYEPP7Hpa3PNIHF6r5+FUVOeCEuZzJB8AFgtQLs4/fr2IwMsebxHiwbwjs5KtTZRch2ZdWnNqf1om
	1P1MO0XYVvnHotN3w6f93LqQ1tiKmWFcF47ymGzUxO6LxUXmYjVWskrI0VBsCNyBsMcCruWu9IJeD
	DQIHetbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nblRe-001mJL-Ow; Tue, 05 Apr 2022 15:50:14 +0000
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nblRc-001mIR-Ay
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 15:50:13 +0000
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-e1e5e8d9faso9548193fac.4
 for <linux-nvme@lists.infradead.org>; Tue, 05 Apr 2022 08:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yUttHdvINpe5sVhWObI5vLGtPLNGhZcWSqGwgeAO4mE=;
 b=qj9doXvWuOFIaHhB/lpA9JrLUjyYVB8c8gFdTvzSHt0jLW1387lWVvGH2dvNVwqeZj
 qC1372+vgjT0U1CZ82ZkGR33s6RLxhvpRJWIvDVB4cULFhGxYaD5ucAn45Vs915PztCa
 bGEkAZ1/Y96zbHwvuPSTfCvuBCqWRnqWr60V7wrP8N6YMNLLdPSeRMLTbv9CjlFlWKWZ
 nuwb9tS5k5cpdDzewQaxniExFQV9GWpJ9Xd3vCHZyX7E6z+R4zBPk8mxAHJBPlJ82k4P
 aNKch2pKombMdNEqfZOdonb387OTkOLF//3iKmeHGfgzNen5jy2z8Lp2CzqokwNbdKBI
 buMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yUttHdvINpe5sVhWObI5vLGtPLNGhZcWSqGwgeAO4mE=;
 b=xkDRCz9HEiiLsFjSRjsGC9Pn+cYadzw23bDOpFvzTvFbN6I+94vTuJnuPzASW4CPzc
 yVICvfaNkDtE1GLo7zTZ6vJHi2ulTJqYq4RXV3o+PvKapoCiuhpL5YCZCZk3sknDV5KP
 hE4Rc2w/zcazyKrBT1wG9rosQ0vR8IKeFCk/OVJH2L8497qw0rU7Gr3TLwelfXBbuy6I
 HBAtPpWggUYbR7bikToPlc9h89OJLCJ7205qeNGP0Xx1bag3iVOEus+rerrv2KXYKefW
 CLfsE3PEOBzExSmIsm8Z/4qMArLtaxHe1n6YMAlbk+VRJR9cG/djsJ6j+zG7qyt4bJbC
 YV4w==
X-Gm-Message-State: AOAM5310mtmW8yv+0No1816KC27h/u0wc4wN7pBABf26c/Y2bvPoLC8v
 NJSpIWg+VaZhoHGMS+VeIMTRAmAEgmbSy/rfvk0=
X-Google-Smtp-Source: ABdhPJzP1wb3PsOcO9yDICUnJCahvxJb3BLsH5WxSrw8IQTqclqb+WJrKOKneWX0DaAUU7SGiWugYRW7oAcNoKNyP+k=
X-Received: by 2002:a05:6870:d18b:b0:d9:f452:be90 with SMTP id
 a11-20020a056870d18b00b000d9f452be90mr1844465oac.15.1649173809200; Tue, 05
 Apr 2022 08:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220401110310.611869-1-joshi.k@samsung.com>
 <CGME20220401110838epcas5p2c1a2e776923dfe5bf65a3e7946820150@epcas5p2.samsung.com>
 <20220401110310.611869-6-joshi.k@samsung.com> <20220404072016.GD444@lst.de>
 <CA+1E3rJ+iWAhUVzVrRDiFTUmp5sNF7wqw_7oVqru2qLCTBQrqQ@mail.gmail.com>
 <20220405060224.GE23698@lst.de>
In-Reply-To: <20220405060224.GE23698@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 5 Apr 2022 21:19:43 +0530
Message-ID: <CA+1E3rJXrUnmc08Zy3yO=0mGJv1q0CaJez4eUDnTpaJcSh_1FQ@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20220405_085012_405251_A7DBFE85 
X-CRM114-Status: GOOD (  28.60  )
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

On Tue, Apr 5, 2022 at 11:32 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Apr 04, 2022 at 07:55:05PM +0530, Kanchan Joshi wrote:
> > > Something like this (untested) patch should help to separate
> > > the much better:
> >
> > It does, thanks. But the only thing is - it would be good to support
> > vectored-passthru too (i.e. NVME_IOCTL_IO64_CMD_VEC) for this path.
> > For the new opcode "NVME_URING_CMD_IO" , either we can change the
> > cmd-structure or flag-based handling so that vectored-io is supported.
> > Or we introduce NVME_URING_CMD_IO_VEC also for that.
> > Which one do you prefer?
>
> I agree vectored I/O support is useful.
>
> Do we even need to support the non-vectored case?
Would be good to have, I suppose.
Helps keeping it simple when user-space wants to use a single-buffer
(otherwise it must carry psuedo iovec for that too).

> Also I think we'll want admin command passthrough on /dev/nvmeX as
> well, but I'm fine solving the other items first.
>
> > > +static int nvme_ioctl_finish_metadata(struct bio *bio, int ret,
> > > +               void __user *meta_ubuf)
> > > +{
> > > +       struct bio_integrity_payload *bip = bio_integrity(bio);
> > > +
> > > +       if (bip) {
> > > +               void *meta = bvec_virt(bip->bip_vec);
> > > +
> > > +               if (!ret && bio_op(bio) == REQ_OP_DRV_IN &&
> > > +                   copy_to_user(meta_ubuf, meta, bip->bip_vec->bv_len))
> > > +                       ret = -EFAULT;
> >
> > Maybe it is better to move the check "bio_op(bio) != REQ_OP_DRV_IN" outside.
> > Because this can be common, and for that we can avoid entering into
> > the function call itself (i.e. nvme_ioctl_finish_metadata).
>
> Function calls are pretty cheap, but I'll see what we can do.  I'll try
> to come up with a prep series to refactor the passthrough support for
> easier adding of the io_uring in the next days.

In that case we will base the newer version on its top.

