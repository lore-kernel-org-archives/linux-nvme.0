Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F3CCD6E57
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 16:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V9gnVT3oH7pg9EGYNvKnvI+9AGQyj9ITavfhYE9KZ0I=; b=CDlw3IiW4a7my2v3/a8Bsr3dy4
	E2yzimDi01vc15IcLNXhzyOi7Le5+/HKutvvKKbWpuhMRNYrnK44UNzVY9W6u8YT0ob4+bz31/4z3
	AaUknJ8w8BCLdEdf/g+ZmYLSgSK5Zqr0grnWdlzAIAsGsjcy3LgInRkmpBrv41bAMc0hhC56w3NY5
	gFtAFYd/DG4wBV8lubGAHVU0xAsqEyeBVZYb3ef1unA+tMaXTR7gyfucrEbHLfkObSScqOb7qA2ee
	VALHaaOL5cWlMjmGUm/2U7j5YKSnVeUQDW4ZYoGIJ2iho6canecVKfBs6vTH37Uiq7mhH7SGFbyt5
	nId/2Mrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wURZc-0000000DOy2-22Lk;
	Tue, 02 Jun 2026 16:02:36 +0000
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wURZZ-0000000DOwQ-2BiC
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 16:02:35 +0000
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-9153e2708aeso387115785a.0
        for <linux-nvme@lists.infradead.org>; Tue, 02 Jun 2026 09:02:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780416148; cv=none;
        d=google.com; s=arc-20240605;
        b=WIelGr02IhqBQcQLyKDjuJSHQT0qyLpIwwftSrlLSX8qTCSjkXIu0UQ8k8ZBqkyE2g
         3wSo8TDzwsNRFZBw/99CaLdwZuUXQBsYOKDmuTwxh5Ysu2uDdx0yANkN4U1lIN49njNv
         Bk2q2LDHgJoZXUGr24y52DZxUe8W68s9q6LAOVzqbvg3ydSdX5i9EatrVQgTwA9AmUZi
         sGdz3+nXr8lUGPzjcIoKz5soWCwOT9yi+B4p/7AMRoce4AmqZex7qPn/R5lA30rIsyPx
         F0PZfmbhy/idMCrcHRktIT5Ryg5EzgbthALiNi3Sebt/Du2Z1Ogg/hhOU5jlkOLgTuSb
         UwxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V9gnVT3oH7pg9EGYNvKnvI+9AGQyj9ITavfhYE9KZ0I=;
        fh=v0XzrlmZfj0qBHl13YzZMyrCS232EJ0tCDmH8eCMKQc=;
        b=Q/IjqqLoNw8ioSscFvlsFbm6lYtvBdOskdL2Svc3ZZNkxtRMf3SeEzKzbkutL7DoqA
         JQuMeYCbu7CaiNvA2umgu6rtkmMrrTQxh5jr/imFwa9Nm+Y8Z3NIkDmeEf07wXOPQiSV
         wl5S9evnXFniaj/JViKKqRkZUDnYIM0GSPFz7czdx/ctuGVdvK6rTLSzxo674+ixlEra
         m2KUwsqkqEWL6xDW+ijwzPclzyPnk1Kn5Z2wsXGgXUp2qOFMESKFWqDwuXEKbM8qOdMA
         oYzn8WpQJZHU9QcG7U7N1MYH7Jsy9Z0Gc4NpYOwQ0XNz2ARxfLbpIrnfN+gtKDI412J9
         +YDQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1780416148; x=1781020948; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9gnVT3oH7pg9EGYNvKnvI+9AGQyj9ITavfhYE9KZ0I=;
        b=e5jGu1aleWjNxzPrgt45PDAk42F+ySfwZMnEgU0jFaQssyMfaYxPCY/rGxg57G0rd6
         u/mV/x1Z5OKxhoa52iMu/Yif8wtEeNpJEoKtVAx3s5TYcr4UsCKLtcEmnIT+QCVgLyQ3
         9O7xYanaqoXFpuXOjXspK0lFf9LMLacnYSrxeFqKkGggIAc5hnan+fJC76rOPVvpBYHQ
         rdYi/vjV5GtU0XeJRiXxIbop/Qr8V4sV2qE0hZW8xAr4Gfcgg7sRFVoqXK4tky2fG6SU
         hMaod7R9fXA/u273qkQjBIAefs93BbvL1MgJNBe/3v218r64jXZhbPMfU3zpWavFZjEQ
         LAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780416148; x=1781020948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V9gnVT3oH7pg9EGYNvKnvI+9AGQyj9ITavfhYE9KZ0I=;
        b=IIZ80WEI1IWL6Q9Ia6f4JuRPEubC9OXvOC1BNX7kS2q29I7EfPhZlU8WAdWVGZw07t
         /IejQzGSRa0D7FbaAwTXK1bmSQeqoVbfTJ5osf2rr/Zefz194l9UvioLOnPsAV4m0x4Z
         6HHols20b4jtZs6c3ic5w+vpn/dAhT+68bOwRhWW7nqXtwvv2S1v+xZmHfYDngMqBSAn
         cPhdlmmUET0d3/ekzdBoAmfypcKnpdQKsIg9ojT2y/T0x27f06SR7cjNEiFWde9DUuXn
         gmJJQumBO95RJqunblJzge3wxgZbUjUckDjsNxXbhpL1MWtp5WkXisQssPWfjLvffLb9
         6dUg==
