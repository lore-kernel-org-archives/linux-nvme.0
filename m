Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932AACD4F3C
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 04:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=cwy8OzonRCaqYjEhU1q6gWvqjf
	8gPuc8FnILUgw6NuJmlcoo6zTYdCyD3wgEOVTLWRZma82Lhxtc8UJJwXQRKTJ4jLCN7bsFVqjGP2R
	AuqZDzAWzQrq5CTmGOx2+ErRxrkyJsH7QDxtiDW9SVZZKcYCaLGKQcCToPUrKQ7QB5YXEGmxEmnFQ
	SUmZEWlCPmZmEAu1aO7sxT+lTol2ozZJYK2A2+djuZYrbaz9bTGPnlUtT+38scv4j74b+ftOjryoT
	e4H0TcJ+T77JYAiNxAXrTF6ZfQzLyHMRpnP1RYUESVIM6GQOjrpBH3CoD/W4kfSNwSox80jbhmqSh
	6MVv5/Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkLY-00000007KRL-4Bmq;
	Fri, 15 May 2026 04:40:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkLV-00000007KQg-3h13
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 04:40:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E6EB768BEB; Fri, 15 May 2026 06:40:18 +0200 (CEST)
Date: Fri, 15 May 2026 06:40:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, Damien Le'Moal <dlemoal@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH] nvme/tcp: release socket on sock_alloc_file() failure
Message-ID: <20260515044018.GA3975@lst.de>
References: <20260512102831.3593121-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512102831.3593121-2-wilfred.opensource@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_214022_054890_7B28EF44 
X-CRM114-Status: UNSURE (   9.46  )
X-CRM114-Notice: Please train this message.
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


