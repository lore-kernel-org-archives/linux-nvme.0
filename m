Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4467DC54E58
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 14:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=abbBUKTHI4gf/jsRFQPIzMQswVaBhj9YHTPYRdp2ZK8=; b=C6B9dmAVKdwBto78smewFE5Qcw
	O5L0dgJoV9NAl0fTUIVuxXAuMC6HQA1uKuA84CzjG0O76tjk/YlnYRsIeTyVqHiGzY0PMJS0UMHcj
	BuSBv8d8ESl8+XuXjuxu2vrDisWmcxEF1mtgAZ38rldqOPdE68pxDHf8CAnAQJs9y4owpSvpINxIj
	w2P/dvSjZZPnRJGp6MAMmY2mE472aGcp13MVuglDllpSVY6/G0uTxARC5AiQQC8htqZlKw/ZgrNI5
	0NZipTmTKreNSqvNN+qTAOtdYQpt2eMylf142bgTS7mRPY+OYb6PjOD2Gm4fl9gq/YCbO89sX8jG3
	ZV2GYhXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3HV-00000006AIQ-3YFL;
	Tue, 12 Mar 2024 14:39:05 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3HS-00000006AHP-3JMP
	for linux-nvme@lists.infradead.org;
	Tue, 12 Mar 2024 14:39:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1E29961158;
	Tue, 12 Mar 2024 14:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6559CC433F1;
	Tue, 12 Mar 2024 14:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710254341;
	bh=0qo9EfHDEZ8iSvosOjDDAIpyZc4u2I/thDSO0I2SpiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g066vWwCbLg7B2oJBSVCGIvXST4RgYqDD/q2vOyOUgwtDixw1Ku2TAQBm2p1TItLc
	 qEYLSKT49FeODILlplrGZMMxy9j4aArsUYzv2vlYNxFPQ4EpbpFKxPAOKRPSkcgl8Z
	 dxQTD6DA2VAru368rNgMc4k4zipw5hK+6NQHNAyDx/Ikz/FOmZ403VAbljquUiSBkA
	 Cb6Vo+yUsywtzbRDFs0M2NhNwPK0+0Tiqm1RYFZTbIS08HY4mf4R79EQhVHmLTwj4U
	 qG+XQWZvnb8KzOyC1yW1vTP5ErDZvV4zC545vG7Wur6mnBrMFn8+caiHeZp7HWcPqA
	 hMURjJ+s8oVgQ==
Date: Tue, 12 Mar 2024 08:38:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Michael Kropaczek <michael.kropaczek@solidigm.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3 0/1] nvme: Fix problem when booting from NVMe drive
 was leading to a hang.
Message-ID: <ZfBpAw_4e-xfAHW8@kbusch-mbp.mynextlight.net>
References: <20240311220811.3011800-1-michael.kropaczek@solidigm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311220811.3011800-1-michael.kropaczek@solidigm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_073903_063575_5BB4DA5E 
X-CRM114-Status: GOOD (  12.94  )
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

On Mon, Mar 11, 2024 at 03:08:11PM -0700, Michael Kropaczek wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index e6267a6aa380..bda7cf5ff674 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2593,6 +2593,9 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
>  	}
>  
> +	if (shutdown && dev->hmb)
> +		nvme_set_host_mem(dev, 0);
> +

As I said last time, this deadlocks if the controller doesn't respond to
the command. While that shouldn't happen with a properly functioning
controller, we can't count on that to prevent a deadlock.

>  	nvme_quiesce_io_queues(&dev->ctrl);
>  
>  	if (!dead && dev->ctrl.queue_count > 0) {
> -- 

