Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C192C25B74
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 04:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wu77ncceR9bhQDQ4jxP19K8KCneb9nkLT2fjoii8yh4=; b=C+aktGWN+Z6f1DyPE4lMp85h2l
	DbEwmFfWrkSVT4jiycO4Y96tmnC9VYy8u9Fqb5iFzNHI1V4iPlodd8EcR+9RZmcooVi1OpHV+8602
	VxRbo+ONcDIkkJ90iSjgeXp/LM07B67D3O0JrpKejIWuru33F28hly5BlZwD/VFLb64TYbccz4mxF
	RFIxKHIO0SmHiVwccVfV/V2Mf/5eLf6ybUxPIo0mnscnKaHH4kXlJGqhz56hA3IM9Qz52c4r9vYU8
	h/s3Iy/o/NsoY+mixg7T0H9f8JdXN7nHRVYHTDXsztlk8kaQL+CKVC0sOUUPoDb83stLuGVl3P/2f
	vd2WqBPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sELou-00000001BGV-1EZn;
	Tue, 04 Jun 2024 04:30:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sELos-00000001BFP-0Fbd
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 04:30:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 71B6A68D15; Tue,  4 Jun 2024 06:30:41 +0200 (CEST)
Date: Tue, 4 Jun 2024 06:30:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Ofir Gal <ofir.gal@volumez.com>,
	davem@davemloft.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	ceph-devel@vger.kernel.org, dhowells@redhat.com,
	edumazet@google.com, pabeni@redhat.com, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
	idryomov@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v2 0/4] bugfix: Introduce sendpages_ok() to check
 sendpage_ok() on contiguous pages
Message-ID: <20240604043041.GA28886@lst.de>
References: <20240530142417.146696-1-ofir.gal@volumez.com> <20240531073214.GA19108@lst.de> <20240601153610.30a92740@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601153610.30a92740@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_213046_276309_B4817A39 
X-CRM114-Status: GOOD (  17.52  )
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

On Sat, Jun 01, 2024 at 03:36:10PM -0700, Jakub Kicinski wrote:
> On Fri, 31 May 2024 09:32:14 +0200 Christoph Hellwig wrote:
> > I still find it hightly annoying that we can't have a helper that
> > simply does the right thing for callers, but I guess this is the
> > best thing we can get without a change of mind from the networking
> > maintainers..
> 
> Change mind about what? Did I miss a discussion?

Having a net helper to just send some memory in the most efficient
way and leave it up to the networking code to decide if it wants
to use sendpage or sendmsg internally as needed instead of burdening
the caller.

This happened before sendpage_ok was added, so probably in 2020
and most involved Dave and not you.

