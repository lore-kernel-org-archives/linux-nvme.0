Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A97C369DC
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Apr 2025 13:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mM3rq4Kn9Xsl23kjwKh7u3CTXjrbYnW3HO8imw9HZLE=; b=chrvR+QVmSwwmdRMT0paorxQJA
	+fyKTjhVvlJK/VirJyNT9V5JOWuLz/y9d1NDIhZC9ib6cdkP8ykgSogZrBUdfyL507mRd9imecoXh
	feBOkNCcA2JO7DEAKcs3emXP2zuiZWTfFz82ECqvNGHBv/EW9RswGKsuV7LOQruAsuETAjsTjA3ZP
	07ahGTxGro5ldXaDlZoFdIqW+rdAGL2qttYkYbpzSQ9ZoJ1CceLXZHPWDZ4uT6ggK2tdSFdIsbI13
	xA+K/PUsTLO3dJb2wGsPulIML4daHbQ+G4fH5WLYLjwjzgIMfjRlaxprNYc0Cyi8RiXMsSDBNdGLI
	VyWc93aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA7EU-0000000CwwF-1DGg;
	Wed, 30 Apr 2025 13:12:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA7EQ-0000000Cwuy-4BWz
	for linux-nvme@lists.infradead.org;
	Wed, 30 Apr 2025 13:12:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8C43A67373; Wed, 30 Apr 2025 15:12:07 +0200 (CEST)
Date: Wed, 30 Apr 2025 15:12:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Liang <mliang@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] nvme-tcp: fix possible data corruption caused
 by premature queue removal and I/O failover
Message-ID: <20250430131207.GB2191@lst.de>
References: <20250429163944.tvyrxt7z6c55abk2@purestorage.com> <20250429164201.cmrhsz5p45q4ceca@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429164201.cmrhsz5p45q4ceca@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_061211_173677_BC9ABA07 
X-CRM114-Status: GOOD (  10.78  )
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

Thanks,

applied to nvme-6.15 with a bit of commit log tweaking to avoid the
overly long lines.


