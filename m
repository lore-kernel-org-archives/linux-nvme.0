Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA88EE57E3
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 08:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YqeB+pTrr5cAsMJlHRRYIfDbkrEe51St3WRx29ZRt+8=; b=YS082rc95FHj6uVGLP7sVRUhSs
	kGiWtJzsdhhGZEmn1eWzgPykvc+rp2XFxSPdz7sbJ07T8PpeJ1t80D/Zh4VAIhu4Sox0FHQLojYYQ
	YPwOPL5Qvp01W/0pwvbtwJYsS92kHnTIyfULIqukrNNg7bGQweeXYzbPYZszU48y8XifcdqeXnV4k
	ioI1knjBMJ9so+g1OM/5wRq3P4Ek1jus4lJGJRzHMy9AKe7jdktnS31PhKxJa3NS/BUD/Wmsb1LMn
	1/YQXnqRBtGE1y9DO72SudXTjvbelm8jq6BEc6O6oRy0SAkfb4y+ejQSDaxlbiLHc069Ga54Or4lG
	2rh8B+lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeWvz-00DK4N-0n;
	Fri, 08 Sep 2023 08:33:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeWvv-00DK3m-2G
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 08:33:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694162022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YqeB+pTrr5cAsMJlHRRYIfDbkrEe51St3WRx29ZRt+8=;
	b=fDv1uytGnmibHc3tflS/U1TDfP+POtDroWpHfMoAnnjdAydUCuWJdtCO4ie1z1FTsT1OOd
	TV8moAD7Cw+y3pYzj8XswvHIXa5sHB21J9SshwmCOy+rePP0EddrSjLmxoBbi2z9/tCiF8
	p6c/06mKh7yXSm8+XEbpS6xY8HhcrWc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-O8pwxOKUM4O5UK2FwmZBxg-1; Fri, 08 Sep 2023 04:33:40 -0400
X-MC-Unique: O8pwxOKUM4O5UK2FwmZBxg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-26cf9b8f209so2324022a91.0
        for <linux-nvme@lists.infradead.org>; Fri, 08 Sep 2023 01:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694162019; x=1694766819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqeB+pTrr5cAsMJlHRRYIfDbkrEe51St3WRx29ZRt+8=;
        b=V0DNVfNDylr1lnY2lR9BoKATMqOdeJ+ovAccfcT786yL5yWI+m68zmvdb+tBQwp5j7
         hdOArK/prXaTIyCiVW3lhQ/7PKK7ct5L/KEnfFWYZT6a8Ay//FpHmzDD5l+fZT5mEcs+
         FqJujf2H8e8tC/RwaEiJ24TqI4BX/C4iwJA3w+fJlc5SnrTiM0Po673ajr6LxKtZed7d
         QvmwyTgMpmwSZ1GwW29c311728hZAqvnTLwtLi+bIV+fe2DJtaQw20VqTLh2ITG2tOK4
         D4zC6fN2JbrwVWBB2xoLfMlUQl9xgn9D6EG8NtQbF97fPo7ZedBg0PMr06ilK48k6789
         vfMQ==
X-Gm-Message-State: AOJu0YyMlgbdOlwyqivuD07stjHzp/glDF2cE7ZJSQyzd2eybJU3lhIX
	RoXL3+tNKinfNE7OuBA8ocqm7eUgjNA5Eg7FgM4GfScTq/yJikjGG85PLjo9eq3PCKiyFELgnkl
	V67zQsLu4a4ty3HHaszSqZQF22ZwVYEKu42jGrzcUkpw=
X-Received: by 2002:a17:90b:1958:b0:26b:698f:dda7 with SMTP id nk24-20020a17090b195800b0026b698fdda7mr2020734pjb.32.1694162019273;
        Fri, 08 Sep 2023 01:33:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnxfmKX2g9vghEPKjgyoluc2e9Bckn2aupy7SigWNAC+otlv3y6h8ZCDlvkcm+fPk0NRQjfhuXPyLiFsMDtEw=
