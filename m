Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBE2D116F3
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 14:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Ht3XFr7/7WOcNzTNEuT0DuzzCseuuyaUOrQvdMSUmw=; b=w7YFbksk9gqsw6BX41zw1QCnV7
	xtoPgFT3SlIVmwvvzNa8W8Wja5/XAvBrTr0yaZozatQFcHLmmvJDLWxwEeDN3QGnRQV5o1b63yy8V
	73q5VoL9HWZGTV1FF8cxAVMi3WuqOyry8LZMp7lQCF82WU+Ddz32dGDfLkBWMd3H3MLa2/bXEc/UF
	FLEmYjr1nFOL8O940+DeuJJhwPjtgsfg/2Ct1ZUSX5dXkhQlzm+4KMItsE9lPXUPCyoF0HmqumiL9
	o9LiwCEOBwmUVLM9KlIhsluWZCxZwXqC8BvyFWX/V62k+1HpOTE1z5Z1ZcsfN+UTjW9sKZPJt/FlI
	m7qfigaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ4eS-000000043xz-0DbJ;
	Mon, 01 Dec 2025 14:13:16 +0000
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ4eQ-000000043x9-0Ozx
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 14:13:15 +0000
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-657044fea68so1878557eaf.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Dec 2025 06:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1764598393; x=1765203193; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ht3XFr7/7WOcNzTNEuT0DuzzCseuuyaUOrQvdMSUmw=;
        b=ihXAHceeIrNLeTUPmltsK4rGcdIrChH042gv/lRlJuATrx/iywyr/iDuXLqJ4+HI72
         WM7B/kAeKqVvZq6g7jDkcwAgOIHGGvyd17SYnu1Iyg73PT77NPvA3cfs72hrQqLzwA0d
         WefE2wcgYy4myYt1nH1xpPvuOaEfYczGoHYZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764598393; x=1765203193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Ht3XFr7/7WOcNzTNEuT0DuzzCseuuyaUOrQvdMSUmw=;
        b=vAQsPiUhv3r9NrNAft1pYnp0GTUlkGdXpYBIBQnvDs8EYvCtBinSpyAdZ/WF5F+7uM
         iI6uvVESDegzS2m16wPWHFAL11wc+N8PG1JAEdvq7v7tnO4AvKYn8E965onHoarerhEq
         D8ia+80t3byp+0ScgoO86O0NPFS6jpV4CNqM12PQ/aBL4ICi+q6IX94dh60zPwTtTcWf
         7SzqAfNynkeoCXOn88sNrt0w6tef8OqDXrqYUEtYwFTp/oDkfepzzyXzHLHNcTemeP1R
         j3VGWy7QgJhFbjjjhpkK27SiOQd+sKPKuskGOdZnJKFk3v5e5vJQ4lDGLNqkDo8oHGoC
         e7FA==
X-Forwarded-Encrypted: i=1; AJvYcCU2vkUPkR3/pN3/6wDk708enIJb8PyAJ2pNcrn6HYDvva6GUNBIoYqQyZbSTpqCJd1PBL+gryc7A8qO@lists.infradead.org
X-Gm-Message-State: AOJu0YxVBHvsXMMYDQzs0FPnGhbSgf7LhBEOAVtvYuTGIt4iQKWtSz+K
	1ozOrFOVqpQCER/DmSPPmZh7XjFJuwYVEENK+ydOpodQPamHUh+RyacplBdq/6T0+QNd6AJHPbH
	g2731hGQ+SrguTKZ0j6aUwkVwzt248nwQxTOqXzVJlw==
X-Gm-Gg: ASbGncs8AwdHSO5lrGulDxtoFpn89l9ItMiXZJ5e3pzXW4JjPng15PCYpTpMSzDOKQz
	j36L6vueB0GC73G7FSc9t0ld5goNAkvFyfNb1XbrDNXkn8Q5ILu5eFTaYdpggHlrrrdihvHoitT
	EJi4YX1renw1NopBRNJATUIyJ9TBNdrkhT1RyEYTOGRK/TkTBibBt4oyHmWlRqICSBDYGZmuaf8
	pg4OXm+sowA0YL4pd1okUJp7g61gi+EbvDvYA/TPxfHncG+CK9X34AjQeWfLbKGt/fVGCgHVU1s
	6uTf6tJEPfkpHxNWrZYmfVjRHnDYBiRr5cIBHScYC/zkk3JF55usKegjvgqO19k=
X-Google-Smtp-Source: AGHT+IHBbgc8lB9i54rXSqzF6P8AJv0GIEgsiuXhi6WtMVciJYCjym2BMgYs+T9pSsyV1Wq14+HPqiEfCQEl0yeRACc=
X-Received: by 2002:a05:6820:1524:b0:657:432e:a820 with SMTP id
 006d021491bc7-65790eb8958mr14276460eaf.1.1764598392784; Mon, 01 Dec 2025
 06:13:12 -0800 (PST)
MIME-Version: 1.0
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
 <aSXDnfU_K0YxE07f@kbusch-mbp>
In-Reply-To: <aSXDnfU_K0YxE07f@kbusch-mbp>
From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Mon, 1 Dec 2025 09:13:01 -0500
X-Gm-Features: AWmQ_bk3d93SsGZafRPWCihS1bzPTNFEpmuf6SICcoksQ9XfTkFEcuzxLZZu8X0
Message-ID: <CAO9zADzUZYzM=xkvHPXepQP_+6V0f4__yroPNV6feyPB27Ju=Q@mail.gmail.com>
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
To: Keith Busch <kbusch@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org, 
	linux-raid@vger.kernel.org, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_061314_132942_7FDF3749 
X-CRM114-Status: GOOD (  13.80  )
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

On Tue, Nov 25, 2025 at 9:56=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Tue, Nov 25, 2025 at 09:42:11AM -0500, Justin Piszcz wrote:
> > I am using the latest Asus ADM/OS which uses the 6.6.x kernel:
>
> It may be a long shot, but there is an update in 6.17 that attempts to
> restart the device after a pci function level reset when we detect it's
> stuck in nvme level reset. For some devices, that's sufficient to get it
> operational again, but it doesn't always work.

Nice, I was not aware of this, thanks!  As this issue appears to
affect different consumer-level NVME drives, any efforts to address
the quirks in various NVME drives to restart the device while keeping
the volume intact would be awesome if it is possible to- get that
point in the future.

