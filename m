Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C591C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 08:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QrGTsMRnHZKpBk8t4Dxu2lEWP5/jduBvlxTdlRtbD1k=; b=AjYM7l/KoaOBgNGdyPCa8QXvGQ
	YPt9FCnqo78lCyIyppJlFxIAibZ4V5l/GDDBxl1lWuBs1WldxyKS4Foy4DMqk5b17RfZJJ3UiKmYL
	EHP68CWl7HNeqR8wfnF5FNVkCTVF3rU+Hxp3xWAYghYagy/7QV2mv+cau43BpBjFPVKCysFtYAQoE
	qQdRwBSg809VFUi47V+JWtbt18HdzMQ2tUgirlMIGLSad7q+raF5rYdtig1RV2aC9uvsh/Op4XXQD
	AjyYqyBg8Pu7IA87JeKoBKUoAGTMpA+iae3AhV+32FYqzVzATjBLFOtvLf1jK1ho6Q3AJE7ccWMDD
	R4G+tf4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBtwK-00CDPA-BH; Thu, 14 Jul 2022 08:11:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBtwH-00CDJN-Av
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 08:11:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 268CE68AA6; Thu, 14 Jul 2022 10:11:04 +0200 (CEST)
Date: Thu, 14 Jul 2022 10:11:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Klaus Jensen <its@irrelevant.dk>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: issuing flush to all namespaces
Message-ID: <20220714081103.GA30086@lst.de>
References: <Ys/PCWCY8YWsoIci@apples>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys/PCWCY8YWsoIci@apples>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_011113_555955_782E80F8 
X-CRM114-Status: GOOD (  15.31  )
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

On Thu, Jul 14, 2022 at 10:08:41AM +0200, Klaus Jensen wrote:
> Hi,
> 
> Since the (very reasonable) changes that cause the driver to check that
> the nsid of the command corresponds to the nsid of the namespace being
> targeted it is no longer possible to issue a flush to all namespaces:
> 
>    # nvme flush /dev/nvme0n1 -n 0xffffffff
>    flush: Invalid argument
> 
> Now, I think we can all agree that Flush is the odd one out here, but
> can we do anything about it? The char devices also check the nsid, so
> they can't be used either.

Don't do it.  Sending flush to all namespaces wasn't even clearly
defined until I think NVMe 1.4 with the supported bits.  It doesn't
really make much sense and there is no point in supporting it in Linux.

