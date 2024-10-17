Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F23D2F7FD
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 08:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vxVH1T++kmoB1GxTp1oRZejVFPBICvLC63mnhDAcavQ=; b=KaGvssQwnYnfajEQwJzQJRLTIn
	T0f+iUUVyF1IJJ36GoLS2PvWRJ0ibmTwU1ZW+p3ynzGjuALxBgvN9wcEIU2bUcWDLbzrKW3K7yyl9
	qvXyrv8oncZBrSKPaRtSxsJxk4ecYYsZhMEOdQBzpdQ0lCIpwHr8bzF7g3N87LFWaUbjNWd32Sfkg
	zJ7knQTuAHYPpToS2ZBxg0zwsg870x7ZEcaCzNQGIJv4NuK9Ml2RrQY3pNsIa2xPPzncObP5XSgRl
	fsqcPrGDUF55EuIWOgmakEqLNHYp74V5UiyObe+lM5vUul0s6M47KThefVMTF1rJex4obvZ4+ke+o
	ETG1A34g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1LRE-0000000E4AX-1gjo;
	Thu, 17 Oct 2024 08:00:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1LQi-0000000E43o-1fgf
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 08:00:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E8666227A87; Thu, 17 Oct 2024 10:00:15 +0200 (CEST)
Date: Thu, 17 Oct 2024 10:00:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, krisman@suse.de, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com
Subject: Re: [PATCH v4 06/11] block: add flags for integrity meta
Message-ID: <20241017080015.GD25343@lst.de>
References: <20241016112912.63542-1-anuj20.g@samsung.com> <CGME20241016113745epcas5p1723d91b979fd0e597495fef377ad0f62@epcas5p1.samsung.com> <20241016112912.63542-7-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016112912.63542-7-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_010020_602163_F982F35D 
X-CRM114-Status: UNSURE (   9.87  )
X-CRM114-Notice: Please train this message.
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

On Wed, Oct 16, 2024 at 04:59:07PM +0530, Anuj Gupta wrote:
> Add flags to describe checks for integrity meta buffer. These flags are
> specified by application as io_uring meta_flags, added in the next patch.

These are now blkdev uapis, but io_uring ones even if currently only
the block file operations implement them.  I do plan to support these
through file systems eventually.


