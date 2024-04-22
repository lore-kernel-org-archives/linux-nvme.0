Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB8EC4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Apr 2024 04:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3feHkqgPPy1+RGpuKoIZf5c3ACEkn4+zXOf51zMJUpk=; b=4PFGzkkyetwngFuWXZuaGfhw1V
	xTse5jn6WxCjnzKThvXYLJ089Tah21rwqgy+3ZtGsl1SgqnU97yzFoMNVEEWSZzeEhqMJP6xfobga
	iNtH6wBcVznVq793RPNrsGSdzEkJzj2UeNUnVhLvqr52XSSTRaDgye50Sl2KSjjvSXvSueU0HLJ4u
	1cA//GGWYgjo6IZ86v/dPQRAxPtc1K4b6ULjX3cmFFVeYZzU/22LdONqxNZTnF4CVwD3nlX3j+PVe
	wN+a4NFYdZQxle7bXbHxZ681mXH9mLEGMMi3xliNd7mQcwDJfUj/ZVisUOPTa8QwgXgSrmpfcu+in
	WOvp+JjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rylmR-0000000C2Hs-1Mqc;
	Mon, 22 Apr 2024 04:59:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rylmN-0000000C2Ge-3atK
	for linux-nvme@lists.infradead.org;
	Mon, 22 Apr 2024 04:59:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713761984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3feHkqgPPy1+RGpuKoIZf5c3ACEkn4+zXOf51zMJUpk=;
	b=GbzyAl+8yc2iQNmSBVnY/DUNHmpSty3G01UzH1c986DeZYM64u3Hd7YuRS20R4GN7qEPBz
	beKdO/8gx4q9gQeRwRYtCo+TuMRAGSqYdv0+23spwhF7AhdqQQzYpYGEc5UHqmul60R9l8
	i73KUJc42+Xb0MTwk2hyui4UmmTTABU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-SRAlZxH4MQO_hphdPv_ykg-1; Mon, 22 Apr 2024 00:59:42 -0400
X-MC-Unique: SRAlZxH4MQO_hphdPv_ykg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a5d989e820so5400478a91.2
        for <linux-nvme@lists.infradead.org>; Sun, 21 Apr 2024 21:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713761982; x=1714366782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3feHkqgPPy1+RGpuKoIZf5c3ACEkn4+zXOf51zMJUpk=;
        b=h08NaIAtygfJK+eyzhW5M7mGpwhStRaxeE8tgQlsXckbvgwebnkPBXyptyJGs1xDmx
         PaBAUmWf1gpijHFzwr8ve9YOKVzmEbZdk1fenBCfAfxHM61JV0XCSR2k8QPbCu+fJN8/
         qF87J8xeFU3Gogwx/adp4hcuFjknvWHvY1WJvF677GQRy2HjRat0F3wo2DczJ/M/H4sy
         /u7wiFucubuKncLCK3fdGiyKuLWScEYrW1xJzEj6yy0+6gETJaP2BKvHnHxb18Gd2MpG
         Zd8peHD/v8OiJtxRmlSce0Fb5l2oxJoSKey3VateYy8MGaVenK1o0UUJkoXNCGaONVHr
         EyeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr89u7f2VfUkoGgbocoPRjjfeZdx6MDmp1Uh5+9aSUVqqzdKoYD630UGIUoBGVxG4PgJBI7RV1g68X2lKGJHiq3xW5FHGOgLRmqzXC8uQ=
X-Gm-Message-State: AOJu0Yzi8hBFm2jFkmZDLFrX5bnKsreHxvxJRnj2zoZJm2QkRozjXj4Z
	MwacX1wypOXJwcmc49CCxwTfAuvowOMv3ZSAUTuOmGWV+wVqlhhFzcHIn6hwpbYAi6+U0eXu1mz
	yoRtd5cnMS8QBv3LrFZxiy6oVZBcxs6X755X60VzzCpHy5jwe7yzb/AMQsWF0zR2iU+zExEYBVg
	Bw8TVcK77/2Q+DAHBKSDrMjpSDF9NWYhR0JR+Ek/c=
X-Received: by 2002:a17:90a:6389:b0:2ab:a53a:6e52 with SMTP id f9-20020a17090a638900b002aba53a6e52mr7841409pjj.37.1713761981960;
        Sun, 21 Apr 2024 21:59:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEkCI65P6txzqz3iyqhbrRVGRMUVMFKgnJxfVOLFXvSKUenWM2+xiSOzJD+8Wc3loMYC1QTZqgf4Pk1IRrkds=
