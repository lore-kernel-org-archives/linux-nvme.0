Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6016FE77188
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jan 2025 06:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=0pj9R5YRSj7cjqU4NJl6N0BSJZ
	sCyN9mgXADQqSnlMVKcdB1S+P2Bc12oj0xmxw06KOyroP1YBa9JOP3ED8D15V/DdIS7sa+yEs2U6G
	zDCeeD36JWcbFYW8pEWcZAvEcQTyCvboCOEArSjJUTdUdUBCWd3MRMs8WVGQsoYETeq/IZBHCtok4
	LtW/N1zkVGIxWS48nvw5qNTM9FH60whLYN7yQNSh0HZPC/dOaQSnVTy7+w4X63/v9IERFNlDen5OD
	FXmdYELQR0fdDEDZOw7DzwYkS37s/ndSp2GsxHFLN7uKao+Mm3WY3mM22N+Pbtrl6qKpM8XCdtFZo
	VxkkgVdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTbXl-0000000CGFY-2aFW;
	Fri, 03 Jan 2025 06:52:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTbXi-0000000CGF4-420T
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jan 2025 06:52:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E9A5768BEB; Fri,  3 Jan 2025 07:52:15 +0100 (CET)
Date: Fri, 3 Jan 2025 07:52:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Add error check for xa_store in
 nvme_get_effects_log
Message-ID: <20250103065215.GA28171@lst.de>
References: <20241216155229.GC23786@lst.de> <20241220120046.13559-1-keisuke.nishimura@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220120046.13559-1-keisuke.nishimura@inria.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250102_225223_136866_9F0E6B88 
X-CRM114-Status: GOOD (  11.35  )
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


