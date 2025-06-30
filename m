Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856EDC83033
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 19:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ga4y3MOQS/NhUmQF1ukYLMYf01uWr2HXnuupm/ZCD24=; b=rKT4jxIhyq3aBtSQQwFwrjvxQc
	Cz10ZxA03c/QeNzhJOLQiA5JDqz02av3xXYor0Gjq3CfllsrimnbIEOb+T9+Eex+j5VWfWuEgTzbx
	srZ8gk1ZWeWW0PFtcg+b9t9FJ+HAiGTHbuZO+hq6ccs9nR4I4WHLzcT4j309oqhbeR0O61JO1I291
	4q9j5iCzFnnb7MZlcZPAj4ttFhtQ6dUMnmstw+vp9otAoTE+2btm3/4BPqsomK2Sod/M9h4k6KpzN
	JcE7Zml6G7PbMIMPaxAffQGzcVNHAPZdj6y8SEHArq+O9G6MTP1gdDST9xK8r/JWEme7zyatIXcdr
	n2xJHm7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWKX6-00000003Kq8-1FqG;
	Mon, 30 Jun 2025 19:51:16 +0000
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWKX3-00000003Kpl-1njM
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 19:51:14 +0000
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-2eb5cbe41e1so3554443fac.0
        for <linux-nvme@lists.infradead.org>; Mon, 30 Jun 2025 12:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751313072; x=1751917872; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ga4y3MOQS/NhUmQF1ukYLMYf01uWr2HXnuupm/ZCD24=;
        b=uyhhy+LVqgc0KfSqbfmbB/tqWWRK9iGnwgXslmgM325kW+O3b4IrchtQQ54Zpvat1y
         C99A6/khhzkN6g+18SdYLQKrBT2KrCraqR/Gqw8R7o+S38p01QLfYDNHTPumR9VxBcjo
         mzN7ljVy4j7ZEm6aPpWkrqFJ5g8bc2XJ4gtyabFYwOzgscHYJto+8Z+6DuVWteHU6y1Q
         aEqTdbck7Q3diMEqhmmHEWiMqFi8XR5rD2VHAv1iZjiIPtU7CTWra02LfDVi+K7xxYB/
         IMxtOnbXa2NB7fDiamUEEmsqCROjFTjtgk/fOxLr1LffEq/Lrea5Onh42QsteAmMo3pL
         Cdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751313072; x=1751917872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ga4y3MOQS/NhUmQF1ukYLMYf01uWr2HXnuupm/ZCD24=;
        b=jXE0U+NuMETC1prdXE2A7D60kvzi+XIu50F05VBL37kj1A9chsi+ZYrjQXHR2FbWWu
         pmRROrdqDrpxHXs4iW8JmbdXNhgfbPzwE2n/d0nLiHoK19moXp8A00+Ss1BpfWkXSjbY
         PNzATUoyABKMjUOYcNEWqgEM4NL7cJVWwlg5bRns2pm8eVn/vM9Xd2cPeKrDzEZag9nW
         paFtuD6+9PgjvZAyPV3Zh8jm6fUUnvLYHBGuNdFvI7iLsrS8wUeYWvFTWK4B+QNm93P5
         k8msGK9sRSENrI0siMrMeMDSZjGcw7j/Tv79ySFEUwIJH7QABPziT/hrtAEzBok4Liaa
         GABg==
X-Forwarded-Encrypted: i=1; AJvYcCV8f2saDpbM1lSfcgmExnWdB19uUkvecIp4mWtTsr061nH4MIvtgq5tPVDgReGmOh7aLhqGSv55pb6M@lists.infradead.org
X-Gm-Message-State: AOJu0YxJwtq4XPALaR2fplxjVrG9SIjBHXGctoaYkpLwwXGDgSJ86BuY
	IC43huxfjOznr8rjZeIdpWrZYb5K07mAVD2n3o5cVGT/jrzW4ThtJPaHeyISw6wfCXY+JNqy6kn
	gj8WsdBdu2H1AhbEzbri/DiuR35f6u/opj2pjPPcg
X-Gm-Gg: ASbGncuQK+ElyO5jvpfuQg6wOkwm0VS/bUxDAAq5Vww4YkXVGgCG7y2NqKibvWKpzof
	mg61dN2drHMygdm4cP0WnLSgIIt6p9DU9TLXSs0qZ91NU+SW+/MDvbcxOYytW39YOSwvFPhq1SR
	Xi07KJ1TV+5ij0D+16Pq4SM2orOHUO7YiKI5k2cwPf
