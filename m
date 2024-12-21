Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E68E77184
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Dec 2024 03:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/eJZB6EuvZqCuMAexZlULTbfQVdCZzFPIunIzkh0xi0=; b=MYzULJZIYmei7ntSh6kNGd+S/h
	dQzkwPSuWnWR0zhEUlFVK3FjE2DKkr4t9ZF0JAA1NwVWOMFbyriJZ/v07Y9N+NBDKtFU5igLlOn7x
	ogPlWrCgBQNZt3R92KOC3wFEttj9tHKpHp1eh0RvMKykJ6YG83rHsZnBJipyoC9RwXWrcyoRFDZIT
	dBfDp2ME6ikH1skAldGo7DGUe/Y1+/ICZ315nrkeXw8oN0v1mqR32c5QaYHvbnkKPSf2+HxUu6/sy
	zLl9gAnTTyXMxtu4zqBZwTwTBy1PvWgBDrSZQ+IIcdc9DAQ5hjCVfI+T+4djp125ieOsmUNurOmWT
	RJb0QxDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOqKN-00000006V3N-0tM1;
	Sat, 21 Dec 2024 03:38:55 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOqKK-00000006V32-29UM
	for linux-nvme@lists.infradead.org;
	Sat, 21 Dec 2024 03:38:54 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2f44353649aso1931286a91.0
        for <linux-nvme@lists.infradead.org>; Fri, 20 Dec 2024 19:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734752331; x=1735357131; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/eJZB6EuvZqCuMAexZlULTbfQVdCZzFPIunIzkh0xi0=;
        b=W0VoMNL+kYQvZcwK3egOzH2+lbsmAJDold1ZZNAUpY8KNbtBUwabVAR1/or0163H0U
         h/0tOpLT2vHdMhIuozmmOSIBFmTsOnX47Nv2VzOxgszVLsjS2Nbh8+1HTL8upq/iC30j
         kFPw1sHckZJtT8TVRolhvfCvPOQKgXBQTVb7Q0Kau3Skr6uBDpcDqG43oGHXtFrYN63F
         qaeWz53A2Wp4DoqN/nRYys4LJXejxV56vXdcGYzvF4eEWB4f6MjkAJUXB++jZJIeV4QC
         stbHfJz1O1eDiOzcrUAvyoLnWSoQxh8oRnqfXX5VRXpJ/Jrr4VKFI726SpLQOwS03Y0m
         Hd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734752331; x=1735357131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/eJZB6EuvZqCuMAexZlULTbfQVdCZzFPIunIzkh0xi0=;
        b=rzOWo8uGR0ehOgY0Th386QMgn6GeXU3z0s5EpdbjsTTf8qubb0lt9YLvoW8v7U64A2
         laiMxsg/ZODAIs3sJHeUCjDFOhs5javdDhLIFniViVy7EosjiziGxx2lVSecgUVaYjQt
         05KK7XDcH+GqC5IBMcLLOOYfDZtelQjpOLAaFb1pkA9EdUkHRhmqACQG/N1RH4zy8Gqz
         l1fW4LbC69OjSD1Cwkwdu8LJ3m2uM/atPHmyyRo8EcILidkDuodiDN5APsG3JKPLVRje
         vlmFNSbzko6e5IIym2ANF0/o1ma30bzi1UOgtjDhhJpzFs9iYBR3ZWnQfugvIw3+htGq
         yvsw==
X-Forwarded-Encrypted: i=1; AJvYcCUiphKeQgfukvd4fi5xP07LbrR8f1Ln+MXPunaHBpPlTN8tQD/p/yap7KvI+J1toUe4vSz0M5FoKn83@lists.infradead.org
X-Gm-Message-State: AOJu0Yx/i7+1OoO38lfJA6VGSa07QQRit8bF2ihttyigG3hgITyrDYtf
	SrNMVouU/T3xRn1wcP6l3xeHGBNopekb+DdUHdArYRgJYR8mAo6EsN1a1s7YPA==
X-Gm-Gg: ASbGncsrh3Tc5mQejhQcuwPv7hl+fYft8ZvDkQCMNT3I/7iyzGljVOv8EVmiWxlW6mh
	TVIzkwjAKhPLHb1cJ8j2/d17b9GgmLEpkHzw6d89gvxtj7RJ17efditczM0hnoTiP6BpTjy0S8l
	u0jxhjF3DaQIs24RwStQhoyYW58TUYl33mcz8V7GrPdeGevnIcxQpe2QbY23wW5jZD8y1jzozwD
	I7t2U/Vmw4J5z2JOaopdp+kMH+S0NlMHzgceKpe0E9a4t8QrYxA7IQ1AHvLZjRgM4CaSQ==
