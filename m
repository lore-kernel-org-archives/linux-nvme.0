Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0590EC3ABAC
	for <linux-nvme@archiver.kernel.org>; Fri,  2 May 2025 16:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H+PQK7cd6vQouY+QWssyC04ldZ+G2r7jfC6DHSaivAY=; b=GSLIYlOidPjXoa4oERNFuVoK3o
	2Y2+P9tcBFjLNrgJPMgeUtiYpITE3gT90V2DNynrb23hDdYj/MDbY8iFRQkeHmoS+6/162JRKwG05
	4wqP63eQukLJYyE0igLetOkibrumcBEsMKIT39S2/iz2sa8Lnpo8iIViCAGmtbGRsgonK0/Bnuo4F
	384RTOGK3JXw5fxqW2ulkUzZUighy12MxWwxHd7oN6NmzsmIMd6Xxt/SdQaHpac70rrzL5nLVT7OX
	9KjB1NXlWuCPMYUTlRm29Z8+Q3XHzFhGvy27Yv55y2BvPJGyLAXamfFWBWNbZFgt8ClMz+JB+0mFp
	86/NCheg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAsrP-00000002QtC-1WXz;
	Fri, 02 May 2025 16:03:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAsmt-00000002Ptv-3agO
	for linux-nvme@bombadil.infradead.org;
	Fri, 02 May 2025 15:58:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=H+PQK7cd6vQouY+QWssyC04ldZ+G2r7jfC6DHSaivAY=; b=j2J6Hp756R7zehuGJQvhFX+5Db
	vqFJRUAiX3qS9l5/Nj6yr05RzmVvrkgmBqGiyWzKdQDnjVYpf0HJAgbHenUCVD/tSkDtvRUvg9BSn
	6S/q8XUyW+u0Cm2f6rr4X54KS8vnBZ3B/hNneh2/hAALYb8Np7mk0D8GO4KIW0QCxM/RD1WU0vKfg
	2+39t9Fkcc19uvHUhSYI6dc8bozxdMhtqED9vdWOn95QuVPURc7qmoEExemygsEUx3ErchDmyOGUG
	ILEOEwqINU9dRy6FywFEdWhrreeGB2sxBef4Mj3FMCEYl5UjquB4RE8L5E9sOtchXvGqH6BvZW4os
	XRd/nCNQ==;
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uAsmm-0000000F31K-2zvD
	for linux-nvme@lists.infradead.org;
	Fri, 02 May 2025 15:58:54 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-22c33ac23edso26757305ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 02 May 2025 08:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746201523; x=1746806323; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H+PQK7cd6vQouY+QWssyC04ldZ+G2r7jfC6DHSaivAY=;
        b=WqxiXPwaUrNppcYX0ChuPeG7Duas4jleDDByiRprj/wk7mtpPWZrBk9TWV0Ze5BwdS
         /WLMIfcnfsF+pQLwVfBCsIuDRVDRrPsWPgbwv78fmAgvrKSlZadJrhxhQlcm+ddA9OhB
         gH4DG0QgpXu2lGWpQ3w14DOMYetP4SmxbH7iaHV9Vsd5sd4c2DATUdtruOQyT2XU/44a
         l8k7CA7tRF+9qr4IfzxFDFVqszOa7nIKnBH9UXv4nUKV4R0g9Nc9b63V+x2HSCShP6fk
         cAhhIEe2XxArLB5Yq0df96WitzogPUb7bFcuZEWGu64krilkaizhfEhbthcNL3SqhrZ0
         Jisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746201523; x=1746806323;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+PQK7cd6vQouY+QWssyC04ldZ+G2r7jfC6DHSaivAY=;
        b=LyK/275wttbFrlR6osSFzF/P6sXrHyIfp57K0NEU+CPMTqbPx8WPIy1K2LWdB9sxTx
         lsIrjqULhL6qWJ8QCRYdfuLdFS7B+oTVj38NJboczoHWTndJVWJVWv/QiFkPYtc1y09u
         xf5aykT4ktRhzv4xXImnMlR7y/IvbTanoeBpfYaH8f2yVP0h/M598wiUU4jgvADKztIe
         NldDUpgJAgIvYBGfMzE9VXCYxp6bFr6e9b1iFiHQO5EDuvKLGoOy+gyQHZYByYpCzO+K
         TzoVdaFF9Q6cTGZVQrKJ7Mv1c43f0UzvT1Lom2PY0F1658mxlOGGRFOZVj8t18yT7Ly0
         zYug==
