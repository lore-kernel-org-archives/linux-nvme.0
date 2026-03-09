Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A0BEF36F8
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2026 08:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iG5cUe+YN0/blrgDC+eLuPZ2HGSdRpdG+sL6fdNqa04=; b=JosrLBeBMgi0VDHkTef5Yj7RpA
	ekBwSEppd1u9N3p5TiY8YPc9F9waa0KrdzHyViCpB4rfz4ac1DVo1oqhXcE95REoU8s5irzeBS4c/
	edxkUcnYDgP8uY0WGlCnLVSCO+J5GqBLoPv9g2Pk/qylCVLz1PDKBizT+RXY7We4dc8tUqFjTDhCo
	y9YwKAAn9ufalD3eDpxSJVaS83eSIcAsE2S/0jyRS45HEFq5vCdhHDMbwILj634EZhuQX1d33N5ZP
	Cc0wdwroghaZLnZfjme5QOJYAoTYF7EOk4SMkCImOISLyVN7eDOZ1jYx4gYc2CuruiJfuHq3WuNFH
	dNwQzgPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzVXl-00000006r7S-0SMK;
	Mon, 09 Mar 2026 08:00:49 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzVXi-00000006r6Y-08zD
	for linux-nvme@lists.infradead.org;
	Mon, 09 Mar 2026 08:00:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B4B5C42E41;
	Mon,  9 Mar 2026 08:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09CEC4CEF7;
	Mon,  9 Mar 2026 08:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773043244;
	bh=oLICg3wmajRFE766zc5v+Mhsl02mz5h3ToNTDdVSp04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CNZItq8LwmKUyF4EsMYfZzw79lQvEZA1PoAqpBMqbYmGVknRBToRujRDKh6Ep4Csh
	 7tpZ+lWDOH1+lfes2lAtWo8E8mb7XSLrUspgSZuiyeJdMDX8h+FQktz7PZZF1T25lJ
	 uACXhUtIhn54ju06Ox37MB4fbfLeXj/G/KflaUyci8mylZHqMmJqgZNArwBJ6t83HP
	 +ji9lZ0aQQJIPvusqwCq22ogl7M502qvPO0+2PuWChQ4mMJGH6LfGAXsdhuF+J6RmM
	 rBi2SCB9AgU2x6l6VsvNUWrbrxXP0lXmwN7v77tVA0KDh+Q7QJ2Vp4TzMh5TbvnyHz
	 r73zDPAlQdt7g==
Date: Mon, 9 Mar 2026 13:30:28 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	krishna.chundru@oss.qualcomm.com, Bjorn Helgaas <helgaas@kernel.org>, 
	manivannan.sadhasivam@oss.qualcomm.com, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, 
	Kai-Heng Feng <kai.heng.feng@canonical.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Chia-Lin Kao <acelan.kao@canonical.com>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
Message-ID: <y6ssm2pxybi26r54aszgsksg7pijnnqkmrut26lwgw2iawihu7@sw7ctkze7yni>
References: <bf37b6a5-268d-4c07-a536-a826b3d5953b@nvidia.com>
 <unc5zefwndgcv7wufaezz3gkg3qtaymkjlmymhyqdqwzn3wybl@ow2rhbyt772h>
 <f9ac8c8f-8959-416b-ba90-14f0886c5bc0@nvidia.com>
 <a5m4pqtiaxsq5lmq64roro633ganbeq7mypa5ojuuqy4npkvok@wcogdbzaq6xe>
 <7157c68e-97f3-43b0-bfb5-e271a8f2a4b8@nvidia.com>
 <cf1e685a-a1cb-45ec-bdc3-1ef1a3d1044e@nvidia.com>
 <npt2cgwksulq5375dzlhszqaqrurgdvlkz6fdczer6shglqfg5@gp6a6xymymww>
 <26ad62ff-4972-4b29-8f9e-1868cd20ee00@nvidia.com>
 <kkly3z4durpagtenadvmzdpojlctachgfgi2fdapt6zthdl2gx@n2qhmlud2zb7>
 <3a0ddcfa-9fe6-4744-a9e4-016c43f9400e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a0ddcfa-9fe6-4744-a9e4-016c43f9400e@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260309_010046_229871_A9FDB394 
X-CRM114-Status: GOOD (  24.20  )
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

On Fri, Mar 06, 2026 at 04:03:35PM +0000, Jon Hunter wrote:
> 
> On 03/03/2026 16:17, Manivannan Sadhasivam wrote:
> 
> ...
> 
> > > For Tegra, we enter a deep low power state known as SC7 on suspend which
> > > does involve firmware. Nonetheless I tried for fun, but this breaks suspend
> > > completely.
> > > 
> > 
> > Ah, this explains the problem. We also have a similar problem on our Qcom Auto
> > boards where the firmware completely shuts down the SoC and puts the DRAM in
> > self refresh mode. So NVMe driver never resumes properly. We tried multiple ways
> > to address this issue in the NVMe driver, but the NVMe maintainers rejected
> > every single one of them and asking for some API in the PCI or PM core to tell
> > the NVMe driver when to shutdown the device during suspend. But this turned out
> > to be not so trivial.
> > 
> > Another way to workaround this issue would be by calling
> > pm_set_suspend_via_firmware() from the driver that controls the entity doing
> > power management of the SoC (firmware). In your case, it is
> > drivers/soc/tegra/pmc.c?
> 
> Actually for newer devices it is PSCI and so ...
> 
> > In that case, you can use this patch as a reference:
> > https://lore.kernel.org/all/20251231162126.7728-1-manivannan.sadhasivam@oss.qualcomm.com
> 
> This change fixes the problem as implemented. What is the status of the
> above? Any plans to get this merged?
> 

It didn't get any love so far. It'd help if you can give your tags to that
patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

