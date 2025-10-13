Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2428FCCD183
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Oct 2025 08:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ly+HQRkobfn8QZ0F7iorzNkMZ8hHSqdbvWQJzpHPzWg=; b=csVdUUriGSr4EYJNyzCBlF1fHt
	Mi2QdOlV/FziU75qLyOf0ivll46COBQcquaZrUVBHARo/BRUIZ5wOXlzs2UtjP7tfRszbzl/p/CC2
	VF990Hk67PUwuphv22EkqMU2MJXSLfpTOs96daI5stKlOBdCOX6bVZ/ctoYP4Joqkq09bxw/l64OR
	pc0ZCCIn1/okx8ZhUkYeYa9P0YmD1Yfpov9gBEXrwp6SHPeGPuoAxnw9nxv/OIDmQWwCG6VwflNjT
	/9aH+UP+3lf//OwS/BvamVyE5MBLjb0uyqiayoQo4YOiLo8P3wmCTRzCq/6PuRV6crJ8szEa14/tf
	yEFlPOPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8ECy-0000000Ce8S-3y5r;
	Mon, 13 Oct 2025 08:47:08 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8ECv-0000000Ce87-13eh
	for linux-nvme@lists.infradead.org;
	Mon, 13 Oct 2025 08:47:06 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-279e2554c8fso38328495ad.2
        for <linux-nvme@lists.infradead.org>; Mon, 13 Oct 2025 01:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760345224; x=1760950024; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ly+HQRkobfn8QZ0F7iorzNkMZ8hHSqdbvWQJzpHPzWg=;
        b=HB0UHKmLBy2iigx/G/nal+s+ZsncIWPlRrUVhO+ytLCP10rwt5eWxxfoq34936pfRy
         KSnZPX7BO4jk1yHqYtSmLG4O2oXnpMRd8CVRz/KYPHgesl1PKHpBbzatjCH1RIW6lz5c
         PyntSvrUtr2XCGvYSBUEAZrI1lvrJzbWm+eEw2KN+Z1JVJcFUPKtAggQT2BIL+wMPmRi
         Cp0az2Abv9RO5hezn5qrxnTrfBRSQpQOQi6lQBWkBDTT9qg+xCKa9WhJjsgvfgFHtX1O
         G5qm1JqAmpjuiHWpNJXoh7Nl+yl9GWDyd5GY7Ww6jzaxdo3bKs9prKUCSHOd4QNd9s5r
         c8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760345224; x=1760950024;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly+HQRkobfn8QZ0F7iorzNkMZ8hHSqdbvWQJzpHPzWg=;
        b=VIO46gRagCCbAjBi8QOgGqB9zhoQOJncLdIrCFBaZPjqkg5lJGkdenM1YGmKeu16Bs
         X+Sl8dakSocK0pOug6noDIuPhB/xXonoBfpZUKxFIWtPadZR51g4RxhaSgNPrYClyZZI
         CxDnfA2DzZwCZ7NUyrPnyUyurIArWjchRNAbI8IxWJEdPx+Ii6GFHHwzPee7I1COJLHb
         MU3ECLKcc3XH7/7Kzj270HUpvvpT3irL26+QFh3XyTvtB3FGcNzI3MKsXPvB/8nXdVUE
         8BsqUDC1M1iZmNcYzExHEjeSrrO721+uxBkP/Cx933Ic7tUELCNQQ9EkLqeqDjOWGgNP
         AHqg==
X-Forwarded-Encrypted: i=1; AJvYcCXtiRKVOzqmGobdjDdaWvNvjExioYAgizrntMrVV4887D/wJNoqaS7vOnucUfPe64St5/wWV+aWfFKP@lists.infradead.org
X-Gm-Message-State: AOJu0YzkM/u7wtBQT/K40ytaImq32A2SGXJHhe/e0r7q82+jcyE1eaK1
	pTgUWuqlzjfgTW9VHvt9jZuJkFQ9cB/yBcHAnAhR0gLNysJiM8hBxAgm
X-Gm-Gg: ASbGnctJ2udOEPYU+iZDRvfceAMe9MhxTCZ1/aiiZ5JWnDH+A+sxnvf+/aA7TAm9/b9
	nC2a+jyCifYdS/BScutOUaZ+A0PhseHv0A+kD6WIV9CpiCuIU4SxX1aiV248CcEhY94KRJoy96V
	SWA96ZO/YMlPVJywyodLxRWq1N6LEzZvUKybzXI/rc8czLGU0mpDGPsr8wMq4ApCIH+FIcqAaTX
	wxrgfD6J1EAhsY7FX+yJNScWHEzyBlZbyyQgC3OK+pQhNxqbhYoyiy8/65u3kUfoQAMuhrQxGIY
	09wVHseoSkPNidPJwurn93itiaLGnO8sK189S7nY4a7Hknd6DT27yyReHrHHGblX1b75OB2u8Hp
	yWx0YcWuTq23IcVZjuftdOcZlCURPc96iK+dKmUREMLr83ffSkn8=
