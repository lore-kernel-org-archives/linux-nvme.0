Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB8AC61DD6
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 13:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=SCMRdVNzIp2Y3pMl5wclGsOIqn
	hhE266m2NcRaVB7dBu6tsQKMPT+Fs6URhFZM8foO3d9yya9Sa8msQc7OU2lllo0mf4fTIgi7dhuxP
	qLzpvILtuNn9Gsu62aMALoXdL27EGtGw9BENZF3pOuKCBgJRCp+csQswP910eqvoUTYXNXn87l/rb
	gK8JtYXuDSTjGtUJgHfAGoR2ahS0WNvZY8P4/pkpRy9OcoHjj1jSE5vmqOCujOqA1aKY9al+QvNnN
	mvegKb77CgGhz0rRZhPjVmGQXIn147OnGa9MFDNl2m5rtPC2PtrTHZg7YmsuUPFu+6LUd9B3IL4H3
	ciYURorg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1l6i-0000000Ep0u-2a3y;
	Wed, 02 Sep 2026 13:34:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1l6g-0000000Ep0Q-13Vd
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 13:34:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1EB466732A; Wed,  2 Sep 2026 15:34:21 +0200 (CEST)
Date: Wed, 2 Sep 2026 15:34:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kazuki Hanai <hnkz.64@gmail.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-auth: Synchronize timeout work during SQ teardown
Message-ID: <20260902133420.GC21167@lst.de>
References: <20260830131105.680566-1-hnkz.64@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830131105.680566-1-hnkz.64@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_063426_439874_61A677B0 
X-CRM114-Status: UNSURE (   9.74  )
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


