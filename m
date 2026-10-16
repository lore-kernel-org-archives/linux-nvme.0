Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128D4CC6B38
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 17:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fpAVW1SblpQMy67RR1lVuwyBnAKE+/uI26KrxUu72XM=; b=3yf5FK4bfKZmT7dt/4mDBPbKjH
	WxL2UUSofYJ+TLbO5jrfl62DowNu7fc5wZUQ3BfVbRYYh1eqUXRNA5xw2t9P/xhBau9a6YIFUGP8s
	2lh2mxamBvVzqpN/MuqB3iYL/Kcps7cupFfSdwyGU/Q0TG05MkwwCqRsFTauPXVz/IQtoUws9vFYO
	orFoW9d/kvNlsZDgrdSLQ5pD4yTzcFY8DS+9rjqpjMcZVhPF1qKlV/g+U6AWgpwH+uJln0xH5g+Pk
	85wkm0yNfNrbhG85NnlTkdId+Ukke0rHSnSY42gBTvGpkrbhTjW571fdymvy+jHmHgqME0+M6+jCF
	yjFHxj8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHly2-00000003aCJ-1XtS;
	Fri, 16 Oct 2026 17:43:42 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHlxy-00000003aBS-0wWH
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 17:43:40 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-c20ce3c118aso51234266b.0
        for <linux-nvme@lists.infradead.org>; Fri, 16 Oct 2026 10:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792172616; cv=none;
        d=google.com; s=arc-20260327;
        b=e4quCEtTE60RgULgZB5Stg4SXipajOG5TFyC0jPufMoiSyO8XUSTQnQIzzrvmojR85
         NgYRG3PNZ2Gh3E8kpyyy6J5EsD940GcZbisvIlDDY2TWHjOWjbQvltm928NQdLTW52cr
         JA+D4wOR2Yw2syJo5RG+chJDGa6ZAPWsdcsiuo3EDIpaFoWbCeBp7rMlmwZbFwuE2u+h
         t5VeDOHJLfnYu8GxI1M/RHsFQNAOQImn7zusY4jnqPIQAwCn1CaJrbhJiTmVppmUItxF
         wJe4sGn+wvZ4407JAgY6Q5cc+m54w5LklBFVUFviVY+WeJ1kxiSGrEFr5RSYb53P/+ZN
         s1Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fpAVW1SblpQMy67RR1lVuwyBnAKE+/uI26KrxUu72XM=;
        fh=Pew3xRwvPFZY6K0526PoLQD8tpumB6YxH2J/LeqXK90=;
        b=X0ggEETGwhmmUK7BqrIe0GGYfoFus2ERdu4Ln8FiEyUTgoC7KKEWjHaWem18N03plT
         MJ2DZ5mWZpkxUmpxda7bwOOizHUDitFbTLbJ/e9Law0W+otUhc9wmmZzETddiJ2VdFFk
         zq2VTH+cKCC4ZAatdHIRH+m34Aju336GMfq5CxmDYN6ptBSBlBEc4Gw/3zlc7wQgvhiA
         2MRLtLs2My38lhiPxdwAav/jwF59SJlgmGSi2tDU9t/e9sxHgxGxLBMG+EVWMGWPUhxP
         Z5AQmRZhrpLut8cZ9+MvUK2DTQ6fxPnifg/W9xHk6tNzFmP/vnf60EBnZU+wGMsO1Xlx
         tG6g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792172616; x=1792777416; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fpAVW1SblpQMy67RR1lVuwyBnAKE+/uI26KrxUu72XM=;
        b=DadlRmRQqNO9+0ylNYKY+drVYS2vYpsT+wn1iDDrhWBtd3hu6WQQ/yeOhTKGgtwVEZ
         Arfkv3YrzwcwTTZUu+oEK7v1GS1jLLWdqmf61YmFfrhvzwOLHeNubd6TcQAUhRj3xaJ8
         L8FTML6Pw+dquj9UGlb2qVbLItSJBqsbnmVrJmuzaG7Sb4pbHJcbOyxywgDpkSaeNLg3
         Y12Ev2E1XRVQAX4kAQrEeCwUbLZmq7x7E5NawxAApyi379uiCZYZxfq7OaY7D+TLk6bY
         cHS7PFVFGdz3a45t2ZC32HHovxgieDzuD9wnQMHL2xDmMU6OTqRLHO+uA5tgXsIfr7h+
         Mjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792172616; x=1792777416;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fpAVW1SblpQMy67RR1lVuwyBnAKE+/uI26KrxUu72XM=;
        b=AcT5Hxp/hlx1JlG8aVfFQD9JcRsRwZc98oakRUZKDuwMLgELjKOnZWBTG2LxCfkiJJ
         TJkDwTCgR0lh6oJaIPYLzghHabb7cdhRWZj/fi0MWjGpyxptOjevg8xxQKj9BAttil/j
         wvcY+KJQpb9Az1nhFyogF01ytIjVdhlftEZ138nL2Np5THwVQ3SYVg5desrKnCBrkv5F
         0UWBWQt/FMFRFkVYv8iDquObJzRFWAFLRxn1ui2Wb1aNLgD/Fe4PbhpuoWrVQlu3jFto
         zaFbz8mENwjtW7bM354jyiDquxFHC0PYwEwLHDT3fX89f9vqtWI8nxuaK+rrd0OHYIct
         oukw==
