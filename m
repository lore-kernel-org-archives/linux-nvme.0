Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D16BC19F32
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 14:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jin3XS8cPeRVnkRtb1V8ssA/lMk6niMUUCmNMxLrPaY=; b=KP9WEE9lpDwzy/M0Rk64ecctCy
	YgY6B3rpe4kqoOMgajXXaQUox7DpmsQWyUc/dfqBYl9gYb3HdHyaElreVMPlomiUHg6exYhb/X2u1
	7gKc146Bva0kc6lHlDBFpdUqVsUlnck5kMapk5GZxnwj1xJTMLCZSmzwDev4GOrdaXaiK420QEc5b
	v0dr+HuTdpDsHge2QLE8WhJDkgw23J8zvSYOuHb+4t7FRGXjvs/4NMwUuUUw9WLFHCeRNJkBMLicX
	u64BgeMPvtWdFtTfQ1gF+qa8G2dRR3Igqi07uHbkmIY1pBeW/C8QhxL4U8fT3kUtMNYXFYgBtZtuO
	o+ebF/4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tppt5-00000008Nij-2cJE;
	Wed, 05 Mar 2025 14:38:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tppt3-00000008Ni9-2kIO
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 14:38:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 49E3568AFE; Wed,  5 Mar 2025 15:38:14 +0100 (CET)
Date: Wed, 5 Mar 2025 15:38:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: fix signedness bug in
 nvme_tcp_init_connection()
Message-ID: <20250305143814.GA18852@lst.de>
References: <0f3be9ff-81a1-4c33-8960-75de2c239ae0@stanley.mountain> <20250305142554.GA18330@lst.de> <739d3443-61c4-4b69-866b-142efde59062@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <739d3443-61c4-4b69-866b-142efde59062@stanley.mountain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_063817_838792_6D88C26C 
X-CRM114-Status: GOOD (  14.57  )
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

On Wed, Mar 05, 2025 at 05:37:15PM +0300, Dan Carpenter wrote:
> > 	if (ret >= 0 && ret < sizeof(*icresp))
> > 		ret = -ECONNRESET;
> > 	if (ret < 0) {
> > 		...
> 
> Sure, I can do that.
> 
> I don't love casts either.  I normally have tried to write these as
> "if (ret < 0 || ret < sizeof(*icresp)) {" and people don't love that.

I can see why people don't like it as it's really counterintuitive.
These kinds of interfaces just suck given the type promotion rules
unfortunately.