X-Received: by 2002:a17:90b:1958:b0:26b:698f:dda7 with SMTP id
 nk24-20020a17090b195800b0026b698fdda7mr2020727pjb.32.1694162019003; Fri, 08
 Sep 2023 01:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
 <ZIcpHbV3oqsjuwfz@ziepe.ca> <3x4kcccwy5s2yhni5t26brhgejj24kxyk7bnlabp5zw2js26eb@kjwyilm5d4wc>
 <ZIhvfdVOMsN2cXEX@ziepe.ca> <20230613180747.GB12152@unreal>
 <iclshorg6eyrorloix2bkfsezzbnkwdepschcn5vhk3m2ionxc@oti3l4kvv4ds>
 <ZIn6ul5jPuxC+uIG@ziepe.ca> <l3gjwsd7hlx5dnl74moxo3rvnbsrejjvur6ykdl3pxiwh52wzp@6hfb4xb2tco3>
 <g2lh3wh6e6yossw2ktqmxx2rf63m36mumqmx4qbtzvxuygsr6h@gpgftgfigllv>
 <sqjbjg7cwcpjx6yn7tmitx6ttxlb4pkutgfbhdgxa2hi4hy6wp@ek7z43bwtkso>
 <3wxdjvmamxdk6s26q4hnxjazuajrp7xynfq7okywc2uzgcdqf4@ydiglvla3k3u>
 <CAHj4cs_mP7kmnKdm--tEkb_yE0saA7A_BBV21E1RQT8a+J7s0g@mail.gmail.com> <a9f6556e-c42b-4be3-819c-06cc302605e7@suse.de>
In-Reply-To: <a9f6556e-c42b-4be3-819c-06cc302605e7@suse.de>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 8 Sep 2023 16:33:27 +0800
Message-ID: <CAHj4cs97MYvh2DsdaHb+h7XiKNCOHG=ne-88X8CJJ4u1uYB5yw@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/cma: prevent rdma id destroy during cma_iw_handler
To: Hannes Reinecke <hare@suse.de>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Daniel Wagner <dwagner@suse.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Guoqing Jiang <guoqing.jiang@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_013343_818570_71A77C51 
X-CRM114-Status: GOOD (  15.55  )
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

On Fri, Sep 8, 2023 at 3:18=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrote=
:
>
> On 9/7/23 09:47, Yi Zhang wrote:
> > Seems I reproduced this issue[3] when I run [1] on the latest
> > linux-block/for-next with kernel config[2].
> >
> > [1]nvme_trtype=3Drdma ./check nvme/
> >
> > [2] https://pastebin.com/u9fh7dbX
> >
> But isn't this the same issue as the circular locking discussed earlier?

Sorry, maybe I mixed up the issues here, There are three issues here:

1. "BUG:KASAN: slab-use-after-free at mutex_lock() in
cma_iw_handler()." which Shin'ichiro mentioned in this patch and
triggered by nvme/rdma nvme/030 nvme/031 use siw

2. nvme/tcp circular locking on install_queue which could be fixed by:
https://lore.kernel.org/linux-nvme/20230810132006.129365-1-hare@suse.de/
https://lore.kernel.org/linux-nvme/20230726142939.10062-1-guoqing.jiang@lin=
ux.dev/

3. circular locking at rdma_destroy_id+0x17/0x20 [rdma_cm] which was
already filed last year but still not get one solution:
https://lore.kernel.org/linux-rdma/CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=3DRQ-=
7Jgcf1-6h+2SQ@mail.gmail.com/


>
> Can you check if the patch
> 'nvmet-tcp: avoid circular locking dependency on install_queue()'
> fixes this issue, too?
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                Kernel Storage Architect
> hare@suse.de                              +49 911 74053 688
> SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andre=
w
> Myers, Andrew McDonald, Martje Boudien Moerman
>
--
Best Regards,
  Yi Zhang