X-Gm-Message-State: AFq9FYK43hfY4Edxwq861InVy4oGu1ZvBtdAbxaGXvwIz74gOBi8QXv/
	CP6R04qrscsO80LmR4tjYWOwfUlVZcQnGiVmpyoRMQ2x/GxqWmQUwrRGY/x2ZcpEuc2oJ1tgyYJ
	8OoN7fZN4c9CEti5+coBkLmAy2JVh9c+gXRiV1vOIH+wB
X-Gm-Gg: AYBFou2qeHGoPiK7bdchAEp80PQsvFWqEz7oNYlEpwtxQjtXv3AyoTd4CEhVNNZ3nwO
	HOuwiTUdGSiWhoe8xXyyjsrpYZG8bVZIgyHF9OCr6qr/LN2qdNij2lk7Ovcgp/serzPEwZCYV+K
	yO0UwATvSU1CQK8GwB6ZccznHL67Mgn8ym0vwrMVWYsfvg9FTLpQtDj+OXt2TWiOyQPDUS+x3FE
	/mQMoJyOIYuObekNSC0Zfl3q1yRwwqQcllLt7KpAs1fM6mnJAetfl78bJHLXQiMkmumfKWZi9mO
	xPD+9D1HTemDS1uODB+F5eH2YRrwkDm9WJ6oKeOqf8ZopkZBR/rdbdc=
X-Received: by 2002:a17:907:9803:b0:c2e:1b6b:8b19 with SMTP id
 a640c23a62f3a-c4021ede38fmr383746366b.23.1792172616105; Fri, 16 Oct 2026
 10:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20261016141208.2641974-1-e.velu@criteo.com> <atJXYHJa4jkUWJmP@kbusch-mbp>
 <CAL2Jzuz1qFwLSA=iivp5qLCTL6-4rvKmvFzJbOQzjPu6j_7Y2A@mail.gmail.com> <atJeazM_rJ0uj3vt@kbusch-mbp>
In-Reply-To: <atJeazM_rJ0uj3vt@kbusch-mbp>
From: Erwan Velu <erwanaliasr1@gmail.com>
Date: Fri, 16 Oct 2026 19:43:24 +0200
X-Gm-Features: AclHuK_U0OkI4Zz6kfXZ9_-ZxJ0-awH9-QelwgmwTfs4tO35QwQMZJ4E5Ywzi5A
Message-ID: <CAL2Jzux8v6zCxfcdd=MY5n0zQMVSa-_8Lki9z-fz7bFShNf7vw@mail.gmail.com>
Subject: Re: [PATCH] nvme: honor the volatile write cache enable state
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, linux-kernel@vger.kernel.org, 
	Erwan Velu <e.velu@criteo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_104338_446854_E2F8E54C 