X-Forwarded-Encrypted: i=1; AJvYcCUb54Dev3G6/ngN/nvmySiFXEing9o8jeurRVMs9is8dfYz7VB/L07JACgtyLDBqZbq+sFz/dpXIPIo@lists.infradead.org
X-Gm-Message-State: AOJu0YzfpmzPfnXEd6PvNt/h1GD1XRCgsE8bufXl7NUepYeeKw/vRbOJ
	6Fsoae74HeoeZR4uO8Yw/pXMXNvmMir7i3spn+MqmpRC2Qx9zvz8QryG5kvdnQ==
X-Gm-Gg: ASbGncu+1nkLGfEemCmKU+trvFj5T3zAkXwzBFCW9xT28lwEgFS1m0TMhcE9KuDY3Rm
	QeGPuURmUd975x2x7CYjd7hvqGY3+eK90t0gdPoFx0eNbLBfWwcHa6PWVJ+yE0PQULk+hWw4G0a
	QNGgdkCs3Ow/3ojXvCvAKHZJroCjUnl38X5JOj4PXTkTMvHSrs6GMfi4W0cw+58IBDxY51buq6d
	kVQdoickFgXDtAkL7S+/M+jaDMqN0Jzwu8OmNhBUMIPutXd39B7eGr1LBqSdKGZJ2loEc/aYxzr
	Ai3ENnaRAQPQw20Fy6g8uEdU/FnB6klUgo4JfTpmfT1maTvw4iiaAJM4JbqTPwMs
X-Google-Smtp-Source: AGHT+IFlt0LgLQmKQSlUwziRdLcwFuwYuvRWbdQ8rrLtwPvn17wSyVYVfRE70VydKdb5hQWDriS11A==
X-Received: by 2002:a17:902:da91:b0:224:10a2:cad9 with SMTP id d9443c01a7336-22e1039fdebmr55655375ad.41.1746201522811;
        Fri, 02 May 2025 08:58:42 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1522952csm9134125ad.185.2025.05.02.08.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:58:42 -0700 (PDT)
Date: Fri, 2 May 2025 21:28:38 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <hans.zhang@cixtech.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk, 
	hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Fix system hang when ASPM L1 is enabled during
 suspend
Message-ID: <z4bq25pr35cklwoodz34pnfaopfrtbjwhc6gvbhbsvnwblhxia@frmtb3t3m4nk>
References: <20250502150027.GA818097@bhelgaas>
 <be8321e5-d048-4434-9b2a-8159e9bdba43@cixtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be8321e5-d048-4434-9b2a-8159e9bdba43@cixtech.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_165849_750094_AF4B6371 
X-CRM114-Status: GOOD (  27.40  )
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

