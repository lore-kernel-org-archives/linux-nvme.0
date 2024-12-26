Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D8DE77188
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Dec 2024 16:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qm1OGexTUahbG35IAioexR2EqAbbh3BE3Y6REOnezMM=; b=b3MCXjswZVQ5YoE5QwcTDNEQD9
	1Hv/FHw274OyAwIFg7Dl+ftNM+iPYeEjkkTZ+WP5gHFxiB/sWMMQQehoLi9obxw9LKkDzSXWPl4yE
	lmTcosqWm4L41ioB2s21JTO9iyHrMQWiX13tPymvg9oWkd4CZbqM/hdIr5UbrkN8cHjespicAvLUG
	xtF9cIblDIxsL7RPzVwoKa3IglNaEHAHPgYk0gb0oGqVey8jPjftJZMcnqsvmjhVDiVdfdOrD5I8+
	d2Rh9OMSFUTDBMaPYE3Thul5B36n36aJo9M53lh1c9t65EhuN1a/pyr+GrK61o4MahpVgHB9d3rWq
	77P3gJhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQqd1-0000000G2EO-3PQr;
	Thu, 26 Dec 2024 16:22:27 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQqcy-0000000G2Dx-3aCL
	for linux-nvme@lists.infradead.org;
	Thu, 26 Dec 2024 16:22:26 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-216395e151bso55343055ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 26 Dec 2024 08:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735230143; x=1735834943; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qm1OGexTUahbG35IAioexR2EqAbbh3BE3Y6REOnezMM=;
        b=bUyQg32fO6dlWUOHih9xEtj1n+iLQqBxctUDjCjk7eZWfQCCXx38aXEuJZS6WEDmKi
         YCNS35Jh9rPzMBQC3W1JMhpYUPOMKMfYyTNskysNuhScbqUL/09lbVTrdbKwo3K4ZX95
         DILfehjUCEON7k+G1c+OVnGQtiaBfj3dHGnPzey8JO5AFfW8c/Wcw8kQ13l3ZZfycCKU
         ZxmyaanpkM+ZO2aVt9dYf+ZA0zGXitaJaYqkyXbWV6+5a0dHnO7RcSFBaL/9w8HOgak6
         8Zx2PKloYUgJBBv63D65vhMX14OONxfA/xe6txsHSI5XSgfYXQxwjuX5nRqx9LakgSFm
         UJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735230143; x=1735834943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qm1OGexTUahbG35IAioexR2EqAbbh3BE3Y6REOnezMM=;
        b=RIufeUUNueEIpPR01Xqk7OwiPDVS+HPbGgNYh44/ja7NpR1UOTxnBGAl1VjWt9YIvK
         8V00AunV9fMlscGM7kRMcn966KhK2Ii+qknMdTW8wyVGqxUM1AgUcjGVaNANDuTB3mWN
         JGnXGmDgSR44RtNm9vaASicg++/7iYjB0U9WmcITlLqA8wEw8XrVHRksXLXBDppfZou0
         1NwhjhzWc26TARmMuQiIfEIurFhzVuooQz41soEE1glLvXmWpHpuOmz+fCWtyhYyoPpQ
         +8ty2WmvWHBKLM+cnAF8a5HFntiXHpisJ8VPnHrHsrAO8o6DckiH9j/I4gy3w+dqDO/a
         c3oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvn5sbMSO98E18ATcdGrILJWKBv5/aFbkVO0ieQsLEXj91dYurBYvyoSwZpFjQzeSaRDmFRwoUhlYA@lists.infradead.org
X-Gm-Message-State: AOJu0YwvA4iRPjHl8yvekrArVZR49om933WBPAmQ5qyEeiPPHNAd+mmz
	P5A/rRFmwSmHzSydn9niaZAvNwxoZyz+g2QM79Tz5dX4oX+/Xm1frQ+N7OmQMQ==
X-Gm-Gg: ASbGncvUyRfXY1bVNp9NGQ0L2I0nSdcUy/IcZ+Wlmam2N3vsDYlfGXpDWVJsz6c6abk
	xO4ivvzyiopuM9y6yNxTRgBL0E/xjx92309HXCpdukoU7K249wV1Ii1YT1VFqkzS1OODgO62Y2p
	WTNrxyWfaV0Apxg2c4hU22NR3gTeasmmnnuk3jkG7njwHtQarUfVobvoPFOV1CsOOrb4gHwHv9G
	CZPoBoXBMyL8EcBbsUnQCUplmPv3Za2jgJ/pVYTmpfz8rlvE6vwERmN6ALcZiuaA+Y=
X-Google-Smtp-Source: AGHT+IHvoBuGe08qo2yEvL2GcLwase7T5VuaXPLzhbgmwOzxg/Nr7C9/tE4B78BHn6KoWJtSaarh9Q==
X-Received: by 2002:a17:902:f648:b0:216:84f0:e33c with SMTP id d9443c01a7336-219da7ef985mr427820475ad.20.1735230143189;
        Thu, 26 Dec 2024 08:22:23 -0800 (PST)
