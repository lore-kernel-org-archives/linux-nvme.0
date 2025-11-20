Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8D8CF885C
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Nov 2025 13:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1j1mwtDM2Tr4by8W9IObZodW1ax59zk4BIBZFcSUeBs=; b=WhY5OBdnfMAj9LflU8TbF4hqDU
	/P6aDVbaVEwi5CauqxuGd/uXk3y+AbowU2JJhZso80i2oCgzFuSr3p9P/lX9fW8FUpviW2Rggf7aS
	tAD2urWY47EblzXdxOEXaWH6wtk9VZhMsa9GgpvwA+fDbXoSpq/JvVzIF26g9ZUgln3IrBbibSz70
	Bsp3Gz4dBg7/nHawxm1YNJ8oYzl9oFoYI3BJmopFSP9MaUiXNkthuJhK3ELtWf0cwXgXqCeD/pVsx
	AOQry85U+N2W2tjmMhBocPWGKcHScupa+kQ6VPVT06uYud5n6TIVra0u1z+vHEMCplXD0NJzDsrLM
	EkEpT3lQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM55h-00000006lts-17xE;
	Thu, 20 Nov 2025 13:52:53 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM55e-00000006lt6-3bnx
	for linux-nvme@lists.infradead.org;
	Thu, 20 Nov 2025 13:52:52 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-644fcafdce9so1346304a12.1
        for <linux-nvme@lists.infradead.org>; Thu, 20 Nov 2025 05:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763646768; x=1764251568; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1j1mwtDM2Tr4by8W9IObZodW1ax59zk4BIBZFcSUeBs=;
        b=gzUT1cngK3jnxp+dQBtju345EtHMRPN5/ynPjS8pVb3z54dY1epEwd9oY5CSq8XoTn
         TZXVt+z/3OQr89dbFjaVr5a78g0CUaDXs6S0aFX9GvnR6ybQekxqB4Jakm0867mqEGw1
         2QxNIxk+dlQdXgNSdRwtT6koI0K4DBKYjEZPu2xo8xqeFbSdCw6sAp7ctWsk850S/sXU
         ZzTcEcQhMxDru6JwxvXWtqHnIgovTJNAW/ogntn2dYr7dVebAY+60vP4dFzoGeP+wkKH
         ef7mOzjItTbWJiJMXFoJaah4L5iaOSZWjWMr38LK64bPXc7thvwn/L7EoNdSQfQ8gmWd
         6Amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763646768; x=1764251568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1j1mwtDM2Tr4by8W9IObZodW1ax59zk4BIBZFcSUeBs=;
        b=xB1OpLo10kdXgSRL58UooOUHKqA04+LKMtKWXXNNHgAaKswvKk1oBiWIiuEmHqcyu5
         iq1xJiyc3L5Pyd3jrPoqjjZZjZ3mr+Jvt3dLgHAV1/dC+TLHIPYl2/KsQ8F++F7JbUqc
         d0vHys5g5b+6PiW5E5EnIJZ7J+rK669PBHXi2eCYlEevlR2zyM9HRhdzJgMBkeP7zeHZ
         gRSHC/B0XhiChnGkPrfxIOV9YCbOxKgNAcfGoNuJTTNUf40RZpR9KDvk+it6LM/u7ukD
         R0yHyKuujX0Yg5MyxEoToGNXFNInJrAuyUF7bpiWi0oa+ICAx2Swf7nrc1mrv0fXq5e4
         GzGA==
X-Forwarded-Encrypted: i=1; AJvYcCVZsuRHt/+p2ZDXRDUV7Qi+qM3eQSdlxa0IPKbc0obj1uWFvJ4BP8WuanAt5qKsxnlDuTvZDNsxlSJi@lists.infradead.org
X-Gm-Message-State: AOJu0Yy6votRLuqgiKXbYIuGckvBI1vmuGf6mkUeMqoWYTRqudzVny2L
	Hs0R+ngjHv504YxdtT+9MO/yH0F+DOd0LBAsLtAU0Vuq+F+CKVcJwNZ+P4EEYxozXUi3ziHmYwX
	Pb30xg1ymu/9+97Ew+Q6wWANtsPX5RI8=
