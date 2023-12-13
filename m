Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB9BC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 22:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wLS95/q6CIXMvIMITS04vQS9H1jDLILf6Z6vEqk8Tao=; b=BNevBfc6FPx/RHsx8g70kYEgGE
	l42SWLEp23J+11hICoujgpAhHpAhsbZEB0ZHpJDpcMyeLsCnfY340Cr0zPjXzCjyxJU3GrBbswsMS
	YD958VrCANY3vqHd9cutEwJJf8vFjErXwa2ibZ3a9jN89encTd/6I6jdWc3ebTBUZluUfuqyoTMKp
	171W7uio2o2o/JZ42L+O05O8xV35GK6Scs064uIq/4KUYZojVr76sKj+N7E1L0vm4HrmC5BJmXKa2
	pd4xMtZt+R8SRAm3uyQ31zu3uZELprbzZnw0ezFnqeir0XyNggDgyoGltTMDiehILQU5Amc5rBNx5
	Boi8977A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDXuR-00G9GZ-2Z;
	Wed, 13 Dec 2023 22:40:55 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDXuO-00G9G8-2D
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 22:40:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 97525CE1378;
	Wed, 13 Dec 2023 22:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B866DC433C8;
	Wed, 13 Dec 2023 22:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702507249;
	bh=TyMld8/hwt0istjsH7futOvalzBHIyEluVP6FcMDrDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=khoVgTxdKvWdusV1ueZnQpUDcyTYrNKXUcpsrhvTqRMYjLLz0zWVDq2huaMEWsl7P
	 MLS9F8PSbTYjxPamGTtl7/s3cWX4woFnOZLhKyuH76KtUw54+i2V4uawpq2NX3guIW
	 piE1uK4V9OOYXeMAkNjfH6t4Pu5XzoK91kodkSpn7jx/lBIyuKX7xwpHBEpVE+TIn+
	 Igl++pLst3TD+iowW+vZI/eT7J5Hcu4NAhEpgmpLwG+qTqXmcnLkVef2aQBmrOT5/M
	 PLD7NubE9fr9M/ZIaG9zZrVAUjj7vRMDtTXibZCsuK6ndlWqj0BG002eYpa1Ciq7z5
	 j1XjESLVgY9Qw==
Date: Wed, 13 Dec 2023 14:40:48 -0800
From: Keith Busch <kbusch@kernel.org>
To: Jeff Johnson <jeff.johnson@aeoncomputing.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: Advice appreciated - attempting data recovery on Intel Optane
 H10 (CSTS=0x0?)
Message-ID: <ZXoy8N6Qw5x-DifR@kbusch-mbp>
References: <CAFCYAseYeXvTTRaC_Mmcbo34Lqd=YApa6-VU93Vz3yPW4Rbr8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCYAseYeXvTTRaC_Mmcbo34Lqd=YApa6-VU93Vz3yPW4Rbr8w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_144052_922747_B4F821B9 
X-CRM114-Status: GOOD (  19.02  )
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

On Fri, Dec 08, 2023 at 06:12:28PM -0800, Jeff Johnson wrote:
> Greetings,
> 
> Seeking wisdom, many thanks to anyone who stops to read and more if
> you have advice.
> 
> I'm attempting data recovery on a odd little SSD Intel built called
> the H10. It is an M.2 NVMe SSD with two controllers and two different
> flash devices. The M.2 is bifurcated from x4 into x2x2 with a
> different controller and flash device behind each x2.
> 
> I was able to access the low side x2 (lanes 0-1) that connected to the
> 32GB 3dXpoint flash device. It was a cache so not much valuable data.
> 
> I had to do some lab gymnastics to access the high side x2 but I was
> successful. Now I can see the other controller and the link speed and
> width are fine but it won't initialize. Basically I had to disable
> PCIe spread spectrum in the system BIOS and use kapton tape to mask
> out PCIe xmt&rcv lanes for lanes 0 & 1 so the high side x2 lanes 2-3
> were the only lanes the root complex saw and connected. Crazy I know
> but it worked.
> 
> Rocky 9.3, 5.14.0-362.8.1.el9_3.x86_64
> [   12.077360] nvme nvme0: pci function 0000:06:00.0
> [   72.080442] nvme nvme0: Device not ready; aborting initialisation, CSTS=0x0

The command line tools require admin queue availability at a minimum, so
this isn't going to work.

I think you need a special PCIe port with a bifurcated retimer. I'm
guessing the nand side requires the optane side up in order to complete
some internal initialization. Perhaps it's sharing the power provided by
the other lanes.

