Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA75C67861
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 16:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C3Ovlq3leBo8j1v4ee7uKF/tI4VSTzGOIhXj3DV8TV4=; b=G24rMshcCWO+qvlheulKZyJkv1
	T4oFCYUy+fiwLKOmElbS/VUYrBOEDPMYcm5GOc3+6gU/hAB7GElFmQOAkdW7PWSzN4ig3/7huIMPP
	fCt6sJtFJi+VZNkNRSiUkveipP4S3Aq6f7SmGOGpI6e9E2bBMkZDuQ39HO2zD+3sledKEXrVdhefg
	WNedqaekzYyNw5nMRJ4K1cJjCnI3JnxXBPnPwsnja+cLY5VUQOP73vOehaT3zX6bMi1AXWc3vPUQI
	Gv0KH04f5IrTyyOr3ZjJlYyPqPMpc/2d7p2i85LYflcVNpVit2OKqJPc7H/o4h4hlISkw0tNka7nO
	Up7e7O4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsm3m-00000007uIk-31mX;
	Fri, 05 Apr 2024 16:04:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsl6b-00000007dUx-2dC1
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 15:03:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E82BA6168A;
	Fri,  5 Apr 2024 15:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C1AC433F1;
	Fri,  5 Apr 2024 15:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712329428;
	bh=dXTTiVWFgc1vtmcr0X1BIZOy1WwUucJv2okTlq23MuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbMjwxy8QRFDktIEUZUOQ+QBwqSocDOBqI7YNiks23QdI+cEvAIcQCb6L/G+/w/F2
	 JvXlx5E+1LAJ/Nh4M8GtaRK93PbJuFmYInW4y5yxcZK0Wma64FCMm9nxTGAPgzUYfz
	 3MIDoEayrlpbJSv47DAKXpOs4BAhjDj6n+5x+Pzj8tTDM8+8KaCr40mXIMxCw2gWh2
	 90lnLXj4qtP2HW4gSGoM1V2myH3snrGFCl8CvOTfrKhceNVptxNiakwDU0C3wBf4k+
	 IF9w5qbcy4LSZFeHbuI6rOUzSgE3Af26yQtpPlmzRYyCbqxdOCDi9LNjf8WreRD1Lv
	 Dgf8KLwi1owrQ==
Date: Fri, 5 Apr 2024 09:03:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCHv2 0/2] block,nvme: latency-based I/O scheduler
Message-ID: <ZhAS0YKfV07qlUes@kbusch-mbp.dhcp.thefacebook.com>
References: <20240403141756.88233-1-hare@kernel.org>
 <Zg8YNrSnZPjR4kan@kbusch-mbp.dhcp.thefacebook.com>
 <b255fca4-a9da-4364-a3af-eb699eeb4160@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b255fca4-a9da-4364-a3af-eb699eeb4160@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240405_080349_732540_A1E5D53E 
X-CRM114-Status: GOOD (  18.64  )
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

On Fri, Apr 05, 2024 at 08:21:14AM +0200, Hannes Reinecke wrote:
> On 4/4/24 23:14, Keith Busch wrote:
> > On Wed, Apr 03, 2024 at 04:17:54PM +0200, Hannes Reinecke wrote:
> > > Hi all,
> > > 
> > > there had been several attempts to implement a latency-based I/O
> > > scheduler for native nvme multipath, all of which had its issues.
> > > 
> > > So time to start afresh, this time using the QoS framework
> > > already present in the block layer.
> > > It consists of two parts:
> > > - a new 'blk-nlatency' QoS module, which is just a simple per-node
> > >    latency tracker
> > > - a 'latency' nvme I/O policy
> > Whatever happened with the io-depth based path selector? That should
> > naturally align with the lower latency path, and that metric is cheaper
> > to track.
> 
> Turns out that tracking queue depth (on the NVMe level) always requires
> an atomic, and with that a performance impact.
> The qos/blk-stat framework is already present, and as the numbers show
> actually leads to a performance improvement.
> 
> So I'm not quite sure what the argument 'cheaper to track' buys us here...

I was considering the blk_stat framework compared to those atomic
operations. I usually don't enable stats because all the extra
ktime_get_ns() and indirect calls are relatively costly. If you're
enabling stats anyway though, then yeah, I guess I don't really have a
point and your idea here seems pretty reasonable.

