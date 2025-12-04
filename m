Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2811DD1D892
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 09:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S6wiXlBUa9vx6zmqdr1nGFk31v/Tk2eLR8c964Zf7q8=; b=ftE6ONbHgVZwXjX07YAkFbeZH+
	WaZKCnC6DxgdhvVFnTYol8nLoKtJ3RM+YT1nv87lq3H6XwjeO24zSiLcQW6XB2NAh70zBm7YtHDG9
	P3hsjTZM13bD7541yPcXXT+w/DBACLjxoa5XpGjzQzNUNoAYK0ynqBlck+n0+YRsrxeRvWtTodNzQ
	t4T9LPUloRz5syIAYVO9vb68ihBwPiW1/w5wzJ6STo2IdSzYm4Tdbc7xps1GNQaXAfY+wnSebMoW0
	FOvNhKXtsDZ5J9nDl28IFyy+B4hX9JatMfG2EoWUdkzbFm/R+L127iihAQPXnV6/zCJ7L0WwTw+8L
	zRvzRuAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR5d1-00000007lZf-2xJy;
	Thu, 04 Dec 2025 09:27:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR5cz-00000007lYP-1iYq
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 09:27:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B9A8D227AAD; Thu,  4 Dec 2025 10:27:38 +0100 (CET)
Date: Thu, 4 Dec 2025 10:27:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Abdulla Nasirli <nasirabd@fit.cvut.cz>
Subject: Re: [PATCH] nvmet: lift blocksize restriction to 64k
Message-ID: <20251204092738.GA19941@lst.de>
References: <20251203113000.67212-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203113000.67212-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_012757_591273_21EABAAB 
X-CRM114-Status: GOOD (  10.34  )
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

On Wed, Dec 03, 2025 at 12:30:00PM +0100, Hannes Reinecke wrote:
> -			file_inode(ns->file)->i_blkbits, 12);
> +			file_inode(ns->file)->i_blkbits, 16);

Make that ilog(SZ_64K) instead of the magic number shift?

Otherwise looks good.


