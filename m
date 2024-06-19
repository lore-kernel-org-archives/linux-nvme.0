Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28053C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 10:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MYkm1cNYHMldtwvX11gHzR3nTT/P9RsNQJPwgGt3xeE=; b=I/yVcndNUpAix33n04uVuwNBaY
	j9w+SjzpPBF53OH1mJNpXxEWMBtHXx60VG0eXaesKb71HFAOADRuGAT9RdQzhoD/HztkjqCLm2LOy
	QQdfRiWWwtf9jpeEHtVP3hpZKuoMG3yEVvqammlPchtT9fZyRNzWa9YCk8/muXT3NGghgB0pk1v3V
	G2EYi7bJbVg70yAO+dh+j4LBkLun2Bs6URVPRRJ5Me1dPihDPt2OXeMMNj7+dgqOoBYM10VaOQBci
	14j6o8R+zG29HKdLOD2kAWr2SeIFs1p3Ud2a4cn7TeKc0rJDWFiHKgCmWi9HoE6Rh6Su49m3oPuHh
	LD23bJ1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJsvx-00000000rRR-35a8;
	Wed, 19 Jun 2024 10:52:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJsvu-00000000rQ0-18NC
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 10:52:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 30B8961D40
	for <linux-nvme@lists.infradead.org>; Wed, 19 Jun 2024 10:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E359C4AF60
	for <linux-nvme@lists.infradead.org>; Wed, 19 Jun 2024 10:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718794372;
	bh=x6rRWvFLspQevsB2WpDwXMeeTixJq93OzwM4BU6/jhU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u3uSaA84l5gVLsWmwxrOtJWM7MF0Vu51G0CMA1IUhuxDqK7DR2yRzGOKrg5XZfJyp
	 gc1uZ0BFFh/wA26oymxl7R1SluIcT5SJ5t1Ag6XbCE5Xkm7ygActqF/NpHFUki9mlL
	 JbLwuS31tzqYMGiroNPmsUu+jF8Vggo/jU2YswgPzfH0OUyJKD3lw6P18dgkFZl/0Y
	 n5dvVHipC+NvVTsEaLa4yR6Z2kvQMtMEiStK1cuhhGDOlvFIk45u6nd3IWZNz0xwwZ
	 4TMCjh7s4W1TjzGlDdladzFqHv7/kFYAVMXWKntAeSqEk/WhLSN/siYOf+znixzC+C
	 tKhqZbYVCrBQQ==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-254939503baso511627fac.0
        for <linux-nvme@lists.infradead.org>; Wed, 19 Jun 2024 03:52:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWr8FBf8TEJS6MyrL5w1fxV37VaD3/Kh/uxjDKc5+aiWhOcirjVVpk4YmzYdHqUhOvRSFq2XKvh893iwMJtKyHym655LUQIAlT7o8fVTlw=
X-Gm-Message-State: AOJu0YxRQZUk8N+qwDF+WSdTDDfbeWkhFasecm9jHnM7PgJtHMUvO2lF
	xvW8BLOeiJXUm5EpRm5YtnRTl/+gIxZ9jLcH+7UAp7KaMvvHipMugyD7pCoxc683qVRVRjfSpdg
	zvqUIaKRG3bWVxmooUyN2Bl6N6Dg=
X-Google-Smtp-Source: AGHT+IHkfbPpplMOo0+AZF3Oi/SLUmBNejk3LQsh8tt80LEVbwbJ0RTdOmOkrR69Re/mAWO5+pPtyJBD56qHP10v7uQ=
X-Received: by 2002:a05:6820:2210:b0:5ba:ead2:c742 with SMTP id
 006d021491bc7-5c1ad8a198cmr2995209eaf.0.1718794371598; Wed, 19 Jun 2024
 03:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240618204946.1271042-1-helgaas@kernel.org>
In-Reply-To: <20240618204946.1271042-1-helgaas@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 19 Jun 2024 12:52:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hZHnMbTLs3KK3ORQey=-u8SEm5H4X-eDSVzdk8s9Rn5A@mail.gmail.com>
Message-ID: <CAJZ5v0hZHnMbTLs3KK3ORQey=-u8SEm5H4X-eDSVzdk8s9Rn5A@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] PCI: Disable AER & DPC on suspend
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Thomas Crider <gloriouseggroll@gmail.com>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-nvme@lists.infradead.org, 
	regressions@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_035254_491046_9D3D0951 
X-CRM114-Status: GOOD (  20.48  )
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

On Tue, Jun 18, 2024 at 10:49=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> This is an old series from Kai-Heng that I didn't handle soon enough.  Th=
e
> intent is to fix several suspend/resume issues:
>
>   - Spurious wakeup from s2idle
>     (https://bugzilla.kernel.org/show_bug.cgi?id=3D216295)
>
>   - Steam Deck doesn't resume after suspend
>     (https://bugzilla.kernel.org/show_bug.cgi?id=3D218090)
>
>   - Unexpected ACS error and DPC event when resuming after suspend
>     (https://bugzilla.kernel.org/show_bug.cgi?id=3D209149)
>
> It seems that a glitch when the link is powered down during suspend cause=
s
> errors to be logged by AER.  When AER is enabled, this causes an AER
> interrupt, and if that IRQ is shared with PME, it may cause a spurious
> wakeup.
>
> Also, errors logged during link power-down and power-up seem to cause
> unwanted error reporting during resume.
>
> This series disables AER interrupts, DPC triggering, and DPC interrupts
> during suspend.  On resume, it clears AER and DPC error status before
> re-enabling their interrupts.
>
> I added a couple cosmetic changes for the v9, but this is essentially all
> Kai-Heng's work.  I'm just posting it as a v9 because I failed to act on
> this earlier.
>
> Bjorn
>
> v9:
>  - Drop pci_ancestor_pr3_present() and pm_suspend_via_firmware; do it
>    unconditionally
>  - Clear DPC status before re-enabling DPC interrupt
>
> v8: https://lore.kernel.org/r/20240416043225.1462548-1-kai.heng.feng@cano=
nical.com
>  - Wording.
>  - Add more bug reports.
>
> v7:
>  - Wording.
>  - Disable AER completely (again) if power will be turned off
>  - Disable DPC completely (again) if power will be turned off
>
> v6: https://lore.kernel.org/r/20230512000014.118942-1-kai.heng.feng@canon=
ical.com
>
> v5: https://lore.kernel.org/r/20230511133610.99759-1-kai.heng.feng@canoni=
cal.com
>  - Wording.
>
> v4: https://lore.kernel.org/r/20230424055249.460381-1-kai.heng.feng@canon=
ical.com
> v3: https://lore.kernel.org/r/20230420125941.333675-1-kai.heng.feng@canon=
ical.com
>  - Correct subject.
>
> v2: https://lore.kernel.org/r/20230420015830.309845-1-kai.heng.feng@canon=
ical.com
>  - Only disable AER IRQ.
>  - No more AER check on PME IRQ#.
>  - Use AER helper.
>  - Only disable DPC IRQ.
>  - No more DPC check on PME IRQ#.
>
> v1: https://lore.kernel.org/r/20220727013255.269815-1-kai.heng.feng@canon=
ical.com
>
> Kai-Heng Feng (2):
>   PCI/AER: Disable AER service on suspend
>   PCI/DPC: Disable DPC service on suspend
>
>  drivers/pci/pcie/aer.c | 18 +++++++++++++
>  drivers/pci/pcie/dpc.c | 60 +++++++++++++++++++++++++++++++++---------
>  2 files changed, 66 insertions(+), 12 deletions(-)
>
> --

Please feel free to add

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

to both patches in the series.

Thanks!

