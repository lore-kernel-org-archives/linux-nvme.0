Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F34ACF6D38
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2024 15:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zXeMRP7UZZzxLHJXcssrIaIRMG5gMfJlzxxsS+oRLcM=; b=aPJsXCBxPd6LUfhYuSlQ0OOlaI
	MUkvdMaLoL+1CeigDYYkhYLxI0S2ZfdFh+shQAv5YYy1TL/Ttse+OPNhd/Kix585cf3R6JDS0WyGL
	VCOcq/tzWioQTRipGh+Eur8qcFbTBUVY75SCjInJCADDQDMC5mICOW8kUCE2WdvWtc0cKwgjSmVdY
	J6vhRYL1PbKxPHxTg7qyVEeYjYemR2UkTmaM/TEP2PGP1crvMxPqHolZE+GZWsWp/A6qxfjCUftiR
	Bewux/FSsds6Cgu3S1VH0jUdpvYfOX34M1OVLwxw5XGkHlHHvDvLhlPvuXbf26xq3Hsqur65rTC7f
	zL2fBt+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sw1Lv-00000006gLQ-1zaf;
	Wed, 02 Oct 2024 15:33:23 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sw1Ls-00000006gJe-2527
	for linux-nvme@lists.infradead.org;
	Wed, 02 Oct 2024 15:33:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C66905C4C32;
	Wed,  2 Oct 2024 15:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADABC4CEC2;
	Wed,  2 Oct 2024 15:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727883199;
	bh=Qu1woXcrjhp6mj151jH+MKv52DBKg49ddjc4vbsUAmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qLgEh+s5Rk39ZYsz061N3zRQj1PrUxxnAh2ujTPzy7wuBwiCFzMzImY8PeFfsOyX+
	 dY3R2xMGK0UDX+Tkm+dcy1WzCapWGbN3e/kiItmXxtt5OBK1SbhLOn08jiz/3Fvlvu
	 2lRoONetfV0k+URzRpp3MC0UTnJELwk5dswLvGxU1dJJVun3tyUAm88GUdKcmbWnx9
	 rDIoyfemGaeJ8kWI5QVcWgE/Z+ZPQJfWEvX57eTHQtrwd86c+L9AzsOjFSOKpEj+CQ
	 xC39H3wqhlT+GygAKBAYtO9N+hiy58Iezn5CbVOviY0FvYGm3JOiAMOkBfDRczf7jN
	 hraPj+0SHpJzQ==
Date: Wed, 2 Oct 2024 09:33:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
	hare@suse.de, sagi@grimberg.me, martin.petersen@oracle.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
	bvanassche@acm.org, asml.silence@gmail.com,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-aio@kvack.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <Zv1nvIcENHnBcd2G@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
 <20240930181305.17286-1-joshi.k@samsung.com>
 <20241001092047.GA23730@lst.de>
 <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk>
 <20241002075140.GB20819@lst.de>
 <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk>
 <20241002151344.GA20364@lst.de>
 <Zv1kD8iLeu0xd7eP@kbusch-mbp.dhcp.thefacebook.com>
 <20241002151949.GA20877@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002151949.GA20877@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_083320_597999_3550C5B0 
X-CRM114-Status: GOOD (  15.57  )
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

On Wed, Oct 02, 2024 at 05:19:49PM +0200, Christoph Hellwig wrote:
> > Nothing prevents future improvements in that direction. It just seems
> > out of scope for what Kanchan is trying to enable for his customer use
> > cases. This patch looks harmless.
> 
> It's not really.  Once we wire it up like this we mess up the ability
> to use the feature in other ways.  Additionally the per-I/O hints are
> simply broken if you want a file system in the way as last time,
> and if I don't misremember you acknowledged in person last week.

You remember right. I also explained the use cases for per-io hints are
to replace current passthrough users with generic read/write paths that
have all the memory guard rails, read/write stats, and other features
that you don't get with passthrough. This just lets you accomplish the
same placement hints with the nvme raw block device that you get with
the nvme char device.

