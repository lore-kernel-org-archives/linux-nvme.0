Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D390C25B74
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 19:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=SnM7SU2QGFo10+6llKAhBvMrPh
	hHjc4PQkMiqVt/86wKslWQZK8ZJmRxZM803NxJDDEx70srj+NskA+x7gJfV+40/rNrFO3si2h0Sb8
	uuQQ+1eNtP0Sw3KOJX1eBKX+cQpR801WP1kJgqb3DpFMIHwoM2irWQd0LloiygJBCh4Og4JnUeaHq
	I06qyw6ORej/8rTHj+gFEww4Yrg0EgssblccKf1PCKAXPNMs9uYPXHWCQa0RmpP3MxsaIybHmKHOu
	EId7J7ApGlhotiTb9AfczL8vpZzRbEkMnocKVW/d/LrOXQytnQyLs8G7FgoVpSMlnomFkKSn/j6Ht
	94hl00nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9VIW-00000000vJE-20Q6;
	Tue, 21 May 2024 19:37:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9VIS-00000000vIU-323j
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 19:37:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2C52268C7B; Tue, 21 May 2024 21:37:05 +0200 (CEST)
Date: Tue, 21 May 2024 21:37:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: fix multipath batched completion accounting
Message-ID: <20240521193705.GB30407@lst.de>
References: <20240521170537.2029233-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521170537.2029233-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_123717_018076_124C3599 
X-CRM114-Status: UNSURE (   8.70  )
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


