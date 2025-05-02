Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CF0C3ABAA
	for <linux-nvme@archiver.kernel.org>; Fri,  2 May 2025 18:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zcSLiUz4ebnW8auKGRYJu0KQ8ZdZMC2lQaQD2lbQrvw=; b=lkQofVLLGLA0tUb6lHGcLTwDrW
	H/FGhuBSds6gKJPGuymHJoH8qQ8sx6ZVaKqXpCRbMQTcIQuzUWMbqP8Gr9XHn9//Bwentf+wIYApm
	rECI5THUOBNTwNOnxhKde0+yW9f1mChB3gTIpW1zZmW8LJczJoER6udg/lHclV0+gEFp4k7EMfcjf
	lZLcH1YXcUSIQCEziuxlFB525LqVFumCWGghoY5LqCFl+t1+MssW7LJl6juOzwOEh6HXLK7yQmle8
	PP3XzJYTmKevCICdGFVMa0zt7CpeBh4mpPVuOm5XqlwwNOvwSPaM9PH3OxRj53H5CWe3G4tE6Z83u
	Xa2lQdww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAun8-00000002k9t-1PjA;
	Fri, 02 May 2025 18:07:18 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAulS-00000002jyt-35ei
	for linux-nvme@lists.infradead.org;
	Fri, 02 May 2025 18:05:35 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2240b4de12bso39714015ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 02 May 2025 11:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746209134; x=1746813934; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zcSLiUz4ebnW8auKGRYJu0KQ8ZdZMC2lQaQD2lbQrvw=;
        b=dcTVK1a+EVcqMr941iHHFsuLVy+71jj2Uj32Om7HeV00qJjnW77drDTygTvNV1/xAc
         mfdFxpH/4oZXkYkMRXoxfzC01dSWeauV/V0CrQguW+upFadjQ9JiLO/Q68OY0I9BvNmA
         6FBxVIPR0vz5KHLECtt6M84KFjU3uyk1C0P5iSBBaIXBVSb8jcsWjSwRwPQOUersnSIq
         IzmUPhHTR3EZzV77y4m9Q+dHGVzAe6jWh+BmqUDw3Yz6dh0PFR/r0LyvvSF9YlcHCcZl
         Lz5Fygb3BFJSTa68+BjJS0e49dAwPB5X9z33Qni82uo8QOLhY75ll0/2eYl/y2r+Vq07
         UonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746209134; x=1746813934;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcSLiUz4ebnW8auKGRYJu0KQ8ZdZMC2lQaQD2lbQrvw=;
        b=KTwY+M0w4LpmBsouXK/GeM2Ahz+XbiM6S0RbFP1EOdnOpH14q1D+YuZEZvZ0vCwgVZ
         Wb4NjIxx4Nzn5SpD2XKCSSg6hFKotHgpCJTNPS2gCYNVoi6l3LYVU0agy49RamccLq3Y
         MbItT2HAQJYgYHcM93XVrGqM2tNscXIJNyywiiFk8cmdYOYg0+mw8HxxPzRzkLqA/l3V
         pWAzZ5etO9LJDsyShrCdVeKAL0BiKPDv/nQmx7Q18xykOQ6IvEApKqSSyJIlwgqOeoSI
         Zg8OOzIAr2JoEtCxKEgMRST+ETmIBafs7c8ttvQPPadxR6KXTHbkrEcDQr4DD0IjdSPW
         iiwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXCyF84XqiGQVZRE+xcPVb4u1jePt/L8wLWL7coFXbMbiXJG2besQ2isfxWLSuLd0KI4Jib/sPZ6A5@lists.infradead.org
X-Gm-Message-State: AOJu0YxEKrzaVqU/WrTCjQSSkj8foifgU3N5osY2FHovkkuAaHjwLFvE
	rqlbj1QWfndgTf3EaS54QkFLYjgRSg8B6GL8/BKZYqwEcmqwqPalwFjqkuFPFw==
