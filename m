Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA0CCCA46C
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 17:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZgxsgKvEhHdyXpM76IfVHoQp5qK7bpr2TwN8jd0TCdo=; b=uv7j6TQ2R6knxxrXCxCxzqeqrU
	wrXEBVvYKib1MFz8JgCjpl7WUlRH39EOy9K3aj/Zw8Icu/ygZE22rnz5pGck1k/Epq6L1T+488B+w
	hOePg+6+T3MD+dgVhbWa7hRsqrjLgwab2W7YdvF2fouchj813D9HAjgNUAeqJJXwxIuKArZZXTC2V
	/6zMhY23+DhjEUpEuz7wRtPvn6h4rSsgstRq4dUD1B4NBCFajCeVm5lAj9EmCBFFNdW8TFssw/ibu
	7UCGuIYMs8U5BKRquoYl5flWTKqAWPzGK3ndyCqLJVZ8lh8NfLaFKrWlR5dVRKqWzHqol6tH0Oct/
	4oF0TEMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHlWr-00000003X96-3VDn;
	Fri, 16 Oct 2026 17:15:37 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHlWp-00000003X8L-2AaM
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 17:15:36 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-c247f6687dcso20973666b.2
        for <linux-nvme@lists.infradead.org>; Fri, 16 Oct 2026 10:15:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792170933; cv=none;
        d=google.com; s=arc-20260327;
        b=fE2c0POg4CjefjlbgcC9EAh4UJF7uEFIQiYwZcjeLYlTQsowf2HG5dzPOinNYqjVcc
         qFxczSyg2JV3o1I8TpjAPA+JYm1WyRkGM4OUdYGnemLmOSNKO2hqfDkkzU4G4+6WtcfO
         Fj3kVeHM9z6fkE2QklGtg6r5ce9qkpZNewhdUde9qctGt85ElxM2GnGL+Is6BBjyBsk9
         b1O81eNvDQ8Yuv7dPXGO4B3OP7WhQPf91+xZ226DED6eBPAYjhHrhUWAcky74wbJo9xr
         /h3W7ScUfhfHhc5hby1LMu7+f0U9Wszt21SyHCXWd5haIhUL8swqOYWyxTcVVeJJanFy
         oZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZgxsgKvEhHdyXpM76IfVHoQp5qK7bpr2TwN8jd0TCdo=;
        fh=Pew3xRwvPFZY6K0526PoLQD8tpumB6YxH2J/LeqXK90=;
        b=Ou5OI7AV2hZKOKhEp0x8rg0l+8zTVtDNPnDtBs+fWM36uWsnInYb7vQi9sSKzag86V
         OSaV5aYYypmed0ZgsLVu1Y7B5QXu35XBDZf+WVMXetwNXK8K+4tcbrSthj9HvsWksd4I
         PxOc4PJfnub8Atewe0nOQllOnNJccRZp91y4AaiLpGctUQ4ZBNEBveahv2ZvVQOpl8fK
         b6EKGaSk/Rq261jlqaEd8x2/tKXI/fd+KaF+a5pypqkqAaprpFHrV8sWXL5MP+9G+fFS
         ZlS8gY5Km2xXKdARWzU5lxcd+6trCamPsVfQly0v8YZ0mRVFn5jpomyctefxsEMq9oxM
         nzbQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792170933; x=1792775733; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZgxsgKvEhHdyXpM76IfVHoQp5qK7bpr2TwN8jd0TCdo=;
        b=na1306o05ShnJPJDUgCDiDO4sFSB2L9W9B2xr98o4f+ezPalAwsCQYYwEb0JyA4eJi
         uaO+rVmpXekjSY+cNMfWm2ZqpZCf4sYm/NlPgSmMoIUZ3LJXA8UNGsEVq9oprsmHmI/O
         VME8Kn35MrjGTFRqY+LmzZroBI04d/kk746zALEWZnLNEAzMY6TIGm4jToBTgPMxdwvg
         gztwpIq+ECo28t9G/oVOpfaUsD20MNNbOcsO+VCxHSjK2KDbS2nWi/K3QsRN2daHp4YD
         1LTsA9Su4da1JFbnLZuIBfqpLTCrP1fszowqWPYj3CYZjIjUNOCENHZBW+/Y5atNyjIH
         2fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792170933; x=1792775733;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZgxsgKvEhHdyXpM76IfVHoQp5qK7bpr2TwN8jd0TCdo=;
        b=aNYX8MbK8j/gDh2odhFyMbbLRgAEbthSImH0BLQflYrUvuxw2bsOGEpWKXSfNj5zKw
         BBjqKQgmautmHNCE+ogsl8TseuD592oONPXvCw8ymlmTj2sc0XgwCfr+MqC6OZIBbkLb
         82nWoH7r5FO425P/pWYEB8V5QgzFCYkKnnQAWzvavJ8nHkQYGujw+5Zjqe5FuoGhL2Wj
         K+v0zgemOLPhnV4dbop7m9tpVO5Ysa5OPmWZT+ua4x9ct/ZPBP68thtf+BNgnORtmsVV
         0x0xfsPJP3XyEwFpJboP41UaiHOKGgpIbVs8iQ7joUpIgfNd3sFNp0hNFXaCb4U1vnv+
         HPvw==