X-Received: by 2002:a17:90a:6389:b0:2ab:a53a:6e52 with SMTP id
 f9-20020a17090a638900b002aba53a6e52mr7841400pjj.37.1713761981617; Sun, 21 Apr
 2024 21:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8xbBXm1_SKpNpeB5_bbD28YwhorikQ-OYRtt9-Mf+vsQ@mail.gmail.com>
 <923a9363-f51b-4fa1-8a0b-003ff46845a2@nvidia.com> <ede49e66-7a0a-472d-a44c-0c60763ddce0@grimberg.me>
In-Reply-To: <ede49e66-7a0a-472d-a44c-0c60763ddce0@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 22 Apr 2024 12:59:29 +0800
Message-ID: <CAHj4cs9UN_pV_raSL2+wNRP9yBeJWkx0_GtHSQ0QoC3jYxhfQA@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed with blktests nvme/tcp
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240421_215948_093990_63E37ED6 
X-CRM114-Status: GOOD (  17.82  )
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

On Sun, Apr 21, 2024 at 6:31=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
>
> On 16/04/2024 6:19, Chaitanya Kulkarni wrote:
> > +linux-nvme list for awareness ...
> >
> > -ck
> >
> >
> > On 4/6/24 17:38, Yi Zhang wrote:
> >> Hello
> >>
> >> I found the kmemleak issue after blktests nvme/tcp tests on the latest
> >> linux-block/for-next, please help check it and let me know if you need
> >> any info/testing for it, thanks.
> > it will help others to specify which testcase you are using ...
> >
> >> # dmesg | grep kmemleak
> >> [ 2580.572467] kmemleak: 92 new suspected memory leaks (see
> >> /sys/kernel/debug/kmemleak)
> >>
> >> # cat kmemleak.log
> >> unreferenced object 0xffff8885a1abe740 (size 32):
> >>     comm "kworker/40:1H", pid 799, jiffies 4296062986
> >>     hex dump (first 32 bytes):
> >>       c2 4a 4a 04 00 ea ff ff 00 00 00 00 00 10 00 00  .JJ............=
.
> >>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ...............=
.
> >>     backtrace (crc 6328eade):
> >>       [<ffffffffa7f2657c>] __kmalloc+0x37c/0x480
> >>       [<ffffffffa86a9b1f>] sgl_alloc_order+0x7f/0x360
> >>       [<ffffffffc261f6c5>] lo_read_simple+0x1d5/0x5b0 [loop]
> >>       [<ffffffffc26287ef>] 0xffffffffc26287ef
> >>       [<ffffffffc262a2c4>] 0xffffffffc262a2c4
> >>       [<ffffffffc262a881>] 0xffffffffc262a881
> >>       [<ffffffffa76adf3c>] process_one_work+0x89c/0x19f0
> >>       [<ffffffffa76b0813>] worker_thread+0x583/0xd20
> >>       [<ffffffffa76ce2a3>] kthread+0x2f3/0x3e0
> >>       [<ffffffffa74a804d>] ret_from_fork+0x2d/0x70
> >>       [<ffffffffa7406e4a>] ret_from_fork_asm+0x1a/0x30
> >> unreferenced object 0xffff88a8b03647c0 (size 16):
> >>     comm "kworker/40:1H", pid 799, jiffies 4296062986
> >>     hex dump (first 16 bytes):
> >>       c0 4a 4a 04 00 ea ff ff 00 10 00 00 00 00 00 00  .JJ............=
.
> >>     backtrace (crc 860ce62b):
> >>       [<ffffffffa7f2657c>] __kmalloc+0x37c/0x480
> >>       [<ffffffffc261f805>] lo_read_simple+0x315/0x5b0 [loop]
> >>       [<ffffffffc26287ef>] 0xffffffffc26287ef
> >>       [<ffffffffc262a2c4>] 0xffffffffc262a2c4
> >>       [<ffffffffc262a881>] 0xffffffffc262a881
> >>       [<ffffffffa76adf3c>] process_one_work+0x89c/0x19f0
> >>       [<ffffffffa76b0813>] worker_thread+0x583/0xd20
> >>       [<ffffffffa76ce2a3>] kthread+0x2f3/0x3e0
> >>       [<ffffffffa74a804d>] ret_from_fork+0x2d/0x70
> >>       [<ffffffffa7406e4a>] ret_from_fork_asm+0x1a/0x30
>
> kmemleak suggest that the leakage is coming from lo_read_simple() Is
> this a regression that can be bisected?
>

It's not one regression issue, I tried 6.7 and it also can be reproduced.


--
Best Regards,
  Yi Zhang


