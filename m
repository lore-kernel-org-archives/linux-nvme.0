Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9684DC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 12 May 2022 08:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jeTIHt3wgzCIsOFoN76KPV7b2vGbO12U/TrCtgb+ew4=; b=fLjfaf7LnekYwMKWRY4XI0WGQp
	/XClLIs6ahAYQ8MxpE7wtHbl6hwGx3PJ81Bh4JVHgCrtOO9sl3rxOMwde2Be83M8xjVrcNNbvg37E
	HzoSLz4e4dW4bNeIya3GB9MUyGAvFlS2NnC4ZI8WFUaPILYQ6hhHMyKaKk0Bu8BECV5Z9sdTjAuwo
	i2fttdJmVQGcp/ukVKuCu6BsygWFNwB/CIQsCC1wODQmRjxXHRXuNP8e8j4nu3GH28uOgNsnO770g
	3I9LYVpS65XcHhIqxL/o31ii6Aequbwe5OK8vJPLALljbJe+CMAqkzD32kALbE/DHOAl2dBYFhtKG
	D+KFCDiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1np3tE-00AsV6-PL; Thu, 12 May 2022 08:09:40 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1np3sy-00AsSN-NK
 for linux-nvme@lists.infradead.org; Thu, 12 May 2022 08:09:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CC0A668BEB; Thu, 12 May 2022 10:09:12 +0200 (CEST)
Date: Thu, 12 May 2022 10:09:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 asml.silence@gmail.com, mcgrof@kernel.org, shr@fb.com,
 joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v5 2/6] block: wire-up support for passthrough plugging
Message-ID: <20220512080912.GA26882@lst.de>
References: <20220511054750.20432-1-joshi.k@samsung.com>
 <CGME20220511055310epcas5p46650f5b6fe963279f686b8f50a98a286@epcas5p4.samsung.com>
 <20220511054750.20432-3-joshi.k@samsung.com> <YnyaRB+u1x6nIVp1@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnyaRB+u1x6nIVp1@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220512_010924_936804_1A7B8715 
X-CRM114-Status: GOOD (  12.31  )
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

On Thu, May 12, 2022 at 01:25:24PM +0800, Ming Lei wrote:
> This way may cause nested plugging, and breaks xfstests generic/131.
> Also may cause io hang since request can't be polled before flushing
> plug in blk_execute_rq().

Looking at this again, yes blk_mq_request_bypass_insert is probably the
wrong place.

> I'd suggest to apply the plug in blk_execute_rq_nowait(), such as:

Do we really need the use_plug parameter and the extra helper?  If
someone holds a plug over passthrough command submission I think
we can assume they actually do want to use it.  Otherwise this does
indeed look like the better plan.

