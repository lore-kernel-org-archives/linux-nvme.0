Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF64C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Dec 2021 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dJggi7nUIDjY4e/Lpn17CnpjIK1Ikpe9G+4qBV+eSGw=; b=TobqCEusqOdjZYNk6vLnTual2B
	3pDtzFFvqb4gXxHKDh+W5nsMoeZR6lyNfH1S8j6BHvbL1KOCeBFwfmlY6mzVRucFTybZH+jk9RKpf
	y1BqOgWateHTsjcP1OuuUTl4b4eQk3eTfZzUrdTUYrlTlCMTYr/o2km6Sh0PduffzQtRqNuym77qD
	q3vvSbpGMMAK/Dvsd/tza/Fueb05KP4gqB/5EYEM4RbMh2B96J2VLzSNOYfezBDK9Pendf1/md2kc
	f6Q8sgpGJUNviY8pARAq2tVkS6cLcLpmcSa8AP2/FbO/XnxEKJPWu8ktmHWxtOZHyjANKHUIhiMUK
	Wngy9I2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n2cuy-003DNH-8j; Wed, 29 Dec 2021 17:39:16 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n2cuu-003DLp-Ez
 for linux-nvme@lists.infradead.org; Wed, 29 Dec 2021 17:39:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9614568B05; Wed, 29 Dec 2021 18:39:02 +0100 (CET)
Date: Wed, 29 Dec 2021 18:39:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCHv2 1/3] block: introduce rq_list_for_each_safe macro
Message-ID: <20211229173902.GA28058@lst.de>
References: <20211227164138.2488066-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227164138.2488066-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211229_093912_708002_95E60256 
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

On Mon, Dec 27, 2021 at 08:41:36AM -0800, Keith Busch wrote:
> While iterating a list, a particular request may need to be removed for
> special handling. Provide an iterator that can safely handle that.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(except for the fact that it, just like the other rq_list helpers
really should go into blk-mq.h, where all request related bits moved
early in this cycle)

