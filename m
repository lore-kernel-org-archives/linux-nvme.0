Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62792CCFA1A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Nov 2025 07:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=11KRJ4oJxwIlBWAUpVSkTom0CFoXkC8tXdpoN+rIfmg=; b=OhIFOsN2yT8MoZdZJW0bscTG/o
	TNdf/3xdd3DrrD2HnkMDgc2bvcBeKpZng7oeeUK3n4TMYHW3AfKnJ/8Nshbx2Rm54j6Zu+dUVQd96
	a212iZmaP47PQzz8Mz3SFWc212eXowwBYQxVRjMDCh8oXlx2z8neUz7i4kxKtwDcpNrdjWBd3B93V
	H7XA+3jWUgufdiupkcwF5fn/ssO4b6GK8myN3H7tk7aPpPZuWrUW+y8AEwdq+xxc0gug/EhVWwgGu
	Mtx5wiMocMJMFa60ENtQZmoKelSMzYAFv2XOcRyqxiktPPnTUBRQDT67dvv6763tZ1XxaUqskOt4/
	gCnHfCrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIiab-00000006fS0-0xUD;
	Tue, 11 Nov 2025 07:14:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIiaX-00000006fRP-2iAO
	for linux-nvme@lists.infradead.org;
	Tue, 11 Nov 2025 07:14:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CF1FA227AA8; Tue, 11 Nov 2025 08:14:39 +0100 (CET)
Date: Tue, 11 Nov 2025 08:14:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@meta.com>,
	hch@lst.de, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Message-ID: <20251111071439.GA4240@lst.de>
References: <20251014150456.2219261-1-kbusch@meta.com> <20251014150456.2219261-2-kbusch@meta.com> <aRK67ahJn15u5OGC@casper.infradead.org> <aRLAqyRBY6k4pT2M@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRLAqyRBY6k4pT2M@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251110_231449_830628_47DF8271 
X-CRM114-Status: GOOD (  13.57  )
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

On Mon, Nov 10, 2025 at 11:50:51PM -0500, Keith Busch wrote:
> Thanks for the heads up. This is in the path I'd been modifying lately,
> so sounds plausible that I introduced the bug. The information here
> should be enough for me to make progress: it looks like req->bio is NULL
> in your trace, which I did not expect would happen. But it's late here
> too, so look with fresh eyes in the morning.

req->bio should only be NULL for flush requests or passthrough requests
that do not transfer data.  None of them should end up in this path.

