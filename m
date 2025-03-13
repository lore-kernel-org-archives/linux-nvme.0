Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E4CC282DE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 08:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=G9UrauDjGNEhsA+PMAHoNvcDAU
	ElG3v+c+pRj0S9kMZ+8x1XNfdhbKr2kEoEd/iC8CLSqKm84YVerzvUdGMVbnQLjmK57JScNVsS2aZ
	aAFxAlJwi2oBiGM773uam3F5PmzJMd2jCklv2nhvFe1A0IsUip8NS+6PRAUtZDI9kUo+D/N/nSZBg
	cbJMThS4J/qk4cJ1gKA/eSdIuPlJDNc8Xh0QOgGSE4iGHQKZ6+zj+2SQ8jRxI58JWWgjn0M8z3BcW
	xRtCIEPkgMFcGPGUBhb/ORHKdZMimVXenhjjZ/rwNIdhq17nVRKMBzVQcnn0eUPRr4UCDrBJdqtVb
	FY3ANgAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsdwX-0000000AYIJ-46PU;
	Thu, 13 Mar 2025 08:29:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsdwU-0000000AYGg-3Tx0
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 08:29:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3B6E468AA6; Thu, 13 Mar 2025 09:29:21 +0100 (CET)
Date: Thu, 13 Mar 2025 09:29:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2] nvmet: pci-epf: Keep completion queues mapped
Message-ID: <20250313082921.GA15313@lst.de>
References: <20250313082218.1444073-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313082218.1444073-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_012927_011957_604F0C34 
X-CRM114-Status: UNSURE (   8.69  )
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