X-Google-Smtp-Source: AGHT+IHRDrJscnosC1ZeT+2J6X1LwE0WFgWPIrMVmWeOWgj5sfxh2F6EAd7QnzFSZOpkIKhjeOC1jIHYzrsZvVxF+Xo=
X-Received: by 2002:a05:6870:7905:b0:2ea:841f:773c with SMTP id
 586e51a60fabf-2efed759ab7mr11102999fac.35.1751313072313; Mon, 30 Jun 2025
 12:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
 <20250630133343.GA26040@lst.de>
In-Reply-To: <20250630133343.GA26040@lst.de>
From: Ben Copeland <ben.copeland@linaro.org>
Date: Mon, 30 Jun 2025 20:51:01 +0100
X-Gm-Features: Ac12FXw8R8mMZVmm9DFkYryumLpFODa-57Pyd4kyo7Xil12Rg1NLjYfQ9ut-Kvw
Message-ID: <CAL0q8a7sE4a00ehKrkyepA_xA3Z2HiGv0LazvYe=2NciTkkPFQ@mail.gmail.com>
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion after 06cae0e3f61c
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org, 
	regressions@lists.linux.dev, linux-nvme@lists.infradead.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, kbusch@kernel.org, axboe@kernel.dk, 
	sagi@grimberg.me, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_125113_488417_3AFAF184 
X-CRM114-Status: GOOD (  11.58  )
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

Hello Christoph,

On Mon, 30 Jun 2025 at 14:33, Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Ben,
>
> > [   32.857521] iommu_dma_unmap_page+0xc4/0xe8 (P)
>
> Can you resolve this to a source location for me. i.e.
>
> gdb vmlinux
>
> l *(iommu_dma_unmap_page+0xc4)

Sure, here's the kernel stack trace.

