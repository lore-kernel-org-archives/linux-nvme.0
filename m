Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB92C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 04:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=21sZB0cQIQyT4qQnFzBbbk2zGnmsUzVxHD9eQSWsXSM=; b=V46TE1nh98HcXhMbXBZZag04bo
	fzoUHRfEatk/oa6K2lfhCcnMyT7WjzuxrxXbie7W5Y5ev6y+4NhULHnBNRBvdVPN6qKo1hiwmAHCe
	zeCBDuvlnAcMrXE/9IYYyfxN3AIA0xQ6rSK4XBzcBrgzMS8+FmzkJOw9mSLWZK8DfsW6dp5i0VoC9
	6DArml9rqkR+CRk6UluijbqiirllKG7ExtgMv395jHU1GftRhzZO4smlrKE1kiX47tKaL+1QGZOBE
	38Bn8nCqoy7Zj+rPsLMJ+nr8VKsqlAGhv0PkiBu2EBHDhoQU16lsjM5Q8QHmf1D9mxxyl/9RRARuZ
	gyxHGPrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYhFN-007Hzs-4h; Mon, 28 Mar 2022 04:44:53 +0000
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYhFE-007HzD-OF
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 04:44:46 +0000
Received: by mail-lj1-x22f.google.com with SMTP id u3so17596074ljd.0
 for <linux-nvme@lists.infradead.org>; Sun, 27 Mar 2022 21:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=21sZB0cQIQyT4qQnFzBbbk2zGnmsUzVxHD9eQSWsXSM=;
 b=O+KOuXPC6hePjUcR3JaYu2NtHEyI4LardvYhun3ke3JbEboM/6CkPnkJJDAwFmCcv7
 XlcLW2To4Am+zfpcyU4zlLlZzHZI46nNlJyy1vUsFRXiPN7dcvH/twJeHnkgJPaoyRUh
 fUyarJt5921dZk4m8OTY+6K5lNXhwvJqqSwhJvlJh8/9SPGCe9S/DNJeoaXJuSCxBKO0
 f2vglgLp/NzEks/xBr5ok9jM+Sg6bLyOl24wwxTIneIEdSQPUxJlCwayzQ38atUrtbUF
 hjR0CVFY+f0Vd6gWn+zf607BCtz0MUpVkAzRLoQwN8jIv4Y8mltXT8kuSaiey7EO+gmQ
 AX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=21sZB0cQIQyT4qQnFzBbbk2zGnmsUzVxHD9eQSWsXSM=;
 b=iaueA3ingAS/IjaoPDWXhnE3TcluZ+QiO8YmFIybmv77i54W78zQIDY4Rqynpd/+45
 skz9lyoRQGaiU/hqJydMx+ybCtN4JqiTCfyNPh+ydsJQze1zKkdYsPOXFQK6CCEp6ts9
 ZKmRsS/oPsCKWmTlBM6+blBn2kEWbveuh7DcT26yooTP3WJZKPkD7I+rHUAsO5cSkt1u
 FhU42KgY/JAsjVmCh1SBZvRPLpf/yd6WlWLsFMSQL7sH3vn79b70NqDxb6LIkeTA2lIF
 nIqrjZ3FY76332aQ5HzKRJOnwuaz0+RxeatQQzheSeG4N8JVZQXphulDVk6rfit05Wwr
 omLQ==
X-Gm-Message-State: AOAM53091JaOXETikXyNkSfW83s9/NDCJpq+sMFbfVh79RU10FMOBzpR
 H8Fksxhbkl5fZDfunWVcJLjgeL4F59F/9WBJ6sj+HWs+Vms=
