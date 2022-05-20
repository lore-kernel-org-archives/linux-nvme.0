Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073F7C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 06:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0TWXRe/eA56q68/TSHMSCqycFBmadaZ5SOVpEI3inAI=; b=zWhy8catpUA/D62762gvkXihcq
	8EO6iefGGaxHLUseb3qARZfg44owl7olucKe/6UpVgXmxTWdF/+F3WrWGIWCgW3Lcpwlgwe40ASmb
	c+Loi/a4WtQB6aBM5FTeAK5fLTde6BcCYA9vrjOlvzz4L8B3mQuo7Ccluuvox+lANwrCf2m3AuXcF
	FA/QbD1+cJy4sjSrLyrqNtL5IoX5jXI2iNjomO0s2xU9tWY80NSrkZdj00Bz0rNqU9v+KW1i54BXK
	1Gvl7UhzFqzEUv8InxNtd1DKLCg/qtYMddSvPQP9jFOSGzr0zpoq0TQauTBf8YJ83hrnF2oagrhJa
	UlZ3EjJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrvi4-00Ah8R-Hc; Fri, 20 May 2022 06:02:00 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrvhw-00Ah5D-FH
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 06:01:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0C149227A87; Fri, 20 May 2022 08:01:44 +0200 (CEST)
Date: Fri, 20 May 2022 08:01:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, gost.dev@samsung.com, joshiiitr@gmail.com
Subject: Re: [PATCH v2 0/2] uring-passthrough for admin commands
Message-ID: <20220520060143.GA16433@lst.de>
References: <CGME20220520050118epcas5p1f6a930419285ecdac65afaa22255c03f@epcas5p1.samsung.com>
 <20220520045600.3773-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520045600.3773-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_230152_696995_9CD06EDD 
X-CRM114-Status: GOOD (  12.58  )
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

On Fri, May 20, 2022 at 10:25:58AM +0530, Kanchan Joshi wrote:
> The series enables uring-passthrough for admin-commands.
> 
> Patch 1 is prep.
> Patch 2 adds new opcode for admin uring-passthrough, and enables it on
> nvme controller dev(/dev/nvmeX). It reuses the code of io-command
> passthrough, with the only difference that commands are issued on admin
> queue.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Can we add vectored admin commands as well, please?  We basically
get them for free, so I see no reason not to add them.

