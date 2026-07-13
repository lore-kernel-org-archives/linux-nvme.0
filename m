Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E42EC43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 06:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mOhOVikLXEEnXiF8yTKtwikKKuP0lNciPx2H8jKCCzY=; b=IPfcykfxXPK2n7L+1qQYXvlO5U
	AwlZ57d/0RPUxoVuNY7LhQxzfEf5nQ5wMqDZnl9QXx4ZAJZLDQXWhn5lYkNRuXHEMHDVHcViRW0gK
	/jFjh5pu2pAv4BO9AaSioGQhWO6bK/lUXmFyHVlRgdRiK1i5v96W/O/RlR72AVHuDVtn3zFtbgRP/
	rpoXqfrERnK5WALM6698X18EmYzttgPpJZc+qyjAv4PqZ5YD8kYWx7lQcvLydz+fpwxcxl97KhrQU
	+2gJaQ4X/uKZuFhjFuM0g2hd1t9b/lExOHnbu2muwts2BYsRqHsAEU/nKWhiT6D/DlB4us3Ng1Gax
	uBNBRbuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjAN5-00000008ICB-0kaZ;
	Mon, 13 Jul 2026 06:42:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjAN2-00000008IBf-1qAj
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 06:42:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3409468BFE; Mon, 13 Jul 2026 08:42:24 +0200 (CEST)
Date: Mon, 13 Jul 2026 08:42:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/2] nvme: bound ns descriptor header and body to
 identify buffer
Message-ID: <20260713064223.GC29416@lst.de>
References: <2026070931-stopping-cost-239a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026070931-stopping-cost-239a@gregkh>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260712_234228_628194_455CBD3E 
X-CRM114-Status: GOOD (  14.35  )
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

On Thu, Jul 09, 2026 at 02:30:32PM +0200, Greg Kroah-Hartman wrote:
> From: Hari Mishal <harimishal1@gmail.com>
> 
> nvme_identify_ns_descs() allocates a buffer and gives it to the
> controller, which populates it and then iterates the buffer with
> variable byte increments that vary by type and body size.  But, there is
> no bounds check inside the iteration itself except the loop bound
> itself.  Fix this by checking and stopping iteration if the next header
> or its declared body would go past the buffer itself.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