X-Gm-Gg: ASbGncs77Xg24bMiXT9k0hSQ4FvUpo9O+LmSlk/fPBhuWfvZ+ICkf/GNEAfosi9F6PS
	CNjVvQWlWGn+NUhVBlmYbEcrlXLRfqx7v+FhxSRaucDA4l17uQG2z5QIM/YMLJF+8VZiMV10Cc1
	wzi2ByOoUVV8DtKJMSa1B2pJr7D/eF3iI1+p3fa39Cgl2QQtYLEjyBW1PdxvAidhPUoxl6Ye/ZE
	HbFCATF/PRHapMuJBS6x6wmlTxRLrJA+jQEp+JonQqqNK+mHT/GRHRrOBN5+b7rojr8OyTmXTYD
	28TQfqbqqLF9lXl98J5ZaUDcSozsgHSnDg7UanR1m/EduTTpfGXT+4Ky3PvTxhiIu8hMZwjKynw
	5+ctoRcKxp4rk0Opbl0EKfkY=
X-Google-Smtp-Source: AGHT+IHUXB1kp6zrYBv6auSQMAL/sgB0VPXpLwXG5pjIHFCT7XGZo/7zo/8Ujx6/q2Kbra3iLMvapvXsSsE74W/tFhA=
X-Received: by 2002:a05:6402:40c9:b0:641:6535:6ccc with SMTP id
 4fb4d7f45d1cf-64536402014mr2925732a12.10.1763646768323; Thu, 20 Nov 2025
 05:52:48 -0800 (PST)
MIME-Version: 1.0
References: <CACbz5yFi8hiPD0Avg=KVTpdEeJC=3MMSkGtYOBQ=OmB_O0khyQ@mail.gmail.com>
 <aRzb6U1se40SrQRM@kbusch-mbp>
In-Reply-To: <aRzb6U1se40SrQRM@kbusch-mbp>
From: Thomas ten Cate <ttencate@gmail.com>
Date: Thu, 20 Nov 2025 14:52:22 +0100
X-Gm-Features: AWmQ_bl3y2pawOYKcPVHvJcKxuWAaIacPRETQh2uNwfRV1iZn-6nDtoP7kE2BS0
Message-ID: <CACbz5yE1RNmJkg-RSBe2u60Y5yd1zxkEZ=pVy_gTa2JLh9d5xQ@mail.gmail.com>
Subject: Re: "controller is down; will reset" on SK Hynix NVMe drive in Lenovo
 IdeaPad Pro 5
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251120_055250_906723_41E40742 
X-CRM114-Status: GOOD (  17.20  )
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

On Tue, Nov 18, 2025 at 9:49=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> The "report a bug" message was originally pointed at hardware vendors
> rather than kernel. Something is wrong with the SSD, the PCIe slot, or
> both if the power features cause the endpoint to drop off the bus. The
> only recourse we have in the nvme driver is a quirk to disable APST for
> the device. The driver doesn't control the PCIe ASPM settings though, so
> that would have to be a different quirk if it's really necessary. Do you
> need all three of those parameters, or is disabling the nvme driver's
> apst sufficient on its own? These parameters do have a negative impact
> on your machine's power consumption, so you'd usually want to hone in if
> it's just the deepest power state or if every power saving feature
> really needs to be disabled.

Thanks for your reply!

Just `nvme_core.default_ps_max_latency_us=3D0` appears to be sufficient,
so presumably it's the drive, not the bus. I wouldn't even know where
to begin reporting a bug to the manufacturer.

Still, it's odd that the problem manifested differently, and much less
severely, on an older kernel. =C2=AF\_(=E3=83=84)_/=C2=AF

I've linked to this thread on the Arch wiki [1] to let others chime
in, in case a single report is not enough evidence to add a quirk to
the driver.

[1] https://wiki.archlinux.org/title/Solid_state_drive/NVMe#Controller_fail=
ure_due_to_broken_APST_support

