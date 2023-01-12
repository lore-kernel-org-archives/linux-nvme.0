Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257E3C54EBC
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 16:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DnU/jHVmsHLAruQT2Nm0nlYbQqCffSOK4rz69rrrRF8=; b=XSDJ/FYgcmcO5egpv4T8IP1CuK
	swmSh/PIRAcG01M6EvvvBr8cC3xqQw3MThSGMcUep6XXfieANYSnxvTxgB4WwHRj19nRYZUzZjdPw
	AhTS4VgYUhHFnyF1OkYOLOob9b/4wuXqCSnBDwdBNRqDYPBZAaiY+qz2vAeIMuJmT+2vdwJ1PFt4V
	RMwbMaGzNuibstYiFZuusOrgaF8/4qat8U94wUklMEqSgMd0Ppz+GtkCyuLnahxh6GDrJpiktlqm4
	DSvjhwPGhwSFm/N44yH+sfD1QgnePuj/sQplADvf2pSCzq7Wed7Mbc3qY5StEGjqF9HZTjrOVK4y1
	M+ifP/Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG0aL-00FsPc-75; Thu, 12 Jan 2023 16:37:49 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG0aI-00FsNs-Mp
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 16:37:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 5C3B7B81EDC;
	Thu, 12 Jan 2023 16:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4224C433F0;
	Thu, 12 Jan 2023 16:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673541464;
	bh=VP+bv1sIlCedADn+6h8q+hg8D0YmhUlHd70hQ4kpwqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tp2xL2fldgwI76fxNbq8SyuEBGy0mMY9UFtf2AzTBtgXpiGS0fca72EyKIQpFxmLO
	 +lgFdQjZ2hrPIVxgWqrC9bJYa6lCCye9J4zXqjmAmBe4fmuPrP+In4XxRg2HynQ3tM
	 GQx42cOEBLNrtF86gQXA6ttgrku/gsGM/M1Dijaaf5dt59VvnAtH/BSWLIZUYJ28Hn
	 QCMKpqbHreTsp3msBGssTuKexCgOwhulGa9qF13wgwDapXGUiuPuV0f8aPB+6vJh4y
	 RnhMSd7sxx77GU00EmydD5e90/M+DV1ZCd3tCsk8SS90/Q2MSlQbSpj10OyF/mTkkF
	 3Tw/4O8j3H0Mw==
Date: Thu, 12 Jan 2023 09:37:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: Julian =?iso-8859-1?Q?Gro=DF?= <julian.g@posteo.de>
Cc: linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: Regression in Kernel 6.0: System partially freezes with "nvme
 controller is down"
Message-ID: <Y8A3VftFnNT7wjl0@kbusch-mbp.dhcp.thefacebook.com>
References: <d5d8d106-acce-e20c-827d-1b37de2b2188@posteo.de>
 <0d3206be-fae8-4bbd-4b6c-a5d1f038356d@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d3206be-fae8-4bbd-4b6c-a5d1f038356d@posteo.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_083746_911444_E81B397F 
X-CRM114-Status: GOOD (  10.53  )
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

On Wed, Jan 11, 2023 at 10:11:22PM +0000, Julian Groß wrote:
> 
> Currently, I am using git bisect to narrow down the window of possible
> commits, but since the issue appears seemingly random, it will take many
> months to identify the offending commit this way.

Unfortunately bisect may be our best option. Link loss like that usually
is a problem below the nvme driver level.