X-Google-Smtp-Source: ABdhPJxgExojDOUG55D0M4bMrvzsdvV63x26gqkghravOLYEjaWru8kgts2OevmizkhBxwU1zczAKfndxGYVXDqDtk4=
X-Received: by 2002:a2e:302:0:b0:24a:c997:d34c with SMTP id
 2-20020a2e0302000000b0024ac997d34cmr7433761ljd.445.1648442680381; Sun, 27 Mar
 2022 21:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152729epcas5p17e82d59c68076eb46b5ef658619d65e3@epcas5p1.samsung.com>
 <20220308152105.309618-18-joshi.k@samsung.com> <20220310083652.GF26614@lst.de>
 <CA+1E3rLaQstG8LWUyJrbK5Qz+AnNpOnAyoK-7H5foFm67BJeFA@mail.gmail.com>
 <20220310141945.GA890@lst.de>
 <CA+1E3rL3Q2noHW-cD20SZyo9EqbzjF54F6TgZoUMMuZGkhkqnw@mail.gmail.com>
 <20220311062710.GA17232@lst.de>
 <CA+1E3rLGwHFbdbSTJBfWrw6RLErwcT2zPxGmmWbcLUj2y=16Qg@mail.gmail.com>
 <20220324063218.GC12660@lst.de> <20220325133921.GA13818@test-zns>
In-Reply-To: <20220325133921.GA13818@test-zns>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 28 Mar 2022 10:14:13 +0530
Message-ID: <CA+1E3rJW-NyOtnn2B5CbSusEs46X4O3Qzb_RGtoR1x_aXZfXsw@mail.gmail.com>
Subject: Re: [PATCH 17/17] nvme: enable non-inline passthru commands
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, 
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220327_214444_850348_BFB8D203 
X-CRM114-Status: GOOD (  29.68  )
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

> >I disagree.  Reusing the same opcode and/or structure for something
> >fundamentally different creates major confusion.  Don't do it.
>
> Ok. If you are open to take new opcode/struct route, that is all we
> require to pair with big-sqe and have this sorted. How about this -
>
> +/* same as nvme_passthru_cmd64 but expecting result field to be pointer */
> +struct nvme_passthru_cmd64_ind {
> +       __u8    opcode;
> +       __u8    flags;
> +       __u16   rsvd1;
> +       __u32   nsid;
> +       __u32   cdw2;
> +       __u32   cdw3;
> +       __u64   metadata;
> +       __u64   addr;
> +       __u32   metadata_len;
> +       union {
> +               __u32   data_len; /* for non-vectored io */
> +               __u32   vec_cnt; /* for vectored io */
> +       };
> +       __u32   cdw10;
> +       __u32   cdw11;
> +       __u32   cdw12;
> +       __u32   cdw13;
> +       __u32   cdw14;
> +       __u32   cdw15;
> +       __u32   timeout_ms;
> +       __u32   rsvd2;
> +       __u64   presult; /* pointer to result */
> +};
> +
>  #define nvme_admin_cmd nvme_passthru_cmd
>
> +#define NVME_IOCTL_IO64_CMD_IND        _IOWR('N', 0x50, struct nvme_passthru_cmd64_ind)
>
> Not heavy on code-volume too, because only one statement (updating
> result) changes and we reuse everything else.
>
> >> >From all that we discussed, maybe the path forward could be this:
> >> - inline-cmd/big-sqe is useful if paired with big-cqe. Drop big-sqe
> >> for now if we cannot go the big-cqe route.
> >> - use only indirect-cmd as this requires nothing special, just regular
> >> sqe and cqe. We can support all passthru commands with a lot less
> >> code. No new ioctl in nvme, so same semantics. For common commands
> >> (i.e. read/write) we can still avoid updating the result (put_user
> >> cost will go).
> >>
> >> Please suggest if we should approach this any differently in v2.
> >
> >Personally I think larger SQEs and CQEs are the only sensible interface
> >here.  Everything else just fails like a horrible hack I would not want
> >to support in NVMe.
>
> So far we have gathered three choices:
>
> (a) big-sqe + new opcode/struct in nvme
> (b) big-sqe + big-cqe
> (c) regular-sqe + regular-cqe
>
> I can post a RFC on big-cqe work if that is what it takes to evaluate
> clearly what path to take. But really, the code is much more compared
> to choice (a) and (c). Differentiating one CQE with another does not
> seem very maintenance-friendly, particularly in liburing.
>
> For (c), I did not get what part feels like horrible hack.
> It is same as how we do sync passthru - read passthru command from
> user-space memory, and update result into that on completion.
> But yes, (a) seems like the best option to me.

Thinking a bit more on "(b) big-sqe + big-cqe". Will that also require
a new ioctl (other than NVME_IOCTL_IO64_CMD) in nvme? Because
semantics will be slightly different (i.e. not updating the result
inside the passthrough command but sending it out-of-band to
io_uring). Or am I just overthinking it.

