Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCEFC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Feb 2022 16:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1FCPRFIp7m+UU5aprMThRmzhjVt2BmSoNQ2b8ele6uM=; b=m7jhaD6TLDHI/8T+o1dCy3PIaG
	Wa0rLB8Bfe5X+7725/Dx9+TSvjOqD0tluM9htJI1LmlotCca4yL4bqPeWpqOXJu+PZ0+7QEaLwUY8
	tBLFJl5bFnCcyDf7Lg45UgyVH6kYzcR9ps7yoFfXaKon2/XrOm5NsohyKnwAEKYtRvg33Wt2EYjmB
	0S8zLfn1ITDFMm/A3A7TfSb8cOSIrSvb095dRfqytcKw3ptdsNXijejQYb+aQQ3B9HQBDs8j2rbax
	pm9DZAKsG/2Yk3XkObmCzcdGO3WG6DvE8pxJjT3kX+yXo7Mr3Kv+t2udORQ0QiMG31704IDviKINR
	f8Cq8DXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNd3k-005mwd-5H; Fri, 25 Feb 2022 16:03:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNd3h-005mvC-8J
 for linux-nvme@lists.infradead.org; Fri, 25 Feb 2022 16:03:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AB19E68AA6; Fri, 25 Feb 2022 17:03:01 +0100 (CET)
Date: Fri, 25 Feb 2022 17:03:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 martin.petersen@oracle.com, colyli@suse.de,
 Hannes Reinecke <hare@suse.de>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv3 03/10] asm-generic: introduce be48 unaligned accessors
Message-ID: <20220225160300.GC13610@lst.de>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-4-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222163144.1782447-4-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220225_080305_477280_63A99EDB 
X-CRM114-Status: GOOD (  10.94  )
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

On Tue, Feb 22, 2022 at 08:31:37AM -0800, Keith Busch wrote:
> The NVMe protocol extended the data integrity fields with unaligned
> 48-bit reference tags. Provide some helper accessors in
> preparation for these.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

