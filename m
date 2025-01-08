Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E240BE77188
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 15:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IbKTc9lGbkrvOPTESZO2YB37uDOYsbWVlpqzaFAHPDs=; b=D//gLPpG6YZ8WIOzuBwJvQR1xE
	HX+okGhSRaw3FpWK5SGOMmKbZxyAzSGLD1GtpOt9QedlPCpBWlQ9QNo1cDJXw7sG84Qus3ADBxetZ
	ylQN6jXV7acU1MaG2oJhTWD5u9D1FtNoJ2U7paqYc0g0wWBQx07QUVVBDPU8AUEHZk2h+nFLu3kW1
	7WdhfqXtjv0w94hli6jInIqGsJRlq44NWF5JJfpXB5EbTmdwWLS0ewr37X23x72/SDpZCWjm65LJ5
	o2wIdVnAD9SW6TxYYyUuu0AV9HBK6FxIySs+pNOrhWWItehwwetmZzWRFr4jopqub/J8IdaeWhzIr
	XYrLK3YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVXeh-00000008u6W-0qQs;
	Wed, 08 Jan 2025 15:07:35 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVXee-00000008u5L-1BGX
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 15:07:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id ADCB05C4CA6;
	Wed,  8 Jan 2025 15:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFB2C4CED3;
	Wed,  8 Jan 2025 15:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736348851;
	bh=6kKI+ZZjIPBF7ralqB98Yh3wcIovpUpRBoUWQ1FiHdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ls0/cX0hzOYLDYZQcy8hvplpbsIg0M3XtD3I+tfAi9zo6dbFHOxo+tthnkOFW+KnE
	 U+igBR4F2WbmhYQkxWti4FyS6TWSoXzr35STmLHBxwJvlYqcZNEtrlv/dPUoE3VmjG
	 hKB6PQCj5SYOxMPVFdgAta5ch/eXa+61UfNTKMx66fpXTYCiA8Pm4g8Rbsu/+D81FW
	 h7FtjEkz00iICDeaPROmlZTCjEx+pIu4/xwa4OghMeJs/WrA5yPeTAFQS0VxXHKy42
	 nDnOJSOvlMxKi2lvAgIGf1wbeTz8u5x7/cb3rDobCxT8YD4nZeKpcDUracWbufct3r
	 kkUhjbtolvHug==
Date: Wed, 8 Jan 2025 08:07:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Adrian Huang <ahuang12@lenovo.com>, Christoph Hellwig <hch@lst.de>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX
Message-ID: <Z36UsE5dj6j5HhkX@kbusch-mbp>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_070732_404936_BE22EEA5 
X-CRM114-Status: GOOD (  18.75  )
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

On Wed, Jan 08, 2025 at 03:38:53PM +0100, Thorsten Leemhuis wrote:
> [side note TWIMC: regression tracking is sadly kinda dormant temporarily
> (hopefully this will change again soon), but this was brought to my
> attention and looked kinda important]
> 
> Hi, Thorsten here, the Linux kernel's regression tracker.
> 
> Adrian, Christoph I noticed a report about a regression in
> bugzilla.kernel.org that appears to be caused by a change you too
> handled a while ago -- or it exposed an earlier problem:
> 
> 3710e2b056cb92 ("nvme-pci: clamp max_hw_sectors based on DMA optimized
> limitation") [v6.4-rc3]

...
 
> > The bug is triggered by the patch "nvme-pci: clamp max_hw_sectors
> > based on DMA optimized limitation" (see https://lore.kernel.org/linux-
> > iommu/20230503161759.GA1614@lst.de/ ) introduced in 6.3.7
> > 
> > To examine the situation, I added this debug info (all files are
> > located in `drivers/nvme/host`):
> > 
> >> --- core.c.orig       2025-01-03 14:27:38.220428482 +0100
> >> +++ core.c    2025-01-03 12:56:34.503259774 +0100
> >> @@ -3306,6 +3306,7 @@
> >>               max_hw_sectors = nvme_mps_to_sectors(ctrl, id->mdts);
> >>       else
> >>               max_hw_sectors = UINT_MAX;
> >> +     dev_warn(ctrl->device, "id->mdts=%d,  max_hw_sectors=%d, 
> >> ctrl->max_hw_sectors=%d\n", id->mdts, max_hw_sectors, ctrl->max_hw_sectors);
> >>       ctrl->max_hw_sectors =
> >>               min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
> > 
> > 6.3.6 (last version w/o mentioned patch and w/o data corruption) says:
> > 
> >> [  127.196212] nvme nvme0: id->mdts=7,  max_hw_sectors=1024, 
> >> ctrl->max_hw_sectors=16384
> >> [  127.203530] nvme nvme0: allocated 40 MiB host memory buffer.
> > 
> > 6.3.7 (first version w/ mentioned patch and w/ data corruption) says:
> > 
> >> [   46.436384] nvme nvme0: id->mdts=7,  max_hw_sectors=1024, 
> >> ctrl->max_hw_sectors=256
> >> [   46.443562] nvme nvme0: allocated 40 MiB host memory buffer.

It should always be okay to do smaller transfers as long as everything
stays aligned the logical block size. I'm guessing the dma opt change
has exposed some other flaw in the nvme controller. For example, two
consecutive smaller writes are hitting some controller side caching bug
that a single larger trasnfer would have handled correctly. The host
could have sent such a sequence even without the patch reverted, but
happens to not be doing that in this particular test.

