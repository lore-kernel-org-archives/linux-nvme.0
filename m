Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1586CC83F38
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jul 2025 16:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8MIpelmmPqltML8oII/lsv9uprNetR33qdPOw6lyr0U=; b=ZLhjPrC5yMkRDB6uiszNPSQ60q
	q3BnfI2WTOMbXpZk65AocO1Ot4zAgerzNXxHRFdF6bR/OpOTkWTIUxLaTq/49fsjQF85T21T6qgRj
	9EdiTSdcpaf1Q+0cCwN7zs9l2IyP2UNMHvQpTORWrHvF0xj7i2r75sI2VjWQKIaQDp+K/C5Jh1fkX
	i8l76c9ojQEX2eiU5K9fhdnfWA2IxDuXJ7pKZc+GnaTpEo9vy/AeyTC8ExbAQkDihzvAW6ZIyeFoT
	Nsmm6H9mGfTYKQnoJ4RW7F3T0nat12wM3RX5rbazbUr4FbipW9OrHPRuEhXonwzIzb0ZiIir3ETl7
	apkRXzfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucRMY-0000000AckR-2Oaf;
	Thu, 17 Jul 2025 16:21:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucQpD-0000000AXQQ-0G66
	for linux-nvme@lists.infradead.org;
	Thu, 17 Jul 2025 15:47:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1E5E1227A87; Thu, 17 Jul 2025 17:47:00 +0200 (CEST)
Date: Thu, 17 Jul 2025 17:46:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCHv2] nvme-pci: try function level reset on init failure
Message-ID: <20250717154659.GA3352@lst.de>
References: <20250715191627.3690017-1-kbusch@meta.com> <aHkApYpN-O1HLKp3@kbusch-mbp> <20250717135706.GA28810@lst.de> <aHkacymDNCqllaRn@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHkacymDNCqllaRn@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_084711_241749_B192B129 
X-CRM114-Status: GOOD (  13.95  )
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

On Thu, Jul 17, 2025 at 09:44:51AM -0600, Keith Busch wrote:
> On Thu, Jul 17, 2025 at 03:57:06PM +0200, Christoph Hellwig wrote:
> > On Thu, Jul 17, 2025 at 07:54:45AM -0600, Keith Busch wrote:
> > > Christoph, could you squash this in?
> > 
> > In fact I already did, but forgot to push out the result or tell
> > anyone..
> 
> Thanks, but the new push appears to have incorporated some unrelated
> changes to fs/verity/verify.c

Fixes.  That's what you for not commiting thing immediately before
rushing to a meeting.

