Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A82C369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 22:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iaUHLg0dvW7boTjUUUvyGYJuf0k+x8BYZi5xJbGoCrE=; b=HJw+3rDVKm6eOCh0Dy/C9g/ooC
	XpCNSMUsZfb0ef8HNLrhbjbq7ORgS6oMrK+AmJtP8UFvH5R+tZsMe8PfviiQ3eFitErBjqQKOneyG
	B4F7HmfDy3M8WmkRDnW9+awSn56vqxDLH1k0p0+Ct39TmrIebtn2QRgwh/XkOUTAuFnPixFkbALY9
	dzAPkB8IMYCeBDjPiWrPKGAzgE48Z3ZUhiM6JdWJ0GHErLzgtmoO2tgvBacQTJM3aFVkGUZqF6mmr
	IYYSef6XL4VNSg5O4RhI83sWMgsaNkMNcVRsA1YMj3EhYuLdsIRT7RMEIPNtRXN4PFtv5lp3zqEQA
	J1ynR8tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9t4V-0000000Aw8O-3xvG;
	Tue, 29 Apr 2025 22:04:59 +0000
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9t4T-0000000Aw7s-2Wyy
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 22:04:58 +0000
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-875b8e006f8so2446770241.0
        for <linux-nvme@lists.infradead.org>; Tue, 29 Apr 2025 15:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745964296; x=1746569096; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaUHLg0dvW7boTjUUUvyGYJuf0k+x8BYZi5xJbGoCrE=;
        b=VwzpoxPtBUVTMeo9l43XxuXk9ef02KN7ltIBjXcPW0YsRGNLXcNo3g8GfgUwd4kGgd
         rBNZKAwtI+JVzc3NreHUpQfpMm3GZEk//8mSO5Biu7oGU9T4TQNCn4jVg/qRejQ2SeEE
         WFYmVZgz28BiBXHw99YGK/GtBMF26y3ZCp8CFVF7jjau3f/TUvgloKcGsgeB8Gshn/7V
         aRa5n5t0dXnw57fGIG5V5j5EiwYJUUd7ySOxpRqIXrU6Gc10LN+BHO5qXpfz171Yq0+q
         zHKMCTu3C69GnPbrMT/d5m3tnfbYyawprc6XPyJAWg+rbnX8m4d81oqgoH7w8FkSbQM3
         Wd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745964296; x=1746569096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iaUHLg0dvW7boTjUUUvyGYJuf0k+x8BYZi5xJbGoCrE=;
        b=OJNZlq0a0ARZoIz5kDbepHlV0K97K+5T3oWgzC4Z3wPx16BuOgnCGq83D73OuXvSSm
         LyAzBHWRWRiO/pzENM++2aSC2Cp6Uho6vVMHIuBRv/09Q3rA3WH69SWxA1HH6gRpEfgi
         OI/Ubqmid+ntVz0y8djwMHTklLZtsayCTCjY2AVSz9dSuhCM6D3W3ka1HSL9e7aI4vNz
         SWxSX35bw+80DUg0KlmGEnT95pMbvsPcXnO3tSByvBotYO0XjUxnPMtwNgDuvIAG1tin
         /vKSWGFZmhH1v94M2tnkth53G/0PrT+p7lhfcyZbwVJdo0Q7IzwFvNV8hzad2f5Pt6zm
         ZpXw==
X-Forwarded-Encrypted: i=1; AJvYcCVRQdZuYNKmazPnclscagyTOEtLBR+PGb/+TRrsUAHNv+qhZuFXMD54sM3GP8dy4LvNRbUUYEqUxyZ5@lists.infradead.org
X-Gm-Message-State: AOJu0YzVvMKuMRiTdZfOKCy+/iG7mLWLN2jyw9MiXAerCZUNiXW/lKJ4
	SMjKXH8NI1sdQdZgtr/wncnrLJ57ld+IDLmyLCK3D4++sHIIOMrUl2T1Ox9Jebpy0QeH7mgU7qU
	Hh8VkLJURcWPUgOr130s/SwkRCm8=
X-Gm-Gg: ASbGncshBqEtDUE1xro/fWoN0dYUJ/m/+VhXodfbMPIX73NsAk1xjQqAScpepxLZEKF
	kmmX8QxY4Zk5gwF6PQvF1iwkJ1z0EC819hcyc+g6PHOPzyd8glsGI3ElYV8HwosOjdu4duBwqwB
	V2R/l9pCF+8o3FvElpUxecMdgLmNDHjXBeKS+SvMRpnUP3oTeA3jCLkJ4kFjyDiB8=
X-Google-Smtp-Source: AGHT+IHrW5PKeQEDp0a0r+ljMXTdHqx4SsIY3Lt49lIO3TlKoEwST57w3Hw/dVsYtfCoLK6co3qKpVMvds+sdwumiKM=
X-Received: by 2002:a05:6122:222a:b0:520:af9c:c058 with SMTP id
 71dfb90a1353d-52acd7a3977mr904933e0c.5.1745964295676; Tue, 29 Apr 2025
 15:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250424101333.2908504-1-alistair.francis@wdc.com>
 <20250429125505.GA13574@lst.de> <aBEPcVursIG8fab6@kbusch-mbp>
In-Reply-To: <aBEPcVursIG8fab6@kbusch-mbp>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 30 Apr 2025 08:04:29 +1000
X-Gm-Features: ATxdqUE9I9yRs_Sv0ELYR0FjEo5w0O9A-VsUGc8YEBhKMma9pQyKFOd0PNZ40nQ
Message-ID: <CAKmqyKO=Fv8g0+EGFG6LAHqMCvXY2BEaD8ujB=h-SmCyQVnWow@mail.gmail.com>
Subject: Re: [PATCH] nvme-tcp: select tls config when tcp tls is enabled
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hare@suse.de, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_150457_639954_C204A41B 
X-CRM114-Status: GOOD (  16.32  )
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

On Wed, Apr 30, 2025 at 3:42=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Tue, Apr 29, 2025 at 02:55:05PM +0200, Christoph Hellwig wrote:
> > On Thu, Apr 24, 2025 at 08:13:33PM +1000, Alistair Francis wrote:
> > > Ensure that TLS support is enabled in the kernel when
> > > NVME_TARGET_TCP_TLS is enabled. This allows TLS secure channels to be
> > > used out of the box.
> >
> > How did the code even build before this?
>
> The nvme tls code doesn't appear to use any symbols that depend on
> CONFIG_TLS, so I guess it would compile but wouldn't work at runtime. ?

Yep. It happily builds but then just doesn't work, with no obvious error.

Alistair