X-Google-Smtp-Source: AGHT+IEWrzsnN5o2nCkQoIeMPbLZpzrdwvyS5pHYhSf/TqTSVhcon5Hfm88OsFR+tUvtiLTb876Vew==
X-Received: by 2002:a17:90b:534f:b0:2ee:e961:3052 with SMTP id 98e67ed59e1d1-2f452e2fe57mr8120881a91.14.1734752331370;
        Fri, 20 Dec 2024 19:38:51 -0800 (PST)
Received: from thinkpad ([117.213.102.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f447882af6sm4486110a91.36.2024.12.20.19.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 19:38:50 -0800 (PST)
Date: Sat, 21 Dec 2024 09:08:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241221033842.6nvmd4clkb3r4roh@thinkpad>
References: <20241209143821.m4dahsaqeydluyf3@thinkpad>
 <20241212055920.GB4825@lst.de>
 <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
 <20241216162303.GA26434@lst.de>
 <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
 <dd557897-f2e0-4347-ae67-27cd45920159@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd557897-f2e0-4347-ae67-27cd45920159@oss.qualcomm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_193852_617251_A6C3EAFE 
X-CRM114-Status: GOOD (  34.27  )
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

On Fri, Dec 20, 2024 at 04:15:21PM +0100, Konrad Dybcio wrote:
> On 16.12.2024 5:42 PM, Rafael J. Wysocki wrote:
> > On Mon, Dec 16, 2024 at 5:23 PM Christoph Hellwig <hch@lst.de> wrote:
> >>
> >> On Sat, Dec 14, 2024 at 12:00:23PM +0530, Manivannan Sadhasivam wrote:
> >>> We need a PM core API that tells the device drivers when it is safe to powerdown
> >>> the devices. The usecase here is with PCIe based NVMe devices but the problem is
> >>> applicable to other devices as well.
> >>
> >> Maybe I'm misunderstanding things, but I think the important part is
> >> to indicate when a suspend actually MUST put the device into D3.  Because
> >> doing that should always be safe, but not always optimal.
> > 
> > I'm not aware of any cases when a device must be put into D3cold
> > (which I think is what you mean) during system-wide suspend.
> > 
> > Suspend-to-idle on x86 doesn't require this, at least not for
> > correctness.  I don't think any platforms using DT require it either.
> 
> That would be correct.
> 
> The Qualcomm platform (or class of platforms) we're looking at with this
> specific issue requires PCIe (implying NVMe) shutdown for S2RAM.
> 
> The S2RAM entry mechanism is unfortunately misrepresented as an S2Idle
> state by Linux as of today, and I'm trying really hard to convince some
> folks to let me describe it correctly, with little success so far..
> 

Perhaps you should say 'S2RAM is misrepresented as S2Idle by the firmware as of
today'...

But I'll leave it up to the PSCI folks to decide whether it makes sense to
expose PSCI SYSTEM_SUSPEND through CPU_SUSPEND or not.

For the people in this thread, I'm leaving the link to the PSCI discussion here:
https://lore.kernel.org/all/20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com/

> That is the real underlying issue and once/if it's solved, this patch
> will not be necessary.
> 
> > In theory, ACPI S3 or hibernation may request that, but I've never
> > seen it happen in practice.
> > 
> > Suspend-to-idle on x86 may want devices to end up in specific power
> > states in order to be able to switch the entire platform into a deep
> > energy-saving mode, but that's never been D3cold so far.
> 
> In our case the plug is only pulled in S2RAM, otherwise the best we can
> do is just turn off the devices individually to decrease the overall
> power draw
> 

I don't think this is accurate. Qcom FW (the one we are discussing in this
thread) doesn't pull the plug (except on platforms like x13s due to hw
limitation). On ACPI though, the FW *might* pull the plug, so that's why drivers
prepare the devices by powering down them (largely) if pm_suspend_via_firmware()
succeeds. On Qcom platforms, we are trying to allow the SoC to transition to low
power state and that requires relinquishing the resource votes by the drivers.

I still have doubt that pm_set_suspend_via_firmware() applies to Qcom FW or not.
Also the API description doesn't exactly match its usecase.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