X-Forwarded-Encrypted: i=1; AFNElJ8bPGab0aIFvFS8+tHjWrBljKDI2FHt+nzZX8hZPKufQoKhPksuAS7oFYTXBL5momdXLWBd9AsyowoG@lists.infradead.org
X-Gm-Message-State: AOJu0YxKyI0wzznQ3pEvGqXD9QTuVtiaoWIO1FyZuRjsBuGuS6jIgwkq
	U70Nj4RHl6jNdu74ZJqtLcQKDbVozmowytasgGsI8XjemGpvT5GS9vfimSk9cjZIHasU4x93VJz
	5QsDNnatRyV3i2yag2VJq2bF7eYVdujnbmsl4GPc6Lg==
X-Gm-Gg: Acq92OGFntcW8tJ+bNINzK8EcWKBn8gBAJnYHeKdwPrirB190aKhXEggjDbLSAmb0uv
	Cs2HvZuP7GqCDvbUQytT8/WMDEJa9FWSogbCL6AsI2xEQ/0FVoJK2WQyj2LGEqe4CY5r7aZkwsv
	apcCh7rppc8fSmnHOurc3pnZu3l9lFsKeFNb/s2mULCLUiWIWwMRyEn/isEnrzY1iasNVSzqxfT
	g/6UKsU7l2qY69GUF8oHWTB2nDtOiXSL/QVv3VGHKHFWXmVSkn2yijL729/ARPxuOi1haGv2BZc
	k/PIvR0Z1IPXbqGMzSi3JcSR8vT5
X-Received: by 2002:a05:620a:2314:20b0:915:2404:bff6 with SMTP id
 af79cd13be357-9153d96ac0amr2038527885a.5.1780416148298; Tue, 02 Jun 2026
 09:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260529001354.1003640-1-sgogte@purestorage.com> <ahomNc0rSH6FRE8t@kbusch-mbp>
In-Reply-To: <ahomNc0rSH6FRE8t@kbusch-mbp>
From: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>
Date: Tue, 2 Jun 2026 09:01:52 -0700
X-Gm-Features: AVHnY4Ikddrtwg0OgG0j-GzEhFnldMiX8b-RU7OU_9NW_-Nvw5xAGeReOBhlEME
Message-ID: <CAMof9cVOrEiH=78Ly8kbBkGdXZ-LakVX_07=zA0eoZiXOAX5hw@mail.gmail.com>
Subject: Re: [PATCH] nvme-rdma: parallelize I/O queue allocation and startup
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mkhalfella@purestorage.com, randyj@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_090233_901654_3D7833F1 
X-CRM114-Status: GOOD (  15.02  )
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

On Fri, May 29, 2026 at 4:50=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Thu, May 28, 2026 at 06:13:54PM -0600, Surabhi Gogte wrote:
> > Refactor nvme rdma I/O queue setup to use parallel work queues,
> > combining allocation and startup into a single parallel operation per
> > queue. This reduces connection and reconnection setup time when there
> > are delays in establishing connections, which is especially important
> > for high-core-count hosts.
>
> Seems like a good idea.
>

Thank you for the review!

> > +struct workqueue_struct *nvme_setup_wq;
> > +EXPORT_SYMBOL_GPL(nvme_setup_wq);
>
> RDMA is the only one using it, so I don't think we want burden the
> common core with this. But I also think a new workqueue is overkill.
> Just use the async APIs. Suggestions below:
>

Plan was to extend nvme_setup_wq for other transports later.
But we can use async APIs for that too. I will send a v2 version.

