Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EC6C71136
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 05:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zU8vDHalSpTAvWDFoa9ukkjqgkpYXaPr/252yqrrki0=; b=09WM0s4QI8DNtEGglSGZbkwukl
	5h91S6DV/Xo1Yz/bZpcZ7YXZjMIyNgpZgbHxyNF+Uc+fl+6L+A05CoRBIKNdPmDlCHSEfcWmygvax
	btUlmOHOye/9PddoNgavy4pA72n/656aH4c0FKJakcEJ4b2cGPazesiBvRGsTL+phISf5glpkj+eo
	FtPi48vFMFrw90qq9Z0O6e24PeJFs56rch3AQ4UhEWVFlf+gzfDZq4Je1g14x3EZj6y4LuXsyjqAG
	29LCxo3dXG6OwwXNm9mgk7gAcu2Y+q8NSlz7enRzmTp+JqRj40+8wQ6GpchT43zZ0JxaAvrJszCSK
	gD6fVe/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR2S0-00000003R3Z-07Wq;
	Mon, 16 Jun 2025 05:32:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR2Rx-00000003R2r-0W5L
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 05:32:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F364668BFE; Mon, 16 Jun 2025 07:31:58 +0200 (CEST)
Date: Mon, 16 Jun 2025 07:31:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH 2/2] nvme: fix atomic write boundary validation
Message-ID: <20250616053158.GE1148@lst.de>
References: <20250611055432.2401372-1-hch@lst.de> <20250611055432.2401372-3-hch@lst.de> <f88d67d4-8484-45ba-9705-95ced325c65a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f88d67d4-8484-45ba-9705-95ced325c65a@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250615_223205_299989_C8EBFAA4 
X-CRM114-Status: GOOD (  11.56  )
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

On Fri, Jun 13, 2025 at 09:03:07AM +0100, John Garry wrote:
> I suppose that many comments in 1/2 aren't relevant any more from this 
> change.

What do you mean with comments in 1/2?


