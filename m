Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0555FC67861
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 03:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LswP6sKv2yCqq2cK5t4lCptCVLRMsozdomeFN0D/yHs=; b=GvRfi+da07C/Wz6/h9BeYlEEsD
	ZjGdR4LnqlrA/YShq84N7p3ys6mHvj+A2fyJhWXSyWxbWttWPuol9agzuTsAi3tfQK+ik0za3dwFf
	5uW3GxKn0JwwRdCKoQv7WYvtiK/mZHyLfgEjEOzfbGTYKaKIeWlbIWr4uMKOb/dm7mcO9Kcb/qdjo
	bCNF+Y9lS9O/V6a/cl3sFowClUKh4f/KixZE6BrrTpXypBjgMQ4M2NbwHt+Cp0Wz2axXV6JSW/rlt
	yht+k6RV3PSLMx54m8nZIDjilvl8KT+DdM416EmABQItb2fCquDlWfR1IP8u2l2AnaeLs3cmDI+JI
	euUn05iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruOKj-00000004pvI-0qsN;
	Wed, 10 Apr 2024 03:09:09 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruOKd-00000004puR-00UF
	for linux-nvme@lists.infradead.org;
	Wed, 10 Apr 2024 03:09:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A96C261A7E;
	Wed, 10 Apr 2024 03:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96534C433F1;
	Wed, 10 Apr 2024 03:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712718540;
	bh=EM7nowdjdbNVWh8bciK9Ha2EeZjxwFBLgso2R6SZNRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/qjir1eLQpUmzvGiwsCTcuX7poh7q1n53pOsndQLCaN8N08FgGHZcHyWtnwJiTDk
	 tdhP1pdvZXueZIu/RWYU1GQerDJdaFwLNP+mrwEQU0ShPPRvc+XwEj0gPfNdKGX6eV
	 7Oa5rqAbGBrMGnEAqhQr7WgS6E7UQ9BPehhk4pMig6+WpuzBZitbu68SXwBdF1YIQt
	 PpKBGmlQsvxl5fKqKMHy0/A07G4tsGhk7ytmAT3um1HUHkpOhW4wmNPjgIGV2TWIor
	 469kgbwXHWwsXVrU3rxum8qXLWfV9YQ9x+vO6TYzbQ0dhd06mtbwJl4liAzvPTHcwJ
	 XzEx46LDJ1y/w==
Date: Tue, 9 Apr 2024 21:08:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Holger Huo <holgerhuo@outlook.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Holger Huo <i@holger.one>
Subject: Re: [PATCH] drivers/nvme: Add quirks for device 1cc4:6a14
Message-ID: <ZhYCyuP6vTJq-TZq@kbusch-mbp.dhcp.thefacebook.com>
References: <ME3P282MB24818FA28E7C73BC01302882B5072@ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM>
 <ZhWhshq7hpPd9XrI@kbusch-mbp.dhcp.thefacebook.com>
 <ME3P282MB2481C1DC0506D154FA3AA3D2B5062@ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ME3P282MB2481C1DC0506D154FA3AA3D2B5062@ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_200906_451529_0D867008 
X-CRM114-Status: GOOD (  21.09  )
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

On Wed, Apr 10, 2024 at 10:05:46AM +0800, Holger Huo wrote:
> On Wednesday, April 10, 2024 4:14:42 AM +08 Keith Busch wrote:
> > On Wed, Apr 10, 2024 at 03:28:50AM +0800, Holger Huo wrote:
> > > This commit adds NVME_QUIRK_BOGUS_NID for device [1cc4:6a14], the
> > > Shenzhen Unionmemory Information System Ltd. RPEYJ1T24MKN2QWY PCIe
> > > 4.0 NVMe SSD 1024GB (DRAM-less), which can be found on many Lenovo
> > > notebooks. This SSD produces all-zero nguid.
> > > 
> > > Other SSDs manufatured by Shenzhen Unionmemory Information System
> > > Ltd are likely to face similar issues, but I currently have no
> > > device to test.
> > 
> > Are you using the most recent stable kernel and still need this patch?
> > These quirks shouldn't be necessary anymore unless it's advertising
> > multipath capabilities, and it doesn't sound like this one should be
> > doing that.
> 
> Yes. My current Linux kernel version is 6.8.4 by arch. After further 
> investigation I found these quirks truly had no effects.
> But my nvme drive still freezes with Device not ready; aborting reset, 
> CSTS=0x1 failures and AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0001 ...] 
> waking from s0 (s2idle) sleep. Are there any other quirks or what that I 
> should try

I've seen the IO_PAGE_FAULT error reported before, but all I've heard is
that it means the device attempts to access a memory address that it is
not allowed to. I don't know why that would happen, though. I've never
first hand experience with this condition, I'm just as confused.

