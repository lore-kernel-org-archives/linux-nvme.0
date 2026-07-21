Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683F7C4451C
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 17:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bqJhHZxbGEvXYhualzcQpDQcrx6Nf+L7xXv1g9Mul7I=; b=Vf6c9QNcD9I6V1KOLhtEWiVN9d
	l6CvajLIMmsYrtF7xr+AUfaOgLUo7E7E6n4UPZMUTdjylvFR9ODRhymsuk7Ln2tWTxoNM1bLqT66X
	D5zTw80WfIRE8qhn3BPiKL7iAeISZ+UTkZ/5oHtg5Dz2xsW1aa9CNoUgLdx3N1dd3CsLLQvst8b9b
	Pl7kdffPbvvnFZIbLuJFNILIQ+kIpsHUG274cG8RyQ3BV6TtS/7FLrO/+LCtNGjEVJTDjYw1VKf7o
	wVDSwhWcy1D7l4NJ8LPeO6s8CqBd2A+ERq6abeENJQquHvnjBaln1Lj6nDZKgGKPKivxC5xW6Iaz8
	9TymBldA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEcX-0000000A6Wr-1PqC;
	Tue, 21 Jul 2026 17:51:09 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEcU-0000000A6WO-4AUI
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 17:51:08 +0000
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-38759bcd877so10392658a91.2
        for <linux-nvme@lists.infradead.org>; Tue, 21 Jul 2026 10:51:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784656266; cv=none;
        d=google.com; s=arc-20260327;
        b=C6QI7e+maR0Ky5y0C9wS2/Rnh0ovl+L4QpsBie6wi6vInpNZ+fic+LJfVDtkw3za+M
         9gjIsvAkB5cwRfBjy0HOPGJf1Lg8d8ayAwXMwG9NKB9wvrBJ/VUBVbOHfc9+8xckRURU
         IqT3cSPpeL5UzbRJqK+5K4PkZDsgeZbmh9/4rHEqmoc6MqtHrvifvrbfnAr3kvSzAKUr
         UCD449UHz7We1r56+qrd6TvUzWcTuUyRb79tIltzMx8ZsvehM7GM9DwZ7QTDedl+U/s7
         bxnlSWhzLxCJBEzuBObqtn0ch5vo5c1ho94HvTerPeIFfEQYb+hywZEDSGkk5En7Adr5
         eaew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bqJhHZxbGEvXYhualzcQpDQcrx6Nf+L7xXv1g9Mul7I=;
        fh=mkJXgfsrzCRL20JYf7viFzeG/9pelXWrRS4lxxLAJUs=;
        b=OoaJ5OuwtwgkIuSnbjA4Zl1sVKj3xFEhN4Hxh5tsM6SP3q1Jh/FUDTBtK3fbWmBuhP
         cqzhN6W5hkr3hSkHBcWOI+tWf0bZjpL8zDTS4RHsjyXpFMpeK5DIrASlbwuE26pvy3tc
         /Y11r3kw1xEHrm2pstExLGAXugeAUSqX6ZnusFNQmSQiRqzDDtEvorAWyyoh6w6p7cKP
         n4SL8exbWxFRsnGbzyq2FtmPlpbHUEDi3+apEqsXAJDiMWY4JiFpetNPH6lcgZD7FQBf
         +S4RMf8AYMW1KKMM0VpRxTB/wStp9xuZ/ZrVJq8PYFcoFrBxpwoAb0h+InZV93nfAtc7
         DALQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784656266; x=1785261066; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bqJhHZxbGEvXYhualzcQpDQcrx6Nf+L7xXv1g9Mul7I=;
        b=WR94QKE9MgzTYPiJ60qWCdCBYCmGNy1MRgxtUoYbpsrAIF0g3OMNeg+ztxierMf9Jf
         X9MeuRc1fmuXzIIUxp/4v0zICeGTneFtRSBb9kzY9tpViFqVwVzYbMZmLTYhjGftvwWC
         fizh764nvjD2uQ2VDzbAY9Rq+6ipxJ9cddDNK0ygWKW/Ze2TZbMfoFs2iGBKMJpnkjg3
         K3ZEID50jgqHQx3vxVocPI3VMbdE1iVI26oX7ECPXgfobCtqGY/yh5nGuheEMQX2XdOq
         7HPcNIw6hz94i6HqFy/0JdnDnUQfxYBh3JuNptrmw4WrOqERDDAtUTVm90vmfNfemi7C
         Y3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656266; x=1785261066;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bqJhHZxbGEvXYhualzcQpDQcrx6Nf+L7xXv1g9Mul7I=;
        b=BTUPsiHYd34B/pkpN+4YfBM72ZGR7DHgRcAkEDZmiSBUJoTNq3tp27v2lTL5c2HyQ9
         4w+ZzFBPn/A6VQ9LMj400t0daWrHCq8oWVu0HIxwX7Xl7w1lEWiWJ46We8pmyODj7hiY
         7rHNN4TwSJ80iFfSwJuzV/cUfyzo5K/zQGgvH2gtGckgOzwbzjbhHpxmCoV9+0OgIh9k
         rhHdUnZBtT3v+2zWQovmtwiIDCa67pRa0imPIjYyGS5/5BcixhT2iHlC/X4bf9CY9eCO
         E8l01JT4SN0YisF0e5X5GxE7hj5cimhpL1MjSQhPc4rCMzeZCLVjSs7hdUJ65c0Nf/jR
         ubVg==
