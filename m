Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BDDC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=njxZPwbhAy5VvluMx0avgyplL5X6yHJpvmwh0qPXIEo=; b=tE8yRBe9KwuFTa6+ZQE3KD1fHT
	iWzWRJIFbiSaZVngiM0IAZo9LiSrBOrKyzNul6x2ClyN5UrxuFYoZD2Ryeq9IFy+iWMi+8Ozk882N
	3XWNi2BTOneif5f9ff+O/UgnwsLMR6QZ7abj7FqGoz8Jl3i8T8uyLdwCwqAa/ZkR+83+p0x3rolwC
	uG2L1KevJpQWQnc1yEOUYRRJPauG0OacNOgIhSDcRajZh40+cJKXwgITDwvPhDrWasQHkiiB6dglR
	xMogiJZERj48S5IGs6cT7GSnlKUeUR2QEMv0rDCdHPiMPQaYiafvMdTwCiF4SZS3jFftQIIbjpBED
	JanUhvxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbNeB-00FJsx-P6; Mon, 04 Apr 2022 14:25:35 +0000
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbNe9-00FJsD-Ll
 for linux-nvme@lists.infradead.org; Mon, 04 Apr 2022 14:25:34 +0000
Received: by mail-oi1-x22b.google.com with SMTP id e4so10233394oif.2
 for <linux-nvme@lists.infradead.org>; Mon, 04 Apr 2022 07:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=njxZPwbhAy5VvluMx0avgyplL5X6yHJpvmwh0qPXIEo=;
 b=q2he80X0zGS1evsZqXWx+wzbOKzrfYMLHWb7xxMfnhQ30Tg6L6jI6sJk6JSowibR/6
 jYUXblvyxiq9GFulOLp9fu8gee2j0n8BuAukJV27A9ZfntSop1W6ejay1lyHOpH7Fuf/
 hfj8UyB1pIG6GjHt+fO3ZR3iIYHBKaU2zXzU4CruF0ZaYpE/7XS1ZNMTYhmgnea1caLF
 lYWKuolP4y4y3s0EpLJzZ2L4Tvh8ysaXjcqeWAifRZxweMYud2CalU7Nfc0MMdiaYs2V
 oXPCJ7Cu5ylLBSuBOX9yCMmEeOuH2Tqc7yVGo/kLIp6/WXLL8dQK0pXm212JM03iIh9P
 shSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=njxZPwbhAy5VvluMx0avgyplL5X6yHJpvmwh0qPXIEo=;
 b=K9mJiBleCj2ARYDwa62582h4zyVSGvG06V1MOPAoMlrqQKapaNzPvn0Q86GRgt/A+d
 UqYePYs9d8SKco6ms0pJm9l8x7CNEJlwxeP40nlbxK0inoNFysq+h78IaOC+w5VT5goU
 qvbKR5l8zwtAF0Vepd2spfICR1JSrELXTcir/6DV6bZQCEhjh2P8tOCrDAK+sxGmBu/A
 jTlss71+VLdMoUP5Q2Q5afmyEb1Zz72BKkrKTIPeNQnT46KsjRNyTWXdmnLbwUNcTL74
 DEMOjm1FKnYU/j4nrIhWMhYHXmCRJIRkBWK/ejeMt1Eb6vIhN4c1Sgy05iL+jgIRFQAG
 ZqGQ==
X-Gm-Message-State: AOAM533kd0mJRW3mR3KJ+qAHXK5Npyi4TODckbTkZLAfTdxyUiTAZFt6
 +aT2djnl+AfzRwUJWmGpZAPbAdJww/JWlJD37dA=
X-Google-Smtp-Source: ABdhPJz5vnt/nUrGIypGkIxs9O9318XjCxougjFruCavALiumxradW4Rc752HuwOXqlwprtw9iCFuHl5xNqrfo+UITU=
X-Received: by 2002:aca:2407:0:b0:2ef:5c86:5a09 with SMTP id
 n7-20020aca2407000000b002ef5c865a09mr51580oic.160.1649082331780; Mon, 04 Apr
 2022 07:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220401110310.611869-1-joshi.k@samsung.com>
 <CGME20220401110838epcas5p2c1a2e776923dfe5bf65a3e7946820150@epcas5p2.samsung.com>
 <20220401110310.611869-6-joshi.k@samsung.com> <20220404072016.GD444@lst.de>
In-Reply-To: <20220404072016.GD444@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 4 Apr 2022 19:55:05 +0530
Message-ID: <CA+1E3rJ+iWAhUVzVrRDiFTUmp5sNF7wqw_7oVqru2qLCTBQrqQ@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20220404_072533_748079_3BE93E58 
X-CRM114-Status: GOOD (  20.83  )
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

On Mon, Apr 4, 2022 at 12:50 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Apr 01, 2022 at 04:33:10PM +0530, Kanchan Joshi wrote:
> > Introduce handler for fops->async_cmd(), implementing async passthru
> > on char device (/dev/ngX). The handler supports NVME_IOCTL_IO64_CMD.
>
> I really don't like how this still mixes up ioctls and uring cmds,
> as mentioned close to half a dozend times we really should not mix
> them up.

Sorry, I too had the plans to use a different opcode eventually (i.e.
for the full series). Just wanted to focus on big-cqe this time.

> Something like this (untested) patch should help to separate
> the much better:

It does, thanks. But the only thing is - it would be good to support
vectored-passthru too (i.e. NVME_IOCTL_IO64_CMD_VEC) for this path.
For the new opcode "NVME_URING_CMD_IO" , either we can change the
cmd-structure or flag-based handling so that vectored-io is supported.
Or we introduce NVME_URING_CMD_IO_VEC also for that.
Which one do you prefer?

> +static int nvme_ioctl_finish_metadata(struct bio *bio, int ret,
> +               void __user *meta_ubuf)
> +{
> +       struct bio_integrity_payload *bip = bio_integrity(bio);
> +
> +       if (bip) {
> +               void *meta = bvec_virt(bip->bip_vec);
> +
> +               if (!ret && bio_op(bio) == REQ_OP_DRV_IN &&
> +                   copy_to_user(meta_ubuf, meta, bip->bip_vec->bv_len))
> +                       ret = -EFAULT;

Maybe it is better to move the check "bio_op(bio) != REQ_OP_DRV_IN" outside.
Because this can be common, and for that we can avoid entering into
the function call itself (i.e. nvme_ioctl_finish_metadata).

