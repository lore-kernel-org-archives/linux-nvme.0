Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26847C83F26
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 17:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YadE89EPsLEJPg9HczGhPLlgaORWN58al9CsrpPsjEk=; b=sQv4S6SBE/NKPvyXqHsTpzi/P0
	esQMDc5GZTacD15cj3bOlK/W1x57Amk2V097tP66e5DSBcthbR89syuFxAJUsUGXx5LxgPoLV5EMB
	IwGTBWXS7Zg2i5wpudwIud4h5XFsum6JOb9aUY+8Iwy6Six8G9frYXLDKy8lq24+Q89upFlCQTbtY
	RPhrKupdfJ0p0chw2LffpsBwTs/X9Wo/9V5w33WnKbk7+hr1CsPsXmrhXorHtw2dZRDxKgwdTUoUi
	a4N9kvMJSg2gaJiMnj9eBfEGaxYB0NZ41FLpC/kVapWmsans+b6m8IzyiAb6JTLThQPQZkj8IeF2c
	JQYlVSfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhAXS-000000026h8-2Wyc;
	Wed, 30 Jul 2025 17:24:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhAXP-000000026gM-25yR
	for linux-nvme@lists.infradead.org;
	Wed, 30 Jul 2025 17:24:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D0A3668BFE; Wed, 30 Jul 2025 19:24:11 +0200 (CEST)
Date: Wed, 30 Jul 2025 19:24:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] nvme: Fix typos
Message-ID: <20250730172411.GB23500@lst.de>
References: <20250730162321.GA22255@lst.de> <20250730171003.GA3369524@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730171003.GA3369524@bhelgaas>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250730_102423_854265_41F4968A 
X-CRM114-Status: GOOD (  17.82  )
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

On Wed, Jul 30, 2025 at 12:10:03PM -0500, Bjorn Helgaas wrote:
> On Wed, Jul 30, 2025 at 06:23:21PM +0200, Christoph Hellwig wrote:
> > On Wed, Jul 23, 2025 at 03:27:51PM -0500, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > Fix typos in comments.
> > 
> > This created multiple rejects.  Can you resend against the current
> > tree?  If you don't want to deal with the nvme tree, maybe resend
> > just before/after rc1?
> 
> Sure, will do.  I'll rebase on nvme/nvme-6.17 (e97c0040215f
> ("nvme-auth: remove unneeded semicolon")) now, and if that's not the
> right branch, let me know and I'll redo it around -rc1.

That is the correct branch.


