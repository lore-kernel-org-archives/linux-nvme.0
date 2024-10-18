Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF556D3C54C
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 05:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kf3swggKLhkpYe/mOmRDHjQHO34kSLYsFEugJkD5Mn8=; b=C810dwU7mtiuj8JuWMoNmiIxuv
	yxounxRJCJEcOJxC67/S+53g6duBx2GsgAxoirkb7tdUdRxQDWzEgVPf20M4ddoRYDnzaFGnWnNsT
	yMv/lHXr6uOPkPgsxKDy0OuRda53zt3rAbTsbpZwP3i2Njc0Wt7JgzOw+rnn5uH0qGwldJo78xRft
	BYFrSFoXZDv2St/SSbYKwVbLKqecLW0Z0j0KqbUoHcT5/p1MeqjGxJ2aM8O6k7atOOQu1rzP1E1qp
	CW5WXdBsW+QmjMhTCphIbQGBZELvgZzjUBeQMPPfGvhSdkGbmks8xpTZNdFOyl64ymhi41eCLtX+t
	vzWxO7cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1fyM-0000000H2jU-47u4;
	Fri, 18 Oct 2024 05:56:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1ftn-0000000H1Q5-1a8G
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 05:51:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C74E7227AAF; Fri, 18 Oct 2024 07:51:40 +0200 (CEST)
Date: Fri, 18 Oct 2024 07:51:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv8 3/6] block: introduce max_write_hints queue limit
Message-ID: <20241018055140.GC20262@lst.de>
References: <20241017160937.2283225-1-kbusch@meta.com> <20241017160937.2283225-4-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017160937.2283225-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_225143_577946_054FD930 
X-CRM114-Status: UNSURE (   9.82  )
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

On Thu, Oct 17, 2024 at 09:09:34AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Drivers with hardware that support write hints need a way to export how
> many are available so applications can generically query this.

Calling this write hints vs write streams is very confusing.

Otherwise this looks reasonable.


