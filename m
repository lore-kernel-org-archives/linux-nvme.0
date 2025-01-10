Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2351E7719E
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 10:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=0vP7R3HOu7+kSoHb8mOGG1G97P
	UtUqvYRoTyk4f9tSF0YtGLLURanvxJYS9x7SDSafPOjrh/DF2dwS9fJwZHs7j8hW5X7XFMP+cD/aR
	JF29x/f2VOxrbbJ3nnE01/0KSt4mxUCQuVXAtS18Q1ztx1l+IS2NenQBuE1BofafpOOleEQMw+tzJ
	HOsBYmMLvdTlENYxOgX2rtZ+hJ4ZA5w/82aQ/1mTku984N74hwMT0zGCACY5yadgtLYQkdn4hIse+
	yF+maCk0HxZsZ86dGzxpZo94QF2ueg2sGnecNRFBdpPZLYf9IzWdVqogw1B3X2HPwDBviLDuLcgMu
	lSiyzl1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWBqE-0000000ErZN-1bCg;
	Fri, 10 Jan 2025 10:02:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWBqC-0000000ErYr-0WY1
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 10:02:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C4B5D68D07; Fri, 10 Jan 2025 11:02:04 +0100 (CET)
Date: Fri, 10 Jan 2025 11:02:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: francis.p@samsung.com
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, anshul@samsung.com,
	jg123.choi@samsung.com, prakash.bv@samsung.com,
	d.palani@samsung.com, sathya.m@samsung.com
Subject: Re: [PATCH] nvme-pci: use correct size to free the hmb buffer
Message-ID: <20250110100204.GA11754@lst.de>
References: <CGME20250110051900epcas5p12cd1640b8e8d7a64680c5130091ad6e6@epcas5p1.samsung.com> <20250109235137.8995-1-francis.p@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109235137.8995-1-francis.p@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_020208_304252_F5165515 
X-CRM114-Status: GOOD (  10.20  )
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