X-CRM114-Status: GOOD (  20.27  )
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

Ok let me clarify this.

This disk is configured by default with VWC_PRESENT enabled, but the
Volatile Write Cache is disabled (NVME_FEAT_VWC_ENABLE=3D0), so the
device has a Volatile Write Cache, but it's disabled.
In that configuration, even though VWC_PRESENT is set to 1 and the
volatile cache is disabled, the kernel treats it as enabled and
switches to "write back" mode, causing tons of sync and bad
performance.

In this table, with my patch, I've enabled and disabled the volatile
write cache using nvme set-feature -f 6; this only affects
NVME_FEAT_VWC_ENABLE, and VWC_PRESENT is still reported as present.
If the volatile cache is enabled, write-back mode engages, resulting
in poor performance.
If the volatile cache is disabled, write-through mode engages with the
expected performance.

Note that in the current mainline state, my drive is _always_ in
write-back mode because NVME_FEAT_VWC_ENABLE isn't being considered,
resulting in horrible performance.
That's why this patch ensures the volatile write cache status (which
the kernel uses to decide which caching mode to engage) depends on
both VWC_PRESENT __and__ NVME_FEAT_VWC_ENABLE.

Hope that's make it more clear,
Erwan,

Le ven. 16 oct. 2026 =C3=A0 19:27, Keith Busch <kbusch@kernel.org> a =C3=A9=
crit :
>
> On Fri, Oct 16, 2026 at 07:15:20PM +0200, Erwan Velu wrote:
> > Le ven. 16 oct. 2026 =C3=A0 18:57, Keith Busch <kbusch@kernel.org> a =
=C3=A9crit :
> > >
> > > On Fri, Oct 16, 2026 at 04:12:08PM +0200, Erwan Velu wrote:
> > > >   job                   | cache   |   IOPS | fsync avg | flushes | =
 gain
> > > >   ----------------------+---------+--------+-----------+---------+-=
-----
> > > >   psync buffered, QD1   | back    |   3885 |   247.6us |  116552 |
> > > >                         | through |  48325 |    15.7us |       0 | =
x12.4
> > > >   ----------------------+---------+--------+-----------+---------+-=
-----
> > > >   io_uring direct, QD1  | back    |   3886 |   238.2us |  116593 |
> > > >                         | through |  41924 |     5.7us |       0 | =
x10.8
> > > >   ----------------------+---------+--------+-----------+---------+-=
-----
> > > >   io_uring direct, QD32 | back    |   5088 |  6173.5us |  117793 |
> > > >                         | through | 140196 |   107.0us |       0 | =
x27.6
> > > >
> > > > From NVMe 1.4c (sections 5.21.1.6 and 6.8) up to the NVMe Base
> > > > Specification 2.4 (sections 5.2.30.1.4 and 7.2), a Flush command ha=
s no
> > > > effect if the volatile write cache is not enabled.
> > >
> > > Yeah, the NVMe Flush operation should be a no-op in the device, so th=
e
> > > dramatic performance difference is a bit alarming. Surely the block
> > > stack's flush machinery is not the reason for the difference, right?
> > >
> > > If the device's flush handling is this bad when VWC is disabled, what
> > > happens when you have it enabled? Can you re-run the same test with t=
hat
> > > setting?
> > >
> > > I'm not necessarily against what you're proposing here, but your numb=
ers
> > > are unexpected.
> >
> > Maybe my table here isn't probably clear enough.
> > The numbers shown in the  "write back" mode were done with VWC enabled.
>
> But you said the table came from tests "with WCE cleared" in the VWC
> feature. ?