X-Gm-Message-State: AFq9FYJCxl+lq9nmIXnQP7J1BSl/AhhnTQKV2JKFi/6kCpubXatA0idB
	eQR2JuLdrfbIxjhPcgcs6vasX0KqGfl32GjVmkp/Nk86iIWK0sl5rqAiH9/LGi9zlj+lvouh4Aq
	Wfkw0csr1ofdyKesu0sHGANP4Bda1lVU=
X-Gm-Gg: AYBFou37aBw2goqXL3fwJ7DU0J/gSg/IZRZRf54QfI8iFD9SeECs+IxaUk41r9kS2bq
	JGRPyX3uADQYH+PY0pVTnIU2Er+T4eBnNlX20a58WLM9LRMzX+/Jz7uucG3AwwRsKFlNX72THYf
	xM2GeAU8mWGjtpF/GvhfiSo/a6sfL0pJ9ULnX++IyL7OCH0BGGrpOyKH5dRZKaGBt7VpjL57uMb
	bQvCrXYXYbqJLjFB3AIcLQ1BY+Ir8IIJ7R66l+sMuiwf/zBklZTqlJd1sGOdB8Ui4pa9BC4xvza
	aWtuUnFB/CI20aVXtDe9F4SxZvdp8VRmGmf9Mv2UEhnbZSijM0MEGTg=
X-Received: by 2002:a17:906:9f90:b0:c31:e19c:fc4f with SMTP id
 a640c23a62f3a-c419d83af2emr40954266b.14.1792170933227; Fri, 16 Oct 2026
 10:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20261016141208.2641974-1-e.velu@criteo.com> <atJXYHJa4jkUWJmP@kbusch-mbp>
In-Reply-To: <atJXYHJa4jkUWJmP@kbusch-mbp>
From: Erwan Velu <erwanaliasr1@gmail.com>
Date: Fri, 16 Oct 2026 19:15:20 +0200
X-Gm-Features: AclHuK_r4vb9kbzFWLHQ6q2g0sJIA58TCtZTbc6GcrsDVimIHbp4lA9EF6qeKpI
Message-ID: <CAL2Jzuz1qFwLSA=iivp5qLCTL6-4rvKmvFzJbOQzjPu6j_7Y2A@mail.gmail.com>
Subject: Re: [PATCH] nvme: honor the volatile write cache enable state
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, linux-kernel@vger.kernel.org, 
	Erwan Velu <e.velu@criteo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_101535_614827_0D8EB99B 
X-CRM114-Status: GOOD (  16.06  )
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

Le ven. 16 oct. 2026 =C3=A0 18:57, Keith Busch <kbusch@kernel.org> a =C3=A9=
crit :
>
> On Fri, Oct 16, 2026 at 04:12:08PM +0200, Erwan Velu wrote:
> >   job                   | cache   |   IOPS | fsync avg | flushes |  gai=
n
> >   ----------------------+---------+--------+-----------+---------+-----=
-
> >   psync buffered, QD1   | back    |   3885 |   247.6us |  116552 |
> >                         | through |  48325 |    15.7us |       0 | x12.=
4
> >   ----------------------+---------+--------+-----------+---------+-----=
-
> >   io_uring direct, QD1  | back    |   3886 |   238.2us |  116593 |
> >                         | through |  41924 |     5.7us |       0 | x10.=
8
> >   ----------------------+---------+--------+-----------+---------+-----=
-
> >   io_uring direct, QD32 | back    |   5088 |  6173.5us |  117793 |
> >                         | through | 140196 |   107.0us |       0 | x27.=
6
> >
> > From NVMe 1.4c (sections 5.21.1.6 and 6.8) up to the NVMe Base
> > Specification 2.4 (sections 5.2.30.1.4 and 7.2), a Flush command has no
> > effect if the volatile write cache is not enabled.
>
> Yeah, the NVMe Flush operation should be a no-op in the device, so the
> dramatic performance difference is a bit alarming. Surely the block
> stack's flush machinery is not the reason for the difference, right?
>
> If the device's flush handling is this bad when VWC is disabled, what
> happens when you have it enabled? Can you re-run the same test with that
> setting?
>
> I'm not necessarily against what you're proposing here, but your numbers
> are unexpected.

Maybe my table here isn't probably clear enough.
The numbers shown in the  "write back" mode were done with VWC enabled.
The numbers shown in the "write through" mode were done with VWC disabled.

As I'm doing lots of fsync (on purpose in this test by having
--fsync=3D1 in my fio cmdline), you can see the "flushes" counter is
very high when VWC is enabled.
The impressive numbers (more than 10x) come from this workload : lots
of fsync for little data.
Please note this patch is following an investigation after a report
from one of my users complaining of poor latency on this NVMe drive
series in particular.
So this isn't an unrealistic use case; the impact we see in production
is of the same order of magnitude as what this patch reports.

Erwan,

