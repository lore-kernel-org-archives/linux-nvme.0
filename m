Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8A0EE0215
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 08:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zVpFzYnPiRvKOCePHg4PPR19a0o9+bDk4MfRlNYN0pY=; b=galVWE6fk19+OXkTYzL/6qYSPi
	muwGTSKzampJMQw8DLydcxAqX/9/MPtOwwjRa2bu22rZIcYeXXDdDeWzNNWYN+WzisIzyI2Tb3bR+
	IU6ZFKiJVFncrYQ6D89TDc9TXlh93Bea5mHBSKdi7AOiQDocgrJyjg5Z5PWlyXNYhGC9osI8bI2TW
	rbxFsBDpIGG4XBkLPymzzreRnzy9t2tEQ+CINUHWCZnRj3eHxtOwPRpz75UW00NaRawLERbNfp3N4
	Ve7HNraaVP7wAT3wDjy5l50Ho5VcvhQ4glXZuzfd5mOwaiUa1vFWNguGeFAOwq5qoAcy9jK7QehCD
	c1KoZojA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soINK-00000008ZSR-06iM;
	Wed, 11 Sep 2024 08:06:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soING-00000008ZQC-04jg
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 08:06:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3EAAF227AB6; Wed, 11 Sep 2024 10:06:38 +0200 (CEST)
Date: Wed, 11 Sep 2024 10:06:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	axboe@kernel.dk, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, sagi@grimberg.me
Subject: Re: [PATCHv3 03/10] scsi: use request helper to get integrity
 segments
Message-ID: <20240911080638.GA7245@lst.de>
References: <20240904152605.4055570-1-kbusch@meta.com> <20240904152605.4055570-4-kbusch@meta.com> <20240910153217.GC23805@lst.de> <ZuDP-ncB0EXrS9Xg@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuDP-ncB0EXrS9Xg@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_010650_218816_69EACEB9 
X-CRM114-Status: GOOD (  14.96  )
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

On Tue, Sep 10, 2024 at 05:02:18PM -0600, Keith Busch wrote:
> Right, I actually have more follow up's doing that. We just need to
> change blk_rq_map_integrity_sg() first to take a request instead of a
> request_queue + bio. I thought I might be getting carried away with the
> "cleanups" though, so was saving that for later. I can definitely add
> that into the series now though.

Well, it seems like the metadata code really needs a lot more attention
:(

And it seems like we really need the io_uring passthrough support to
be able to fully exercise it.

