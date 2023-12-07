Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671C1C4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 17:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PBMLBGVjr8Ik2kGNkyAQgXvspfYezAGcqDF6AXpcxzI=; b=gW3ACNgmnR9urPjzs6sTdVN5cO
	6Vpxc9IgmgFrwz2MPV9uV1WP2Z1QbsmPpqQoYHeiP0MeqQ1jtX+aVmwSdbAKKfx0fJXXPsiVhiuAa
	QfSd7HoBgzpkfTA7oh55DOUrcYGciQhvY+I3iUqYUYm5jwce14Gbel+ENa8UQe6CAjzpB8Gmxa11F
	eCWdhFGUJD7f4dIAUUEigU8rxSsXswAg05CyYCX+qiHYooKEnvLv6nxWjGXcAKlAcS2OgYr0ub65/
	cIzibYKHpoKnYoj1oaComoex4OX2ITmnGAP/L3kPH1Yy2pRcsDT0UeC9/rMvNMd/I7apt2QhFUufs
	ngy3ubdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBIUg-00DZbU-0R;
	Thu, 07 Dec 2023 17:49:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBIUd-00DZaM-2A
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 17:49:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1A0D5227A87; Thu,  7 Dec 2023 18:48:54 +0100 (CET)
Date: Thu, 7 Dec 2023 18:48:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Jeff Moyer <jmoyer@redhat.com>,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, asml.silence@gmail.com,
	linux-security-module@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 1/2] iouring: one capable call per iouring instance
Message-ID: <20231207174853.GA31395@lst.de>
References: <20231204175342.3418422-1-kbusch@meta.com> <x49zfypstdx.fsf@segfault.usersys.redhat.com> <ZW4hM0H6pjbCpIg9@kbusch-mbp> <ZW6jjiq9wXHm5d10@fedora> <ZW6nmR2ytIBApXE0@kbusch-mbp> <ZW60WPf/hmAUoxPv@fedora> <ZW9FhsBXdPlN6qrU@kbusch-mbp> <ZW/loVJu0+11+boh@fedora> <ZXCT6mpt2Tq0k-Nw@kbusch-mbp> <ZXEeei6eoDW87xcN@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXEeei6eoDW87xcN@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_094859_849440_421FE21C 
X-CRM114-Status: GOOD (  11.27  )
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

On Thu, Dec 07, 2023 at 09:23:06AM +0800, Ming Lei wrote:
> Got it, thanks for the explanation, and looks one big defect of
> NVMe protocol or the device implementation.

It is.  And NVMe has plenty more problems like that and people keep
adding this kind of crap even today :(