X-Google-Smtp-Source: AGHT+IF7w1EIeSODUr5AIUsDNw48vbrBIgBhYBiRRyhl8w2rgyXTNwbHm6KkbxbA5Bn+oLw+XAdTJw==
X-Received: by 2002:a17:902:e550:b0:25f:fe5f:c927 with SMTP id d9443c01a7336-290272c0a06mr273302795ad.31.1760345224148;
        Mon, 13 Oct 2025 01:47:04 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29034de9febsm127921165ad.7.2025.10.13.01.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:47:03 -0700 (PDT)
Date: Mon, 13 Oct 2025 16:46:18 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Genes Lists <lists@sapience.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: linux-pci@vger.kernel.org
Subject: Re: mainline boot fail nvme/block? [BISECTED]
Message-ID: <trdjd7zhpldyeurmpvx4zpgjoz7hmf3ugayybz4gagu2iue56c@zswmzvauqnxk>
References: <4b392af8847cc19720ffcd53865f60ab3edc56b3.camel@sapience.com>
 <cf4e88c6-0319-4084-8311-a7ca28a78c81@kernel.dk>
 <3152ca947e89ee37264b90c422e77bb0e3d575b9.camel@sapience.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3152ca947e89ee37264b90c422e77bb0e3d575b9.camel@sapience.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_014705_298173_EC71AB5D 
X-CRM114-Status: GOOD (  27.05  )
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

