Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA5AC001DC
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 16:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4d2s+iN0hU5ElA/lT3SolsnTIYmwNJk52FdrvGPrf6U=; b=juqHYmbQkym+kNmZIpO0EeIeeq
	VEiNNFZQMqEbNU2/aYkrUlJNW3BIrpor/eERJY0+1TaekBXOG/ndD2ASFUSPkqffZEcamcZWd0D97
	PP/WvnWUB4R2pe52Q5+dgqLelbx16iw0xYodqZ978wqYFMZHKs3mQmsyKC6Gexx5Z8FJYhix0yf0L
	nzDAOFkzjZ4ks/iBJ/58ij0NQ/sOYNd4iUealIhvTnLgPn7B/1eeRUPPZmZOia/RvA5df2A4Z7W2n
	PEBu8Dnfw4EUmoO9bGOUMPqhNRIFNzZW0yMJOqfl17G5Torb9HGowGDnV6LlpvKP/O6IdujrbxCoT
	fIYLET8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOhCZ-00AzEW-1v;
	Wed, 26 Jul 2023 16:17:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOhCW-00AzDy-32
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 16:17:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D622361BA7;
	Wed, 26 Jul 2023 16:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A53C433C8;
	Wed, 26 Jul 2023 16:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690388243;
	bh=EzXddJxdLCYjjaFLuW2hCq3oDwt9vioK1ChWO2Mwx8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q06Z4ihIpUy+7SKUtFzFVavPTBeQavAX3BgEqflbadf8w+4hCjOuVpbKAYKUaB7Lf
	 nqzj8nF+wZ250iGYlYL5rhE7bqDiSswYvwgKkt1LyBKXSeQil04tT7FzKMiegLL0E7
	 xPBSCs31s9usjL9nVoqgmcsvx77Hwd9p25c4ld5ErkeWHTjjAKTeSXhS9sYDxYphnF
	 OZi+jNvnGBGXY118qbP/jkJJ4raskWDJTPiyxcnBPHerXvK5EjbUPsOd1imz4gvF8L
	 tjPz9mtKR26a8HOAego60n7FvpCH2FZ4dxPdUbnXljxRl2So+rX/84Y7TP8oAJ52eb
	 Q7xM3XoMMwCXw==
Date: Wed, 26 Jul 2023 10:17:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
Message-ID: <ZMFHEK95WGwtYbid@kbusch-mbp.dhcp.thefacebook.com>
References: <20230725110622.129361-1-ptyadav@amazon.de>
 <ZL/dphk/MJMRskX8@kbusch-mbp.dhcp.thefacebook.com>
 <50a125da-95c8-3b9b-543a-016c165c745d@grimberg.me>
 <20230726131408.GA15909@lst.de>
 <mafs0cz0e8zc6.fsf_-_@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0cz0e8zc6.fsf_-_@amazon.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_091725_041769_53A986CE 
X-CRM114-Status: GOOD (  21.20  )
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

On Wed, Jul 26, 2023 at 05:30:33PM +0200, Pratyush Yadav wrote:
> On Wed, Jul 26 2023, Christoph Hellwig wrote:
> > On Wed, Jul 26, 2023 at 10:58:36AM +0300, Sagi Grimberg wrote:
> >>>> For example, AWS EC2's i3.16xlarge instance does not expose NUMA
> >>>> information for the NVMe devices. This means all NVMe devices have
> >>>> NUMA_NO_NODE by default. Without this patch, random 4k read performance
> >>>> measured via fio on CPUs from node 1 (around 165k IOPS) is almost 50%
> >>>> less than CPUs from node 0 (around 315k IOPS). With this patch, CPUs on
> >>>> both nodes get similar performance (around 315k IOPS).
> >>>
> >>> irqbalance doesn't work with this driver though: the interrupts are
> >>> managed by the kernel. Is there some other reason to explain the perf
> >>> difference?
> 
> Hmm, I did not know that. I have not gone and looked at the code but I
> think the same reasoning should hold, just with s/irqbalance/kernel. If
> the kernel IRQ balancer sees the device is on node 0, it would deliver
> its interrupts to CPUs on node 0.
> 
> In my tests I can see that the interrupts for NVME queues are sent only
> to CPUs from node 0 without this patch. With this patch CPUs from both
> nodes get the interrupts.

Could you send the output of:

  numactl --hardware

and then with and without your patch:

  for i in $(cat /proc/interrupts | grep nvme0 | sed "s/^ *//g" | cut -d":" -f 1); do \
    cat /proc/irq/$i/{smp,effective}_affinity_list; \
  done

?

