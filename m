Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1979CD5BC0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 05:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OZFL1yjZu3wadMa48WbG5/8lOCBxvdCmCsF4SmlQQio=; b=qKMGvUdUPeklVbJAkfijOnbEjS
	2uFJ1WWFjcVJy9r2f3zr8RPCO5DIpKS3IduGwS0Wd9iNnGRy93+kARv/pV39+DvAKM3VMbT29n9my
	EybwYj0rIpzLsOdOHLQShqewsYeXex8XyXd8FAIZGlfjefSjkshsQUHNbgtExrLmhMZts+NwbBSaB
	qo7mxAJ3ao1OlE1APPEsq9EiglplN1aSE+ahXExUlCXosRCJpNROzNQdOp7BMD7iOsQVziIrOxy0C
	KHHuxZnBOf/qn2i30unnrkoAupxkl0Ya8iEBzdQHqAjwb2ptaoEWJU5ouRqdsiIZE6tt9cROZCXrg
	VVJ1M89g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROLs-0000000GN5k-1uKw;
	Mon, 25 May 2026 05:59:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROLq-0000000GN5K-0Xs3
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 05:59:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8A36368B05; Mon, 25 May 2026 07:59:42 +0200 (CEST)
Date: Mon, 25 May 2026 07:59:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Bommarito <michael.bommarito@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: log when APST skips a state due to latency cap
Message-ID: <20260525055942.GA3370@lst.de>
References: <20260523114552.101452-1-michael.bommarito@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523114552.101452-1-michael.bommarito@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260524_225946_312827_AD03B2B6 
X-CRM114-Status: GOOD (  10.88  )
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

On Sat, May 23, 2026 at 07:45:52AM -0400, Mike Bommarito wrote:
> Assisted-by: Claude:claude-opus-4-7

Either you take charge of this and drop these stupid annotations,
or you don't and we'll have to ignore it.


