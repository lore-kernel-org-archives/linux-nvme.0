Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D607C5B552
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jun 2025 07:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BH/BFS4DBD/MyEOZSB2vsiZjeO/geaFzg1v7t3pZn2g=; b=Wij5mCHPNuruhSsjz1q+6UFbEC
	PLQUfjfjtbvmofjc/p8ghxhrvV8XW9m6+WEYIkZ4P2XiTWl6UmWlHhIVwPEOTnn/+P3u316HcuxKM
	EOZAla0anex7HgxxGpBGCTW7+NXO4KdcfqCFryIgsG2DzMo6+4plDBr4TspY/HLVZKBzeidIuHtiM
	1H1QHAxRllpHlzLy+0Kq3joKM3qdMc3az3P/4mAs4lzZ7kahC/ViPuh9CEfIcy5Gjob3VLtiTS84J
	aijuWHo2cqXaB2KZ5ID3eYwJnm+kvhKqk5oiIg1WoI0IWirrHQqdIWx/9sBbeZw+kObHNSZ5HL3oT
	TnLhsLvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMiz5-0000000CoKl-2OEH;
	Wed, 04 Jun 2025 07:56:27 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMivl-0000000Co6s-0APh;
	Wed, 04 Jun 2025 07:53:01 +0000
Date: Wed, 4 Jun 2025 00:53:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] nvme-tcp: remove tag set when second admin queue
 config fails
Message-ID: <aD_7XStbEMT1jUxV@infradead.org>
References: <20250602043522.55787-1-shinichiro.kawasaki@wdc.com>
 <20250602043522.55787-3-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602043522.55787-3-shinichiro.kawasaki@wdc.com>
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

Thanks, applied to nvme-6.16.


