Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0777CC83F1A
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jul 2025 15:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+jDq79/Y9YlPpF00uHZYioAJyotedds0Q9UT4/8hxrQ=; b=EZMv6C2esjwSkcJMOp2L1BdEeQ
	01wzbRIgT+8yMTcCRRZSbkhSqFMNLbawj48lwWJzlyGX6qsHSaOW9E33yi+jfuiM8WPej0mQoJffo
	vRybKfW2B12hWzWoEgpuyUUyIU4u1TgRZr5PDdQfSsuhdulB3ONrchgvx3qRUJb+4MnP07ZNauZPa
	AG5iBO44PN8si0oekXynKuK926leXxvYgUEQX2IjdyPgEO244XpZ0BQW+XTpv2ldmAjUMLde1scOv
	lJBuSyh2AJCTjGJlNG4bEhlNC1xgNPpWb+uqkP/0YwUWrVN5vBZivESHFGmwsnlYV6fF4C1WtFKw8
	YOpkHuhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucQ7v-0000000ARgc-0ZhS;
	Thu, 17 Jul 2025 15:02:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucP6u-0000000AJ9p-2WjS
	for linux-nvme@lists.infradead.org;
	Thu, 17 Jul 2025 13:57:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 08D54227A88; Thu, 17 Jul 2025 15:57:07 +0200 (CEST)
Date: Thu, 17 Jul 2025 15:57:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCHv2] nvme-pci: try function level reset on init failure
Message-ID: <20250717135706.GA28810@lst.de>
References: <20250715191627.3690017-1-kbusch@meta.com> <aHkApYpN-O1HLKp3@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHkApYpN-O1HLKp3@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_065720_780308_38904F8B 
X-CRM114-Status: GOOD (  11.57  )
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

On Thu, Jul 17, 2025 at 07:54:45AM -0600, Keith Busch wrote:
> On Tue, Jul 15, 2025 at 12:16:27PM -0700, Keith Busch wrote:
> > +		dev_info(&dev->ctrl.device,
> > +			"controller reset completed after pcie flr\n");
> 
> Urg, sorry, this was the wrong diff: that '&' shouldn't be there, and
> build bot will probably flag this.
> 
> Christoph, could you squash this in?

In fact I already did, but forgot to push out the result or tell
anyone..


