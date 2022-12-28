Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D389C3DA7A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Dec 2022 16:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MlhlF4i2LKEZHjoKw0oUc+o8vq6do4kY8w0cGYdrGXs=; b=YQmDsFK/yp+Zj0NAmF6rxgsacr
	LHuydKNwk5ifs+sQCtxLdYu4rQtOS+onJRx0Ah1bPFFlLlANRjsJgkwQQG2tK51BqJajyvhAE3zH/
	3p4F/VOxtHpMcZXXzEI53/VjqMjUroxKMFfODQLQDoPy085GZVqUbaoeoQpArhiyFTyYZzuDitdly
	5tAJC5AoBtu8Dm6iTc4xObHrhG4ppHPvIIlhs2GWgNEeGsfKeRaLFEYByyPHFGuni4cT5S/yZwxGQ
	ejY9pMPiU1b3SbME69UiWXmLlKPlH7aDXCI/nft1sHMObQNcT0zLPlzkaViPPXtGLLZzUpCCKIg8X
	Iyv4cC2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAZ1c-006EnK-SZ; Wed, 28 Dec 2022 16:11:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAZ1Z-006El7-98
	for linux-nvme@lists.infradead.org; Wed, 28 Dec 2022 16:11:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0269F68C7B; Wed, 28 Dec 2022 17:11:21 +0100 (CET)
Date: Wed, 28 Dec 2022 17:11:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
	Hugh Dickins <hughd@google.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] nvme: fix setting the queue depth in
 nvme_alloc_io_tag_set
Message-ID: <20221228161121.GB849@lst.de>
References: <20221225103234.226794-1-hch@lst.de> <20221225103234.226794-2-hch@lst.de> <a7a593fa-9a48-6f6b-a428-2fe6db694d22@grimberg.me> <4f1f6a12-bf9d-4118-23e9-6d20a3d8a265@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f1f6a12-bf9d-4118-23e9-6d20a3d8a265@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221228_081125_493738_22134E7D 
X-CRM114-Status: GOOD (  11.19  )
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

On Sun, Dec 25, 2022 at 12:53:38PM +0200, Sagi Grimberg wrote:
> But this means that fabrics drivers automatically get 1 less queue entry? 
> with this patch alone?

Yes.  And also with the entire series.

