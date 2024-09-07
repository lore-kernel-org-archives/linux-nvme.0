Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA7CE6FE4D
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Sep 2024 06:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rjQU1QeLt59MiSHO48W4SSULpumhuxHPIcuQGZ8Goe0=; b=MF2f5eH41DB7sRidepZjYW1vJc
	lxtof48GaJrhUzGGC+5w78oVG06tJnjpNdAR7yixSWjYulnL3vTp98bT23F2iLGgoUcd16OEXxJZA
	UPipaA8j/IdrShWLocLIY/kjAs3u7GNBRlcFOYYM6T/sFK+eCTJCU7cc1UtyWxW8WEyy5x13oZ4bg
	KA0eMbjMpePPFMqEEl1YI9hbl50KKHudKehVIFprSMoO7TaXrTLjnl2WxNhjdOI2E4LFbjFDNqcvD
	en1H5Qtf+GBZihojjtEhHv+Y89VFeWXeV5d/PdiPaW69q/pihGJYbbI/7LSmx26t0xyHa0kRrf8u+
	SFh9pDIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smp55-0000000EV2J-41z0;
	Sat, 07 Sep 2024 06:37:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smp52-0000000EV1k-342X
	for linux-nvme@lists.infradead.org;
	Sat, 07 Sep 2024 06:37:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725691073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjQU1QeLt59MiSHO48W4SSULpumhuxHPIcuQGZ8Goe0=;
	b=PPunyF4/QmCS2ObzDknNX/dbD7shUeLlL+Y91vtDqNviXFNOkOoQf/sYoY5MsWGFkkdmOb
	3yMFMPvgcf9S/2AYGhj6OGXa7ulc2xL/+UGiz6s+hlUQhKW6FgHdePDD9k9ZAGVhV4kDgg
	8y6YngQPFmqUTaPiN6QF9V56DeXh3Jw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-rNDL1isBOR27IcSihXmTuw-1; Sat, 07 Sep 2024 02:37:52 -0400
X-MC-Unique: rNDL1isBOR27IcSihXmTuw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-20556f1cfebso39689525ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 06 Sep 2024 23:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725691070; x=1726295870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjQU1QeLt59MiSHO48W4SSULpumhuxHPIcuQGZ8Goe0=;
        b=RUfRn6BMPJbCoM5Q03ySHsg4Bsi012Rz+1szt9WPqVTf1Qybht+1NSJj3wyBqhuyQl
         MFdRuTgm14BCIc2nIbVJYzSDPfQh8hm1lojMxd9eq8CT4tyJjmLXV+EhOrwrBK/HWoHF
         zNdMy6n4tVTddbMtoK4qtqKu95GcIoTjlOHfn3XKy2ySvNYCYyFE8nOErl5iYJSULJ7f
         KrDVA4eBhB8Q97uI9qSCmF8vYdnMU3+Kr/MObzRNDvx/5nX6pDH2gYPt8MTFbz4zsRb/
         QlHAvR6/sCcX4J7T7e1wMvrENizJwzzUCG4r6LvfN1YP5ukJUQhlQ0dKcZ0/sCsvxzeX
         Vtjg==
X-Forwarded-Encrypted: i=1; AJvYcCXCnHgz87WJg3joohoBxdyaKyQHHYasVr94Zh5zyAavpfV8TYrhrC4Qdbsv/XmISUDP2rbvS41WsgZN@lists.infradead.org
X-Gm-Message-State: AOJu0YyU51cmfx39Zjs3uyM2Dyh7o8PwVijHWKDeW5j6tgmXGtf8wTim
	7D2sh0wdOMJYnzoU2+vrzRjjn2f4Sqp28Ifm5P87VKALiMVzoqeMvvAoON/BfC+MqNTm/kHAgIe
	+ENPR/qnDFs/8uf5oK/tQI8Ldc8mPgIbDs185FOSw6oO1eb8GpRZOcB5FJ+TvpA5N6FKJmyMcz+
	lIyBoqcfy0Q2fmFW9qYUiBOcwYZ/W0VC8GIMyIiuIHybDJ5MJnb94q
X-Received: by 2002:a17:903:41cf:b0:1fa:9c04:946a with SMTP id d9443c01a7336-206f04c9dd2mr64553195ad.1.1725691070532;
        Fri, 06 Sep 2024 23:37:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ29SdijpTBv7ZRgvH/AH/T9uuUK+QtzHvNpWO62vl0wkkG72JzN2WeUlkoOFIKoSGEVJrk+pqrx/8+MDbUhQ=
X-Received: by 2002:a17:903:41cf:b0:1fa:9c04:946a with SMTP id
 d9443c01a7336-206f04c9dd2mr64553105ad.1.1725691070238; Fri, 06 Sep 2024
 23:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240902105454.1244406-1-shinichiro.kawasaki@wdc.com> <x5e7cl6iupvspx6eadustxbzt442cprye77dh7u2rjl32xajg7@egnrpr5b73so>
In-Reply-To: <x5e7cl6iupvspx6eadustxbzt442cprye77dh7u2rjl32xajg7@egnrpr5b73so>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 7 Sep 2024 14:37:37 +0800
Message-ID: <CAHj4cs-hhV0S+BmLyn++LSE=V-hgE7JTqQDJYtxRjAExfRwuMw@mail.gmail.com>
Subject: Re: [PATCH blktests v3] nvme/052: wait for namespace removal before
 recreating namespace
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Nilay Shroff <nilay@linux.ibm.com>, 
	Daniel Wagner <dwagner@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_233756_865349_8E9C7594 
X-CRM114-Status: GOOD (  15.36  )
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

On Fri, Sep 6, 2024 at 4:22=E2=80=AFPM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Sep 02, 2024 / 19:54, Shin'ichiro Kawasaki wrote:
> > The CKI project reported that the test case nvme/052 fails occasionally
> > with the errors below:
> [...]
> > To avoid the failure, wait for the namespace removal before recreating
> > the namespace. Modify nvmf_wait_for_ns() so that it can wait for
> > namespace creation and removal. Call nvmf_wait_for_ns() for removal
> > after _remove_nvmet_ns() call. While at it, reduce the wait time unit
> > from 1 second to 0.1 second to shorten test time.
> >
> > The test case intends to catch the regression fixed by the kernel commi=
t
> > ff0ffe5b7c3c ("nvme: fix namespace removal list"). I reverted the commi=
t
> > from the kernel v6.11-rc4, then confirmed that the test case still can
> > catch the regression with this change.
> >
> > Link: https://lore.kernel.org/linux-block/tczctp5tkr34o3k3f4dlyhuutgp2y=
cex6gdbjuqx4trn6ewm2i@qbkza3yr5wdd/
> > Fixes: 077211a0e9ff ("nvme: add test for creating/deleting file-ns")
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>
> I applied the patch. Nilay, thanks for your help!
>

Thanks for the fix, I've verified the fix on the reproduced server.
BTW, after the change, the executing time also reduced to 7s from 22s


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D294
nvme/052 (tr=3Dloop) (Test file-ns creation/deletion under one subsystem) [=
passed]
    runtime  7.759s  ...  7.673s

--=20
Best Regards,
  Yi Zhang


