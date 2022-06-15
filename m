Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFD9CCA473
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 18:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PPSTAQnuEYPVvy4m+rns2DfwGnMdcGxfaJPkUIMrMgs=; b=gbnOGAcxhbe9S+Hz9lZWW0IoyI
	tEfO7VZFHwK/MZATTtnv9X/hj7Dn9bMdc8IwL+z1fQ8ZhFiTpO9RVZ791bG5YGUY050RjhLBRfoKN
	n5ruDDmYZP0ntB/JwAzjaZ9VUZCMDW83bZZMmc15mIDYvaN1lRisgior3tA9SCi8wSqxMAGU7bEse
	i0gIV5wIpu4jK/Od8xSx5Pk9vSpuL1hSB4tJQ/GYEzLIOpeoVPsloGp63K5p97/N1YYjtzFt7mHVe
	hHO/Nd0XEbrBXjn5hDGBVIVbdcpMBpJNTnx2zA6c1vSbOnvizQur5hwUo3S1qSvn3bjzfj0TUj4bE
	te0Ky7gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Xx2-00FwW8-8j; Wed, 15 Jun 2022 18:41:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Xx0-00FwUH-BG
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 18:41:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 77C2761C22;
	Wed, 15 Jun 2022 18:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F01FC34115;
	Wed, 15 Jun 2022 18:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655318468;
	bh=aQrwqFLT5KW3RGQgBn+BHZAI/LCgRU4T3zqdiFw1N7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ltvj3ELLROvjZiA+vZ9/XTdu6ZHC0rN40UdjI9aHr8z17KjaRnfMG5CBqD30ftlZ6
	 kx92xiAp9otoG3YyPqc+cjJwECdxHG8FoppMCCCedaFXI++mWseAIgWHZPB1AEox7T
	 BJqH4dgfwtbwNUjr9wK5aFfuVdJlIbZiXG8XPdk1QXdaSH3xqTUGourVIY4qfd02d9
	 nS70C69mwGmpVmYtSuLi9iDdMAa+I45rpIztDoU1YVnK0dJm/cLBrwZJ5I6z+f/q/d
	 aX/6gJeaeH/68VtFBdqkF1Rpk84cEDlp8uF9ITU0NBCu9IW9I1FBsaB7FLmNi8vTDB
	 1B3tviLs9rFdQ==
Date: Wed, 15 Jun 2022 12:41:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: Erwan Velu <e.velu@criteo.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Report model,sn,fw,pci device information during
 init
Message-ID: <YqonwfjE8BL6Xowf@kbusch-mbp>
References: <20220615180213.760756-1-e.velu@criteo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615180213.760756-1-e.velu@criteo.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_114110_484581_3F8E046A 
X-CRM114-Status: GOOD (  16.60  )
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

On Wed, Jun 15, 2022 at 08:02:13PM +0200, Erwan Velu wrote:
> SCSI-based device get their identify properties being printed when initialized like :
> 
> [    1.245357] scsi 0:0:0:0: Direct-Access     ATA      HGST HTE721010A9 A3M0 PQ: 0 ANSI: 5
> 
> When initializing nvme devices, no identification message is reported
> making difficult to identify them during the boot process. If the system
> crashes during boot process or if the init phase fail, it could be very diffcult
> to identify the faulty disk.
> 
> This patch reports model, serial, firmware version and pci information
> as soon as possible making this early identifying task possible.
> 
> Reporting the serial has the interest of being able to ensure which
> physical drive is concerned if a hardware replacement is required and
> host features the exact same drive multiple times.
> 
> A typical output looks like:
> [    0.383353] nvme nvme0: pci function 0000:00:03.0
> [    0.418184] nvme nvme0: MODEL:QEMU NVMe Ctrl                          SN:deadbeef            FW:1.0     PCI_ID:1b36:1af4
> [    0.422020] nvme nvme0: 1/0/0 default/read/poll queues

The PCI_ID: print is misleading. That format usually indicates VID:DID, but
you're printing VID:SSVID.

This is also very similar to the recently introduced nvme_print_device_info(),
but that one removes the annoying trailing spaces if they exist. I guess if
we're going this direction, just use that print, but change it from dev_err to
dev_info, and remove the call on global id collision detection.

