Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886D2C4829B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 07:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=23Hv2XK1oBCKxvnicS27FjvYMBitdDqzXYveyhpdGb0=; b=RYhgXsvT84woE4XY4x/QhimXSR
	bdQHZnEyKmf0r8U7+z+oLxa5VtmpSRPuBkkEpYBIdEYA/A/2UJZBOp8mxPCf0mdnODlaHhqvYg4yd
	qWPu1vqf3r8sW24j3snLEm5BjbC+Ul7JXkuj4n0C0OFVMlowJ+m7gbEbwl6RnwnnUDPyB1upUbSIc
	vlFj3mX6si+xxWPPaiGb9FYoTaoR6aUJb20loHE4ervaoDl7x6auvPfdPpAYi431ja+s/2KW9hXWB
	mz8gCbMFIpZEgGTDDi3ljlzBCx71Xjfbh0b6x7No1Y/CzleRG7TDX0C3f+Lp+s0YkTnIw+0A3I8wA
	zahZhidA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQjr-00000004ViF-0kMD;
	Mon, 12 Feb 2024 07:28:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQjo-00000004Vhp-2fzv
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 07:28:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E4522227A87; Mon, 12 Feb 2024 08:28:20 +0100 (CET)
Date: Mon, 12 Feb 2024 08:28:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 03/15] block: decouple blk_set_stacking_limits from
 blk_set_default_limits
Message-ID: <20240212072820.GA19597@lst.de>
References: <20240212064609.1327143-1-hch@lst.de> <20240212064609.1327143-4-hch@lst.de> <74b1ddcc-4249-4b5f-89ef-6ebca70100a2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74b1ddcc-4249-4b5f-89ef-6ebca70100a2@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240211_232824_837556_8D7CA65B 
X-CRM114-Status: GOOD (  12.86  )
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

On Mon, Feb 12, 2024 at 04:14:48PM +0900, Damien Le Moal wrote:
> > -	blk_set_default_limits(lim);
> > +	memset(lim, 0, sizeof(*lim));
> > +	lim->logical_block_size = lim->physical_block_size = lim->io_min = 512;
> > +	lim->discard_granularity = 512;
> 
> Super minor nit: SECTOR_SIZE would be nice here.

Just a code movement / copy, but otherwise yes.  This code should go
away when updating the stacking to the new API, so I'm not going to
bother.


