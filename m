Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A401CDB479
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2026 00:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qY6KgmWUgw7fhczkkTMBwJb+99IHOmGzkMWso7v9Fqw=; b=cVRVV1czR9aC2vSsM5Dlzksvbi
	v31BlwJNBq5e2ndWDJm8X88QcjZHF5JpNt08X9W4sC6DDXJTUrNUiuWmXobTVv4WIL/7hEn5Ik3RS
	sbP6oPFEXtel0bXlAsN0B+IcqP1tYL5iEHjjrG3zfp2mV3OwdWEzlgAtN4IKmMkAww9Rh4BnFpCVA
	PiAuax/WA7MUlBnTJ+2cC5Xnoy+mAP60HSHweXdixvdaRWtWFojmnnM0dfUhxJAkra7j7E/6QjTVQ
	H32VkJospZ+Gf/w6GdPFwcYZwGEHZXrv5FYNI4bZ+iF7LJepOGCxU1/xkxN7N4n/eg/4kX/cF4mtB
	66fm73UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcYLP-00000008UQi-1z1F;
	Thu, 25 Jun 2026 00:53:27 +0000
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcYLL-00000008UQA-3Q7S
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jun 2026 00:53:25 +0000
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-727fad2be54so551819137.1
        for <linux-nvme@lists.infradead.org>; Wed, 24 Jun 2026 17:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782348802; cv=none;
        d=google.com; s=arc-20260327;
        b=F/V5RgmVH4cJP51qQnynBTDw5O8RYFuBeV4ICCruqIq2Xe0zBpAauJMjz1RnB6ergM
         6FTBFQQZGEg1xRu5ghSTm9r7ukpwOO6ua16CryoIa17TnF3Jjr3yHNV7o+xyVHBBxt6o
         Zk7Mu99QpUP/qApu6hzwyE+RA8oFUmVh0BVotxnsVnMgY1jSDKP/6FT/N4krHHgqvCR+
         rP9J5aEyuijuJiJB7deXMoWaYGyOQrqCwDPkbrCWFkTX6jID5DCWHqGP7RrcyItkwt33
         62UyPJcfu4JCL1s62IEOeSP/355nFwYWDIbe0FAEpKCRIRUvE/ZX9578g71UJbsIC6Zr
         X2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qY6KgmWUgw7fhczkkTMBwJb+99IHOmGzkMWso7v9Fqw=;
        fh=qlXgARVhmFfgtbs2l9sAAso5ydyQLHyfSBokLUQWKDw=;
        b=boWm7MefOdSLYoBlmTDv+qf9Cw+Rmw6MNsfy4/2EOnI0Dh6sf3+Y3PEinnyAed1qhL
         2oJ8MpVrNTrd/amSfaHT/LQ3er4YS9hSLTFrzka0EOL//54SU9QlvLiWVo1NHX/gOlol
         +qsSQs5a9AXPxnyXS+ik70n1IIOto9RuyItrLGFrx0C0W9GfPOwNsBEcKEFS6kChpUK1
         Y34RiuJ7AziNZX/ZBz42o3s8b6Gj0cStJZbGFPlFmVkfsnAEmDzkKQPi//6ImgMhCcgg
         e3MpxCtp3mjNTYdWuvPGP6LwbWgidSBbcKsOJiGjipz938h9O+H73jsO47FAcb5pCkNX
         uZJg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1782348802; x=1782953602; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qY6KgmWUgw7fhczkkTMBwJb+99IHOmGzkMWso7v9Fqw=;
        b=wMHkx2LSzpHWwQ33E0x705Jq2UWZPdkh6KubFcx5vJ1Sler4qAYKsUkJ5vk2MrznLF
         6kOugNxrG7b6Y78iLF8NjZ2fnhznyDb73yDt3mvQ23yKtXHV8jqH4knywZR2GDp4i6EZ
         M1LNN1rF/5gGTDlUvv5boup9OT4eVfrp6X9yRhoWeSORd6j/IBDBkjIjuT18Jg8g6nRT
         NEVUiibMZMWR82tHUqvbq6FaIF9Sg6G+6nEr1uivkAZJICKZryVoBV/3ZlcDXmINSb4Z
         5DGZ53ZZPLvsEZM5yI9kjnAHzn2HWk6siNEgdR9nb/lwS2gSlGrPyvKpqzcog/7cVP4h
         J/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782348802; x=1782953602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qY6KgmWUgw7fhczkkTMBwJb+99IHOmGzkMWso7v9Fqw=;
        b=Wsvs7EA3YdDcz5wkmLTiNRP0sBorfeZ4SamWT7ij8Oek1pB0/qDshpXSFVhqaEyBAW
         LHHDGOTjBWT++dQYqnZmrH2Vu8ueMk40NxkhTUGiMq5HC7K1Hr/O18H6hmRLqimglync
         n+uGBcAWq6YaNGZoAUoJLoUVjDW1aOVm7+EKwviJIeGHb1TLLJJ1Q9nfvWevOZ1yVTbW
         UlXKZtmSj0BNry2WlUZgqLmHsx1AZ8kgHAaKaUuVCg2H4KJlYzgmtDQmDCXnlALVTSJR
         PAqhVXCOrjMgHktNgGh9nzKXwp7+zrr3DqOIo4desvzVO/Z5SYew8GWZc3OlRXDCWSQJ
         aSlQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro05ytFrfZdLH5RKOQFDf2aIr7PAU7neJcc6tlUtSLYc3bNs6RqD26bPxaARBBLMtChHPkDxySf9Nkw@lists.infradead.org
