Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CB4E7717F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 15:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bUUaL9FsAkwgMF8kBBg7mPyxtRIG1wJ2y3f4qCA24jA=; b=eKoqo31cWzvRJzwC/WkXNzDqo/
	78o4fMPrYWldNtN87jh4vizilKT8FCWQJKjuIqvDWVARIJ0Re3HmJdbcq6a6hh++idI8CFY3nv1H1
	qd+2U6ygR5M1qcI41mUw1N5AAkRo3Rm0DYqeE1gxTr5MMqtvBhaYNIVOBtNHR1xNwwHvwSIVTP8Ip
	663KKhIBy1vzUC9e1dLbWin/gQVquSxmFSV0NOoxB2aDvgRyV6aPVPtTany3L9Rkz4oPDDeu3dxi5
	DwMAnhqhVdcxHzr+lQvj+8r2hNgbV0zX2Gv0LF/PuSxQIZlKMpsjJWbGo7fcGzbhwPEyOYcvwyrAG
	wH6rv0HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNDOf-0000000ATie-22b4;
	Mon, 16 Dec 2024 15:52:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNDOd-0000000ATiD-0aGp
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 15:52:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 00BE168C4E; Mon, 16 Dec 2024 16:52:29 +0100 (CET)
Date: Mon, 16 Dec 2024 16:52:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Allocate memory for xa_store in advance in
 nvme_get_effects_log
Message-ID: <20241216155229.GC23786@lst.de>
References: <20241202124239.49894-1-keisuke.nishimura@inria.fr> <20241212062749.GA5718@lst.de> <d0b96f78-7538-4bf9-acec-711e3b0b912d@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0b96f78-7538-4bf9-acec-711e3b0b912d@inria.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_075235_323307_179A6D43 
X-CRM114-Status: GOOD (  15.84  )
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

On Mon, Dec 16, 2024 at 02:06:50PM +0100, Keisuke Nishimura wrote:
> Without this xa_reserve(), if xa_store() fails, we cannot store cel after 
> calling nvme_get_log() which can have side effects. My intention is to 
> ensure xa_store() succeeds first and, if not, return early before invoking 
> nvme_get_log().

While reading various log pages can have side effects there shouldn't be
any for the Command Supported and Effects log page.

> But I am not very familiar with this code. If it is okay to check after the 
> nvme_get_log(), I will send the patch soon.

I think it should be fine, but I'm happy to wait for more opinions.


