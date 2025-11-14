Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E631CDE019
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 08:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eSG+F2z762AObFBFM8zyufAOcmgQ09VZlyrPM/jJgfA=; b=k/LVRPPNIwngWV+voW7N2gqlVV
	+4EmvkaLv5Lq1yMGxeHwuIWmQbgEJ5aUSRC90vur2d19PYD/L9zD/10ZBEEvX8K3LrQX/FOwMPoye
	1sH9fJtSgZq90DIXIVhZP0QMM6AoNW45ZyeDEFuCVqo8H2kQySoFa0fCorr/wOrh7Pkq84wyHqo6x
	J+bwb+lNwX/D5IEtYcKfM1lfTYnQUY96bxUDcRF/RM/WSS8XuVFgpGgX3iPM98uD2sxoQpEvGsC6C
	1Av4UztlD9sZXCfYUWH6W3kMsz2bvLULiolgtS+9NSBsz1ti/uekq7AhTip2NPLAB4FyGcAWFwmkZ
	AyYh2FNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJoys-0000000BnPI-1JBa;
	Fri, 14 Nov 2025 08:16:30 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJoyr-0000000BnP9-0kJy
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 08:16:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 52EEC60127;
	Fri, 14 Nov 2025 08:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3CBC116D0;
	Fri, 14 Nov 2025 08:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763108188;
	bh=/GKXEoBtcXx0a0NjG6jUraQg+k9dQvuk/Fg5FkEDWFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOf05MVjrdRhj/0Yd+x4tuVND9kaU0XV73O5OHkWW8Mq2O5bQXMgxARIBMgCEymc/
	 Em8yXhLFvhRQjNfr/pAILbNT/krqQDSRuHeFftF1VifoLo2S6o/uiVitEVa4qrbO9t
	 0YVd56YATKVnr1fzblG68tp8oehiZ4RVdD64YNI1QBnn6TlaW6mATf0gVgx3oenpKp
	 NhMTR0DkPLSugOhWQ9MvKsq3/dFDsjhZtQMok0qKieO8YKVfPL0ZYWkSNJVR2eIHUy
	 srbbkj28JGCqDctUigibzl6RX/fMjxwMN/FyRqtKwMB7VVie+ulvesrOfDNZaRKm1o
	 1WSlR0mF0TShQ==
Date: Fri, 14 Nov 2025 10:16:23 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P
 DMA
Message-ID: <20251114081623.GB147495@unreal>
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
 <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
 <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>
 <aRY28IRvBFmTW6cz@kbusch-mbp>
 <d1641814-5ef8-4ccd-8a41-42bf99a61d0d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1641814-5ef8-4ccd-8a41-42bf99a61d0d@kernel.dk>
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

On Thu, Nov 13, 2025 at 01:40:50PM -0700, Jens Axboe wrote:
> On 11/13/25 12:52 PM, Keith Busch wrote:
> > On Thu, Nov 13, 2025 at 10:45:53AM -0700, Jens Axboe wrote:
> >> I took a look, and what happens here is that iter.p2pdma.map is 0 as it
> >> never got set to anything. That is the same as PCI_P2PDMA_MAP_UNKNOWN,
> >> and hence we just end up in a BLK_STS_RESOURCE. First of all, returning
> >> BLK_STS_RESOURCE for that seems... highly suspicious. That should surely
> >> be a fatal error. And secondly, this just further backs up that there's
> >> ZERO testing done on this patchset at all. WTF?
> >>
> >> FWIW, the below makes it boot just fine, as expected, as a default zero
> >> filled iter then matches the UNKNOWN case.
> > 
> > I think this must mean you don't have CONFIG_PCI_P2PDMA enabled. The
> 
> Right, like most normal people :-)

It depends how you are declaring normal people :).
In my Fedora OS, installed on my laptop, CONFIG_PCI_P2PDMA is enabled by default.
https://src.fedoraproject.org/rpms/kernel/blob/rawhide/f/kernel-x86_64-fedora.config#_5567
and in RHEL too
https://src.fedoraproject.org/rpms/kernel/blob/rawhide/f/kernel-x86_64-rhel.config#_4964

Thanks