X-Gm-Gg: ASbGncu7RraDnCV/UyvUei79wwDwbBg8sog2L0NB4B9KPS9nuFx6Mqvpmrh8dWHqYkP
	efqOqfEFTg28LFss5xwjRGpwcKDGEq4C0oT5d/t4dyZ3Tx/RGRnTouCEsvFOwomiYRQc6kA+vvH
	Z4C/+VQMo8TmjoCyvfWzz5zzMaugWRlPz+RqfYorJLT3f5p/mnWPISgwjpNshLt8b62MlwyS+ks
	cMMYdunURV9c0KDaDZQzOh/8LmmchYzNMC5l9iJSRgbZL+XWiweICAlZUXeqaNrPThGcwqUuGZj
	dokvX3GAkFric3HSBUEXSbQsADICxSIL+eJaIuqbQ7lDaMgt5vrIQQ==
X-Google-Smtp-Source: AGHT+IEYeLUys5tfLkjUspsmDDI1Cb1YA+edBh30Ni418v1MT8XNeWwFc7kK/LBz4rDgcz2jBf4ikw==
X-Received: by 2002:a17:903:2c9:b0:21f:7e12:5642 with SMTP id d9443c01a7336-22e102c79d0mr54635905ad.18.1746209133893;
        Fri, 02 May 2025 11:05:33 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e150eae63sm10793605ad.18.2025.05.02.11.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 11:05:33 -0700 (PDT)
Date: Fri, 2 May 2025 23:35:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <hans.zhang@cixtech.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk, 
	hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Fix system hang when ASPM L1 is enabled during
 suspend
Message-ID: <onw47gzc6mda2unsew36b2cmp2et3ijrjqlmgpueeko5vucgph@wrkaiqlbo2fp>
References: <20250502150027.GA818097@bhelgaas>
 <be8321e5-d048-4434-9b2a-8159e9bdba43@cixtech.com>
 <z4bq25pr35cklwoodz34pnfaopfrtbjwhc6gvbhbsvnwblhxia@frmtb3t3m4nk>
 <433f2678-86c1-4ff6-88d1-7ed485cf44b7@cixtech.com>
 <58e343d9-adf3-4853-9dec-df7c1892d6b2@cixtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58e343d9-adf3-4853-9dec-df7c1892d6b2@cixtech.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_110534_802119_290EEF89 
X-CRM114-Status: GOOD (  33.61  )
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

