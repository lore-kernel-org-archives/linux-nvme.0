Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177E5CA0ECA
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 08:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BRy58mtOMfLsnyOd5KeG4RjAf/fDpf2NPVmv4pRKN3U=; b=sLAdvg20trbDJ14rfgszDULean
	gAH174OINpEuqHWfcg1YTx5PRXaGJ8BAntFZownAUW2kdIqU55rAFVqOOlq5ujY5Q3zc73ry63+3Q
	y69uYEN6dYcWeSoCZwptSUKMfpbpgtLSImvz4qKuIzb9T9Z0Pcx7SYtp+bo4kign0Fg1cMtazuN00
	x9DLyGAePebgZztfZR0bS9Ksv0Jm49cCRng4wv5uL06glmLXs7GQmEb4RvSZ0UAlh+Rh+ofP8n8WN
	GzoygPBFPOucIZHs7HEMAmXcainw10HzpicFzuy+xX9gS2/QOSJLGFFtwFnssTict1VKFT9lyOGIw
	xAKeeMMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfySH-002WbM-2k;
	Tue, 12 Sep 2023 08:09:05 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfySF-002WZU-1L
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 08:09:04 +0000
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-501ce655fcbso8547804e87.2
        for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 01:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694506139; x=1695110939; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRy58mtOMfLsnyOd5KeG4RjAf/fDpf2NPVmv4pRKN3U=;
        b=lyaad5rG8PFqSshWyxNGy3cxavwxr4dD+GIUX6UDTnbSS0r+Ja95uloS2kV0ybKxPR
         fAv/v2kEzKc5fc6KTMG3mL0+5h0vSvGVeMPrMTo5FkIgMhTajcraqs+Eci85NhnSc5sM
         i4wV6tjdJ2iPGqF61+BYqOoKDIODqol3724LPtv6uiDCtOc+IY3g+pB7/ua5Gtp93zP1
         MQoqLzhNvheSpMOjgK+/5TJ32yBA3vS9/60ygzKbNbcbV3S7vAZCY1pUeaPObQTOqHFO
         QkW4lqCqmgJInB0iaqC4zhLTQ1ibqjE43H39WQbe/k878rMC8myZ5pvhcRbDv1+/ROnR
         Ab0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694506139; x=1695110939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRy58mtOMfLsnyOd5KeG4RjAf/fDpf2NPVmv4pRKN3U=;
        b=go66c8uFso5Um5COuBvevrhwkfNg67KWwa7Xt/iocNLKrrmQpxUdDnJ8LVBKzP66vp
         kp+5AI6TOKt+izp9cTzsVavT/QZPyz6qlgr+meZhv31viYQvUPjbd433N64jzHrzIeIs
         Uanj1FPsMpSwh6CmElBUxLtkU6HA/hpTJTPLxIWJWRwik6MTI6k/YP5tRQFv8WMohGqp
         iKscgtq6/l4AqCOyn09y0QBH7v1Q/qiKUUCk4SQrtrN0oFFW5OOcEwcBCfZP7CQLnMWn
         Wrqt9NkzmJfgLSUy0gAQG+GfWBl42nW8slh5S8wa167e1HSxroeMyoou46/1vYDL26AG
         6wyQ==
X-Gm-Message-State: AOJu0Yws47mwNzdMIcSZgk/QM1UvMA3CVg1rEw39+vlvfXUqRT4x+6/f
	R58ZrQli5mbLcvLrSw1ps46E1V3Gp25j1BgDGic=
X-Google-Smtp-Source: AGHT+IFwDwJhrpy8HowhIBYcBi/whf/X/T3w9uKWfcXrLILoGcUMzinlah9wOUe1t9L08eJ9Z5UmcgaMaRFE2N9j4uo=
X-Received: by 2002:a05:6512:33c8:b0:502:a56b:65f7 with SMTP id
 d8-20020a05651233c800b00502a56b65f7mr8526287lfg.16.1694506138521; Tue, 12 Sep
 2023 01:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>
 <faa245bf-e925-45b0-9827-b0c9c117e06c@leemhuis.info> <ZPc8v9-lHF4jAcxL@kbusch-mbp>