X-Forwarded-Encrypted: i=1; AHgh+RqtIZjeqVZRBPmo0/Ir2FJ34PR5QL4Mwm/uSlO/jwZUBrZSrlD6mMk0gm7WfmJORPPgjLTjj3ojE2Mg@lists.infradead.org
X-Gm-Message-State: AOJu0Yw/dCA2WZCC0DdxbvrpOEiJxQQdw3nnZdAp0YXkYS1K3l9PmR1i
	wwkU3G1wZ3H6TiPRiABpx/D8eG6LKZ80+n6l67jyt31bsMmy0m5ABY71hsrwOoLxEQK7W+A+pEP
	trw9mOdT4X/NrI5Ehdqlsxl0hSxAT+yWnZYX/h9Xh
X-Gm-Gg: AR+sD13RnmJpODY29qYzZCe+O0vWX15j1b9WwovSI+spWphH3FzQC96Bbs2S1TXeMBx
	GRW+1m+GgZvdCAULJm0lp+s/5b3OX6tu8F86PNElAhIb5/eqd+n11M8M5bLSXuAV8wfxQ13DrRe
	OtMlBM1ClHoCz/4IRTMQH27PLDWosH05UkzOacibxb2qOsj6KDf9N/lR7rCmyWLe1EwJyExRz/o
	P0jFWMVlSuxbLCPYzTJHwZeyMO4E9RdrgWLlgnFytGI2DzFt7/nAVfBYX4UqTVCobf11ZYYfhU3
	7m3NmRsErkiF087FsYS/3j55u20EJ8BwQT5LKLVqz34=
X-Received: by 2002:a17:90b:2e90:b0:368:ed26:15b2 with SMTP id
 98e67ed59e1d1-38e4b43c408mr19724564a91.8.1784656266239; Tue, 21 Jul 2026
 10:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260719105327.864949-1-mykola@meshstor.io> <20260719105327.864949-7-mykola@meshstor.io>
 <ee312bcb-92f4-4884-91cd-3bd56180c8c7@deltatee.com>
In-Reply-To: <ee312bcb-92f4-4884-91cd-3bd56180c8c7@deltatee.com>
From: Mykola Marzhan <mykola@meshstor.io>
Date: Tue, 21 Jul 2026 19:50:54 +0200
X-Gm-Features: AUfX_mys0lIoq4Q-xmicA-5OIV7AmcAZv6tYBswRu-bPoovrkHLh5N1N3P5Onu0
Message-ID: <CAPzsNDsLr_BABgizujN0CgnLNfzS3S37vQ133fjbJzFMvRs7CQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] md/raid1,raid10: skip futile retries on P2PDMA
 mapping failures
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>, Yu Kuai <yukuai@fygo.io>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Li Nan <magiclinan@didiglobal.com>, 
	Xiao Ni <xiao@kernel.org>, Guoqing Jiang <guoqing.jiang@linux.dev>, 
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_105107_057054_92C3A44A 
X-CRM114-Status: GOOD (  17.59  )
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

Thanks you!

On 2026-07-20 10:49, Logan Gunthorpe wrote:
> My eyes glazed over a bit. But one point is that maybe this could be
> split into multiple patches: one patch introduces R1BIO_P2PDMA, one
> patch for raid1 and another patch for raid10? That might make it a bit
> more manageable.

I have split it in v3 into a raid1 patch and a raid10 patch.
I am not sure about separate "introduce the bit" patches.
R1BIO_P2PDMA and R10BIO_P2PDMA are entries in the two personalities'
with own r*bio state enums.
The commit messages are shorter now.

> Also, I'm not sure if it's possible without digging deeper but, instead
> of adding a !p2pdma_unmappable check to every if() statement in the
> raid*_end_write_request() functions, might it be possible to factor out
> a helper function and return early from it?

An early return doesn't work here: on a mapping failure the
function must still fall through to set R1BIO_WriteError, so the
completion path runs the (single, whole-range) retry and records
the bad range -- only WantReplacement and the FailFast md_error()
are skipped.  v3 folds the two tests into one branch now,
which reads better and keeps the fall-through. Please check v3.

> Maybe the helper could be
> shared between raid10 and raid1 as they look very similar. The
> differences between the two are minimal -- there might be a bug fix that
> was applied to one that should be applied to both?

I compared the two sides after splitting: the P2PDMA handling is
symmetric, and the remaining differences are pre-existing
personality differences rather than missed fixes.
A shared helper would be heavier than the two open-coded branches,
so I kept it per-personality.

Mykola