On Sat, May 03, 2025 at 12:20:52AM +0800, Hans Zhang wrote:
> 
> 
> On 2025/5/3 00:07, Hans Zhang wrote:
> > 
> > 
> > On 2025/5/2 23:58, Manivannan Sadhasivam wrote:
> > > EXTERNAL EMAIL
> > > 
> > > On Fri, May 02, 2025 at 11:49:07PM +0800, Hans Zhang wrote:
> > > > 
> > > > 
> > > > On 2025/5/2 23:00, Bjorn Helgaas wrote:
> > > > > EXTERNAL EMAIL
> > > > > 
> > > > > On Fri, May 02, 2025 at 11:20:51AM +0800, hans.zhang@cixtech.com wrote:
> > > > > > From: Hans Zhang <hans.zhang@cixtech.com>
> > > > > > 
> > > > > > When PCIe ASPM L1 is enabled (CONFIG_PCIEASPM_POWERSAVE=y), certain
> > > > > 
> > > > > CONFIG_PCIEASPM_POWERSAVE=y only sets the default.  L1 can be enabled
> > > > > dynamically regardless of the config.
> > > > > 
> > > > 
> > > > Dear Bjorn,
> > > > 
> > > > Thank you very much for your reply.
> > > > 
> > > > Yes. To reduce the power consumption of the SOC system, we have
> > > > enabled ASPM
> > > > L1 by default.
> > > > 
> > > > > > NVMe controllers fail to release LPI MSI-X interrupts during system
> > > > > > suspend, leading to a system hang. This occurs because the driver's
> > > > > > existing power management path does not fully disable the device
> > > > > > when ASPM is active.
> > > > > 
> > > > > I have no idea what this has to do with ASPM L1.  I do see that
> > > > > nvme_suspend() tests pcie_aspm_enabled(pdev) (which seems kind of
> > > > > janky and racy).  But this doesn't explain anything about what would
> > > > > cause a system hang.
> > > > 
> > > > [   92.411265] [pid:322,cpu11,kworker/u24:6]nvme 0000:91:00.0:
> > > > PM: calling
> > > > pci_pm_suspend_noirq+0x0/0x2c0 @ 322, parent: 0000:90:00.0
> > > > [   92.423028] [pid:322,cpu11,kworker/u24:6]nvme 0000:91:00.0: PM:
> > > > pci_pm_suspend_noirq+0x0/0x2c0 returned 0 after 1 usecs
> > > > [   92.433894] [pid:324,cpu10,kworker/u24:7]pcieport 0000:90:00.0: PM:
> > > > calling pci_pm_suspend_noirq+0x0/0x2c0 @ 324, parent: pci0000:90
> > > > [   92.445880] [pid:324,cpu10,kworker/u24:7]pcieport 0000:90:00.0: PM:
> > > > pci_pm_suspend_noirq+0x0/0x2c0 returned 0 after 39 usecs
> > > > [   92.457227] [pid:916,cpu7,bash]sky1-pcie a070000.pcie: PM: calling
> > > > sky1_pcie_suspend_noirq+0x0/0x174 @ 916, parent: soc@0
> > > > [   92.479315] [pid:916,cpu7,bash]cix-pcie-phy a080000.pcie_phy:
> > > > pcie_phy_common_exit end
> > > > [   92.487389] [pid:916,cpu7,bash]sky1-pcie a070000.pcie:
> > > > sky1_pcie_suspend_noirq
> > > > [   92.494604] [pid:916,cpu7,bash]sky1-pcie a070000.pcie: PM:
> > > > sky1_pcie_suspend_noirq+0x0/0x174 returned 0 after 26379 usecs
> > > > [   92.505619] [pid:916,cpu7,bash]sky1-audss-clk
> > > > 7110000.system-controller:clock-controller: PM: calling
> > > > genpd_suspend_noirq+0x0/0x80 @ 916, parent: 7110000.system-controller
> > > > [   92.520919] [pid:916,cpu7,bash]sky1-audss-clk
> > > > 7110000.system-controller:clock-controller: PM:
> > > > genpd_suspend_noirq+0x0/0x80
> > > > returned 0 after 1 usecs
> > > > [   92.534214] [pid:916,cpu7,bash]Disabling non-boot CPUs ...
> > > > 
> > > > 
> > > > Hans: Before I added the printk for debugging, it hung here.
> > > > 
> > > > 
> > > > I added the log output after debugging printk.
> > > > 
> > > > Sky1 SOC Root Port driver's suspend function: sky1_pcie_suspend_noirq
> > > > Our hardware is in STR(suspend to ram), and the controller and
> > > > PHY will lose
> > > > power.
> > > > 
> > > > So in sky1_pcie_suspend_noirq, the AXI,APB clock, etc. of the PCIe
> > > > controller will be turned off. In sky1_pcie_resume_noirq, the PCIe
> > > > controller and PHY will be reinitialized. If suspend does not
> > > > close the AXI
> > > > and APB clock, and the AXI is reopened during the resume
> > > > process, the APB
> > > > clock will cause the reference count of the kernel API to accumulate
> > > > continuously.
> > > > 
> > > 
> > > So this is the actual issue (controller loosing power during system
> > > suspend) and
> > > everything else (ASPM, MSIX write) are all side effects of it.
> > > 
> 
> Dear Mani,
> 
> There are some things I don't understand here. Why doesn't the NVMe SSD
> driver release the MSI/MSIx interrupt when ASPM is enabled? However, if ASPM
> is not enabled, the MSI/MSIx interrupt will be released instead.
> 

You mean by calling pci_free_irq_vectors()? If so, the reason is that if ASPM is
unavailable, then the NVMe cannot be put into low power APST state during
suspend. So shutting down it is the only sane option to save power, with the
cost of increased resume latency. But if ASPM is available, then the driver
doesn't shut the NVMe as it relies on APST to keep the NVMe controller/memory in
low power mode.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

