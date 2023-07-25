Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1CEC001E0
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jul 2023 14:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WWBebdUOHAwGjNmUd0BLD5EBUj4u21H/flsLVNiSGyE=; b=Fx+f9/+IGd1EkRHV/BEzOIdB9G
	uT6sTiV71AGe0woqBgWX49gZtwVsqO85/KYnKkf2XNE3O4xY4gG1lgPukJBTtFoLOuhLcxfRrQdvC
	ms/hwT8cicxcNyotCXo1do6qtQx7HQMMBLbS+l28fpmiAwNrmLgEW1rGsow0qz21nsljefdW1ZNNz
	VSiVnJiRPop05/Tn5Pvj6LLISy0UO7SeEc2LZSTjFBSgDImMQuQ2DiTKkhPkeEZl3ZLJMI6U9gAQp
	kikftKz7w+WCqFUlFxX/rDyMR5+xv73bxHGdsp6v5vM+9nz1M/yhPKOAmWbYxtrAHhNPFB/5rQC0o
	WsuvWdVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOJ8H-007n3U-0j;
	Tue, 25 Jul 2023 14:35:25 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOJ8E-007n2u-2J
	for linux-nvme@lists.infradead.org;
	Tue, 25 Jul 2023 14:35:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9953361782;
	Tue, 25 Jul 2023 14:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FB4C433C7;
	Tue, 25 Jul 2023 14:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690295721;
	bh=WWBebdUOHAwGjNmUd0BLD5EBUj4u21H/flsLVNiSGyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IerEz7osX93i6yK1JNW2zmIpgHzJcMB+j3yDUJPtDvwWOGcSkxCx31sDEIcFaOk9n
	 GuErLPO0vaQXJjmS0o/WAOEaDFhC9kM3e3RpS4VcbumZRO2tWHRvdoJAGcmKXxPb7v
	 r91/m6ZY1VwuUPMLl6g8giZgnu1HsBa4wZUgmiP93ByjBWGNGEIlYSUePSrGu2KEsb
	 IcYci2QbXP0UkLRNW2M5VYVotMEzA9e87AI6Dw/y6AAGXsj40bS3RsIZot3n8LeoBk
	 xEQ6gPTeG5N0p9QioniD/xm6JBhSsUTTBMAFi1fSIjl9FtG4Qpue3a/thTAm/J2s4+
	 w49bXwqQu0ZPA==
Date: Tue, 25 Jul 2023 08:35:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
Message-ID: <ZL/dphk/MJMRskX8@kbusch-mbp.dhcp.thefacebook.com>
References: <20230725110622.129361-1-ptyadav@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725110622.129361-1-ptyadav@amazon.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230725_073522_818995_A29CA97D 
X-CRM114-Status: GOOD (  20.28  )
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

On Tue, Jul 25, 2023 at 01:06:22PM +0200, Pratyush Yadav wrote:
> If a device has no NUMA node information associated with it, the driver
> puts the device in node first_memory_node (say node 0). As a side
> effect, this gives an indication to userspace IRQ balancing programs
> that the device is in node 0 so they prefer CPUs in node 0 to handle the
> IRQs associated with the queues. For example, irqbalance will only let
> CPUs in node 0 handle the interrupts. This reduces random access
> performance on CPUs in node 1 since the interrupt for command completion
> will fire on node 0.
>
> For example, AWS EC2's i3.16xlarge instance does not expose NUMA
> information for the NVMe devices. This means all NVMe devices have
> NUMA_NO_NODE by default. Without this patch, random 4k read performance
> measured via fio on CPUs from node 1 (around 165k IOPS) is almost 50%
> less than CPUs from node 0 (around 315k IOPS). With this patch, CPUs on
> both nodes get similar performance (around 315k IOPS).

irqbalance doesn't work with this driver though: the interrupts are
managed by the kernel. Is there some other reason to explain the perf
difference?