[   32.699872] WARNING: drivers/iommu/dma-iommu.c:1232 at
iommu_dma_unmap_page+0xc4/0xe8, CPU#13: swapper/13/0
[   32.714204] Modules linked in: cdc_ether usbnet sm3_ce nvme sha3_ce
nvme_core xhci_pci_renesas arm_cspmu_module arm_spe_pmu ipmi_devintf
arm_cmn ipmi_msghandler cppc_cpufreq fuse drm backlight ip_tables
x_tables
[   32.732967] CPU: 13 UID: 0 PID: 0 Comm: swapper/13 Tainted: G W
6.16.0-rc3-next-20250627 #1 PREEMPT
[   32.743562] Tainted: [W]=WARN
[   32.749381] Hardware name: Inspur NF5280R7/Mitchell MB, BIOS
04.04.00004001 2025-02-04 22:23:30 02/04/2025
[   32.759020] pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[   32.768746] pc : iommu_dma_unmap_page
(/builds/linux/drivers/iommu/dma-iommu.c:1232 (discriminator 1))
[   32.776040] lr : iommu_dma_unmap_page
(/builds/linux/drivers/iommu/dma-iommu.c:1232 (discriminator 1))
[   32.780559] sp : ffff8000801afde0
[   32.783861] x29: ffff8000801afde0 x28: 0000000000000005 x27: fff00001d7d230f0
[   32.790983] x26: 0000000000000000 x25: fff00001003da0c8 x24: 0000000000000002
[   32.798106] x23: 0000000000000000 x22: 0000000000001000 x21: 00000000feed5000
[   32.805229] x20: fff00001003da0c8 x19: fff00001d7d23000 x18: 0000000000080000
[   32.812352] x17: 0000000000000040 x16: ffffae5c7594ea68 x15: 0000000000000000
[   32.819474] x14: 000000000007ffff x13: 0000000000000001 x12: 000000000000002c
[   32.826597] x11: 00000000000fffff x10: ffffffffffffffff x9 : ffffae5c76358e60
[   32.833719] x8 : ffff8000801afd68 x7 : ffffae5c76358a78 x6 : 00000000feed5001
[   32.840842] x5 : 000000000000000d x4 : ffffae5c76358a78 x3 : 0000000000000000
[   32.847965] x2 : 0000000000000000 x1 : fff00001027e54c0 x0 : 0000000000000000
[   32.855088] Call trace:
[   32.857521] iommu_dma_unmap_page
(/builds/linux/drivers/iommu/dma-iommu.c:1232 (discriminator 1)) (P)
[   32.862039] dma_unmap_page_attrs (/builds/linux/kernel/dma/mapping.c:193)
[   32.866385] nvme_unmap_data
(/home/ben/linux/linux/drivers/nvme/host/nvme.h:788
/home/ben/linux/linux/drivers/nvme/host/pci.c:1077) nvme
[   32.870904] nvme_pci_complete_rq
(/home/ben/linux/linux/drivers/nvme/host/pci.c:1051
/home/ben/linux/linux/drivers/nvme/host/pci.c:1063
/home/ben/linux/linux/drivers/nvme/host/pci.c:1071) nvme
[   32.878632] blk_complete_reqs (/builds/linux/block/blk-mq.c:1223
(discriminator 1))
[   32.885320] blk_done_softirq (/builds/linux/block/blk-mq.c:1230)
[   32.892006] handle_softirqs
(/builds/linux/arch/arm64/include/asm/jump_label.h:36
/builds/linux/include/trace/events/irq.h:142
/builds/linux/kernel/softirq.c:580)
[   32.896436] __do_softirq (/builds/linux/kernel/softirq.c:614)
[   32.899912] ____do_softirq (/builds/linux/arch/arm64/kernel/irq.c:82)
[   32.903561] call_on_irq_stack (/builds/linux/arch/arm64/kernel/entry.S:897)
[   32.907472] do_softirq_own_stack (/builds/linux/arch/arm64/kernel/irq.c:87)
[   32.911642] __irq_exit_rcu (/builds/linux/kernel/softirq.c:460
/builds/linux/kernel/softirq.c:680)
[   32.915378] irq_exit_rcu (/builds/linux/kernel/softirq.c:698
(discriminator 1))
[   32.918854] el1_interrupt
(/builds/linux/arch/arm64/include/asm/current.h:19
/builds/linux/arch/arm64/kernel/entry-common.c:280
/builds/linux/arch/arm64/kernel/entry-common.c:586
/builds/linux/arch/arm64/kernel/entry-common.c:598)
[   32.922418] el1h_64_irq_handler
(/builds/linux/arch/arm64/kernel/entry-common.c:604)
[   32.926502] el1h_64_irq (/builds/linux/arch/arm64/kernel/entry.S:596)
[   32.929891] cpuidle_enter_state
(/builds/linux/drivers/cpuidle/cpuidle.c:292) (P)
[   32.934410] cpuidle_enter
(/builds/linux/drivers/cpuidle/cpuidle.c:391 (discriminator 2))
[   32.937972] do_idle (/builds/linux/kernel/sched/idle.c:160
/builds/linux/kernel/sched/idle.c:235
/builds/linux/kernel/sched/idle.c:330)
[   32.941188] cpu_startup_entry
(/builds/linux/kernel/sched/idle.c:428 (discriminator 1))
[   32.945098] secondary_start_kernel
(/builds/linux/arch/arm64/include/asm/atomic_ll_sc.h:95 (discriminator
2) /builds/linux/arch/arm64/include/asm/atomic.h:28 (discriminator 2)
/builds/linux/include/linux/atomic/atomic-arch-fallback.h:546
(discriminator 2)
/builds/linux/include/linux/atomic/atomic-arch-fallback.h:994
(discriminator 2)
/builds/linux/include/linux/atomic/atomic-instrumented.h:436
(discriminator 2) /builds/linux/include/linux/sched/mm.h:37
(discriminator 2) /builds/linux/arch/arm64/kernel/smp.c:214
(discriminator 2))
[   32.949617] __secondary_switched (/builds/linux/arch/arm64/kernel/head.S:405)
[   32.953788] ---[ end trace 0000000000000000 ]---


>
> Also what IOMMU driver is this device using?  It looks like it
> might not support a 4k IOMMU page size.
>

From the boot log, I can see

[    1.083447] arm-smmu-v3 arm-smmu-v3.16.auto: option mask 0x0
[    1.083460] arm-smmu-v3 arm-smmu-v3.16.auto: IDR0.HTTU
features(0x600000) overridden by FW configuration (0x0)
[    1.083463] arm-smmu-v3 arm-smmu-v3.16.auto: ias 48-bit, oas 48-bit
(features 0x0094dfef)

Let me know if there is anything else.

Ben