On Fri, Oct 10, 2025 at 07:49:34PM -0400, Genes Lists wrote:
> On Fri, 2025-10-10 at 08:54 -0600, Jens Axboe wrote:
> > On 10/10/25 8:29 AM, Genes Lists wrote:
> > > Mainline fails to boot - 6.17.1 works fine.
> > > Same kernel on an older laptop without any nvme works just fine.
> > > 
> > > It seems to get stuck enumerating disks within the initramfs
> > > created by
> > > dracut.
> > > 
> > > ,,,
> > > 
> > > Machine is dell xps 9320 laptop (firmware 2.23.0) with nvme
> > > partitioned:
> > > 
> > >     # lsblk -f
> > >     NAME        FSTYPE      FSVER LABEL FSAVAIL FSUSE%
> > > MOUNTPOINTS    
> > >     sr0
> > >     nvme0n1
> > >     ├─nvme0n1p1 vfat        FAT32 ESP   2.6G    12% /boot
> > >     ├─nvme0n1p2 ext4        1.0   root  77.7G    42% / 
> > >     └─nvme0n1p3 crypto_LUKS 2                          
> > >       └─home    btrfs             home  1.3T    26% /opt
> > >                                                    
> > > /home             
> > > 
> > > 
> > > 
> > > Will try do bisect over the weekend.
> > 
> > That'd be great, because there's really not much to glean from this
> > bug
> > report.
> 
> Bisect landed here. (cc linux-pci@vger.kernel.org)
> Hopefully it is helpful, even though I don't see MSI in lspci output
> (which is provided below).
> 
> gene
> 
> 
> 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b is the first bad commit
> commit 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b (HEAD)
> Author: Inochi Amaoto <inochiama@gmail.com>
> Date:   Thu Aug 14 07:28:32 2025 +0800
> 
>     PCI/MSI: Add startup/shutdown for per device domains
> 
>     As the RISC-V PLIC cannot apply affinity settings without invoking
>     irq_enable(), it will make the interrupt unavailble when used as an
>     underlying interrupt chip for the MSI controller.
> 
>     Implement the irq_startup() and irq_shutdown() callbacks for the
> PCI MSI
>     and MSI-X templates.
> 
>     For chips that specify MSI_FLAG_PCI_MSI_STARTUP_PARENT, the parent
> startup
>     and shutdown functions are invoked. That allows the interrupt on
> the parent
>     chip to be enabled if the interrupt has not been enabled during
>     allocation. This is necessary for MSI controllers which use PLIC as
>     underlying parent interrupt chip.
> 
>     Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>     Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     Tested-by: Chen Wang <unicorn_wang@outlook.com> # Pioneerbox
>     Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
>     Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>     Link: https://lore.kernel.org/all/20250813232835.43458-3-
> inochiama@gmail.com
> 
>  drivers/pci/msi/irqdomain.c | 52
> ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/msi.h         |  2 ++
>  2 files changed, 54 insertions(+)
> 
> 
> ----------------------------------------- lspci output ----------------
> In case helpful here's lspci output:
> 
> 0000:00:00.0 Host bridge: Intel Corporation Raptor Lake-P/U 4p+8e cores
> Host Bridge/DRAM Controller
> 0000:00:02.0 VGA compatible controller: Intel Corporation Raptor Lake-P
> [Iris Xe Graphics] (rev 04)
> 0000:00:04.0 Signal processing controller: Intel Corporation Raptor
> Lake Dynamic Platform and Thermal Framework Processor Participant
> 0000:00:05.0 Multimedia controller: Intel Corporation Raptor Lake IPU
> 0000:00:06.0 System peripheral: Intel Corporation RST VMD Managed
> Controller
> 0000:00:07.0 PCI bridge: Intel Corporation Raptor Lake-P Thunderbolt 4
> PCI Express Root Port #0
> 0000:00:07.2 PCI bridge: Intel Corporation Raptor Lake-P Thunderbolt 4
> PCI Express Root Port #2
> 0000:00:08.0 System peripheral: Intel Corporation GNA Scoring
> Accelerator module
> 0000:00:0a.0 Signal processing controller: Intel Corporation Raptor
> Lake Crashlog and Telemetry (rev 01)
> 0000:00:0d.0 USB controller: Intel Corporation Raptor Lake-P
> Thunderbolt 4 USB Controller
> 0000:00:0d.2 USB controller: Intel Corporation Raptor Lake-P
> Thunderbolt 4 NHI #0
> 0000:00:0d.3 USB controller: Intel Corporation Raptor Lake-P
> Thunderbolt 4 NHI #1
> 0000:00:0e.0 RAID bus controller: Intel Corporation Volume Management
> Device NVMe RAID Controller Intel Corporation
> 0000:00:12.0 Serial controller: Intel Corporation Alder Lake-P
> Integrated Sensor Hub (rev 01)
> 0000:00:14.0 USB controller: Intel Corporation Alder Lake PCH USB 3.2
> xHCI Host Controller (rev 01)
> 0000:00:14.2 RAM memory: Intel Corporation Alder Lake PCH Shared SRAM
> (rev 01)
> 0000:00:14.3 Network controller: Intel Corporation Raptor Lake PCH CNVi
> WiFi (rev 01)
> 0000:00:15.0 Serial bus controller: Intel Corporation Alder Lake PCH
> Serial IO I2C Controller #0 (rev 01)
> 0000:00:15.1 Serial bus controller: Intel Corporation Alder Lake PCH
> Serial IO I2C Controller #1 (rev 01)
> 0000:00:16.0 Communication controller: Intel Corporation Alder Lake PCH
> HECI Controller (rev 01)
> 0000:00:1e.0 Communication controller: Intel Corporation Alder Lake PCH
> UART #0 (rev 01)
> 0000:00:1e.3 Serial bus controller: Intel Corporation Alder Lake SPI
> Controller (rev 01)
> 0000:00:1f.0 ISA bridge: Intel Corporation Raptor Lake LPC/eSPI
> Controller (rev 01)
> 0000:00:1f.3 Multimedia audio controller: Intel Corporation Raptor
> Lake-P/U/H cAVS (rev 01)
> 0000:00:1f.4 SMBus: Intel Corporation Alder Lake PCH-P SMBus Host
> Controller (rev 01)
> 0000:00:1f.5 Serial bus controller: Intel Corporation Alder Lake-P PCH
> SPI Controller (rev 01)
> 0000:01:00.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
> Ridge 2020] (rev 02)
> 0000:02:00.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
> Ridge 2020] (rev 02)
> 0000:02:01.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
> Ridge 2020] (rev 02)
> 0000:02:02.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
> Ridge 2020] (rev 02)
> 0000:02:03.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
> Ridge 2020] (rev 02)
> 0000:02:04.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen
> Ridge 2020] (rev 02)
> 10000:e0:06.0 PCI bridge: Intel Corporation Raptor Lake PCIe 4.0
> Graphics Port
> 10000:e1:00.0 Non-Volatile memory controller: SK hynix Platinum
> P41/PC801 NVMe Solid State Drive
> 
> 
> -- 
> Gene

I think this is caused by VMD device, which I have a temporary solution
here [1]. Since I have no idea about how VMD works, I hope if anyone
can help to convert this as an formal fix.

[1] https://lore.kernel.org/all/qs2vydzm6xngul77xuwjli7h757gzfhmb4siiklzogihz5oplw@gsvgn75lib6t/

Regards,
Inochi

