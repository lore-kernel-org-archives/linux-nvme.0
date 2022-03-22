Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAABBC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 17:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DjMPQuRgSqtggQih30jd9BA8LLZ+Br+5GjfemEGTtt0=; b=csh09S0iiypCpYGDuMy50ycYtn
	1MvA89jNdxyaQOIYI64uAnEJ41UNDrYA3JnrTZZYPRs2gIPAvnsc74OHWOg+QKLmIYnMr1aBKbi/7
	XAiLlumajgrYETjfBq+W45BP/c8wwC/ns+GHCdGtbr2FQNGKzNzByoFvBKxe2JH5yuTJX3UBQc39r
	J1xhdVa4EfLxmS0EkYCAXPw15Z3ecR5GBo+HJqFYt3tjNv3/uAPU7pSMJVzq9q1NO//iOIcco8t3u
	rVBXHMTSrtBWMxVslv35dMiw0ScDb8SNakYhYdfCEWN4xcP4FMz+85w39IFfTUrpwr1dAuZBvuFEn
	HYXe8SAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWi28-00Bh4H-2u; Tue, 22 Mar 2022 17:11:00 +0000
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWi25-00Bh39-Q7
 for linux-nvme@lists.infradead.org; Tue, 22 Mar 2022 17:10:59 +0000
Received: by mail-lj1-x233.google.com with SMTP id b5so6247024ljf.13
 for <linux-nvme@lists.infradead.org>; Tue, 22 Mar 2022 10:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DjMPQuRgSqtggQih30jd9BA8LLZ+Br+5GjfemEGTtt0=;
 b=E7cDRaZRUBAhq0mF0x/5leAbAfq9Y0seSKmP4gYSckQ64vJxUvLCxQJhfqoesl/amX
 5U38gpi4dJIXYBjT/j2k7AP+hGurmVeTFxJu2a4lCGXFFUP1f1lTYwzpNdV3mRPPdtLu
 2/Oc5i8i0Yv5OMjXy5P4Jlf+25scC/jQtW32/oQJUWfGyq2UImFu9TMfgvA6qQGsxhjs
 1WDmJ91t5lyjRz2wtsggZXFhLmxV3EExdwZzanRvgL2HXw6v6smjMW/0cPt799Lo7SLS
 rKYU2xCQv51pTBNnTBnFHKDNkW3Vzyoc0baoGJb7Lv2qA40raaTElHVoEKl7BQJNNdOz
 ddzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DjMPQuRgSqtggQih30jd9BA8LLZ+Br+5GjfemEGTtt0=;
 b=hILZK9GevCSsOZYDLRafmZ5k18mK8jaTX7WNerjDbpJixDUaUMqew5KyWTNrtc6EAD
 Kq14vaJH+7OsCL2zdR/U3QsUIiprOuj6VT44/8KK2zHnEPsQFU/fxKMG7Du+ReN8Zneu
 gCk1I8H4uo4WamyfwLC3T3b3wJ9OryKl+rKQ42T1iytzYBJLMBC0cuCw1AkbC3S6oDO8
 rbmgOkj295AMhk6i/GeXpW3JXu32igcreDWrwX3f9GunEFtFldNv0e5vDk64doUXbRyv
 tSiOHmdhShJ3PHp7ThjQRb4PR1phmXE6DLen3zx+NMHmoARfA7L/Zwx8C5j5EHxwxzCf
 NzXQ==
X-Gm-Message-State: AOAM531BbgR6LltB9YhUxw6MkEuIrH6OYnAQsbSMTR4CUhgmTp8RhkiV
 t9NO3NG1ykJW9YtESBYdoLY0YyuAiw6sFfuGeGs=
X-Google-Smtp-Source: ABdhPJwtGnaC9zO93M2q8sI0Kc9qeume6nrAuEkn++6FTTxjwDL9+DZYrRj1rED9VvFBUf11TkY5zTG1JwTkR0wUMAA=
X-Received: by 2002:a2e:3004:0:b0:223:c126:5d1a with SMTP id
 w4-20020a2e3004000000b00223c1265d1amr19224954ljw.408.1647969052469; Tue, 22
 Mar 2022 10:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152729epcas5p17e82d59c68076eb46b5ef658619d65e3@epcas5p1.samsung.com>
 <20220308152105.309618-18-joshi.k@samsung.com> <20220310083652.GF26614@lst.de>
 <CA+1E3rLaQstG8LWUyJrbK5Qz+AnNpOnAyoK-7H5foFm67BJeFA@mail.gmail.com>
 <20220310141945.GA890@lst.de>
 <CA+1E3rL3Q2noHW-cD20SZyo9EqbzjF54F6TgZoUMMuZGkhkqnw@mail.gmail.com>
 <20220311062710.GA17232@lst.de>
In-Reply-To: <20220311062710.GA17232@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 22 Mar 2022 22:40:27 +0530
Message-ID: <CA+1E3rLGwHFbdbSTJBfWrw6RLErwcT2zPxGmmWbcLUj2y=16Qg@mail.gmail.com>
Subject: Re: [PATCH 17/17] nvme: enable non-inline passthru commands
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
X-CRM114-CacheID: sfid-20220322_101057_870336_0CC18DF9 
X-CRM114-Status: GOOD (  17.43  )
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

On Fri, Mar 11, 2022 at 11:57 AM Christoph Hellwig <hch@lst.de> wrote:
> > And that's because this ioctl requires additional "__u64 result;" to
> > be updated within "struct nvme_passthru_cmd64".
> > To update that during completion, we need, at the least, the result
> > field to be a pointer "__u64 result_ptr" inside the struct
> > nvme_passthru_cmd64.
> > Do you see that is possible without adding a new passthru ioctl in nvme?
>
> We don't need a new passthrough ioctl in nvme.
Right. Maybe it is easier for applications if they get to use the same
ioctl opcode/structure that they know well already.

> We need to decouple the
> uring cmd properly.  And properly in this case means not to add a
> result pointer, but to drop the result from the _input_ structure
> entirely, and instead optionally support a larger CQ entry that contains
> it, just like the first patch does for the SQ.

Creating a large CQE was my thought too. Gave that another stab.
Dealing with two types of CQE felt nasty to fit in liburing's api-set
(which is cqe-heavy).

Jens: Do you already have thoughts (go/no-go) for this route?

From all that we discussed, maybe the path forward could be this:
- inline-cmd/big-sqe is useful if paired with big-cqe. Drop big-sqe
for now if we cannot go the big-cqe route.
- use only indirect-cmd as this requires nothing special, just regular
sqe and cqe. We can support all passthru commands with a lot less
code. No new ioctl in nvme, so same semantics. For common commands
(i.e. read/write) we can still avoid updating the result (put_user
cost will go).

Please suggest if we should approach this any differently in v2.

Thanks,
-- 
Kanchan

