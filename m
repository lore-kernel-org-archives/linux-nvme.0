Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89343F94CCB
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 06:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=thbZfXkz/A852PqySjvzvzKlTaWnHNtYFcgmrLGDHfQ=; b=ja7xE4XT8QYdNU2gF3yMVI9tbr
	xQv3WgVTOa5+h8d3L1eFet6fmvy+UCIZwT41loA42dgIpkPFvSGJEmyJ7VH2DKFHCln0djq/T2h1I
	43N16kusR0QMgkPEDP2o9XrjoUTK8mxNE85GtTakRMTJdKgMobzWYgI+nLyYCXpzXWQwtN2vzTcb6
	4i2vlAaJmEow6DJ78MbjJz8V4Q+YWcSmByyJvoc6DzbWTLhaDshk9oJVR0crC5qeCAHP3I2tXNaiK
	js2DUPLl1TlZhp8gXoZwwQ9QRcsyqXH9MhmFoHOxh7jOTefn5LuBkfCSxC1i+ba6bavN9aWBLdilA
	ztCGnYeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFQf7-00000009djZ-08hb;
	Wed, 22 Apr 2026 06:02:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFQf4-00000009dhe-1AuH
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 06:02:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3F01668D0A; Wed, 22 Apr 2026 08:01:58 +0200 (CEST)
Date: Wed, 22 Apr 2026 08:01:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-pci: fix missed admin queue sq doorbell write
Message-ID: <20260422060155.GA5391@lst.de>
References: <20260421161855.3980034-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421161855.3980034-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_230210_455285_DF1220C0 
X-CRM114-Status: GOOD (  10.91  )
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

On Tue, Apr 21, 2026 at 09:18:55AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> We can batch admin commands, which means bd->last may be false,

How do we end up batching them?  io_uring passthrough I guess?  Can
you expand the commit log a bit with that?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