In-Reply-To: <ZPc8v9-lHF4jAcxL@kbusch-mbp>
From: =?UTF-8?Q?Cl=C3=A1udio_Sampaio?= <patola@gmail.com>
Date: Tue, 12 Sep 2023 10:08:48 +0200
Message-ID: <CA+4wXKCAYM19H7n4TpbnrtRy_Yv1JOjT3CHVuxh_18Mb7NB4+A@mail.gmail.com>
Subject: Re: Fwd: Lexar NM790 SSDs are not recognized anymore after 6.1.50 LTS
To: Keith Busch <kbusch@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux NVMe <linux-nvme@lists.infradead.org>, 
	Linux Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_010903_450944_D5DD2F65 
X-CRM114-Status: GOOD (  30.76  )
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

Hi, Keith... Just to give you guys a response concerning this, I'm
sorry for the late reply -- too much work. But yes, you are correct,
due to having tried patching the kernel in different days and too much
stuff going on at the same time, I applied this two-line patch to the
same source where I have applied the other patch that multiplies the
timeout by 2 and occurs at an earlier time on activation. I thought I
had an unpatched kernel at the time and ended up compiling it this
way. Sorry for the mistake, but I also saw that now there's a better
patch for the issue.

On Tue, Sep 5, 2023 at 4:35=E2=80=AFPM Keith Busch <kbusch@kernel.org> wrot=
e:
>
> On Tue, Sep 05, 2023 at 01:37:36PM +0200, Linux regression tracking (Thor=
sten Leemhuis) wrote:
> > On 04.09.23 13:07, Bagas Sanjaya wrote:
> > >
> > > I notice a regression report on Bugzilla [1]. Quoting from it:
> > >
> > >> I bought a new 4 TB Lexar NM790 and I was using kernel 6.3.13 at the=
 time. It wasn't recognized, with these messages in dmesg:
> > >>
> > >> [ 358.950147] nvme nvme0: pci function 0000:06:00.0
> > >> [ 358.958327] nvme nvme0: Device not ready; aborting initialisation,=
 CSTS=3D0x0
> > >>
> > >> My other NVMe appears correctly in the nvme list though.
> > >>
> > >>
> > >> So I tried using other kernels I had installed at the time: 6.3.7, 6=
.4.10, 6.5.0rc6, 6.5.0, 6.5.1 and none of these recognized the disk.
> > >> I installed the 6.1.50 lts kernel from arch repositories (I can comp=
ile my own too if this would be an issue) and then the device was correctly=
 recognized:
> > >>
> > >> [    4.654613] nvme 0000:06:00.0: platform quirk: setting simple sus=
pend
> > >> [    4.654632] nvme nvme0: pci function 0000:06:00.0
> > >> [    4.667290] nvme nvme0: allocated 40 MiB host memory buffer.
> > >> [    4.709473] nvme nvme0: 16/0/0 default/read/poll queues
> >
> > FWIW, the quoted mail missed one crucial detail:
> > """
> >  Claudio Sampaio 2023-09-02 19:04:29 UTC
> >
> > Adding the two lines
> >
> > =E2=94=82 3457   { PCI_DEVICE(0x1d97, 0x1602), /* Lexar NM790 */
> > =E2=94=82 3458   =E2=94=82 .driver_data =3D NVME_QUIRK_BOGUS_NID, },
> >
> > in file drivers/nvme/host/pci.c made my NVMe work correctly. Compiled a
> > new 6.5.1 kernel and everything works.
> > """
> >
> > @NVME maintainers: is there anything more you need from Claudio at this
> > point?
>
> Yes: it doesn't really make any sense. The report says the device
> stopped showing up with message:
>
>   nvme nvme0: Device not ready; aborting initialisation, CSTS=3D0x0
>
> That (a) happens long before the mentioned quirk is considered by the
> driver, and (b) the "quirk" behavior is now the default in 6.5 and
> several of the listed stable kernels anyway.
>
> It more likely sounds like the device is flaky and either never becomes
> ready due to some unspecified internal firmware condition, or
> inaccurately reports how long it actually needs to become ready in
> worst-case-scenario.



--=20
Cl=C3=A1udio "Patola" Sampaio
MakerLinux Labs - Campinas, SP
Resume Gmail - YOUTUBE!
Facebook - Facebook da MakerLinux - Lattes

