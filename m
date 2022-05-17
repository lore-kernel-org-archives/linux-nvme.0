Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AA4C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 13:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zRhw5sqFeqx9rdn4dxPQI/1ItNPhmYCSrx/kszU//Fo=; b=uLiKnIdvwM/OcL4joJnlJQMSIn
	D1CPvkoMmXwVXWNfh9L3ALqPzg4XXunEfZEmuYzVKbmaY/Q1z0VTsDb+KXGuCjihiBhyViTK3MpZ9
	u0mEjixcv4olCzCrX5gvMEYprVhXuSFSEUtdZRjbS9+Yespu6W62FQBnxS8fgLCzPXrPSQL/WLCGG
	dvjZrUvayFQfkVCIuX6JPG9yOEiEomPefFKtOM+xl/7CJq35C1Z85neSsbr3kXnu05hkIEyi8JgEs
	2+r9kyW+AwDI7cMKX/k3Luji0cZ5WUA7noLe/KGfxfTxutCoX/o+FRjVAjH7igHenz4GGMAAVE/Aw
	0dRbYUxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqxcx-00E5tW-TR; Tue, 17 May 2022 13:52:43 +0000
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqxbc-00E54H-Ng
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 13:51:23 +0000
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-f165bc447fso14356296fac.6
 for <linux-nvme@lists.infradead.org>; Tue, 17 May 2022 06:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zRhw5sqFeqx9rdn4dxPQI/1ItNPhmYCSrx/kszU//Fo=;
 b=Zcx9JJu2A/XxoIcD38p6r2As1HMPWvCofnMYMUAmZIiXKxxSJkI2YSHiN0g98kJaKp
 VdJ7/ARns3VVw2J5LEqEXgZcwne2BAktL9Ugd62oA7gCvGl7LPBEzr3yg85lkBPSNWzi
 VM12rGigzpzwYrqCd7c+quD2qb/WIGy0DOBMvEEPXv/WqatGKJohM0lmYSgAMPfqBiuR
 N/MlSrQJTK0/B1stGkQXU9r9J1UWLPicrRZFw0SGo1vBKg+kWhtDSniDLskZw7Mttya5
 GcywES95Fwx/Ic2GxgvkdNDf2o4h/DLD/KryxGPI747BSojHIs0ODI5MDNUgng9hWXJm
 nQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zRhw5sqFeqx9rdn4dxPQI/1ItNPhmYCSrx/kszU//Fo=;
 b=SYGWumDjqy6EOL5iKKTgQec86qkkm1jOYAZp3C90L89Ddcxu58LsPAA2zEMmfo/mMV
 2SIhcyi6IKA+B94nuovUfXlZ7xE6Gb2p615WmsCBbfq9imq1oq18TFrj2GUVD+SfUGwm
 1a83D244ICy4lAvtYKiQHA3r4tZZ6X8W7NEMklZj5RM+Fkgi5ov8aAG9wG4YMjJiFlGp
 I5zxERTHvFkqR4a9utF8y+vEAshyNxoSrZH8+up4MHGZAF9FdPJ/rem7vs86isQEZudL
 4/2lGegoowVnpVT98dn3ic1qLdVTpH1mkWcswA1p7EWEz0mQH7PoVwBgOF5HqU5Ug8rr
 YdKg==
X-Gm-Message-State: AOAM5324orbhcQfGmvVZpbnDE3gyseWAxr5UFGlbcn852ZTrPlXb4Gw4
 phoAxc4RtKivDiLvJE/OjaDw3gpQJtNAEoe0MMc=
X-Google-Smtp-Source: ABdhPJxKGQjd1MOfAsw41YEx/1jjJq2ugVjxv1NPPH84pV1jxJBSVJ6BPwMr5lUh594RhdHf/IqVRs1c5M5q9xFdvIY=
X-Received: by 2002:a05:6870:6006:b0:e5:e6f1:5f2a with SMTP id
 t6-20020a056870600600b000e5e6f15f2amr12695964oaa.160.1652795476939; Tue, 17
 May 2022 06:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220517053147.7925-1-joshi.k@samsung.com>
 <CGME20220517053712epcas5p20c6a2b123709d7df1a1df8c9b1c91125@epcas5p2.samsung.com>
 <20220517053147.7925-3-joshi.k@samsung.com> <20220517081520.GA14308@lst.de>
In-Reply-To: <20220517081520.GA14308@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 17 May 2022 19:20:52 +0530
Message-ID: <CA+1E3r+9CeNJAxGH8EzC+TSNgGt8GnLVCC9544_3v=pdgqmTbw@mail.gmail.com>
Subject: Re: [PATCH 2/3] nvme: enable uring-passthrough for admin commands
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_065120_875114_1C795AEF 
X-CRM114-Status: GOOD (  17.74  )
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

On Tue, May 17, 2022 at 1:45 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, May 17, 2022 at 11:01:46AM +0530, Kanchan Joshi wrote:
> > Add a new opcode NVME_URING_CMD_ADMIN that userspace can use.
> > Wire up support for the case when this is issued over generic char
> > device node (/dev/ngXnY).
>
> I would really prefer not adding this to the per-namespaces nodes.
> The do something controller specific on the namespace node patter is
> a massive pain both in terms of code and semantics.

Both block (nvme0n1) and char (ng0n1) nodes allow admin-cmds to be
sent in the same way (with sync passthrough) as this patch does. So
same semantics when we support this for async/uring passthrough, IMHO.

To do passthrough read/write (and other stuff) via ns-generic
interface, uring-application will need information (such as lba
format) which can be obtained only with admin-commands. And if we
don't support what this patch does, it will have to either -

(a) get that information with sync-passthrough from /dev/ng0n1. Since
we clearly separated async-passthrough with separate opcode/struct, it
will need more bookkeeping to keep both sync and async dispatch
engines alive.

or

(b) maintain one more fd (for /dev/nvme0 node) and use that for async
dispatch whenever admin-cmd needs to be sent

Given the implications, is it not better to have this up on ns-char
node and applications get to use everything (io and admin cmds) in
async manner with async-specific opcode/struct only?

I will kill this if you still think it is a bad idea somehow, and move
the code of this to patch 3 (enable only /dev/nvme0). LMK.

