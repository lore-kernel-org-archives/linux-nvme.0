Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB51DCCF9E9
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 11:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ge5yVH+rgTk7yHRDi3yqgvONhI5/hNOx9YIFNv3msM=; b=pA8gagWwpbHZ4JNBK/FL6eXiPX
	3NqSSW1+l/dna9Z4tYUKHNnQR9TH7VSgAhu9F8TMMOhSmkWLJDfEIsVI837ztyP3UTj6/0S012G0H
	nzHDTYUMoOEW0CA2iVmauWjV8ClzZ7pUsU+rD0u+tYTeHwOlwko5h2wsqYsrVdUdVDLxJEL3L5UJH
	xfgS0TDc1gzGt/sjPGOf4DoNNyjcugzd2bcchchFrJiiv4t/F3x7h3VGNKisQa5gg5jmfc9VeryrX
	bm/ncK9Ce3x0ovtitAsNG8nwv0sSOPfsRE6b1eFbets6LH7trcbfanpjseI1tIUCg7NWezHZ+CcAT
	LXK2XsUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE4En-00000000vrv-1EsH;
	Wed, 29 Oct 2025 11:21:09 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE4Ej-00000000vnx-1Zw9
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 11:21:07 +0000
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-63c11011e01so10318005a12.2
        for <linux-nvme@lists.infradead.org>; Wed, 29 Oct 2025 04:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761736863; x=1762341663; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ge5yVH+rgTk7yHRDi3yqgvONhI5/hNOx9YIFNv3msM=;
        b=JWUX2tzs1wUpb2GFd0Z4oXQ6FAWyKt6SFxxpT3tQEAavTBPZkIzB2xuYWSQZSWaIR/
         qZctvx184u4jQxjbznHvYgCXYJXGZR3ACv59KORM/+tIr7+ZOKg7gq50w7qwISYDJBVm
         2nmaQHSS8qiT+Ai/V3H10hQ/tqfuVtkJlwuC+qAKIx/+aoqjzsMXlki/WOMvyykhAYkT
         KAE2LbVGo3xTnt3cwLtWl2YthsVRbyA2h7qDmzp4NlWv+/zt3RMDlLHb6r+aqDi+Qq4T
         muJTsXQy5WUc0h1dUc8ykXIEI1hMuD0XG+G6kCRHtZxLovcw+IouNBjaMyIL+Kns6Y6k
         4pbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761736863; x=1762341663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ge5yVH+rgTk7yHRDi3yqgvONhI5/hNOx9YIFNv3msM=;
        b=xKhPU7Hgy0jwR1cFv+AIAYmORzMsiCIdu9aT9XL0pyAzc8h0f45qPUEuNJBcbFJx89
         dIygc6TYih+wfHhp6nEqYULEWqHF9h02qc3CBIXixTs6HDbOrcNU1lj7J4G7tyxfwbdF
         6Sscy1EgwXVA9wqc/6PLP5GL3C2EHFt4iFYO7HWUQ3P5aNbfC5GdYsh/xeSuvQ/NE4p9
         weQuCNHG6cjSX/C5jWQj8RBLgQXp4IYlmgoQz+D5hQ20/UYbDz693u7op9jiLjeCyf3y
         c4VhunMgShkSgDZiKwxQfasVaLQXeOLbCccEE66PQ9lj4xdqM4UtGKRzOCgEGSnOgP0A
         +HaA==
X-Forwarded-Encrypted: i=1; AJvYcCWyXr9bA3xMadYCzi3euuOybIvH0sHnjACP+iFLysMMTuic39E+ohvWLjkyXug2Lw8JyB5bWdggnXO/@lists.infradead.org
X-Gm-Message-State: AOJu0Yw7yAr3pdnasEAGJZ4EwDtD+fyfphbVBlcHhSeIuJat3U/qKw/c
	EYz6YD404njzm+bLJM1Mr1NdFP05MR/ITALT009r/kBlNa8Jri0+vbnUCdsqdBqWbJmv617Rqc5
	Ssv0t0055J+yw9YStXO+kpX1tb1mFuSU=
X-Gm-Gg: ASbGncuWNO8Ysm/isR3DhwjS7FGUUSAOrjNdqueLX2X3NTQDMmSD28jQHf21kFUYTY+
	qmpLSkVQ07RTeU4uh19BmHP2NAE4RHSbjDSKemNKFIQIkYvjgi46vUtR6SmOUosp2htZysoubwR
	slLfOPxaJtR7hkQPUyyBNlhSD/+w5+YwoybAmUEusgdYl95pgm9hmVdpJlg9uKGNoALHOnK9ekG
	JlJVCiC6RafVrToOuRCQAtUll/6kFAwoMppKiWhw9Fh5gt1qUuJ27EZKXSG1UKqunuAJ4U9i7zd
	3JLvQdISg44g/GE=
X-Google-Smtp-Source: AGHT+IGtzoXO/g3ZiHN2G1f7VZ5xjrcwHTs9yl4nbdJE0yJz6nLpSbbR0buPMaTahTQwYt80671Cx/7NYexnra+u6C8=
X-Received: by 2002:a05:6402:146c:b0:638:d4bb:6c80 with SMTP id
 4fb4d7f45d1cf-6404438173amr1626778a12.36.1761736863168; Wed, 29 Oct 2025
 04:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20251029045327.2035337-1-alistair.francis@wdc.com> <9b8d8baf-022a-49a9-b8b9-db699125e064@suse.de>
In-Reply-To: <9b8d8baf-022a-49a9-b8b9-db699125e064@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Oct 2025 21:20:36 +1000
X-Gm-Features: AWmQ_bkE7bJJHM3m1di6ZILHWBJlXLfT5wUJRaEfqSJFakwpllKcXC186lzlSPY
Message-ID: <CAKmqyKMH4dNGP0aW1ufkHKXuzNGjixAQrMwFd0QjCy9UT00KTw@mail.gmail.com>
Subject: Re: [PATCH] nvmet-auth: update sc_c in target host hash calculation
To: Hannes Reinecke <hare@suse.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_042105_441314_488091CF 
X-CRM114-Status: GOOD (  20.48  )
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

On Wed, Oct 29, 2025 at 6:10=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 10/29/25 05:53, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Commit 7e091add9c43 "nvme-auth: update sc_c in host response" added
> > the sc_c variable to the dhchap queue context structure which is
> > appropriately set during negotiate and then used in the host response.
> >
> > This breaks secure concat connections with a Linux target as the target
> > code wasn't updated at the same time. This patch fixes this by adding a
> > new sc_c variable to the host hash calculations.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   drivers/nvme/host/auth.c               | 1 +
> >   drivers/nvme/target/auth.c             | 3 ++-
> >   drivers/nvme/target/fabrics-cmd-auth.c | 1 +
> >   drivers/nvme/target/nvmet.h            | 1 +
> >   4 files changed, 5 insertions(+), 1 deletion(-)
> >
> I've already send a similar patch for this, which actually should
> already have been merged.
> Can you check if that works for you?

I checked master when I sent this and there was nothing applied. Is it
in a different tree?

Alistair

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