Received: from thinkpad ([120.56.206.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d4c89sm118912905ad.124.2024.12.26.08.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 08:22:22 -0800 (PST)
Date: Thu, 26 Dec 2024 21:52:15 +0530
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
Message-ID: <20241226162215.vnhidukzkzfhuwt2@thinkpad>
References: <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
 <20241216162303.GA26434@lst.de>
 <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
 <dd557897-f2e0-4347-ae67-27cd45920159@oss.qualcomm.com>
 <20241221033842.6nvmd4clkb3r4roh@thinkpad>
 <a514f047-d56e-40a1-ad36-b655cc8cddb7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a514f047-d56e-40a1-ad36-b655cc8cddb7@oss.qualcomm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241226_082224_953713_A98CE79E 
X-CRM114-Status: GOOD (  41.24  )
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

On Sat, Dec 21, 2024 at 12:17:02PM +0100, Konrad Dybcio wrote:
> On 21.12.2024 4:38 AM, Manivannan Sadhasivam wrote:
> > On Fri, Dec 20, 2024 at 04:15:21PM +0100, Konrad Dybcio wrote:
> >> On 16.12.2024 5:42 PM, Rafael J. Wysocki wrote:
> >>> On Mon, Dec 16, 2024 at 5:23 PM Christoph Hellwig <hch@lst.de> wrote:
> >>>>
> >>>> On Sat, Dec 14, 2024 at 12:00:23PM +0530, Manivannan Sadhasivam wrote:
> >>>>> We need a PM core API that tells the device drivers when it is safe to powerdown
> >>>>> the devices. The usecase here is with PCIe based NVMe devices but the problem is
> >>>>> applicable to other devices as well.
> >>>>
> >>>> Maybe I'm misunderstanding things, but I think the important part is
> >>>> to indicate when a suspend actually MUST put the device into D3.  Because
> >>>> doing that should always be safe, but not always optimal.
> >>>
> >>> I'm not aware of any cases when a device must be put into D3cold
> >>> (which I think is what you mean) during system-wide suspend.
> >>>
> >>> Suspend-to-idle on x86 doesn't require this, at least not for
> >>> correctness.  I don't think any platforms using DT require it either.
> >>
> >> That would be correct.
> >>
> >> The Qualcomm platform (or class of platforms) we're looking at with this
> >> specific issue requires PCIe (implying NVMe) shutdown for S2RAM.
> >>
> >> The S2RAM entry mechanism is unfortunately misrepresented as an S2Idle
> >> state by Linux as of today, and I'm trying really hard to convince some
> >> folks to let me describe it correctly, with little success so far..
> >>
> > 
> > Perhaps you should say 'S2RAM is misrepresented as S2Idle by the firmware as of
> > today'...
> > 
> > But I'll leave it up to the PSCI folks to decide whether it makes sense to
> > expose PSCI SYSTEM_SUSPEND through CPU_SUSPEND or not.
> 
> The firmware happily performs the actions required to put the platform
> in S2RAM, but the interface used to request entry (CPU_SUSPEND) is
> mostly used for entering CPU/cluster idle states on arm64.
> 
> (although the PSCI spec also clearly states that using CPU_SUSPEND for
> system-level low power states is allowed *plus* the reference
> implementation literally just calls CPU_SUSPEND internally whenever
> the """proper""" SYSTEM_SUSPEND call is used, anyway)
> 

Ok, sounds fair.

> > 
> > For the people in this thread, I'm leaving the link to the PSCI discussion here:
> > https://lore.kernel.org/all/20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com/
> > 
> >> That is the real underlying issue and once/if it's solved, this patch
> >> will not be necessary.
> >>
> >>> In theory, ACPI S3 or hibernation may request that, but I've never
> >>> seen it happen in practice.
> >>>
> >>> Suspend-to-idle on x86 may want devices to end up in specific power
> >>> states in order to be able to switch the entire platform into a deep
> >>> energy-saving mode, but that's never been D3cold so far.
> >>
> >> In our case the plug is only pulled in S2RAM, otherwise the best we can
> >> do is just turn off the devices individually to decrease the overall
> >> power draw
> >>
> > 
> > I don't think this is accurate. Qcom FW (the one we are discussing in this
> > thread) doesn't pull the plug (except on platforms like x13s due to hw
> > limitation). On ACPI though, the FW *might* pull the plug, so that's why drivers
> > prepare the devices by powering down them (largely) if pm_suspend_via_firmware()
> > succeeds. On Qcom platforms, we are trying to allow the SoC to transition to low
> > power state and that requires relinquishing the resource votes by the drivers.
> 
> Look, I have a power measurement device before my eyes and I clearly see
> the main power rail being cut on successful S2RAM entry.
> 

You seem to have misunderstood what I said. I do *know* the power state of the
SoC when it enters the CX power collapse state. What I said was in the case of
ACPI, it powers down the peripherals in S3 without any SW dependency (except for
wakeup capable devices). But in Qcom case, each driver has to relinquish the
vote for the SoC to enter CX collapse state. But anyhow, the difference doesn't
matter much here as all drivers need to drop the vote except in wakeup path.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

