Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A9BC4345F
	for <linux-nvme@archiver.kernel.org>; Thu,  2 May 2024 07:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tlVq0zV7PPRyL4TfrFkMTscYtH9rzwR77WV4fpfEQ9s=; b=uALzzm1oe8nvI8tSRva/mHwohu
	fCbs81m8xPjLmewlZbramiwFIZLXGZ/TKdwLrHJ0Y9Xcc/hLamipSP9DYDfTTyBzwYI20A59UNVxG
	csMcxc/HEgWjsJN6IAWhS5w4BqVzcslV264VHnBhjqCFv+fHluQt/Fl9LiFi3LlzstzfY8BajNekL
	mPgJE/0oHWnpi51Djf3tP4i/Ak433vvvV479VwYE042Rc2PQAomuqQIWxfy1jWX+liT+oBjhvZXyP
	7eJsfZZok9iPtJkCCiLkpf3CO2w1Flmmh2uGFQ1T6BngjliI2Yvxsx6zJn9ks1R3fIT8i+lbsz04f
	KSY91uZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2QcI-0000000Blb7-3I1D;
	Thu, 02 May 2024 07:12:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2QcG-0000000BlaV-03BF
	for linux-nvme@lists.infradead.org;
	Thu, 02 May 2024 07:12:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 496A1227A87; Thu,  2 May 2024 09:12:22 +0200 (CEST)
Date: Thu, 2 May 2024 09:12:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	martin.petersen@oracle.com, kbusch@kernel.org, brauner@kernel.org,
	asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 04/10] block: avoid unpinning/freeing the bio_vec
 incase of cloned bio
Message-ID: <20240502071221.GA31379@lst.de>
References: <20240425183943.6319-1-joshi.k@samsung.com> <CGME20240425184658epcas5p2adb6bf01a5c56ffaac3a55ab57afaf8e@epcas5p2.samsung.com> <20240425183943.6319-5-joshi.k@samsung.com> <20240427070508.GD3873@lst.de> <03cb6ac3-595f-abb1-324b-647ed84cfe6b@samsung.com> <20240429170929.GB31337@lst.de> <ebeca5f1-8d80-e4d4-cf45-9a14ef1413a5@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebeca5f1-8d80-e4d4-cf45-9a14ef1413a5@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240502_001228_357064_2F39A7BB 
X-CRM114-Status: GOOD (  11.64  )
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

On Wed, May 01, 2024 at 06:32:45PM +0530, Kanchan Joshi wrote:
> Can you please tell what function(s) in bio data path that need this 
> conversion?
> To me data path handling seems similar. Each cloned bio will lead to 
> some amount of data transfer to pinned user-memory. The same is 
> happening for meta transfer here.

Well, everywhere.  e.g. for direct I/O everything is just driven from
the fs/direct-io.c and and fs/iomap/direct-io.c code without any
knowledge in the underlying driver if data has been pinned (no bounce
buffering in this case).  Or for passthrough I/O none of the underlying
logic knows about the pinning or bounce buffering, everything is handled
in block/blk-map.c.

