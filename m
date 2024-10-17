Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128B4D374A9
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 15:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T2wqw1ntS1odolWg2RThJSsZCNX1Mqx4emjm0CAzWE0=; b=cnKk6TZ3BGsLHop6888wY2kaTY
	bZpKrUL+0v21uqw2DnAASvJXTPxe7RcnTJxcEhMTtMtfl0XW3eJJppEhjVjDq/S6NGao9eg/lfRXn
	waVFe3gKYga2PMp2dGt0X/Zl2ayO3KiW72hUHidiM/tyrionOnOm9C4HSOKf2OdHEcKgJ2MD2oafy
	KSJyF8xsPe661RxLSt5PQXKgstD5C7O9sv2msuLEP0A9tCYzaYW7/hsBERn05Ji+T9ZtSQnaJml3L
	uHRBHS6ZC+L2U1B9VVt+iQ9H63brvfz3JowgcNlbGTYgpY/g7HDMnsXECI4YzUFzUjHwzfJoSGq2E
	s0DP/gSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1SsU-0000000FNVF-0jIM;
	Thu, 17 Oct 2024 15:57:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1SiF-0000000FLhJ-2qq2
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 15:46:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E6EEF227A8E; Thu, 17 Oct 2024 17:46:49 +0200 (CEST)
Date: Thu, 17 Oct 2024 17:46:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	axboe@kernel.dk, hare@suse.de, sagi@grimberg.me,
	martin.petersen@oracle.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, bvanassche@acm.org,
	asml.silence@gmail.com, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241017154649.GA27203@lst.de>
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com> <20240930181305.17286-1-joshi.k@samsung.com> <20241015055006.GA18759@lst.de> <8be869a7-c858-459a-a34b-063bc81ce358@samsung.com> <20241017152336.GA25327@lst.de> <ZxEw5-l6DtlXCQRO@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxEw5-l6DtlXCQRO@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_084655_890510_3FDC8E2A 
X-CRM114-Status: GOOD (  15.83  )
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

On Thu, Oct 17, 2024 at 09:44:39AM -0600, Keith Busch wrote:
> I'm replying just to make sure I understand what you're saying:
> 
> If we send per IO hints on a file, we could have interleaved hot and
> cold pages at various offsets of that file, so the filesystem needs an
> efficient way to allocate extents and track these so that it doesn't
> interleave these in LBA space. I think that makes sense.

That's a little simplified, but yes.

> We can add a fop_flags and block/fops.c can be the first one to turn it
> on since that LBA access is entirely user driven.

Yes, that's my main request on the per-I/O hint interface.

Now we just need to not dumb down the bio level interface to five
temeperature level and just expose the different write streams and we
can all have a happy Kumbaya.