X-Gm-Message-State: AOJu0Yx39y32N35eXkKtGJKAYhimrI0lcW/1SxLg/SJfk6N4oZq58F/v
	+bCQsvgTZ4ci5BmlwEcwT62MIP0jXEyfEfboT0anU3L5BRNKif31UT8OUv/QY9Sl15k8DZCfr0U
	sUU+znUxeKQKv3j43Z2kmnoSkQ9NADiKFDeNQftTrww==
X-Gm-Gg: AfdE7cm8LObGNzodjeUtRPBV74xN5yPRDk4X6jzivxuaVesMz1sX2DxlvS4Cmlo4qJq
	Xo+rfV4HFzB2hS+qHA1rwLqA2aL5hJkLs6jbD1giaxOCaJOX8HDiW/4s77Jxz2pB+15G4Ncmb7I
	W+Aj/24HDtd51M8AosjJi8KwzOZekPXo7gbfewW3s2m+8tqPu6PGu+slZQjTxNtWmS0cfxWmDk6
	jY5lUN29+sTRmJMouGamsiyUZgtdyHKwTg2DYX6ikgGXiqJ+GwN5NlZr6JNkj0S9y5ogqEbmW2s
	YCgT+cL5jbPjUsBKRoh8+Jd44h8+P/aN5bixpjipK7sjlmdsMWcsgVlkGUE=
X-Received: by 2002:a05:6102:3e20:b0:66b:a0d7:abc4 with SMTP id
 ada2fe7eead31-73430d8bccdmr122489137.0.1782348801771; Wed, 24 Jun 2026
 17:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <DGOQMFJJ6K5P.3KLF45WQT2SAS@arkamax.eu> <e43b914c-2ca5-455e-b0fe-3ce2eb0c64bd@redhat.com>
 <aaCNtpPzP9TIDNjE@kbusch-mbp> <869034b1-c7e8-4e35-b153-43fd787a8edd@suse.de>
 <aaXE4s3AT45UIAN8@kbusch-mbp> <DJBICZU143X2.3S261SDT21N0V@arkamax.eu>
 <ajRpWLqaEyA6cwkJ@kbusch-mbp> <531aa19b-a9ae-44f7-82ce-3714621ceee8@suse.de>
 <ajWOWdD0P5ri9bWY@kbusch-mbp> <d46493a3-3c9c-4799-bd63-e8759f04463c@suse.de> <ajxXMblhuipjnbtS@kbusch-mbp>
In-Reply-To: <ajxXMblhuipjnbtS@kbusch-mbp>
From: Randy Jennings <randyj@everpuredata.com>
Date: Wed, 24 Jun 2026 17:53:08 -0700
X-Gm-Features: AVVi8Ce3Xi6Wvuopbv3TazswoE4m1dwi9cB-m_9FXoP2lZ-zwtOvtLKD2Qf4kjc
Message-ID: <CAPpK+O3tdk7X34od+WoM+dM0BQCajjDeBOUx1jja0zF0uUuUmw@mail.gmail.com>
Subject: Re: [PATCH V3 0/3] Ensure ordered namespace registration during async scan
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Maurizio Lombardi <mlombard@arkamax.eu>, 
	John Meneghini <jmeneghi@redhat.com>, Maurizio Lombardi <mlombard@redhat.com>, hch@lst.de, 
	chaitanyak@nvidia.com, bvanassche@acm.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org, James.Bottomley@hansenpartnership.com, 
	emilne@redhat.com, bgurney@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_175324_075617_4C735AAB 
X-CRM114-Status: GOOD (  21.75  )
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

On Wed, Jun 24, 2026 at 4:02=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> > In general I fail to see the issue here.
> > Any modern distro should be using persistent device links to access
> > devices, so the actual device name is pretty much irrelevant.
> > We on our side haven't had any issues here since ages.
>
> I agree there's not a real issue here. The suggestion is purely a
> quality-of-life improvement to provide a visual clue that aligns with
> people's expectations, reducing any surprises. There are people and
> documentation that still think the "n1" in the nvme0n1 means it's NSID
> 1. If we can easily align to that, then why not? But I'm not exactly
> needing this feature either, so if you think there are some "gotcha's"
> here that may destablize the current scanning, then I have no
> problem shelving this one.

There is the issue where the NSID of a specific namespace can change
when there are no hosts connected that it is attached to.  It does not
happen often, but it can need to happen (even without namespace
migration).  This is not speculative.  Over the course of years, our array
has had to do it for specific scenarios a couple of times.

However, the more fundamental problem is this:
> That said, many users still rely on /dev/nvmeXnY links, for example for
> some nvme-cli commands. Because kernel 6.11 made these names totally
> random across reboots, it's causing some confusion for them.
Relying on NSID to fix references to a specific namespace is not a safe
way to operate.  And making the device name predictable leads to people
taking these shortcuts.  To find a specific namespace, the NGUID should
be used.  That guarantees you are on the same storage.  Enabling
shortcuts that are not reliable is not a good practice.

Sincerely,
Randy Jennings