On Fri, May 02, 2025 at 11:49:07PM +0800, Hans Zhang wrote:
> 
> 
> On 2025/5/2 23:00, Bjorn Helgaas wrote:
> > EXTERNAL EMAIL
> > 
> > On Fri, May 02, 2025 at 11:20:51AM +0800, hans.zhang@cixtech.com wrote:
> > > From: Hans Zhang <hans.zhang@cixtech.com>
> > > 
> > > When PCIe ASPM L1 is enabled (CONFIG_PCIEASPM_POWERSAVE=y), certain
> > 
> > CONFIG_PCIEASPM_POWERSAVE=y only sets the default.  L1 can be enabled
> > dynamically regardless of the config.
> > 
> 
> Dear Bjorn,
> 
> Thank you very much for your reply.
> 
> Yes. To reduce the power consumption of the SOC system, we have enabled ASPM
> L1 by default.
> 
> > > NVMe controllers fail to release LPI MSI-X interrupts during system
> > > suspend, leading to a system hang. This occurs because the driver's
> > > existing power management path does not fully disable the device
> > > when ASPM is active.
> > 
> > I have no idea what this has to do with ASPM L1.  I do see that
> > nvme_suspend() tests pcie_aspm_enabled(pdev) (which seems kind of
> > janky and racy).  But this doesn't explain anything about what would
> > cause a system hang.
> 
> [   92.411265] [pid:322,cpu11,kworker/u24:6]nvme 0000:91:00.0: PM: calling
> pci_pm_suspend_noirq+0x0/0x2c0 @ 322, parent: 0000:90:00.0
> [   92.423028] [pid:322,cpu11,kworker/u24:6]nvme 0000:91:00.0: PM:
> pci_pm_suspend_noirq+0x0/0x2c0 returned 0 after 1 usecs
> [   92.433894] [pid:324,cpu10,kworker/u24:7]pcieport 0000:90:00.0: PM:
> calling pci_pm_suspend_noirq+0x0/0x2c0 @ 324, parent: pci0000:90
> [   92.445880] [pid:324,cpu10,kworker/u24:7]pcieport 0000:90:00.0: PM:
> pci_pm_suspend_noirq+0x0/0x2c0 returned 0 after 39 usecs
> [   92.457227] [pid:916,cpu7,bash]sky1-pcie a070000.pcie: PM: calling
> sky1_pcie_suspend_noirq+0x0/0x174 @ 916, parent: soc@0
> [   92.479315] [pid:916,cpu7,bash]cix-pcie-phy a080000.pcie_phy:
> pcie_phy_common_exit end
> [   92.487389] [pid:916,cpu7,bash]sky1-pcie a070000.pcie:
> sky1_pcie_suspend_noirq
> [   92.494604] [pid:916,cpu7,bash]sky1-pcie a070000.pcie: PM:
> sky1_pcie_suspend_noirq+0x0/0x174 returned 0 after 26379 usecs
> [   92.505619] [pid:916,cpu7,bash]sky1-audss-clk
> 7110000.system-controller:clock-controller: PM: calling
> genpd_suspend_noirq+0x0/0x80 @ 916, parent: 7110000.system-controller
> [   92.520919] [pid:916,cpu7,bash]sky1-audss-clk
> 7110000.system-controller:clock-controller: PM: genpd_suspend_noirq+0x0/0x80
> returned 0 after 1 usecs
> [   92.534214] [pid:916,cpu7,bash]Disabling non-boot CPUs ...
> 
> 
> Hans: Before I added the printk for debugging, it hung here.
> 
> 
> I added the log output after debugging printk.
> 
> Sky1 SOC Root Port driver's suspend function: sky1_pcie_suspend_noirq
> Our hardware is in STR(suspend to ram), and the controller and PHY will lose
> power.
> 
> So in sky1_pcie_suspend_noirq, the AXI,APB clock, etc. of the PCIe
> controller will be turned off. In sky1_pcie_resume_noirq, the PCIe
> controller and PHY will be reinitialized. If suspend does not close the AXI
> and APB clock, and the AXI is reopened during the resume process, the APB
> clock will cause the reference count of the kernel API to accumulate
> continuously.
> 

So this is the actual issue (controller loosing power during system suspend) and
everything else (ASPM, MSIX write) are all side effects of it.

Yes, this issue is more common with several vendors and we need to come up with
a generic solution instead of hacking up the client drivers. I'm planning to
work on it in the coming days. Will keep you in the loop.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

