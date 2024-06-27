Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08442C2BD09
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jun 2024 12:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=acffdR2Dzv6FH4UpBYv/dUGCQ2x4UkJfqQ9BLUqOnpc=; b=eHXlgMscMdAdIdjAutTl7mH7lA
	JfhmJrVVYcg1xl3F1m3GLofJQmAXdv5KtPrQMrx+zmeU26OZUAm7ryGRwJ7DCWEnI/cE7B8utVp1o
	Fc/vTvzUJCHKQ0PPVLjAQ1h13uvpontAQphTbgo8ETzEt61kglPC/lZLg8ij1rlwcGR9DjCBU5W2+
	jUeEOAmcrFxBk88nxImcFP7bWlO4KsisiG/bmhogIAUTs2xTCeEAvwQESfIbzQYLiUhPGa+oGo6Pc
	+uxXr8ahGP1T2Zx03AnpEsKQfgvvQntnkScCv+JD1U9ZpugEhVQKvROhv8SI2Avp38A6Rr5eNJ6ie
	+9/EzGqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMoKG-0000000AKYZ-2lER;
	Thu, 27 Jun 2024 12:34:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMoJn-0000000AKUY-2zQX
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jun 2024 12:33:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719491616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=acffdR2Dzv6FH4UpBYv/dUGCQ2x4UkJfqQ9BLUqOnpc=;
	b=QCUVcdT8h6TShAbIINEEIXi2/FvjqzfrCyVFNbXzoGhHxnFhw0Owm20wY7nkNeOktjFx8x
	/BBxtdvxkbAWzgvK0Pk3b1UwbFCl4QSAOT0K8OqmaPZDPX74HeTUHBXy8rx5cldwjcyROV
	szQMVBneU3KY1zChb8TpVnPQB+mZjsY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-n2KUmsANNkaBQwCDZVwEZg-1; Thu, 27 Jun 2024 08:33:35 -0400
X-MC-Unique: n2KUmsANNkaBQwCDZVwEZg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1faa9402195so8188715ad.2
        for <linux-nvme@lists.infradead.org>; Thu, 27 Jun 2024 05:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719491613; x=1720096413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acffdR2Dzv6FH4UpBYv/dUGCQ2x4UkJfqQ9BLUqOnpc=;
        b=bKv5VGiBqO2k3BAwZyiW5oSJYv82y+LBWTEmA8sB8jjWySlrFGyxjV9eyC195M75f+
         KDgS7gixwNa81D8mGIq0VyRsvbmETv/Wep2vT319YLKNkmCJiG/hcEcujw/1fQyTLLnQ
         H8hwJiAKUcOGyCllB1OPgcHtp4w7OV6zzy5q5H6lq/en8JEaa/huTjTtVdOwlm412mRW
         d7mP2fGGiIVkyg9f1+pPJsaXa0Lwi+jFwaU8RJflcprpHZVlz3TesfHyKDBx9CnHXx5L
         NamI21h57ifExzsiGSbCBmmSC7GkPGhfww/UeE9jnQM09NE8XsBn7OAKmXXigrMzPBIB
         NHFA==
X-Gm-Message-State: AOJu0YxfQaNY3EYyYPx0vtNDlC7fDyWq+zQvM8BPZ5V4eeOZc2AJmKTP
	26tQAXZZxV1d/al7lRrPfJou2yKa5WzEvXYt/1fhJF+zvs+FcfF2hXxrRTv+CwipHUK+Yua6JZs
	PhJ+eCOOrRI5qjvXIN/NpFvGXl+R4acZoAq57+KTnOnFgcc5RJmiBlBsSnuGsyJj0Lm8oMVkHqg
	Eb/+a7gavbMHDTg0FSWVmw9sFvNuLMZjJ8bpq/XXxADiVwvA7/FT2u
X-Received: by 2002:a17:903:41cb:b0:1f9:cf2f:507c with SMTP id d9443c01a7336-1fa1d62bc54mr148154625ad.41.1719491613075;
        Thu, 27 Jun 2024 05:33:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQvH0ye6N4QXgtJLZYW/V0SkefAqiQVlnU/uIT7jL72J8doKV7iXrTUkO7VumIArGCZTkl0SJNdivBKhOsHDE=
X-Received: by 2002:a17:903:41cb:b0:1f9:cf2f:507c with SMTP id
 d9443c01a7336-1fa1d62bc54mr148154485ad.41.1719491612745; Thu, 27 Jun 2024
 05:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_o_8hhGK9PUhqX-OV3SqE2i0y0j4f5x2LVuWWx_cHJ2w@mail.gmail.com>
 <ft3wp75xsypwwuihlxs57x5s5qrqwa37uegf45fsh5wko7qube@x2gkjnltl7wn>
In-Reply-To: <ft3wp75xsypwwuihlxs57x5s5qrqwa37uegf45fsh5wko7qube@x2gkjnltl7wn>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 27 Jun 2024 20:33:20 +0800
Message-ID: <CAHj4cs8yA2LGGM80TRdY2-MOn0Dqmn5hpVJ8XdNC=sza=iwWrA@mail.gmail.com>
Subject: Re: [bug report] Oops: general protection fault at RIP:
 0010:__nvmet_fc_free_assocs+0xbe/0x450 [nvmet_fc]
To: Daniel Wagner <dwagner@suse.de>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240627_053339_997278_DF25C6F7 
X-CRM114-Status: GOOD (  10.55  )
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

On Thu, Jun 27, 2024 at 8:01=E2=80=AFPM Daniel Wagner <dwagner@suse.de> wro=
te:
>
> On Mon, Jun 17, 2024 at 05:22:42PM GMT, Yi Zhang wrote:
> > Reproducer:
> > 1. start blktests nvme/fc nvme/010
> > #NVMET_TRTYPES=3D"fc"   NVMET_BLKDEV_TYPES=3D"device file" ./check nvme=
/010
> > 2. remove nvme-fcloop module during step 1
> > #modprobe -fr nvme-fcloop
>
> Known issue: removing the target module while it is use can trigger
> these crashes. We should add a blktest for this and fix it obviously.
>

OK, thanks for the update, I will try to add one new case to cover it.

--=20
Best Regards,
  Yi Zhang


