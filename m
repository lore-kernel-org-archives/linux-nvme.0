Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842C0C79FAA
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2026 08:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h5a67p9bBINgQ7LBbBcS4dRSdhOilWoAw3aEd1cEzKg=; b=AuWUc8wjZ4IWi27Zt32c0/NTBo
	oUZ9oDE2Lt3jgPJu/xt87LzcCg60PNO0lT4aLlS2967jVKAQfu4OkUNKivgZxrf5uYPdqjsvdlt7v
	LPIFNKJqYisq38+xcYNTeU42ZoiFSfAavgFN+GjL97ZH4kAeO7vIHgSMSVdeirxV4nqHOw32Re9Xe
	s5xRrqhLMumuGX0Z8H+m8eZwiVsXgQc40L+t6I/SqFD5xnWJUBR/LOfwBnPVzBcivxv4S25PH9kDQ
	CQy2pjpdZXc9Spu9wfDXXVPU+jD6OV3j/43c5HpYK7u/G0jI8at4Q0Ke2VVBGbMWN1daTQVf43qMi
	aUSWwUkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4DKU-0000000B3i3-3boI;
	Wed, 09 Sep 2026 08:06:50 +0000
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4DKT-0000000B3gh-07yt
	for linux-nvme@lists.infradead.org;
	Wed, 09 Sep 2026 08:06:50 +0000
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2d6ff3aca07so64395ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 09 Sep 2026 01:06:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788941207; cv=none;
        d=google.com; s=arc-20260327;
        b=TXXdknBAQokPC6MYinBoEoektQdcCpjB0Bbvn5GmmKaZcXiEQZPe9jU6eruA9qmdWk
         DzyRhpGcVxNECYSRtrRwPYA3K7EcnixS4dFn/s/9TmUKrGiQAfSsRcR+xi1L0Lhti9Vo
         fFZizJAp6aWQb+ywJY/0vQbnqgi8fSaCdR2k6jQoHiYJB2kCitDD+dFb1YOJqywvFWHd
         yVerQrqnG9H0w51CKrzbHMxPVG1EyRCNw72o9YJXPJb3XIc3I7EQnEUb97CRjCd1+qat
         oQg4kvKK4c2cUP2agMMxiGefmo4d8i3P4J361adfUvf2UJjx3LxyblCT7clT6vu+8si9
         1jqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h5a67p9bBINgQ7LBbBcS4dRSdhOilWoAw3aEd1cEzKg=;
        fh=vyd4vSNiCB3ECP6cIPGt0N5x5t27bz0toacqw04UnPE=;
        b=sMyUwV/XSc0LKrrtZV1j0sajGo8ej2e1Vl5ay30wzYl1L81heaHFK2KgQskMycC60r
         HSrJXkDiVD8U0/wCg7zRl1yVmWllFdiklbcmrkdPCNHeN2WfwBiC/s+C5qbrgTYd9qk5
         AnGu+K61BPS/SJ6PZtBNKiJXkXD9olZ+3tgJGXYd1pPT9C6hzL1XDf/xuO4MdTcYiovw
         3abtzJ/Tt8U20daJ+YBOfJSMVVGU0OJsRNDdSXbC6eU7oXogP73LtnGG/z+fpnVk6N++
         l/89rHeO8ERjmcf+dUQunishf2N/g/SPteN00T8Wg1F0oTkmRh/rFuqh8DLvo0dTpzah
         NIgg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788941207; x=1789546007; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h5a67p9bBINgQ7LBbBcS4dRSdhOilWoAw3aEd1cEzKg=;
        b=nqGzz072lUtyDxug5IwgZ1ydpBseKnedszqXXvRtYs1DYARDelDbxU2HTaquirOW44
         o15e4XaZHhrf9w2cdx8RibQhD2wy76NS56yLWeEN7nua+ZC+ghK2ZOIYCtIJLF8qSECx
         WQgWnph3PWCk4y4GeGgWDcT3jOri2H6f8zanDl7L4ZzfCKum6Xjy7tQsNUmPhk362flP
         Rb39OtdGXa8uK2EeaUCXcFb4Dr88r5QZxsh01wEXzu2wNSUWuS5YzyPlQPXbOs+dn3gE
         pkj/a4K35uKLP3k/FvBxVQ2yvqESHGepVJNj6HkDCHsvNcD8xMNLWIsD/D/hjJLfUpXR
         CRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788941207; x=1789546007;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h5a67p9bBINgQ7LBbBcS4dRSdhOilWoAw3aEd1cEzKg=;
        b=naMa4UDoaV8itxivo/9uZy2cgGEG/cIl+BwanzZ6uMT5kX6cI/u5GtQdXSBVv/KJA2
         A7j4V8AR+tlFnv18bq4LYV0I6Qt38jCXDxFpb2kYcLU4fR0o1KcmmzCUCykKNTyCrw96
         B73evfZTYSo+bq3r7QGcklPLDYCBMahtn4a4xVljYg8b0gF/4Zz9W9T1Us/yERz0Sz5n
         07adoHkNEFTuD/S1V45fEi1WbmyM/5b7iwZmPyaFMYNvlzHINJk8lgGKBaD3uWV5TASg
         5BAL++XPugjqnKWSXGyoDrdrZ3wvAQuiyZA7j3q22bldFFUiSCPJqXGwZk3xOPaAkjLY
         DMjw==
X-Forwarded-Encrypted: i=1; AKwUvBxG9Ky03ZbyDhnmnbOl1jTmfPl0C97+Gs+RYa0YXLCYZO6Q+hNUn+h42DLXUUSQwFhG0zN+8/2/gov0@lists.infradead.org
X-Gm-Message-State: AFuF++ktOr7CpOKDPkki8kEelZFcgVPXAWl0w1LpHTanTqWtvnxvycwr
	kRjQ51bXXGPY4IPXPEGgzeD6Cddvdy/mmWjDqnIMfnfFQTjr3gfLAFCPtRPPNS34qzqXxyl6E1c
	Rdra9wjuyQMM43jy4pl53jaYha3PR/deC3hr0ok/R
X-Gm-Gg: AYBFou2fLHdYST1+8qZ+XuThWhy1hMDOY0ukWGSb00K0R7l3jWtgChfT4OK+ZmH1xWw
	QLuVMEa2ce0/e8OOowI5itJxFHBR53XmpZX6muT1LeDik8rhEskffJ0BmQ6BKeLPQeaCdl46gPV
	VWncDOD7u5zjwk0eJmclc7ruxZEa6T+Lc8q8lrgKJcAmFVkhiIwhCCWyyb/3U+1rG0wLV6nm1A3
	enCje8iPwAT8pj2tB/nSD1x8W3Paz/fjtaEOMgE2GtdVMaOpcSeN2SVyaWr6iPDRVwhLz1pqDTv
	44Po8Qf+eUbrjJ6xGGiT9+FoSNVZDc92sMT7HmZnFlfty87y4D9gNC9CdA==
X-Received: by 2002:a17:902:d988:b0:2b9:e831:5e5c with SMTP id
 d9443c01a7336-2dbddb1f4f4mr5306795ad.4.1788941206507; Wed, 09 Sep 2026
 01:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <878q5f5tlt.ffs@fw13> <aqD7FDvDhiEF_u0N@infradead.org>
In-Reply-To: <aqD7FDvDhiEF_u0N@infradead.org>
From: Luigi Rizzo <lrizzo@google.com>
Date: Wed, 9 Sep 2026 10:06:10 +0200
X-Gm-Features: AcwNN1VkP_hnkhu1BhimxJBNF_bxxxh-Y07PAXa53bzMuSECve8p-f-Z8Pr0vg8
Message-ID: <CAMOZA0Lt99A1H45Hp0Snq4aSEw-Xr_Mh4xA--Cx0Qh_6vsQvOQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Global Software Interrupt Moderation (GSIM)
To: Christoph Hellwig <hch@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Fengnan Chang <changfengnan@bytedance.com>, 
	Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, netdev@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Guzebing <guzebing@bytedance.com>, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_010649_116773_F66B9721 
X-CRM114-Status: GOOD (  23.79  )
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

On Wed, Sep 9, 2026 at 8:25=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Sat, Sep 05, 2026 at 10:30:22PM +0200, Thomas Gleixner wrote:
> > > it appears that GSIM is only effective in scenarios where multi disks=
 at very high
> > > IOPS; in some cases, there was a noticeable performance regression.
> > > If there=E2=80=99s something wrong with my configuration, please corr=
ect me.
> >
> > So we have a NVME specific mechanism to tackle the same problem and a
> > more generic version which is subsystem "independent".
>
> I'm not sure they tackle the entirely same problem, although they are
> very related.

There is overlap but it is accidental.
The difference between the two mechanism is the following:

- GSIM addresses hardware limitations (SoCs that create huge PCIe
  backpressure on each MSIx interrupt, eventually reducing the available
  bandwidth too much, regardless of how many CPUs can process interrupts).
  The goal here is to throttle the total MSIx rate, blocking them at
  the source (PCIe device) rather than later in the interrupt controller.

- the NVME mechanism (and NAPI) aim to amortize interrupt processing
  overhead. It does so by recreating some fine grained single-source
  interrupt moderation (something that NICs do in hardware, but NVME
  does not, with 100us being way too coarse for modern SSDs) and an
  adaptive scheme to adjust the delay and decide when to kick in.

I think there is a reason for both.

GSIM because it is more general and addresses an issue the others cannot ha=
ndle
the subsystem-specific scheme because they can be more efficient
(eg they can hook into existing helpers like the threaded irq handler,
call directly the handler without going through the full irq chain,
use more targeted heuristics to decide when to kick in).

cheers
luigi

